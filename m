From: tony@atomide.com (Tony Lindgren)
Date: Tue, 15 May 2012 12:58:36 -0700
Subject: [RESEND PATCH 1/2] ARM: OMAP2+: nand: Make
 board_onenand_init() visible to board code
In-Reply-To: <87zk99jort.fsf@ti.com>
References: <1333564586-3259-1-git-send-email-javier@dowhile0.org>
 <CAFqH_52aiDvR_xHY6TUN7igMiq6EqB-Nx9D=sPMCUeUaKLiuQg@mail.gmail.com>
 <CABxcv=kXukrVYOzjrMGoWzi=GTefh8EsXnTwzcahsfLa1a6Kaw@mail.gmail.com>
 <20120508231653.GP5088@atomide.com> <87zk99jort.fsf@ti.com>
Message-ID: <20120515195835.GC17852@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120515 11:17]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Javier Martinez Canillas <javier@dowhile0.org> [120427 02:33]:
> >> On Wed, Apr 25, 2012 at 9:59 AM, Enric Balletb? i Serra
> >> <eballetbo@gmail.com> wrote:
> >> >
> >> > Tony, as this is a fix ,may be included ?
> >> >
> >> > Acked-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> >> > Tested-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> >> >
> >> > Cheers,
> >> > ? ?Enric
> >> 
> >> Hi Tony, Russel:
> >> 
> >> This patch is a requirement for patch:
> >> 
> >> [RESEND PATCH 2/2] OMAP3: igep0020: Add support for Micron NAND Flash
> >> storage memory
> >> 
> >> which is really important since newer IGEPv2 boards have changed their
> >> flash memory from OneNAND to NAND.
> >> 
> >> This patch-set is necessary to make the board work, otherwise it
> >> doesn't even boot.
> >> 
> >> Could we please include these patches?
> >
> > Thanks for the patience, applying now into board branch finally.
> 
> This patch breaks the build for platforms that don't use ONENAND.
> Using omap2plus_defconfig, set CONFIG_MTD_ONENAND_OMAP2=n and you'll get
> the build error below[1]

Thanks for catching that.
 
> By removing the static, there is now duplicate definitions in the .c and
> .h files.
> 
> The solution is to remove the dummy definition from the .c file.  
> 
> Tony, feel free to fold the diff below[2] into the original patch to fix
> this compile problem.

That's already merged as 8259573b (ARM: OMAP2+: nand: Make board_onenand_init()
visible to board code) so we need to apply it as a fix.

Can you do a fix with your Signed-off-by or at least reply with that
so I can apply it?

Thanks,

Tony

 
> [1]
> /work/kernel/omap/dev/arch/arm/mach-omap2/board-flash.c:102:111: error: redefinition of 'board_onenand_init'
> /work/kernel/omap/dev/arch/arm/mach-omap2/board-flash.h:56:51: note: previous definition of 'board_onenand_init' was here
> make[2]: *** [arch/arm/mach-omap2/board-flash.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [arch/arm/mach-omap2] Error 2
> make: *** [sub-make] Error 2
> 
> [2]
> diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
> index 70a81f9..53c39d2 100644
> --- a/arch/arm/mach-omap2/board-flash.c
> +++ b/arch/arm/mach-omap2/board-flash.c
> @@ -97,11 +97,6 @@ __init board_onenand_init(struct mtd_partition *onenand_parts,
>  
>  	gpmc_onenand_init(&board_onenand_data);
>  }
> -#else
> -void
> -__init board_onenand_init(struct mtd_partition *nor_parts, u8 nr_parts, u8 cs)
> -{
> -}
>  #endif /* CONFIG_MTD_ONENAND_OMAP2 || CONFIG_MTD_ONENAND_OMAP2_MODULE */
>  
>  #if defined(CONFIG_MTD_NAND_OMAP2) || \
