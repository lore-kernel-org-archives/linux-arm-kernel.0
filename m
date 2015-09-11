From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 11 Sep 2015 09:07:11 +0200
Subject: [PATCH] ARM: exynos_defconfig: Disable simplefb support
In-Reply-To: <55F26042.2080600@samsung.com>
References: <1441892552-13819-1-git-send-email-javier@osg.samsung.com>
 <55F26042.2080600@samsung.com>
Message-ID: <55F27D9F.1000702@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 09/11/2015 07:01 AM, Krzysztof Kozlowski wrote:
> On 10.09.2015 22:42, Javier Martinez Canillas wrote:
>> The simplefb driver allows the kernel to render on a pre-allocated
>> buffer that's been initialized by firmware before the kernel boots.
>>
>> This option was enabled to have display working on the Exynos5250
>> Snow Chromebook by commit da9d0fbf5e9a ("ARM: exynos: defconfig
>> update") since proper DRM/KMS support did not exist at that time.
>>
>> But now that the Exynos DRM driver has support for this hardware,
>> there is no need to have simplefb enabled. In fact, if a user has
>> a u-boot that injects the simplefb dev node to the FDT before pass
>> it to the kernel, display won't be properly initialized and only a
>> blank screen will be shown since there isn't a proper handoff from
>> the simplefb driver to the Exynos DRM driver.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>
>> ---
>>
>>  arch/arm/configs/exynos_defconfig | 1 -
>>  1 file changed, 1 deletion(-)
> 
> Seems logical. None of the boards use simple-framebuffer compatible
> anyway. I understand that on Snow simplefb was needed along with change
> in Uboot like this one:
> https://chromium.googlesource.com/chromiumos/third_party/u-boot/+/refs/changes/58/49358/2
>

Exactly but you won't see the dev node with the "simple-framebuffer"
compatible string in the DTS since is the bootloader that adds this
device node to the FDT before passing it to the kernel.

The bootloader shouldn't mangle the FDT (with the exception of the
memory and choosen/bootargs nodes) but simplefb is just a hack to
re-use the display HW initialization made by the bootloader.

> and now none of Exynos boards use simplefb anymore?
>

Yes, there are no other Exynos boards using simplefb besides Snow
that I'm aware of but since Exynos DRM is working well on this board
from v4.0, there is no need for it anymore.

In fact, as explained in the commit message, it could do more harm
than good since users that are still booting with a u-boot that adds
the simplefb device node, only get a blank screen since the simplefb
driver is probed, creates a console and later the Exynos DRM probes
and re-initializes the HW creating its own console, causing this issue.

I got several reports of users that says that mainline stop booting for
them but is just that they didn't get display working. Disabling simplefb
makes display to work again so maybe this is even -rc material and should
go to stable # v4.0+

> Best regards,
> Krzysztof
> 
> 
 
Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
