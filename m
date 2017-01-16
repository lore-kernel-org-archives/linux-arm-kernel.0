From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 16 Jan 2017 12:14:03 +0100
Subject: USB: OHCI: high softirq load
In-Reply-To: <d49db4ac-fbeb-23ce-d48c-bd087c314328@overkiz.com>
References: <bd83e3b2-b329-3635-2917-0ffe61d3535f@overkiz.com>
 <20170116100220.0b00658e@bbrezillon>
 <ad8a54c3-c83d-109f-5cc5-7e77e9deff12@overkiz.com>
 <d49db4ac-fbeb-23ce-d48c-bd087c314328@overkiz.com>
Message-ID: <20170116121403.4a3a7b17@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Jan 2017 11:54:23 +0100
Antoine Aubert <a.aubert@overkiz.com> wrote:

> Also, I made a big misunderstanding
> 
> With EHCI + OHCI = high level of softirq (USB2.0)

Well, the number of irqs and softirqs are likely to be related (you
usually trigger a softirq after you received an hardirq).

> 
> OHCI only = normal level

What about EHCI only? And what happens if you only plug 1 device?
Please share the content of /proc/interrupts (and everything you think
is relevant) for each of these cases.

> 
> Le 16/01/2017 ? 11:31, Antoine Aubert a ?crit :
> > Thx for your answer Boris
> >
> > Le 16/01/2017 ? 10:02, Boris Brezillon a ?crit :  
> >> Hi Antoine,
> >>
> >> On Mon, 16 Jan 2017 08:45:58 +0100
> >> Antoine Aubert <a.aubert@overkiz.com> wrote:
> >>  
> >>> Hi,
> >>>
> >>> Im working on a AT91SAM9G25cu board
> >>> (arch/arm/boot/dts/at91-kizboxmini.dts). We use linux-4.1.31, and when
> >>> OHCI is enabled, I got some wired effects.  
> >> Can you test on a more recent kernel (4.9 or 4.10-rc4)?  
> > I'll give a try, just need little time ;)  
> >>> eg with 3 FTDI pluged, interrupts: more than 3.5k/s, cpu softirq > 24%,
> >>> loadavg > 0.5  
> >> Can you check which interrupt is triggered (cat /proc/interrupts),  
> > cat /proc/interrupts
> >            CPU0      
> >  16:       2286  atmel-aic   1 Level     pmc, at91_tick, at91_rtc, ttyS0
> >  17:          0       PMC  17 Level     main_rc_osc
> >  18:          0       PMC   0 Level     main_osc
> >  19:          0       PMC  16 Level     mainck
> >  20:          0       PMC   1 Level     clk-plla
> >  21:          0       PMC   6 Level     clk-utmi
> >  22:          0       PMC   3 Level     clk-master
> >  23:     945527  atmel-aic  17 Level     tc_clkevt
> >  24:      21815  atmel-aic  20 Level     at_hdmac
> >  25:          0  atmel-aic  21 Level     at_hdmac
> >  30:     120299  atmel-aic  24 Level     eth0
> >  31:   22783651  atmel-aic  22 Level     ehci_hcd:usb1, ohci_hcd:usb2
> >  99:          0      GPIO  16 Edge      PB_RST
> > 100:          0      GPIO  17 Edge      PB_PROG
> > Err:          0
> >  
> >>  and
> >> enable debug messages in drivers/usb/host/ohci-at91.c?  

Actually, I was asking for debug messages. You can enable them
dynamically with dynamic printk [1].
BTW, please use pastebin (or any other alternative) to share these
information.

Thanks,

Boris

[1]http://lxr.free-electrons.com/source/Documentation/dynamic-debug-howto.txt
