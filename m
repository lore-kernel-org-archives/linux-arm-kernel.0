From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Fri, 19 Dec 2014 02:50:04 +0000
Subject: AT91 slow clock mode regression/fixes, improvement proposal
In-Reply-To: <20141218203904.GA25215@gradator.net>
References: <20141218203904.GA25215@gradator.net>
Message-ID: <B256D81BAE5131468A838E5D7A243641BFCB6762@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylvain,

> -----Original Message-----
> From: Sylvain Rochet [mailto:sylvain.rochet at finsecur.com]
> Sent: Friday, December 19, 2014 4:39 AM
> To: Yang, Wenyou; Ferre, Nicolas; Desroches, Ludovic; Alexandre Belloni; Maxime
> Ripard
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: AT91 slow clock mode regression/fixes, improvement proposal
> 
> Hello Wenyou,
> 
> You worked recently on AT91 slow clock mode in the linux4sam/linux-at91 master
> branch, however I am seeing regressions on a AT91SAM9G35-EK board
> concerning the following commit-id:
> 
> e0c8ba9b0ec3154e87da747098ee56e96ca3cee6
>   pm: at91: pm_slowclock: move disable/enable PLLB out of the route
> 
> cc4dc9885103af3b3262f7ac2b6aa887df1618b3
>   pm: at91: pm_slowclock: improvement to disable the UTMI PLL
> 
> 
> 
> About cc4dc9885103af3b3262f7ac2b6aa887df1618b3:
> 
> The assembly look wrong for me, it seems you can't have two following labels with
> the same identifier, so:
> 
> /* Turn on UTMI PLL */
> cmp flag, #1
> bne 1f
>   (...)
> 1:
> (...)
> 1:
> wait_pllblock
> 
> Is actually jumping to wait_pllblock before enabling PLLB instead of skipping UTMI
> PLL. Unfortunately the compiler does not warn about that.
Thanks. I will check it

> 
> 
> 
> About e0c8ba9b0ec3154e87da747098ee56e96ca3cee6:
> 
> I have mixed feeling about moving the PLL enabling from slow clock mode
> to master clock mode. Starting PLL is almost all about waiting, waiting,
> and waiting until they are stable enough to be used, the few CPU
> instructions required to switch ON the PLL is nothing compared to the
> wait time.
> 
> To be sure I benchmarked the required time to set up the UTMI PLL (using
> a GPIO + scope) on my AT91SAM9G35-CM module in both slow clock and
> master clock mode, I found out the required time to start up the PLL is,
> as expected, -exactly- the same.
> 
> But, previously, we were waiting with the CPU in slow clock mode, when
> the CPU power consumption is very very low, now we are waiting when the
> CPU is in full speed, which is worse.
> 
> Or, I am missing something ?
> 
> 
> Anyway, if we wait for the PLL in master clock mode we *MUST* increase
> the PLL timeout a lot, with the current code I guess we are leaving the
> resume code when the PLL are not yet ready at all since we are only
> waiting out of a 1000 iteration loop on master clock.
> 
> (Note that I didn't get fooled by that and I disabled the timeout when I
> checked the UPLL start time.)
> 
> 
> 
> Furthermore, it looks like MCKRDY_TIMEOUT set to 1000 is not enough, my board
> crashes in about 1 wake up to 10 with this value and works perfectly
> fine with 4000.
I also encountered this issue. 
Moreover the Main Crystal Oscillator Startup Time seems not enough too, not sure, I am confirming it.

> 
> 
> I have attached a patch that do the following:
> 
>  * Increase MCKRDY_TIMEOUT from 1000 to 4000 so my board don't crash.
>  * Fix the assembly on the "Turn on UTMI PLL" part
>  * Increase timeouts for PLLB and UPLL
> 
> 
> However I still disagree with this patch (this is why I didn't do a pull
> request ;-), I am proposing doing a patch set that:
> 
>  * Increase MCKRDY_TIMEOUT from 1000 to 4000 so my board don't crash, I
>    would be happy to have a feed back on this with your boards ;-)
>  * Fix the assembly on the "Turn on UTMI PLL" part
>  * Move back PLLB and UPLL to slow clock mode to save power
> 
> What do you think ?
> 
> 
> I have also mixed feeling about those timeouts, is it really useful in
> the wild ?  We don't event catch the timeout event to do something else
> if it happens, we still switch to the master clock whatever happened or
> even worse we continue even if AT91_PMC_MCKRDY isn't set? which is why I
> am having hard fault. In my opinion this is the watchdog job to handle
> those cases cleanly, there is nothing much we can do if something fail
> other than waiting a watchdog reset.
> 
> (Yeah, I know the watchdog is hard to use with sleep mode on AT91 chip,
> I have a work in progress about using the RTC to wake up before the
> watchdog expire to clear the watchdog and go back to sleep as fast as
> possible without resuming all the devices. It works, but I am still not
> happy at all with what I did for now.)
> 
> Therefore I am also proposing to remove all the timeout.
Good idea, but I still worry the deadlock without timeout. Maybe increasing timeout is better.

> 
> 
> By the way, I don't know for other AT91 boards (or without DT, or
> something else), but the UTMI PLL suspend/resume seem unnecessary for
> me, the USB driver is already disabling the USB PLL when suspending,
> could you confirm ?
Yes, I agree.
Remove disabling the PLLB code as well.  

> 
> 
> 
> Regards,
> Sylvain

Best Regards,
Wenyou Yang
