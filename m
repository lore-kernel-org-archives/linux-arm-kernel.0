From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 4 Jul 2017 16:43:29 +0200 (CEST)
Subject: [PATCH V3 2/2] timer: imx-tpm: add imx tpm timer support
In-Reply-To: <AM3PR04MB3061653B4CF496CD1A4FAE280D70@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <1499176823-4421-1-git-send-email-aisheng.dong@nxp.com>
 <1499176823-4421-3-git-send-email-aisheng.dong@nxp.com>
 <alpine.DEB.2.20.1707041603571.9000@nanos>
 <AM3PR04MB3061653B4CF496CD1A4FAE280D70@AM3PR04MB306.eurprd04.prod.outlook.com>
Message-ID: <alpine.DEB.2.20.1707041636050.9000@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Jul 2017, A.s. Dong wrote:
> > From: Thomas Gleixner [mailto:tglx at linutronix.de]
> > I'm really impressed, that 10 years after we discovered the HPET disaster
> > (See comment in arch/x86/kernel/hpet.c::hpet_next_event) the same
> > hardware idiocy comes around again....
> > 
> 
> Not quite sure but seems a bit different issue.
> The issue is still uncertain but the test shows it's related to fabric priority
> Configuration, if increase the A7 core priority higher than GPU, the issue
> is very hard to be seen. But we don't want to change the default priority,
> we use ETIME check to fix it.

Well, whether it's hard to be observed or not is not the question. The
point is, that with match equal registers you always have:

      now = read_counter();
      match = now + delta;
      write_match(match);

If the counter advanced past match before the write hits the match
register, then the next interrupt will come after the wrap around of the
counter, which might be close to eternity depending on the counter
frequency and bit width.

This advancement can be caused by a gazillion of reasons:

     - Fabric delays
     - TLB/cache misses
     - .....

The probability might be low, but this can and will happen. And there is
nothing you can do about it. No FIXME in the world will change that
behaviour except that the FIXME actually changes the hardware.

Match equal registers are simply crap in such a context and should never be
used for timers. That's not a new finding, that's well known since 40+
years. But sure, hardware folks are always smarter.

Thanks,

	tglx
