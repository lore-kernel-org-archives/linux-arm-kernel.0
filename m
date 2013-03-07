From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 7 Mar 2013 14:37:30 +0800 (HKT)
Subject: ARM: 7653/2: do not scale loops_per_jiffy when using a constant
 delay clock
In-Reply-To: <20130307033221.GC25137@mudshark.cambridge.arm.com>
References: <20130306022308.GA21539@mudshark.cambridge.arm.com>
 <20130306183751.GV17833@n2100.arm.linux.org.uk>
 <20130307033221.GC25137@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.03.1303071417260.28820@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Mar 2013, Will Deacon wrote:

> On the topic of this patch: I still think that we should revert it and
> require cpufreq drivers to pass CPUFREQ_CONST_LOOPS in their flags (I guess
> the cpu0 platform data may need extending to take some flags).

I must disagree.  The constness here is a property of the timer source 
used to implement one of the udelay() providers.  Constness has no 
relation with cpufreq which may or may not impact a given udelay 
implementation.

> Longer term, we might want to assess the binding between timer-based 
> delays and loops_per_jiffy, but that's an entirely new problem.

Actually I do think that the lpj should always be scaled regardless, as 
this has meaning only for a CPU loop.  This is even more important if 
there is the possibility for switching between different 
implementations. The local timer based udelay implementation should 
simply never factor in lpj into its delay evaluation.

So the current patch is a stop gap to fix the problem today.  When 
something better is proposed we can remove this fix.


Nicolas
