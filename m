From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 11 Jan 2013 18:57:58 +0000
Subject: [PATCH] ARM: VIC: use irq_domain_add_simple()
In-Reply-To: <CACRpkdbtn4Pz3uLCxDGOBSVW7vfLECf2UZkT5+X9ip1ZZFb8Lw@mail.gmail.com>
References: <1350392786-29191-1-git-send-email-linus.walleij@stericsson.com>
 <507D61E7.2080704@gmail.com>
 <CACxGe6tBLfj3CDDZAfGmznj3B-h4OfJsrRc+85w9fnxFH6Cd_Q@mail.gmail.com>
 <CACRpkdbtn4Pz3uLCxDGOBSVW7vfLECf2UZkT5+X9ip1ZZFb8Lw@mail.gmail.com>
Message-ID: <20130111185758.45FF73E215F@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Dec 2012 19:45:24 +0100, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Dec 19, 2012 at 12:34 AM, Grant Likely
> <grant.likely@secretlab.ca> wrote:
> 
> > It looks to me like the below patch breaks versatile because it makes
> > it try to register a linear irq_domain instead of the legacy one that
> > it needs. Here are the relevant commits:
> >
> > 07c9249f1: "ARM: 7554/1: VIC: use irq_domain_add_simple()"
> > 946c59a08: "ARM: vic: fix build warning caused by previous commit"

(sorry for the really late reply on this. I took a break at Christmas
and jetlag has been beating up my concentration since I got back. I
actually started writing this reply before Christmas, but the
investigation sidetracked me enough that I never finished it.)

> > I'm working on getting it properly sorted out (and more importantly
> > *simplified*), but in the mean time I think the above two commits need
> > to be reverted. Reverting them on my tree fixes booting for me.
> 
> Isn't that a bit violent, can't we just fix the real bug?

I did try to fix the bug first, but it became more involved that I would
like for a stablization change (and I went down a lot of rabbit trails
in the process). I preferred reverting because this was all contained
to a single driver which can be backed out easily to have another cycle
for a correct fix. I did try your change though...

> Does the below patch work for you, it does two things:
> 
> 1) Bump all Versatile IRQs to offset at 32, because it is using
>   IRQ 0 which is NO_IRQ and illegal anyway so it's anyway
>   a bug that should be fixed.
> 
> 2) Make sure we call irq_create_mapping() if the start IRQ is
>   anyway 0, as in the device tree case, and make sure to
>   actually pass zero in that case.

In actual fact, only changing the offset to 32 is required to get
Versatile to boot with DT. That platform doesn't yet use vic_of_init().
It currently depends on pre-allocated irq_descs. Calling
irq_create_mapping() doesn't resolve this. I now have patches to rework
the versatile OF support to use irq_of_init(), but they aren't ready
for posting yet. Merging the bump to offset 32 would be fine for now.

> diff --git a/arch/arm/mach-versatile/include/mach/irqs.h
> b/arch/arm/mach-versatile/include/mach/irqs.h
> index bf44c61..0fd771c 100644
> --- a/arch/arm/mach-versatile/include/mach/irqs.h
> +++ b/arch/arm/mach-versatile/include/mach/irqs.h
> @@ -25,7 +25,7 @@
>   *  IRQ interrupts definitions are the same as the INT definitions
>   *  held within platform.h
>   */
> -#define IRQ_VIC_START		0
> +#define IRQ_VIC_START		32
>  #define IRQ_WDOGINT		(IRQ_VIC_START + INT_WDOGINT)
>  #define IRQ_SOFTINT		(IRQ_VIC_START + INT_SOFTINT)
>  #define IRQ_COMMRx		(IRQ_VIC_START + INT_COMMRx)
> @@ -100,7 +100,7 @@
>  /*
>   * Secondary interrupt controller
>   */
> -#define IRQ_SIC_START		32
> +#define IRQ_SIC_START		64

Since you're touching this line anyway, please change to:

#define IRQ_SIC_START			(IRQ_VIC_START + 32)

>  #define IRQ_SIC_MMCI0B 		(IRQ_SIC_START + SIC_INT_MMCI0B)
>  #define IRQ_SIC_MMCI1B 		(IRQ_SIC_START + SIC_INT_MMCI1B)
>  #define IRQ_SIC_KMI0		(IRQ_SIC_START + SIC_INT_KMI0)
> @@ -120,7 +120,7 @@
>  #define IRQ_SIC_PCI1		(IRQ_SIC_START + SIC_INT_PCI1)
>  #define IRQ_SIC_PCI2		(IRQ_SIC_START + SIC_INT_PCI2)
>  #define IRQ_SIC_PCI3		(IRQ_SIC_START + SIC_INT_PCI3)
> -#define IRQ_SIC_END		63
> +#define IRQ_SIC_END		95

Similarly here: #define IRQ_SIC_END (IRQ_SIC_START + 31)

And then you can add my acked by for the irq number changes.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

g.
