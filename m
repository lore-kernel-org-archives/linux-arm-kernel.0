From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 16 May 2011 18:33:11 +0200 (CEST)
Subject: [PATCH] ARM: twd: Adjust localtimer frequency withcpufreqnotifiers
In-Reply-To: <BANLkTimMSPmqD+kyz1EJUrH9sS=qWRZymw@mail.gmail.com>
References: <1290060899-9786-1-git-send-email-ccross@android.com>
	<AANLkTimCuV5N0jr8c949uONEvieQ5MDZ9KHDXtneG5AT@mail.gmail.com>
	<4D70BE9D.4000507@stericsson.com>
	<AANLkTin7ZXYALOy_jk1uR3SbZA51nSnU-ncSjG+n_RPn@mail.gmail.com>
	<4D714C17.7080102@gmail.com>
	<AANLkTims4e7o0sPxVnN0D1mNWDH7uC9q=pBQrBoad2os@mail.gmail.com>
	<eea425c066cc69c30f118fb102fff43e@mail.gmail.com>
	<AANLkTi=KcmqmghVxhwGvv79heRU3C+TC-v2VnWSWt7bU@mail.gmail.com>
	<7e9fafa016bfe536ccc373fc2cc7ba61@mail.gmail.com>
	<AANLkTinRNG4nTjh15a2tuJt_iDboHUtomxemSjY+6DcD@mail.gmail.com>
	<AANLkTikkcYw66MiJO9Bpm+De=XD2-1MFxm-CUPp6sMqL@mail.gmail.com>
	<BANLkTi=-T6P0KrsQ8+Ot_inq1JabY62LvA@mail.gmail.com>
	<alpine.LFD.2.02.1105131138460.2831@ionos>
	<BANLkTimxkY4MvQ+-qiOwdwbo7jPUAQ1vxw@mail.gmail.com>
	<alpine.LFD.2.02.1105141749510.3078@ionos> <4DD10814.1010103@ti.com>
	<alpine.LFD.2.02.1105161642250.3078@ionos>
	<BANLkTimMSPmqD+kyz1EJUrH9sS=qWRZymw@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1105161831440.3078@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 May 2011, Colin Cross wrote:
> On Mon, May 16, 2011 at 7:44 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Mon, 16 May 2011, Santosh Shilimkar wrote:
> >> On 5/14/2011 9:21 PM, Thomas Gleixner wrote:
> >> Just for my understanding, the clockevents_reconfigure() needs to
> >> be called with interrupts disabled on that CPU as part of
> >> the CPUFREQ notifiers. I assume the right place is do it
> >> in POST notifier after the CPU clock and hence TWD clock is
> >> updated. Is that right ?
> >
> > Yes.
> 
> Is it safe to only call it in POST?  If the frequency is increasing,
> and the TWD is not updated until after the CPU frequency has changed,
> it is possible for a clockevent to fire too early.  Will that cause
> problems, or does the clockevent code check against a clocksource to
> ensure the desired time has been reached?  If that is OK, it
> drastically simplifies the code, because the driver only needs to know
> the current TWD frequency, not predict a future TWD frequency.

Yes, the hrtimer code checks against current time, so if it fires too
early it rearms the timer.
 
Thanks,

	tglx
