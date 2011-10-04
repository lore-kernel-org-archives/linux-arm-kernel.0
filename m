From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 04 Oct 2011 21:45:19 +0900
Subject: [PATCH V2 2/2] ARM: SAMSUNG: Cleanup resources by using macro
In-Reply-To: <1957187.UuLfeIqa6D@wuerfel>
References: <005901cc817e$51a56d00$f4f04700$%kim@samsung.com>
	<1957187.UuLfeIqa6D@wuerfel>
Message-ID: <019301cc8293$79a6f510$6cf4df30$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> On Monday 03 October 2011 12:41:22 Kukjin Kim wrote:
> > This patch adds macro SAMSUNG_RES_MEM, SAMSUNG_RES_IRQ
> > and so on to cleanup regarding 'struct resource' by using
> > defined helpers at <linux/ioport.h>.
> >
> > Cc: Ben Dooks <ben-linux@fluff.org>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> When we introduced those macros, it was specifically so that platforms
> would be migrated to use them instead of providing their own.
> 
> > index 8f19241..a506831 100644
> > --- a/arch/arm/plat-samsung/include/plat/devs.h
> > +++ b/arch/arm/plat-samsung/include/plat/devs.h
> > @@ -18,6 +18,17 @@
> >
> >  #include <linux/platform_device.h>
> >
> > +#define SAMSUNG_RES_MEM(soc, ip, sz)
> DEFINE_RES_MEM(soc##_PA_##ip, sz)
> > +#define SAMSUNG_RES_IRQ(ip)            DEFINE_RES_IRQ(IRQ_##ip)
> > +
> > +#define SAMSUNG_RES_MEM_NAMED(soc, ip, sz, name)       \
> > +
> DEFINE_RES_MEM_NAMED(soc##_PA_##ip, sz, name)
> > +#define SAMSUNG_RES_IRQ_NAMED(ip, name)                        \
> > +                               DEFINE_RES_IRQ_NAMED(IRQ_##ip,
> name)
> > +#define SAMSUNG_RES_DMA_NAMED(ch, name)
> \
> > +
> DEFINE_RES_DMA_NAMED(DMACH_##ch, name)
> 
> I think the string concatenation really just obfuscates the code, and
> it does not actually save much at all. When you replace
> 
> +       [0] = SAMSUNG_RES_MEM(S3C, WDT, SZ_1K),
> +       [1] = SAMSUNG_RES_IRQ(WDT),
> 
> with
> 
> +       [0] = DEFINE_RES_MEM(S3C_PA_WDT, SZ_1K),
> +       [1] = DEFINE_RES_IRQ(IRQ_WDT),
> 
> you need practically no extra space, but you gain the advantages that
> 
> * Someone using grep for DEFINE_RES_MEM finds all memory resources without
>   having to look up what your macros do an where they are used.
> * Someone using grep to look for S3C_PA_WDT finds the place where it is
used.
> * Someone reading the resource definition immediately knows what the
>   macro does if familiar with other platforms using that macro.

Yes, right. But I'm preparing to reduce the 'soc' part to consolidate some
duplicated resources and platform data after this and the new SAMSUNG_RES
macro will be used.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
