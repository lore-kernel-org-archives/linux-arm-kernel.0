From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 28 Feb 2011 15:38:38 +0530
Subject: [PATCH v4 2/2] Defines DA850/AM18xx/OMAPL1-38 SOC resources
	used by PRUSS UIO driver
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024BF3591A@dbde02.ent.ti.com>
References: <1298556402-26456-1-git-send-email-pratheesh@ti.com>
	<1298556402-26456-2-git-send-email-pratheesh@ti.com>
	<1298556402-26456-3-git-send-email-pratheesh@ti.com>
	<4D6796D6.5050008@mvista.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024BF3591A@dbde02.ent.ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024BF35C6E@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratheesh,

On Mon, Feb 28, 2011 at 10:16:18, TK, Pratheesh Gangadhar wrote:

> > > diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-
> > davinci/devices-da8xx.c
> > > index beda8a4..4ea3d1f 100644
> > > --- a/arch/arm/mach-davinci/devices-da8xx.c
> > > +++ b/arch/arm/mach-davinci/devices-da8xx.c
> > > @@ -725,3 +725,76 @@ int __init da8xx_register_cpuidle(void)
> > >
> > >   	return platform_device_register(&da8xx_cpuidle_device);
> > >   }
> > > +static struct resource pruss_resources[] = {
> > > +	[0] = {
> > > +		.start  = DA8XX_PRUSS_BASE,
> > > +		.end    = DA8XX_PRUSS_BASE + SZ_64K - 1,
> > > +		.flags  = IORESOURCE_MEM,
> > > +	},
> > > +	[1] = {
> > > +		.start  = DA8XX_L3RAM_BASE,
> > > +		.end    = DA8XX_L3RAM_BASE + SZ_128K - 1,
> > > +		.flags  = IORESOURCE_MEM,
> > > +	},
> > > +	[2] = {
> > > +		.start  = 0,
> > > +		.end    = SZ_256K - 1,
> > 
> >     Huh? I don't see where it's filled...
> > 
> The current use is only to indicate memory block size to the PRUSS UIO 
> driver when we allocate DDR memory using dma_alloc_coherent.

If the user/platform needs to specify the amount of memory that
will be allocated by the driver, it can be done though platform
data or (better) using module params.

> sram_alloc is changed to use L3_RAM (128KB) instead of ARM RAM (8KB) in 
> Mistral patch set - I need to follow the same convention for L3 RAM as well 
> if I need to align with that patch. Is there a better way to do this?

Yes, with that patch sram_alloc() will allocate from L3 RAM. You can make
calls to sram_alloc() in your driver. Again the size to be allocated can
be platform data or module params.

Thanks,
Sekhar
