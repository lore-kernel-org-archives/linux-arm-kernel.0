From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 5 Feb 2016 14:30:18 +0000
Subject: [QUESTION ]ARM64 external L3 cache support in topology info
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA8172E13A4@lhreml504-mbs>
References: <5FC3163CFD30C246ABAA99954A238FA8172E13A4@lhreml504-mbs>
Message-ID: <56B4B1FA.5030309@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/02/16 12:04, Shameerali Kolothum Thodi wrote:
> Hi,
>
> This is a query to get the external L3 cache included in the cache
> topology info. ARM64 kernel now has the cache topology info added
> based on the patch here [1].
>
> 1. http://permalink.gmane.org/gmane.linux.ports.arm.kernel/383628
>

[..]

>
> We have a ARM64 board(Hisilicon D02) and it has got an external L3 cache.
> As per my understanding after talking to our SoC guys, this cache is not
> integrated into the processor and is not visible in (CLIDR) register.
> But this looks to be fine as per the Programmer's Guide for ARMv8-A.
>
> "The CLIDR register is only aware of how many levels of cache are
> integrated into the processor itself. It cannot provide information
> about any caches in the external memory system. For example, if
> only L1 and L2 are integrated, CLIDR/CLIDR_EL1 identifies two levels
> of cache and the processor is unaware of any external L3 cache.
> It might be necessary to take into account non-integrated caches
> when performing cache maintenance, or code that is maintaining
> coherency with integrated caches."
>

Understood.

[..]

>
> In our case, the L3 cache seems to be intelligent enough and doesn't
> require any additional maintenance ops. So there is no cache-controller
> code for this. I am just wondering what's the best way to add this L3
> cache info to the topology. Overriding the CLIDR register, if there is
> a next-level-cache entry in the dts and then retrieve the cache geometry
> either from dts or from cache specific registers( but this will be
> implementation specific) ? Or am I missing something here?
>

Recent discussion on this [1] made it clear that we need to support
overriding cache properties using DT for some designs. I will consider
this "transparent" external/system level cache when I look into moving
PPC DT code in generic cacheinfo. I am not sure if it's OK to support
mixed information source for a platform(all internal caches via CLIDR
and external ones via DT), but we can pick up discussion once we I have
the patch.

-- 
Regards,
Sudeep

[1] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/381758.html
