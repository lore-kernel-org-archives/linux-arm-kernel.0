From: robherring2@gmail.com (Rob Herring)
Date: Wed, 19 Mar 2014 17:04:48 -0500
Subject: [PATCH 61/62] ARM: sunxi: fix build for THUMB2_KERNEL
In-Reply-To: <1395257399-359545-62-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-62-git-send-email-arnd@arndb.de>
Message-ID: <CAL_JsqKaL4W_bjozC_hTmZ9439pqh8f8pHU25H5CNdf8hQZtOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 2:29 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Building an SMP kernel for the sunxi platform with THUMB2 instructions
> fails with this error at the moment:
>
> headsmp.S:7: Error: Thumb encoding does not support an immediate here -- `msr cpsr_fsxc,#0xd3'
>
> This changes the code to use a register for loading the
> value instead, which works in both ARM and THUMB mode.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/mach-sunxi/headsmp.S | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-sunxi/headsmp.S b/arch/arm/mach-sunxi/headsmp.S
> index a10d494..a8e0fef 100644
> --- a/arch/arm/mach-sunxi/headsmp.S
> +++ b/arch/arm/mach-sunxi/headsmp.S
> @@ -4,6 +4,7 @@
>          .section ".text.head", "ax"
>
>  ENTRY(sun6i_secondary_startup)
> -       msr     cpsr_fsxc, #0xd3
> +       mov     r0, #0xd3
> +       msr     cpsr_fsxc, r0
>         b       secondary_startup

Secondary cores should always enter the kernel in ARM mode like the
primary core, right? So we need the same switching to Thumb2 as
head.S, but even secondary_startup doesn't do any switching. So either
platforms jump into the kernel with a bx and happen to work or
secondary boot is broken for Thumb2 kernels.

Also, secondary_startup takes care of making sure the core is in SVC
mode, so this function shouldn't be needed in the first place.

Rob
