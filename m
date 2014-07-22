From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Jul 2014 16:37:55 +0200
Subject: [PATCH] ARM: imx6: fix SMP compilation again
In-Reply-To: <20140722134815.GZ8537@dragon>
References: <37015543.ZyZKZyEIPW@wuerfel> <16557676.B1fW0k49Wz@wuerfel>
 <20140722134815.GZ8537@dragon>
Message-ID: <12850450.mxMbPOMjsW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 July 2014 21:48:16 Shawn Guo wrote:
> On Tue, Jul 22, 2014 at 12:26:31PM +0200, Arnd Bergmann wrote:
> > Ah, you are right, I got the text wrong here, and I think I now understand
> > why it didn't happen earlier. Updated patch below (same patch, new
> > text).
> > 
> > 8<-------------
> > Subject: [PATCH] ARM: imx6: fix SMP compilation again
> > 
> > My earlier patch 1fc593feaf8e ("ARM: imx: build i.MX6 functions
> > only when needed") fixed a problem with building an i.MX5 kernel,
> > but now the problem has returned for the case where we allow
> > ARMv6K SMP builds in multiplatform. With CONFIG_CPU_V7 disabled,
> > but i.MX3 and SMP enabled, we get this build error:
> 
> Maybe I missed something, but I have problem to get the following three
> conditions meet in a single kernel configuration.
> 
>  a) CONFIG_CPU_V7 disabled
>  b) i.MX3 enabled
>  c) SMP enabled
> 
> When I get a) and b) in the config, I have no way to get c).  And it
> seems that the only way to get a) and c) at the same time is to enable
> MACH_REALVIEW_PB11MP, which is not part of multi-platform support.  So
> i.MX3 cannot be enabled in there.

I have a patch series to make ARCH_REALVIEW multiplatform-enabled,
and I guess the condition can only be hit with these patches, or any
other that selects HAS_SMP.

> I tried both mainline and -next tree.  I really need some help to
> reproduce the error first.

My branch is at git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
in the randconfig-next branch. Sorry for the inconvenience.

> > arch/arm/mach-imx/built-in.o: In function `v7_secondary_startup':
> > :(.text+0x5124): undefined reference to `v7_invalidate_l1'
> > 
> > This puts the code inside of an "ifdef CONFIG_SMP" to hopefully
> 
> The code says "ifdef CONFIG_SOC_IMX6"?

It seems I'm having a bad day. I'll fix it up.

	Arnd
