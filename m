From: w@1wt.eu (Willy Tarreau)
Date: Fri, 10 Apr 2015 17:06:49 +0200
Subject: Guarantee udelay(N) spins at least N microseconds
In-Reply-To: <5527E3D6.1010608@free.fr>
References: <5527B331.5000205@free.fr> <20150410114253.GA18645@1wt.eu>
 <5527E3D6.1010608@free.fr>
Message-ID: <20150410150649.GB18690@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mason,

On Fri, Apr 10, 2015 at 04:53:10PM +0200, Mason wrote:
> The important thing to realize is that xloops is already rounded down,
> because we use 2199023 as an approximation of 2^41 / 10^6.
> 
> Thus, even when 'loops' is a multiple of 2^30, we'll want to round up.
> 
> Illustration
> 
> timer->freq = 100*2^20 && HZ = 100
> (thus UDELAY_MULT = 107374 && ticks_per_jiffy = 2^20)
> 
> Suppose udelay(512)
> so we want to spin for 512 / 10^6 * 100*2^20 = 53687,0912 cycles
> i.e. 53688 cycles if we round up.
> 
> loops = 512 * 107374 * 2^20 = 53687 * 2^30
> 
> If we just add (2^30-1) before shifting by 30, the result comes out
> to 53687, but (loops >> 30) + 1 is closer to what we really want.
> 
> One might argue that the difference between 53687 and 53688 is
> lost in the noise and thus irrelevant. I can agree with that.
> 
> Which is why I chose the simpler
> 
>   __timer_delay((loops >> UDELAY_SHIFT) + 1);
> 
> over
> 
>   __timer_delay((loops + (1 << UDELAY_SHIFT) - 1) >> UDELAY_SHIFT);
> 
> 
> Do you disagree with this logic?

OK it seems to make sense then.

Regards,
Willy
