From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 6 Jun 2013 17:50:53 +0100
Subject: [PATCH 4/4] ARM: ux500: Remove call to u8500_of_init_devices() -
 again
In-Reply-To: <201306061758.25106.arnd@arndb.de>
References: <1370517676-10909-1-git-send-email-lee.jones@linaro.org>
 <1370517676-10909-5-git-send-email-lee.jones@linaro.org>
 <201306061758.25106.arnd@arndb.de>
Message-ID: <20130606165053.GU3370@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 06 Jun 2013, Arnd Bergmann wrote:

> On Thursday 06 June 2013, Lee Jones wrote:
> > Somehow, probably due to a merge error the call to u8500_of_init_devices()
> > has re-appeared in next, causing this error:
> > 
> > arch/arm/mach-ux500/cpu-db8500.c: In function ?u8500_init_machine?:
> > arch/arm/mach-ux500/cpu-db8500.c:268:2: error: implicit declaration of     \
> >   function ?u8500_of_init_devices? [-Werror=implicit-function-declaration]
> > arch/arm/mach-ux500/cpu-db8500.c:268:9: warning: assignment makes pointer  \
> >   from integer without a cast [enabled by default]
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  arch/arm/mach-ux500/cpu-db8500.c |    3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
> > index d8ee616..f391d08 100644
> > --- a/arch/arm/mach-ux500/cpu-db8500.c
> > +++ b/arch/arm/mach-ux500/cpu-db8500.c
> > @@ -264,9 +264,6 @@ static void __init u8500_init_machine(void)
> >  	else if (of_machine_is_compatible("st-ericsson,ccu9540")) {}
> >  		/* TODO: Add pinmaps for ccu9540 board. */
> >  
> > -	/* TODO: Export SoC, USB, cpu-freq and DMA40 */
> > -	parent = u8500_of_init_devices();
> > -
> >  	/* automatically probe child nodes of dbx5x0 devices */
> >  	if (of_machine_is_compatible("st-ericsson,u8540"))
> >  		of_platform_populate(NULL, u8500_local_bus_nodes,
> 
> In the code I'm looking at, the definition for that function is
> 
> /* TODO: Once all pieces are DT:ed, remove completely. */
> static struct device * __init u8500_of_init_devices(void)
> {
>         struct device *parent = db8500_soc_device_init();
>         db8500_add_usb(parent, usb_db8500_dma_cfg, usb_db8500_dma_cfg);
>         return parent;
> }
> 
> I'm not sure about the db8500_add_usb() call, but I think at least
> db8500_soc_device_init() is required to get the root device for all
> other devices.

Right:

https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-stericsson.git/commit/arch/arm/mach-ux500/cpu-db8500.c?h=next&id=1e74043a29cdec67279d6e4f494dd1674a1b2365

For some reason (I suspect a merge error), u8500_of_init_devices
reappeared.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
