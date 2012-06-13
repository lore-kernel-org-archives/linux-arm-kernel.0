From: afzal@ti.com (Mohammed, Afzal)
Date: Wed, 13 Jun 2012 12:18:15 +0000
Subject: [PATCH v5 03/14] ARM: OMAP2+: gpmc: driver migration helper
In-Reply-To: <20120613120457.GO12766@atomide.com>
References: <cover.1339419492.git.afzal@ti.com>
 <a121156faf6c758d4e37447ab832f6f825cc5bc8.1339419492.git.afzal@ti.com>
 <4FD6555D.4000508@ti.com> <20120613120457.GO12766@atomide.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E998CF2@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Wed, Jun 13, 2012 at 17:34:58, Tony Lindgren wrote:
 
> > I am not sure if I am missing something, but it appears that pdev will
> > always be NULL here as it is a local uninitialised variable.
> 
> This also creates a new warning:
> 
> arch/arm/mach-omap2/gpmc.c: In function ?gpmc_create_device?:
> arch/arm/mach-omap2/gpmc.c:1434: warning: ?pdev? may be used uninitialized in this function

I use an internal toolchain, that does not give warning,  seems I need to
check with codesourcery.

> 
> > Not sure I see the point in the above function. Why not declare the
> > gpmc_device_data struct as static in the file and access it directly
> > instead of passing it in omap_gpmc_init(). The postcore_init can then
> > call omap_gpmc_init() directly.
> > 
> > Shouldn't the post_initcall be added in patch #4, when the driver is
> > created?
> 
> There should no longer be any need to initialize GPMC early. It should
> behave like any other device driver, and also work as a loadable module.

Once driver migration is complete for all the boards, we can remove the
initcall and make it loadable.

But till that time as we need to support both old & new interface,
I feel this is necessary as old interface would happen in arch initcall,
and old gpmc_init is now gpmc_probe, and hence it needs to get executed
before arch initcall, necessitating this.

Regards
Afzal
