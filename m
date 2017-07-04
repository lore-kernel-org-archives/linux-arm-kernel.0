From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 4 Jul 2017 15:15:17 +0000
Subject: [PATCH V3 2/2] timer: imx-tpm: add imx tpm timer support
In-Reply-To: <alpine.DEB.2.20.1707041636050.9000@nanos>
References: <1499176823-4421-1-git-send-email-aisheng.dong@nxp.com>
 <1499176823-4421-3-git-send-email-aisheng.dong@nxp.com>
 <alpine.DEB.2.20.1707041603571.9000@nanos>
 <AM3PR04MB3061653B4CF496CD1A4FAE280D70@AM3PR04MB306.eurprd04.prod.outlook.com>
 <alpine.DEB.2.20.1707041636050.9000@nanos>
Message-ID: <AM3PR04MB3066C526C5AB6138684393C80D70@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx at linutronix.de]
> Sent: Tuesday, July 04, 2017 10:43 PM
> To: A.s. Dong
> Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> daniel.lezcano at linaro.org; shawnguo at kernel.org; Jacky Bai; Anson Huang;
> dongas86 at gmail.com; kernel at pengutronix.de; Arnd Bergmann; Anson Huang
> Subject: RE: [PATCH V3 2/2] timer: imx-tpm: add imx tpm timer support
> 
> On Tue, 4 Jul 2017, A.s. Dong wrote:
> > > From: Thomas Gleixner [mailto:tglx at linutronix.de] I'm really
> > > impressed, that 10 years after we discovered the HPET disaster (See
> > > comment in arch/x86/kernel/hpet.c::hpet_next_event) the same
> > > hardware idiocy comes around again....
> > >
> >
> > Not quite sure but seems a bit different issue.
> > The issue is still uncertain but the test shows it's related to fabric
> > priority Configuration, if increase the A7 core priority higher than
> > GPU, the issue is very hard to be seen. But we don't want to change
> > the default priority, we use ETIME check to fix it.
> 
> Well, whether it's hard to be observed or not is not the question. The
> point is, that with match equal registers you always have:
> 
>       now = read_counter();
>       match = now + delta;
>       write_match(match);
> 
> If the counter advanced past match before the write hits the match
> register, then the next interrupt will come after the wrap around of the
> counter, which might be close to eternity depending on the counter
> frequency and bit width.
> 

Yes we did observe that.
TPM CNT is 32 bit width and working at 3Mhz, it takes about 23 seconds
to wrap around to trigger the next event.
And due to it's single core, RCU stall can't trap it. The kernel
Seems have no idea about the wrap around and just resume and keep run.

> This advancement can be caused by a gazillion of reasons:
> 
>      - Fabric delays
>      - TLB/cache misses
>      - .....
> 
> The probability might be low, but this can and will happen. And there is
> nothing you can do about it. No FIXME in the world will change that
> behaviour except that the FIXME actually changes the hardware.
> 

That's Right.

> Match equal registers are simply crap in such a context and should never
> be used for timers. That's not a new finding, that's well known since 40+
> years. But sure, hardware folks are always smarter.
> 

Thanks for the detailed explanation.

I planned to add the following explanation in function for this issue.
diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 4716746..c13a8de 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -99,6 +99,12 @@ static int tpm_set_next_event(unsigned long delta,
        writel(next, timer_base + TPM_C0V);
        now = tpm_read_counter();
 
+       /*
+        * NOTE: We observed in a very small probability, the bus fabric
+        * contention between GPU and A7 may results a few cycles delay
+        * of writing CNT registers which may cause the min_delta event got
+        * missed, so we need add a ETIME check here in case it happened.
+        */
        return (int)((next - now) <= 0) ? -ETIME : 0;
 }

Do you think it's ok?

Regards
Dong Aisheng

> Thanks,
> 
> 	tglx
> 
