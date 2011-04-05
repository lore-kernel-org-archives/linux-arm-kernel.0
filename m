From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 5 Apr 2011 16:28:33 +0530
Subject: [PATCH v18 08/13] davinci: eliminate use of IO_ADDRESS() on sysmod
In-Reply-To: <1301737397-4327-1-git-send-email-manjunath.hadli@ti.com>
References: <1301737397-4327-1-git-send-email-manjunath.hadli@ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C75E97E@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manju,

On Sat, Apr 02, 2011 at 15:13:17, Hadli, Manjunath wrote:
> Current devices.c file has a number of instances where
> IO_ADDRESS() is used for system module register
> access. Eliminate this in favor of a ioremap()
> based access.
> 
> Consequent to this, a new global pointer davinci_sysmodbase
> has been introduced which gets initialized during
> the initialization of each relevant SoC
> 
> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
> Acked-by: Sekhar Nori <nsekhar@ti.com>
> ---

> diff --git a/arch/arm/mach-davinci/include/mach/hardware.h b/arch/arm/mach-davinci/include/mach/hardware.h
> index 414e0b9..2a6b560 100644
> --- a/arch/arm/mach-davinci/include/mach/hardware.h
> +++ b/arch/arm/mach-davinci/include/mach/hardware.h
> @@ -21,6 +21,12 @@
>   */
>  #define DAVINCI_SYSTEM_MODULE_BASE        0x01C40000
>  
> +#ifndef __ASSEMBLER__
> +extern void __iomem *davinci_sysmodbase;
> +#define DAVINCI_SYSMODULE_VIRT(x)	(davinci_sysmodbase + (x))
> +void davinci_map_sysmod(void);
> +#endif

Russell has posted[1] that the hardware.h file should
not be polluted with platform private stuff like this.

Your patch 7/13 actually helped towards that goal, but
this one takes us back. This patch cannot be used in
the current form.

Currently there are separate header files for dm644x,
dm355, dm646x and dm365. I would like to start by
removing unnecessary code from these files and trying
to consolidate them into a single file.

Example, the EMAC base address definitions in dm365.h
should be moved into dm365.c. Similarly, there is a lot
of VPIF specific stuff in dm646x.h which is not really
specific to dm646x.h and so should probably be moved to
include/media/ or arch/arm/mach-davinci/include/mach/vpif.h

Once consolidated into a single file, davinci_sysmodbase
can be moved into that file.

Also, Russell has said[2] that at least for this merge
window only consolidation and bug fixes will go through
his tree. This means that as far as mach-davinci is
concerned, the clean-up part of this series can go to
2.6.40 - but not the stuff which adds new support.

Thanks,
Sekhar

[1] http://www.spinics.net/lists/arm-kernel/msg120410.html
[2] http://www.spinics.net/lists/arm-kernel/msg120606.html
