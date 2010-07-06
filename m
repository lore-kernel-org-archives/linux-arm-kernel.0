From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 07 Jul 2010 08:49:16 +0900
Subject: [PATCH] ARM: S5PV210: Fix on SECTION_SIZE_BITS on	S5PV210/S5PC110.
In-Reply-To: <AANLkTimqquLc7lW7TdMD2q84d4uATvHKppt5gVfKcMFT@mail.gmail.com>
References: <1278391007-11144-1-git-send-email-kgene.kim@samsung.com>
	<AANLkTimqquLc7lW7TdMD2q84d4uATvHKppt5gVfKcMFT@mail.gmail.com>
Message-ID: <013301cb1d65$daf2f8d0$90d8ea70$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On Tue, Jul 6, 2010 at 1:36 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > This patch fixes on SECTION_SIZE_BITS for Sparsemem on S5PV210/S5PC110.
> > Because smallest size of a bank on S5PV210/S5PC110 is aligned by 16MB.
> > So each section's maximum size should be 16MB.
> 
> Could you explain what's the problem?
> 
The size of a section for use in Sparsemem should be a power of 2.
And as you know, S5PC110 D-type has only 80MiB in a bank(DMC0).

80 = 2^4 * 5, thus should be 16MiB.

In case the section size is greater than 16MiB, a section will have a hole
in it.

> Even though 80MiB is used at logical size. it used the physical 128MiB
> so. it's reasonable to use 128MiB align instead of 16MiB. Are there
> boards use 64MiB or less?
> 
> I think if decrease the SECTIONS_SIZE_BITS, it wastes the memory.
> 
> Thank you,
> Kyungmin Park
> 
> >
> > Reported-by: Kyongho Cho <pullip.cho@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> > ?arch/arm/mach-s5pv210/include/mach/memory.h | ? ?8 ++++++--
> > ?1 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-s5pv210/include/mach/memory.h
b/arch/arm/mach-
> s5pv210/include/mach/memory.h
> > index 379117e..4a372d8 100644
> > --- a/arch/arm/mach-s5pv210/include/mach/memory.h
> > +++ b/arch/arm/mach-s5pv210/include/mach/memory.h
> > @@ -16,8 +16,12 @@
> > ?#define PHYS_OFFSET ? ? ? ? ? ?UL(0x20000000)
> > ?#define CONSISTENT_DMA_SIZE ? ?(SZ_8M + SZ_4M + SZ_2M)
> >
> > -/* Maximum of 256MiB in one bank */
> > +/* Sparsemem support. Each section is a maximum of 16MB.
> > + * Because there are many different memory type on S5PC110(MCP),
> > + * and there is a case that having 80MB, 128MB or 256MB in one
> > + * bank.
> > +*/
> > ?#define MAX_PHYSMEM_BITS ? ? ? 32
> > -#define SECTION_SIZE_BITS ? ? ?28
> > +#define SECTION_SIZE_BITS ? ? ?24
> >
> > ?#endif /* __ASM_ARCH_MEMORY_H */
> > --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
