From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Sep 2014 11:46:22 +0200
Subject: [PATCH v6] mfd: syscon: Decouple syscon interface from platform
 devices
In-Reply-To: <1411980458-32329-1-git-send-email-pankaj.dubey@samsung.com>
References: <1411980458-32329-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <8048434.zrhWRM6Kke@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 September 2014 14:17:38 Pankaj Dubey wrote:
> Currently a syscon entity can be only registered directly through a
> platform device that binds to a dedicated syscon driver. However in
> certain use cases it is desirable to make a device used with another
> driver a syscon interface provider.
> 
> For example, certain SoCs (e.g. Exynos) contain system controller
> blocks which perform various functions such as power domain control,
> CPU power management, low power mode control, but in addition contain
> certain IP integration glue, such as various signal masks,
> coprocessor power control, etc. In such case, there is a need to have
> a dedicated driver for such system controller but also share registers
> with other drivers. The latter is where the syscon interface is helpful.
> 
> In case of DT based platforms, this patch decouples syscon object from
> syscon platform driver, and allows to create syscon objects first time
> when it is required by calling of syscon_regmap_lookup_by APIs and keep
> a list of such syscon objects along with syscon provider device_nodes
> and regmap handles.
> 
> For non-DT based platforms, this patch keeps syscon platform driver
> structure where is can be probed and such non-DT based drivers can use
> syscon_regmap_lookup_by_pdev API and get access to regmap handles.
> Once all users of "syscon_regmap_lookup_by_pdev" migrated to DT based,
> we can completely remove platform driver of syscon, and keep only helper
> functions to get regmap handles.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Tomasz Figa <tomasz.figa@gmail.com>
> Tested-by: Vivek Gautam <gautam.vivek@samsung.com>
> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
> Patch v5 and related discussions can be found here [1].
> 
> Change since v5:
>  - Dropping creation of dummy platform device in of_syscon_register.
>  - As we are changing syscon to decouple from platform_device, creation of 
>    dummy platform_device does not look good option, and as suggested by Arnd,
>    I made another attempt so that regmap_mmio_init API should work with NULL
>    dev pointer itself. Since regmap needs to know about Syscon device node
>    properties so let's parse device node of syscon in syscon itself for any
>    such properties and using regmap_config parameter pass all such information
>    to regmap. Other concern of crashes due to NULL dev pointer in regmap already
>    addressed in separate patches of regmap. Please see [2] and [3].
>   
> 
> 

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Looks good to me, thanks a lot!



	Arnd
