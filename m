From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 28 Apr 2014 20:39:54 +0200
Subject: [PATCH] ARM: mvebu: refine which files are build in mach-mvebu
In-Reply-To: <1398709239-6126-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <20140427231044.GX28159@titan.lakedaemon.net>
 <1398709239-6126-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140428183954.GC10755@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 08:20:39PM +0200, Thomas Petazzoni wrote:
> Following the integration into mach-mvebu of the Kirkwood ARMv5
> support, we need to be more careful about which files get built. For
> example, the pmsu.c file now calls wfi(), which only exists on ARMv7
> platforms.
> 
> Therefore, this commit changes mach-mvebu/Makefile to build the Armada
> 370/XP/375/38x specific files only when CONFIG_MACH_MVEBU_V7 is
> enabled.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Hi Thomas

Thanks for this. It looks O.K. to me.

Acked-by: Andrew Lunn <andrew@lunn.ch>

	  Andrew

> ---
> This commit applies on top of mvebu/soc, and has been built tested
> with mvebu_v7_defconfig, mvebu_v5_defconfig, multi_v7_defconfig and
> multi_v5_defconfig (on top of mvebu/for-next).
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/Makefile | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
> index 02b5389..ec0b217 100644
> --- a/arch/arm/mach-mvebu/Makefile
> +++ b/arch/arm/mach-mvebu/Makefile
> @@ -3,11 +3,14 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
>  
>  AFLAGS_coherency_ll.o		:= -Wa,-march=armv7-a
>  
> -obj-y				 += system-controller.o mvebu-soc-id.o cpu-reset.o
> -obj-$(CONFIG_MACH_MVEBU_V7)      += board-v7.o
> +obj-y				 += system-controller.o mvebu-soc-id.o
> +
> +ifeq ($(CONFIG_MACH_MVEBU_V7),y)
> +obj-y				 += cpu-reset.o board-v7.o coherency.o coherency_ll.o pmsu.o
> +obj-$(CONFIG_SMP)		 += platsmp.o headsmp.o platsmp-a9.o headsmp-a9.o
> +obj-$(CONFIG_HOTPLUG_CPU)	 += hotplug.o
> +endif
> +
>  obj-$(CONFIG_MACH_DOVE)		 += dove.o
> -obj-$(CONFIG_ARCH_MVEBU)	 += coherency.o coherency_ll.o pmsu.o
> -obj-$(CONFIG_SMP)                += platsmp.o headsmp.o platsmp-a9.o headsmp-a9.o
> -obj-$(CONFIG_HOTPLUG_CPU)        += hotplug.o
>  obj-$(CONFIG_MACH_KIRKWOOD)	 += kirkwood.o kirkwood-pm.o
>  obj-$(CONFIG_MACH_T5325)	 += board-t5325.o
> -- 
> 1.9.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
