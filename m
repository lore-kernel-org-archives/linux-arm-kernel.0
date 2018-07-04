From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 4 Jul 2018 17:14:50 +0200 (CEST)
Subject: [linux-sunxi] Re: [PATCH 0/2] Allwinner A64 timer workaround
In-Reply-To: <55fc9e48-6329-df75-3a12-60cc42d91a31@arm.com>
References: <20180511022751.9096-1-samuel@sholland.org>
 <2c16d5ab-38f7-8f3e-875c-19e8032f440a@arm.com>
 <bdfb1a31-2c4a-d258-7bf6-aaab8cee4663@sholland.org>
 <5283f98e-6443-db7a-fe51-6379ed19002c@arm.com>
 <24b78819-5e3f-431f-3987-f7409742ef07@linaro.org>
 <1d75c538-9166-5eec-a08c-b168f9770bd1@arm.com>
 <alpine.DEB.2.21.1807041151530.1816@nanos.tec.linutronix.de>
 <1a36f63c-0259-bdcd-bb96-d5230c2564ea@arm.com>
 <alpine.DEB.2.21.1807041628440.1752@nanos.tec.linutronix.de>
 <55fc9e48-6329-df75-3a12-60cc42d91a31@arm.com>
Message-ID: <alpine.DEB.2.21.1807041704570.1752@nanos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 4 Jul 2018, Andre Przywara wrote:
> On 04/07/18 15:31, Thomas Gleixner wrote:
> > If that's the case then you need to find a different functional timer for
> > time keeping. Having an erratic behaving timer for time keeping is not an
> > option at all.
> 
> That's not an option on arm64. There are other usable time sources in
> the SoC, but the arch timer is somewhat mandatory for all practical
> purposes on arm64. We rely on it in some many places that it's not
> feasible to run without it. That's why we call it "architected" timer
> after all ;-)

The argument that it has to be used just because someone defined it as
'architected' is bullshit and doesn't change the fact that it's broken and
not usable for timekeeping. There is no wiggle room. Either it works or
not, but works mostly is not an option.

> But I am quite confident that we can find a correct workaround. Maybe
> it's really the TVAL (the downcounter) write which is the culprit here,
> since the hardware actually writes "now() + TVAL" into the CVAL
> (upcounter) register. This internal counter access may be flawed as well.

If the write to the event device is wreckaging the counter which provides
time, then there is something seriously wrong either in the design or in
that particular piece of silicon.

Yet another proof for the theory that timers are implemented by janitors
and that silicon/IP vendors have a competition running who can create the
most subtly broken timers. Intel surely had a head start with that, but ARM
is definitely catching up.

Thanks,

	tglx
