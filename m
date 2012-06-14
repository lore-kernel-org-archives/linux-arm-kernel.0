From: afzal@ti.com (Mohammed, Afzal)
Date: Thu, 14 Jun 2012 05:40:02 +0000
Subject: [PATCH 2/3] ARM: OMAP2+: onenand: cleanup for gpmc driver
 conversion
In-Reply-To: <4FD8C217.2050006@ti.com>
References: <cover.1339419244.git.afzal@ti.com>
 <2d6f0fb31cde98cd700d7a4268683b4aeeee87f2.1339419244.git.afzal@ti.com>
 <4FD63AAE.90008@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997D47@DBDE01.ent.ti.com>
 <4FD77CC8.4000003@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998781@DBDE01.ent.ti.com>
 <4FD8C217.2050006@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9993EF@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Wed, Jun 13, 2012 at 22:08:47, Hunter, Jon wrote:
> On 06/13/2012 12:03 AM, Mohammed, Afzal wrote:

> > As gpmc_onenand_setup is a callback by onenand driver, we would have
> > lost the opportunity to configure onenand before driver is probed.
> 
> Is that a problem? Looks like it is called early in the probe and so I
> would hope no one is attempting to access the onenand itself before the
> probe has completed.

During gpmc driver probe, it will configure all the connected peripherals,
if configuration details are not present at that point of time, gpmc driver
will cry out saying that configuration & timings has not been configured,
(please see holler if no configuration patch). And I do not see any reason
why gpmc driver should not be fed with async mode configuration initially,
as it has to be done always.

> 
> > This would cause requirement of double GPMC configuring and we lost
> > the opportunity to configure GPMC before driver is probed.
> 
> I am not convinced we need to. Furthermore with your change you do not
> actually set async mode in the onenand until _set_sync() is called.

Yes, setting async mode in onenand is done in set_sync function, and it is
always called by onenand driver indirectly.

Seems if setting async mode in onenand is taken out of set_sync & placed
it before set_sync invocation in gpmc_onenand_setup, intention will be
clear, right ? (even though sequence wise same thing is happening now)


> 
> > And the first step for onenand configuration is always to set it
> > to async mode (with the way it is done now), so it seems reasonable
> > to rely on normal GPMC configuration for async & then do reconfigure
> > for sync.
> 
> Yes but as far as I can see, it seems that this is the intent of the
> onenand_setup() function to perform the necessary initialisation.

I believe doing it in gpmc_onenand_init is better, due to the reasons
mentioned above as well as because function name will correspond to what
it is doing, i.e. initialization

> 
> Have you tested onenand? Do you have a board with onenand?

Yes, on omap3evm, with help of local patches (as mainline doesn't have
those). It was mentioned in cover letter of gpmc driver conversion series

Regards
Afzal
