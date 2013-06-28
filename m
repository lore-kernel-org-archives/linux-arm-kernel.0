From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 28 Jun 2013 12:19:11 +0200
Subject: [linux-sunxi] [PATCH 2/8] clocksource: sun4i: Add clocksource
 and sched clock drivers
In-Reply-To: <20130627225101.358208c1@i7>
References: <1372281421-2099-1-git-send-email-maxime.ripard@free-electrons.com>
 <1372281421-2099-3-git-send-email-maxime.ripard@free-electrons.com>
 <20130627131729.5fff8468@i7> <20130627170228.GC4319@lukather>
 <20130627225101.358208c1@i7>
Message-ID: <20130628101911.GF4319@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Siarhei,

> > > If we can be absolutely sure that nothing else may ever change
> > > the TIMER_CNT64_CTL_REG, then its default value can be probably
> > > cached instead of doing expensive read from the hardware register
> > > each time?
> > 
> > Since it's a free-running counter, its value will always change, so the
> > caching will bring no additions at all, right?
> 
> Sorry, 'caching' was not a very good description for something that is
> already a compile time constant. I mean just replace
> 
>     u32 reg = readl(timer_base + TIMER_CNT64_CTL_REG);
> 
> with 
> 
>     u32 reg = TIMER_CNT64_CTL_CLR;
> 
> Because we know that the TIMER_CNT64_CTL_REG is already supposed
> to have the default TIMER_CNT64_CTL_CLR value (initialized in the
> 'sun4i_timer_init' function) between calls to 'sun4i_timer_sched_read'.
> Inside of 'sun4i_timer_sched_read' we set an extra TIMER_CNT64_CTL_RL
> bit in this register, but wait until it clears, effectively reverting
> TIMER_CNT64_CTL_REG register back to the default TIMER_CNT64_CTL_CLR
> value.
> 
> Removing this extra HW register read can save roughly a hundred of CPU
> cycles here and provide a ~10% overall improvement for gettimeofday
> (these estimates are based on the earlier benchmarks done with the
> Allwinner 3.4 kernel).
> 
> Or maybe I'm overlooking something?

Ah, I get what you mean now. We don't even need to bother about
TIMER_CNT64_CTL_CLR now, since it's suppose to be cleared once the
counter is reset.

However, I'd very much prefer to take the safer approach for now, and
try to optimise afterwards.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130628/844d3b16/attachment.sig>
