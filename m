From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Sep 2009 14:45:36 +0100
Subject: [RFC] ARM: increase L1_CACHE_SHIFT
In-Reply-To: <19099.38966.482309.340880@pilspetsen.it.uu.se>
References: <1251460695-26481-1-git-send-email-aaro.koskinen@nokia.com>
	<19099.38966.482309.340880@pilspetsen.it.uu.se>
Message-ID: <20090901134536.GQ19719@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 31, 2009 at 11:30:30AM +0200, Mikael Pettersson wrote:
> Aaro Koskinen writes:
>  > Hello,
>  > 
>  > ARM Cortex-A8 has 64 byte cache line, so the current code is
>  > wrong. This is little worrying if you e.g. read the comments from
>  > eb5f4ca9536ba297c98721ecbbdf41ec5b987bd5.
>  > 
>  > What would be the proper way to handle this? Should we set it to 64
>  > bytes for everyone, or set it according to some #define or Kconfig option?
> 
> It should be an internal (not user-selectable) CONFIG symbol
> synthesized from the CPU type selection option. See e.g. the
> x86 Kconfig for an example on how this can be done.
> 
> It's probably cleaner to have the CPU selection options "select"
> appropriate L1_CACHE_SHIFT_$N options than to force the L1_CACHE_SHIFT
> option to enumerate all possible CPU types for a given shift value.

The problem is that L1_CACHE_SHIFT must be at least the cache line size
of the CPU which you're going to be running on.  From an architectural
point of view, this is something which is only really known at run time
and doesn't really bear any relationship to the CPU architecture version.
However, L1_CACHE_SHIFT needs to be a compile time constant.

Eg, an ARMv6 CPU could have 128 byte cache lines.  I don't know of such
a device though.  However, it would be silly to enforce a 128 byte lines
on all ARMv6 CPUs.

Maybe the approach we should take is to have CONFIG_L1_CACHE_SHIFT be
an integer between 5 and 7, and default it according to the architecture
selected (so 5 for anything pre-Cortex A8, and 6 for Cortex A8).
