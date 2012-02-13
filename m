From: rmallon@gmail.com (Ryan Mallon)
Date: Tue, 14 Feb 2012 08:52:24 +1100
Subject: [PATCH 11/15] ARM: ep93xx: clean-up mach/io.h
In-Reply-To: <1329169408-17253-12-git-send-email-robherring2@gmail.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <1329169408-17253-12-git-send-email-robherring2@gmail.com>
Message-ID: <4F398618.8070305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/02/12 08:43, Rob Herring wrote:

> From: Rob Herring <rob.herring@calxeda.com>
> 
> Move ep93xx specifics in mach/io.h to ep93xx-regs.h.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> index c4a7b84..8933c62 100644
> --- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> +++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> @@ -25,6 +25,12 @@
>   *	http://www.cirrus.com/en/pubs/appNote/AN273REV4.pdf
>   */
>  
> +#ifdef __ASSEMBLER__
> +#define IOMEM(p)                p
> +#else
> +#define IOMEM(p)                ((void __iomem __force *)(p))
> +#endif
> +


I think you will get multiple definition warnings with this patch
applied, but not the later patches (think git bisect, etc). For example,
arch/arm/mach-ep93xx/clock.c includes both linux/io.h (includes
mach/io.h) and mach/hardware.h (includes mach/ep93xx-regs.h) so you will
get warnings about IOMEM being redefined.

~Ryan
