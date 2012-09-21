From: sourav.poddar@ti.com (Poddar, Sourav)
Date: Fri, 21 Sep 2012 17:09:56 +0530
Subject: [PATCH] serial: omap: fix the overrun case
In-Reply-To: <20120921110050.GC16003@arwen.pp.htv.fi>
References: <1348222976-7241-1-git-send-email-shubhrajyoti@ti.com>
 <20120921110050.GC16003@arwen.pp.htv.fi>
Message-ID: <CAKdam55VG8KTRZNvPgur9M-wkbD7wyJt27Jsvks=r4PNiuEGaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On Fri, Sep 21, 2012 at 4:30 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Fri, Sep 21, 2012 at 03:52:56PM +0530, Shubhrajyoti D wrote:
>> Overrun also causes an internal flag to be set, which disables further
>> reception. Before the next frame can
>> be received, the MPU must:
>> ? Reset the RX FIFO.
>> ? clear the internal flag.
>>
>> In the uart mode a dummy read is needed. Add the same.
>
> Very nice patch but I think commit log can be a bit more verbose.
>
> Please make the problem a little clearer. Why do we even get that
> interrupt fired if BRK_ERROR_BITS aren't set ?
>
According to LSR registers, there are few other bits like RX_FIFO_E( atleast 1
character in RX_FIFO or TX FIFO Empty), which might be the cause of an
interrupt. ?
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>> ---
>> - functional testing on omap4sdp
>> - Verified idle and suspend path hits off on beagle.
>>
>>  drivers/tty/serial/omap-serial.c |    7 +++++++
>>  1 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
>> index a0d4460..bc22a2b 100644
>> --- a/drivers/tty/serial/omap-serial.c
>> +++ b/drivers/tty/serial/omap-serial.c
>> @@ -334,6 +334,13 @@ static unsigned int check_modem_status(struct uart_omap_port *up)
>>  static void serial_omap_rlsi(struct uart_omap_port *up, unsigned int lsr)
>>  {
>>       unsigned int flag;
>> +     unsigned char ch = 0;
>> +
>> +     if (!(lsr & UART_LSR_BRK_ERROR_BITS))
>> +             return;
>> +
>> +     if (likely(lsr & UART_LSR_DR))
>> +             ch = serial_in(up, UART_RX);
>
> Maybe add a comment before this condition stating why this character
> read is necessary ?
>
> --
> balbi
