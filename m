From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 May 2017 13:22:47 +0200
Subject: [PATCH] drm/pl111: add ARM_AMBA dependency
In-Reply-To: <CAJKOXPeweaJxUHM=uURarbW8dWeZ=PHt7W7k0wt-cfhz0_2QUg@mail.gmail.com>
References: <20170522152058.3346428-1-arnd@arndb.de>
 <20170522163231.bk6zltgzse4szm2o@kozik-lap>
 <CAK8P3a2Rbd2tnehO4vnqgmMYTPqgvws3ZEtbzJ86AxVWd9j6nA@mail.gmail.com>
 <CAJKOXPeweaJxUHM=uURarbW8dWeZ=PHt7W7k0wt-cfhz0_2QUg@mail.gmail.com>
Message-ID: <CAK8P3a1EwzUH=4P96oOJyv42Z_hbOh5McLYiTT_Dn_XZshybEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 23, 2017 at 1:17 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Mon, May 22, 2017 at 11:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Mon, May 22, 2017 at 6:32 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>> On Mon, May 22, 2017 at 05:20:08PM +0200, Arnd Bergmann wrote:
>>>> The driver is written in a way to enable compile-testing without CONFIG_ARM_AMBA,
>>>> but it just causes needless warnings:
>>>>
>>>> drivers/gpu/drm/pl111/pl111_drv.c:149:26: error: 'pl111_drm_driver' defined but not used [-Werror=unused-variable]
>>>> drivers/gpu/drm/pl111/pl111_drv.c:81:12: error: 'pl111_modeset_init' defined but not used [-Werror=unused-function]
>>>>
>>>> This removes the #ifdef instead, and adds a dependency on ARM_AMBA to
>>>> only let us build the driver when the base support is enabled.
>>>>
>>>> Unfortunately, this requires removing one redundant 'select ARM_AMBA'
>>>> line from mach-s3c64xx to avoid a circular dependency.
>>>>
>>>> It might be good to allow manually enabling ARM_AMBA when COMPILE_TEST
>>>> is turned on, but that should be a separate patch and may cause other
>>>> build regressions.
>>>>
>>>> Fixes: bed41005e617 ("drm/pl111: Initial drm/kms driver for pl111")
>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>>> ---
>>>>  arch/arm/mach-s3c64xx/Kconfig     | 1 -
>>>>  drivers/gpu/drm/pl111/Kconfig     | 1 +
>>>>  drivers/gpu/drm/pl111/pl111_drv.c | 2 --
>>>>  3 files changed, 1 insertion(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
>>>> index 459214fa20b4..5ee5ad74a3d6 100644
>>>> --- a/arch/arm/mach-s3c64xx/Kconfig
>>>> +++ b/arch/arm/mach-s3c64xx/Kconfig
>>>> @@ -40,7 +40,6 @@ config CPU_S3C6410
>>>>
>>>>  config S3C64XX_PL080
>>>>       def_bool DMADEVICES
>>>> -     select ARM_AMBA
>>>
>>> I must admit that I miss how pl111 DRM driver create circular dependency
>>> with S3C64XX_PL080 (or AMBA_PL08X?). Maybe it is unrelated change and
>>> should be a separate patch?
>>
>> When I add 'depends on ARM_AMBA' for pl111, I get this dependency loop:
>>
>> drivers/i2c/Kconfig:7: symbol I2C is selected by FB_DDC
>> For a resolution refer to Documentation/kbuild/kconfig-language.txt
>> subsection "Kconfig recursive dependency limitations"
>> drivers/video/fbdev/Kconfig:63: symbol FB_DDC is selected by FB_CYBER2000_DDC
>> For a resolution refer to Documentation/kbuild/kconfig-language.txt
>> subsection "Kconfig recursive dependency limitations"
>> drivers/video/fbdev/Kconfig:381: symbol FB_CYBER2000_DDC depends on FB_CYBER2000
>> For a resolution refer to Documentation/kbuild/kconfig-language.txt
>> subsection "Kconfig recursive dependency limitations"
>> drivers/video/fbdev/Kconfig:369: symbol FB_CYBER2000 depends on FB
>> For a resolution refer to Documentation/kbuild/kconfig-language.txt
>> subsection "Kconfig recursive dependency limitations"
>> drivers/video/fbdev/Kconfig:5: symbol FB is selected by DRM_KMS_FB_HELPER
>> For a resolution refer to Documentation/kbuild/kconfig-language.txt
>> subsection "Kconfig recursive dependency limitations"
>> drivers/gpu/drm/Kconfig:72: symbol DRM_KMS_FB_HELPER is selected by
>> DRM_KMS_CMA_HELPER
>> For a resolution refer to Documentation/kbuild/kconfig-language.txt
>> subsection "Kconfig recursive dependency limitations"
>> drivers/gpu/drm/Kconfig:137: symbol DRM_KMS_CMA_HELPER is selected by DRM_PL111
>> For a resolution refer to Documentation/kbuild/kconfig-language.txt
>> subsection "Kconfig recursive dependency limitations"
>> drivers/gpu/drm/pl111/Kconfig:1: symbol DRM_PL111 depends on ARM_AMBA
>> For a resolution refer to Documentation/kbuild/kconfig-language.txt
>> subsection "Kconfig recursive dependency limitations"
>> drivers/amba/Kconfig:1: symbol ARM_AMBA is selected by S3C64XX_PL080
>> For a resolution refer to Documentation/kbuild/kconfig-language.txt
>> subsection "Kconfig recursive dependency limitations"
>> arch/arm/mach-s3c64xx/Kconfig:42: symbol S3C64XX_PL080 default value
>> contains DMADEVICES
>> For a resolution refer to Documentation/kbuild/kconfig-language.txt
>> subsection "Kconfig recursive dependency limitations"
>> drivers/dma/Kconfig:5: symbol DMADEVICES is selected by SND_SOC_SH4_SIU
>> For a resolution refer to Documentation/kbuild/kconfig-language.txt
>> subsection "Kconfig recursive dependency limitations"
>> sound/soc/sh/Kconfig:29: symbol SND_SOC_SH4_SIU is selected by SND_SIU_MIGOR
>> For a resolution refer to Documentation/kbuild/kconfig-language.txt
>> subsection "Kconfig recursive dependency limitations"
>> sound/soc/sh/Kconfig:59: symbol SND_SIU_MIGOR depends on I2C
>>
>> We could break the loop at any of those places, but the
>> S3C64XX_PL080 symbol seemed the easiest way since the
>> 'select' there is completely unnecessary and it directly relates
>> to the change I made in PL111.
>
> Assuming ARM_AMBA is unnecessary here, then it should be unnecessary
> in other platforms as well but we have it (git grep 'select
> ARM_AMBA'). The ARM_AMBA is a dependency of AMBA_PL08X which is
> selected by S3C64xx... so IMHO this is needed.

I guess I should have explained it in more detail: S3C64XX_PL080
is set to 'ARCH_S3C64XX && DMADEVICES', and ARCH_S3C64XX
selects ARM_AMBA, so the 'select ARM_AMBA' for S3C64XX_PL080
is redundant. We still need it, but it's already guaranteed to be enabled.

        Arnd
