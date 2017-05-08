From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 8 May 2017 22:22:08 +0200 (CEST)
Subject: usb: dwc2: NMI watchdog: BUG: soft lockup - CPU#0 stuck for 146s
In-Reply-To: <2127594073.298820.1493143869792@email.1und1.de>
References: <1795308650.27171.9a53158f-312d-40ce-80ce-8bf792d8db34.open-xchange@email.1und1.de>
 <172093673.40121.1492427140661@email.1und1.de>
 <CAD=FV=WJBTUcMPw8OgQT_jhz0H8AsH=YqWMR7LtudUKrF5-XOA@mail.gmail.com>
 <79b9b35b-0600-771f-4cd2-9e03c5ba3a25@i2se.com>
 <186569458.91967.1492547106553@email.1und1.de>
 <CAD=FV=VHkJFrsJDmMytbUw=WjKQaGZ-8Ewfy5bPCA82AWS4O2Q@mail.gmail.com>
 <212870399.174480.1492633502649@email.1und1.de>
 <87mvbaykn1.fsf@eliezer.anholt.net>
 <1998517910.54108.1492894253010@email.1und1.de>
 <2127594073.298820.1493143869792@email.1und1.de>
Message-ID: <316369012.317772.1494274928708@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Stefan Wahren <stefan.wahren@i2se.com> hat am 25. April 2017 um 20:11 geschrieben:
> 
> 
> > Stefan Wahren <stefan.wahren@i2se.com> hat am 22. April 2017 um 22:50 geschrieben:
> > 
> > 
> > Hi,
> > 
> > > Eric Anholt <eric@anholt.net> hat am 20. April 2017 um 20:54 geschrieben:
> > > 
> > > 
> > > Stefan Wahren <stefan.wahren@i2se.com> writes:
> > > 
> > > > Hi,
> > > >
> > > >> Doug Anderson <dianders@chromium.org> hat am 18. April 2017 um 22:41 geschrieben:
> > > >> 
> > > >> 
> > > >> It's hard to know for sure that all of this time is really in
> > > >> urb_enqueue().  Possible we could have task switched out and been
> > > >> blocked elsewhere.  Using ftrace to get more fine-grained timings
> > > >> would be useful.  ktime_get(), ktime_sub(), and ktime_to_us() are your
> > > >> friends here if you want to use trace_printk.
> > > >
> > > > i'm a newbie to ftrace, so i hope this would be helpful.
> > > >
> > > > # connect PL2303 to the onboard hub
> > > > # echo 0 > options/sleep-time
> > > > # echo 0 > function_profile_enabled
> > > > # echo 1 > function_profile_enabled
> > > > # ./usb_test
> > > > # Waiting for at least 20 seconds and then disconnect PL2303
> > > > # echo 0 > function_profile_enabled
> > > > # cat trace_stat/function0
> > > >
> > > >   Function                               Hit    Time            Avg             s^2
> > > >   --------                               ---    ----            ---             ---
> > > >   bcm2835_handle_irq                  361347    219567633 us     607.636 us      1485199 us  
> > > >   __handle_domain_irq                1082482    212639551 us     196.437 us      3642030 us  
> > > >   generic_handle_irq                 1082482    100592051 us     92.927 us       50511334 us 
> > > >   irq_exit                           1082482    98197771 us     90.715 us       29649040 us 
> > > >   handle_level_irq                   1082482    95812379 us     88.511 us       51910093 us 
> > > 
> > > If I'm reading this output right, we're spending half of our interrupt
> > > processing time in irq_exit(), so even if dwc2's interrupt was free (the
> > > generic_handle_irq() chain), we'd be eating about half the CPU getting
> > > back out of the interrupt handler, right?
> > > 
> > > I don't really know anything about DWC2 or USB, but is there any way we
> > > could mitigate the interrupt frequency with this hardware?  If nothing
> > > else, could we loop reading gintsts until it reads back 0?
> > 
> > first of all i updated my kernel to 4.11rc7 and the issue still occures. Today i had some time to investigate this issue further and i made some interesting observations:
> > 
> > 1. The lockup doesn't occure always after starting usb_test. In rare cases i was able to run the program without lockup.
> > 2. In case the lockup occured we are always able to "rescue" the BCM2835 from this state by sending some serial data to the PL2303.
> 
> Based on this scenario i patched the interrupt routine to detect the interrupt storm and normal condition. So i can dump the global and host registers in both situations (bad and goodcase).
> 
> Here is the diff between both register dumps, maybe someone see something interesting:
> 
> --- badcase.txt	2017-04-25 18:02:59.000000000 +0000
> +++ goodcase.txt	2017-04-25 18:02:59.000000000 +0000
> @@ -4,12 +4,12 @@
>   dwc2_dump_global_registers: GAHBCFG	 @0xCC850008 : 0x00000031
>   dwc2_dump_global_registers: GUSBCFG	 @0xCC85000C : 0x20001700
>   dwc2_dump_global_registers: GRSTCTL	 @0xCC850010 : 0x80000000
> - dwc2_dump_global_registers: GINTSTS	 @0xCC850014 : 0x06000021
> + dwc2_dump_global_registers: GINTSTS	 @0xCC850014 : 0x06000029
>   dwc2_dump_global_registers: GINTMSK	 @0xCC850018 : 0xF300080E
> - dwc2_dump_global_registers: GRXSTSR	 @0xCC85001C : 0x00070044
> + dwc2_dump_global_registers: GRXSTSR	 @0xCC85001C : 0x000F0001
>   dwc2_dump_global_registers: GRXFSIZ	 @0xCC850024 : 0x00000306
>   dwc2_dump_global_registers: GNPTXFSIZ	 @0xCC850028 : 0x01000306
> - dwc2_dump_global_registers: GNPTXSTS	 @0xCC85002C : 0x1D080100
> + dwc2_dump_global_registers: GNPTXSTS	 @0xCC85002C : 0x18080100
> ...

@Doug, @John Y., @Johan: Any further ideas to narrow down the reason for this interrupt storm?

Regards
Stefan
