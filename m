From: rob@landley.net (Rob Landley)
Date: Wed, 1 Nov 2017 03:58:02 -0500
Subject: [PATCH 9/9] ARM: multi_v7_defconfig: Enable DMA for Renesas
 serial ports
In-Reply-To: <CAMuHMdWW7gbdDY0y2jUVn=ERG1JEWCX=UotQVeyVwhW3fqSHMQ@mail.gmail.com>
References: <1499693302-25120-1-git-send-email-geert+renesas@glider.be>
 <1499693302-25120-10-git-send-email-geert+renesas@glider.be>
 <CANqRtoSi8x7zqwV3Gp_n0dBe4Uw6LDRvC1Lheu+GrLZNYuxAHw@mail.gmail.com>
 <CAMuHMdXb1yAgw4AVvheYhPV=V9HeDCW2NdvhJWzoSz8i-mM3TQ@mail.gmail.com>
 <CAK8P3a3c68=L=h+nni39BmOb68wno7TuvXuBgOHrEMOrkhdx2g@mail.gmail.com>
 <CAMuHMdUFnYSxF0grMQ6GB4h7svOeKa-SpPo_2TpTW9Hx+zvrEQ@mail.gmail.com>
 <95cf2c11-c7db-bdff-7165-282586e08b19@landley.net>
 <CAMuHMdWW7gbdDY0y2jUVn=ERG1JEWCX=UotQVeyVwhW3fqSHMQ@mail.gmail.com>
Message-ID: <4defc0d0-5e4b-42f7-3104-84f93e3baf47@landley.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/11/2017 05:46 AM, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> On Tue, Jul 11, 2017 at 12:37 PM, Rob Landley <rob@landley.net> wrote:
>> On 07/11/2017 03:59 AM, Geert Uytterhoeven wrote:
>>> On Tue, Jul 11, 2017 at 10:42 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>> On Tue, Jul 11, 2017 at 8:59 AM, Geert Uytterhoeven
>>>> <geert@linux-m68k.org> wrote:
>>>>> On Tue, Jul 11, 2017 at 5:38 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>>>>> On Mon, Jul 10, 2017 at 10:28 PM, Geert Uytterhoeven
>>>>>> Since enabling DMA Engine still keeps PIO support around I wonder why
>>>>>> we need this Kconfig at all - other drivers seem to get by without
>>>>>> this kind of thing?
>>>>>> So in my opinion it would also be nice to get rid of SERIAL_SH_SCI_DMA
>>>>>> completely and reducing the number of special per-driver Kconfig
>>>>>> entries.
>>>>>
>>>>> In general, I would agree, and remove the option at the blimp of an eye.
>>>>> However, this driver is shared with H8/300 and SuperH.  While both could use
>>>>> DMA (but it's not supported by Linux yet), I don't know if they are willing to
>>>>> live with the increased static and dynamic memory footprint of SH_SCI DMA
>>>>> support.
>>>>
>>>> One more thing: enabling the DMA support in the console driver generally
>>>> means you cannot use printk in the DMA driver anywhere that may be called
>>>> during printk(). Not sure if that is a concern here.
>>>
>>> Not anymore, as all of these prints should have been removed/disabled already.
>>
>> Last I checked qemu-system-sh4 still doesn't work with current linux
>> serial driver unless you do:
>>
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c
>> @@ -2193,7 +2193,7 @@ static void sci_reset(struct uart_port *port)
>>                         setup_timer(&s->rx_fifo_timer, rx_fifo_timer_fn,
>>                                     (unsigned long)s);
>>                 } else {
>> -                       if (port->type == PORT_SCIFA ||
>> +                       if (1 || port->type == PORT_SCIFA ||
>>                             port->type == PORT_SCIFB)
>>                                 scif_set_rtrg(port, 1);
>>                         else
>>
>> Does this DMA stuff make that situation worse?
> 
> No, SH-SCI DMA is not used on your platform.
> 
> Gr{oetje,eeting}s,

This issue is still there. QEMU's serial output is borked with the last
year's worth of vanilla superh kernels.

Rob
