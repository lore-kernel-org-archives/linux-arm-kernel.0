From: Dean_Jenkins@mentor.com (Dean Jenkins)
Date: Wed, 14 May 2014 17:24:53 +0100
Subject: [PATCH 3/5] serial: imx: avoid spinlock recursion deadlock
In-Reply-To: <53703C0F.20504@freescale.com>
References: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
 <1399648788-26061-4-git-send-email-dean_jenkins@mentor.com>
 <53703C0F.20504@freescale.com>
Message-ID: <537398D5.2010608@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/14 04:12, Huang Shijie wrote:
> ? 2014?05?09? 23:19, dean_jenkins at mentor.com ??:
>> From: Andy Lowe<andy_lowe@mentor.com>
>>
>> The following deadlock has been observed:
>>
>> imx_int() {
>>    imx_txint() {
>>      spin_lock_irqsave(&sport->port.lock,flags);
>>      /* ^^^uart_port spinlock taken in imx_txint */
>>      imx_transmit_buffer() {
>>        uart_write_wakeup(&sport->port) {
>>          tty_wakeup() {
>>            hci_uart_tty_wakeup() {
>>              hci_uart_tx_wakeup() {
>>                uart_write() {
>>                  spin_lock_irqsave(&port->lock, flags);
>>                  /* ^^^deadlock here when spinlock is taken again */
>>                    .
>>                    .
>>                    .
>>                  spin_unlock_irqrestore(&port->lock, flags);
>>                }
>>              }
>>            }
>>          }
>>        }
>>      }
>>      spin_unlock_irqrestore(&sport->port.lock,flags);
>>    }
>> }
>>
>> To correct this call uart_write_wakeup() at the end of imx_txint() after
>> the uart_port spinlock is unlocked.
>>
>> Signed-off-by: Andy Lowe<andy_lowe@mentor.com>
>> Signed-off-by: Dirk Behme<dirk.behme@de.bosch.com>
>> ---
>>   drivers/tty/serial/imx.c |    7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index abe31ad..cc79706 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -636,8 +636,13 @@ static irqreturn_t imx_txint(int irq, void *dev_id)
>>
>>       imx_transmit_buffer(sport);
>>
>> -    if (uart_circ_chars_pending(xmit)<  WAKEUP_CHARS)
>> +    if (uart_circ_chars_pending(xmit)<  WAKEUP_CHARS) {
>> +        spin_unlock_irqrestore(&sport->port.lock, flags);
>>           uart_write_wakeup(&sport->port);
>> +    } else
>> +        spin_unlock_irqrestore(&sport->port.lock, flags);
>> +
>> +    return IRQ_HANDLED;
>>
>>   out:
>>       spin_unlock_irqrestore(&sport->port.lock, flags);
> I think this patch :
>
> https://lkml.org/lkml/2014/3/20/623
My analysis of this modification in the lkml suggests the following 
undesirable side-effects have been introduced:

The addition of the work queue to split the IRQ interrupt context 
handling from running hci_uart_tx_wakeup() or new hci_uart_write_work() 
"fixes" the i.MX6 serial driver deadlock crash. However, this code is 
being scheduled far too often so adds unnecessary processor loading.

There is an underlying flaw in the operation of the TTY_DO_WRITE_WAKEUP 
bit which is set too early which causes the wakeup mechanism to trigger 
when there are no pending characters to be written to the holding 
circular buffer. For BCSP under normal operating conditions, I think the 
wakeup mechanism is redundant because the BCSP frames are unable to 
completely fill the holding circular buffer so no characters remain 
pending. But currently, I think this work queue scheduling will occur 
for EVERY transmission of a BCSP frame from the interrupt context and 
again from the writing of the BCSP frame into the holding circular 
buffer via hci_uart_send_frame(). eg. is scheduled twice per TX BCSP frame.

TTY_DO_WRITE_WAKEUP is tested in drivers/tty/tty_io.c: tty_wakeup() and 
therefore if TTY_DO_WRITE_WAKEUP is in the clear state then 
ld->ops->write_wakeup(tty) is not called so avoids running 
hci_uart_tty_wakeup() so avoids the scheduling of the work queue.

Separate to the deadlock issue, is a contributing issue concerning the 
setting of TTY_DO_WRITE_WAKEUP when it is known there are pending 
characters to be sent when the holding circular buffer becomes full. The 
problematic code is in drivers/bluetooth/hci_ldisc.c : 
hci_uart_tx_wakeup() or new hci_uart_write_work() because 
TTY_DO_WRITE_WAKEUP is ALWAYS set despite the writing of BCSP frames 
usually not filling up the holding circular buffer. I do not see an easy 
fix for this because the TTY_DO_WRITE_WAKEUP must be set BEFORE the TX 
interrupts are set in the lower bound function tty->ops->write(). 
Perhaps a callback function pointer is needed that sets 
TTY_DO_WRITE_WAKEUP when the write function fails to write all of the 
characters into the holding circular buffer ?

An additional side effect of adding the work queue is that BCSP frame 
hci_uart_send_frame() calls will also become delayed by the scheduling 
and running of the work queue. This is undesirable because it adds 
unnecessary processor loading. The work queue should only act on the 
interrupt context program flow and not the normal kernel thread flow of 
writing BCSP frames. I fear that the work queue is in the wrong place. A 
better place would be in hci_uart_tty_wakeup() for the work queue so 
that it only effects the interrupt context.

In other words, fixing TTY_DO_WRITE_WAKEUP prevents unnecessary TX 
wakeup handling (probably no TX wakeups in BCSP operation) and this 
reduces the chances of the original deadlock issue occurring due to the 
lower rate of TX wakeup events, if any. The patch fixes the deadlock in 
the i.MX6 UART driver without introducing a work-queue in the general code.
>
> has fixed this deadlock.
>
Well, it has prevented the deadlock but fundamentally it is inefficient 
due to increasing latency and processor loading as described above.

> We can ignore this patch now.
>
This patch is compatible with the change in
https://lkml.org/lkml/2014/3/20/623
with the result that the deadlock is prevented in 2 places.

Regards,
Dean
