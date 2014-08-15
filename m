From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Fri, 15 Aug 2014 21:27:59 +0200
Subject: [PATCH 05/15] tty: serial: Add 8250-core based omap driver
In-Reply-To: <20140815183731.GI17769@csclub.uwaterloo.ca>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>
 <1408124563-31541-6-git-send-email-bigeasy@linutronix.de>
 <20140815183731.GI17769@csclub.uwaterloo.ca>
Message-ID: <53EE5F3F.2000707@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/15/2014 08:37 PM, Lennart Sorensen wrote:
> On Fri, Aug 15, 2014 at 07:42:33PM +0200, Sebastian Andrzej Siewior wrote:
>> This patch provides a 8250-core based UART driver for the internal OMAP
>> UART. The long term goal is to provide the same functionality as the
>> current OMAP uart driver and DMA support.
>> I tried to merge omap-serial code together with the 8250-core code.
>> There should should be hardly a noticable difference. The trigger levels
>> are different compared to omap-serial:
>> - omap serial
>>   TX: Interrupt comes after TX FIFO has room for 16 bytes.
>>       TX of 4096 bytes in one go results in 256 interrupts
>>
>>   RX: Interrupt comes after there is on byte in the FIFO.
>                                        one
>>       RX of 4096 bytes results in 4096 interrupts.
>>
>> - this driver
>>   TX: Interrupt comes once the TX FIFO is empty.
>>       TX of 4096 bytes results in 65 interrupts. That means there will
>>       be gaps on the line while the driver reloads the FIFO.
> 
> Any idea how long the gap is likely to be?  Probably not much.  I like
> the reduction in the number of interrupts.

If you want to change this to reduce the gap, then you have first
change 8250 core code. Currently it waits until the shift register is
empty.
On the other hand if you use DMA then it can handle transfers > 64bytes
in one go and you can start transfers while the FIFO is not completely
empty.

> I suppose if you did an interrupt when half empty or 3/4 empty, you
> would avoid the gap, and only increase the interrupt amount a little bit.
> Waiting until completely empty gives you larger dma transfers and less
> interrupts, but reduces your effective bandwidth on the port.  Is that
> really the right tradeoff?  I think the original driver behaviour there
> was fairly sane, although the 16 byte value could perhaps be increased
> to 32 or 48.

If you use DMA. You program one transfer says 100 bytes. You get an
dma-transfer complete once the 100 bytes are transfered which means the
FIFO has 63 bytes. From this point on you could enqueue the next
transfer with say another 100 bytes. In that scenario you don't see the
gap.

You get only to the gap if you use the non-DMA mode (and not UARTs
support DMA). In that case, yes waiting till there only 16 bytes before
starting the refill would make sense if you want to utilize the port by
100%. But as I said in 0/15, you need to teach the core this first.
Otherwise it will return doing nothing until the shift register is
empty (i.e. until the FIFO is completely empty).

>>   RX: Interrupt comes once there are 48 bytes in the FIFO or less over
>>       "longer" time frame. We have
>>           1 / 11520 * 10^3 * 16 => 1.38? ms
>>       1.38ms to react and purge the FIFO on 115200,8N1. Since the other
>>       driver fired after each byte it had ~5.47ms time to react. This
>>       _may_ cause problems if one relies on no missing bytes and has no
>>       flow control. On the other hand we get only 85 interrupts for the
>>       same amount of data.
> 
> Hmm, so if this was 32 instead of 48, it would double the amount of
> time you have to react, while only increasing the interrupt rate by 50%
> (1 every 32 rather than 1 every 48).  Could be interesting to tweak to
> get the balance just right.  Maybe it could have an optional dtb entry
> to control it if you don't like the default or is there a way to change
> it from user space already?

There is patch in Greg's tty tree already where you are able to
configure the RX trigger level. We could wire this up once we agree
which levels we want support. The OMAP supports all levels from 1?63.

> I know for our system we would like to be able to tolerate 1ms at 230400
> without data loss.

Yes, true. However this is only an issue without HW control. With DMA
the buffer is slightly larger. The DMA engine starts the transfer on
its own once there 48 bytes in the FIFO (except in the few cases where
it does not).

Sebastian
