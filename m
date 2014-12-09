From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Dec 2014 09:51:38 +0100
Subject: [PATCH] ARM: bcm: fix __iomem annotation on kona_smc
In-Reply-To: <54862498.8080101@gmail.com>
References: <1418075148-8752-1-git-send-email-olof@lixom.net>
 <54862498.8080101@gmail.com>
Message-ID: <3044718.ZPFEmzteVb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 December 2014 14:22:16 Florian Fainelli wrote:
> > diff --git a/arch/arm/mach-bcm/bcm_kona_smc.c b/arch/arm/mach-bcm/bcm_kona_smc.c
> > index a55a7ec..d506d17 100644
> > --- a/arch/arm/mach-bcm/bcm_kona_smc.c
> > +++ b/arch/arm/mach-bcm/bcm_kona_smc.c
> > @@ -142,7 +142,7 @@ static int bcm_kona_do_smc(u32 service_id, u32 buffer_phys)
> >  static void __bcm_kona_smc(void *info)
> >  {
> >       struct bcm_kona_smc_data *data = info;
> > -     u32 *args = bcm_smc_buffer;
> > +     u32 __iomem *args = bcm_smc_buffer;
> 
> Your fix looks good to me, although the original code sounds a little
> dubious, especially in LPAE environment.

Right, I think it could just use of_iomap() and drop the size
check. If you want to keep the check, using of_address_to_resource()
will do the right thing.

	Arnd
