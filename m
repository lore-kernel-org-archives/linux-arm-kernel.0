From: ezequiel@vanguardiasur.com.ar (Ezequiel =?iso-8859-1?Q?Garc=EDa?=)
Date: Wed, 25 Jun 2014 11:53:37 -0300
Subject: [PATCH/RESEND 8/9] drm/tilcdc: remove submodule destroy calls
In-Reply-To: <53A9F660.8060703@ti.com>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-9-git-send-email-guido@vanguardiasur.com.ar>
 <53A9F660.8060703@ti.com>
Message-ID: <20140625145337.GB743@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 Jun 05:06 PM, Darren Etheridge wrote:
> 
> On 06/17/2014 09:17 AM, Guido Mart?nez wrote:
> >The TI tilcdc driver is designed with a notion of submodules. Currently,
> >at unload time, these submodules are iterated and destroyed.
> >
> >Now that the tilcdc remove order is fixed, this can be handled perfectly
> 
> I am not sure I understand the first part of the above sentence - did
> something change with tilcdc ordering?

Yes, patch [PATCH/RESEND 6/9] drm/tilcdc: fix release order on exit changes
the tilcdc remove ordering. 

Currently, the tilcdc DRM is removed with this:

        tilcdc_tfp410_fini();
        tilcdc_slave_fini();
        tilcdc_panel_fini();
        platform_driver_unregister(&tilcdc_platform_driver);

Which is wrong as you shouldn't remove the tilcdc "modules" (panel, slave,
tfp410) before the DRM driver itself. So the above patch fixed it to be:

        platform_driver_unregister(&tilcdc_platform_driver);
        tilcdc_panel_fini();
        tilcdc_slave_fini();
        tilcdc_tfp410_fini();

> I think you a referring to previous
> patches in your series which really mean tilcdc can actually unload now.  So
> really the method this patch uses could always have been used, it just
> wasn't for some reason?
> 

No, I believe this patch which removes the tilcdc sub-module destroy
infrastructure can only be applied *after* the above remove order is fixed
(iow, the 6/9 patch mentioned above).

In other words, only once you have a proper remove() that releases things
in the right order you can rely in the kernel and avoid any custom
implementation.
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
