From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 31 May 2016 11:35:08 +0200
Subject: [BUG] CONFIG_UNINLINE_SPIN_UNLOCK important for Cortex-A9
In-Reply-To: <874m9eoetu.fsf@gmail.com>
References: <874m9eoetu.fsf@gmail.com>
Message-ID: <4854518.jvbplH0SM0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, May 31, 2016 9:40:29 AM CEST Holger Schurig wrote:
> I chased a bug in the recent weeks that seems to be related to spinlocks.
> 
> 
> 
> Hardware & Kernel config
> ------------------------
> I have an i.MX6Q device. I don't use "make imx_v6_v7_defconfig", but
> selected only what I need. As such, I only have CONFIG_ARCH_MXC and
> CONFIG_SOC_IMX6Q enabled.
> 
> As a result, in my kernel CONFIG_UNINLINE_SPIN_UNLOCK was *not* defined.
> 
> In a kernel configured with "make imx_v6_v7_defconfig" this is
> configured. And so people (e.g. the Freescale/NPX people) that normally
> use this defconfig will never see the issue.

Have you tried multi_v7_defconfig? That also does not set 
CONFIG_UNINLINE_SPIN_UNLOCK, but it is generally assumed to work.

> Cure
> ----
> When I turned on CONFIG_PROVE_RCU the issue stopped. This option does
> "select UNINLINE_SPIN_UNLOCK", and this uninline option is also selected
> with the imx_v6_v7_defconfig. I actually don't care if RCUs are proven
> or not, this just turns on the uninlining as a side-effect.

Just to be sure: If you just enable UNINLINE_SPIN_UNLOCK (e.g. using
a 'select' from arch/arm/mach-imx/Kconfig) without selecting PROVE_RCU,
you say the bug is gone too?

> Question
> --------
> I don't have the slightest idea what produces the error and why
> uninlining helps (I'm not deep in such internals), so I wonder how to
> proceed.
>
> Should I simply send in a patch that "select UNINLINE_SPIN_UNLOCK" on
> i.MX6Q ???

I think we really need to get to the bottom of this, as there are tons
of possible reasons for the behavior, and selecting it for i.MX6Q.

Please provide a few more details about your environment:

- Specific kernel version, and full list of patches applied (if any).
  Have you reproduced this with a plain unpatched linux-4.6 kernel?

- Specific gcc version you used for building the kernel. Does this
  happen with both old and new compilers, e.g. 4.7 and 6.1?

- If it happens with an unpatched linux-4.6 and all gcc versions
  with multi_v7_defconfig, we should try reproducing it on some
  other quad-core Cortex-A9 (non-imx) platform with the same kernel
  binary.

	Arnd
