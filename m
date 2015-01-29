From: ajaynumb@gmail.com (Ajay kumar)
Date: Thu, 29 Jan 2015 20:09:07 +0530
Subject: [PATCH V9 04/14] drm/bridge: ptn3460: Convert to i2c driver model
In-Reply-To: <20150129142919.GN2001@joana>
References: <1421771935-31618-1-git-send-email-ajaykumar.rs@samsung.com>
 <1421771935-31618-5-git-send-email-ajaykumar.rs@samsung.com>
 <20150129142919.GN2001@joana>
Message-ID: <CAEC9eQMKrUsdUdSRPNqE_YOobb__8nXLLe454kKXab14rPg-ZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gustavo,

I think Thierry already fixed it. Check this.
http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/drivers/gpu/drm/bridge/Kconfig


Regards,
Ajay



On Thu, Jan 29, 2015 at 7:59 PM, Gustavo Padovan <gustavo@padovan.org> wrote:
> Hi Ajay,
>
> 2015-01-20 Ajay Kumar <ajaykumar.rs@samsung.com>:
>
>> Use drm_bridge helpers to modify the driver to support
>> i2c driver model.
>>
>> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
>> Acked-by: Inki Dae <inki.dae@samsung.com>
>> Tested-by: Rahul Sharma <rahul.sharma@samsung.com>
>> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Tested-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
>> Tested-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
>> ---
>>  drivers/gpu/drm/bridge/Kconfig          |    2 +
>>  drivers/gpu/drm/bridge/ptn3460.c        |  124 +++++++++++++++++++++----------
>>  drivers/gpu/drm/exynos/exynos_dp_core.c |   22 ------
>>  3 files changed, 86 insertions(+), 62 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
>> index 884923f..4254c2b 100644
>> --- a/drivers/gpu/drm/bridge/Kconfig
>> +++ b/drivers/gpu/drm/bridge/Kconfig
>> @@ -1,5 +1,7 @@
>>  config DRM_PTN3460
>>       tristate "PTN3460 DP/LVDS bridge"
>>       depends on DRM
>> +     depends on OF && I2C
>
> Adding I2C here is causing this circular dependency:
>
> scripts/kconfig/conf --silentoldconfig Kconfig
> drivers/video/fbdev/Kconfig:5:error: recursive dependency detected!
> drivers/video/fbdev/Kconfig:5:  symbol FB is selected by DRM_KMS_FB_HELPER
> drivers/gpu/drm/Kconfig:34:     symbol DRM_KMS_FB_HELPER depends on
> DRM_KMS_HELPER
> drivers/gpu/drm/Kconfig:28:     symbol DRM_KMS_HELPER is selected by
> DRM_PTN3460
> drivers/gpu/drm/bridge/Kconfig:1:       symbol DRM_PTN3460 depends on I2C
> drivers/i2c/Kconfig:7:  symbol I2C is selected by FB_DDC
> drivers/video/fbdev/Kconfig:59: symbol FB_DDC is selected by FB_CYBER2000_DDC
> drivers/video/fbdev/Kconfig:374:        symbol FB_CYBER2000_DDC depends on
> FB_CYBER2000
> drivers/video/fbdev/Kconfig:362:        symbol FB_CYBER2000 depends on FB
>
> To solve this we just need to remove I2C from depends as DRM already selects
> I2C. This was already fixed by:
>
>
> commit 90bde571ad194adb039cb92a11a5b346f15eb610
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Tue Mar 25 12:06:46 2014 +0100
>
>     drm/bridge: PTN3460 needs DRM_KMS_HELPER
>
>     The recently added PTN3460 device driver uses interfaces that
>     are provided by the KMS helper infrastructure, so we should
>     explicitly select that to avoid this linker error:
>
>     ERROR: "drm_helper_probe_single_connector_modes" [drivers/gpu/drm/bridge/ptn3460.ko] undefined!
>     ERROR: "drm_helper_connector_dpms" [drivers/gpu/drm/bridge/ptn3460.ko] undefined!
>
>     We have to drop the I2C dependency to avoid a circular dependency
>     chain, but that's ok because DRM already selects I2C.
>
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>     Signed-off-by: Dave Airlie <airlied@redhat.com>
>
>
> But you may have introduced it again on a rebase. The following patch fixes it:
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 990b4b2..946d1ef 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -1,7 +1,6 @@
>  config DRM_PTN3460
>         tristate "PTN3460 DP/LVDS bridge"
> -       depends on DRM
> -       depends on OF && I2C
> +       depends on DRM && OF
>         select DRM_KMS_HELPER
>         select DRM_PANEL
>         ---help---
>
>
>         Gustavo
