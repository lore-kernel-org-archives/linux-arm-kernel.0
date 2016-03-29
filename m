From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 29 Mar 2016 10:59:15 -0400
Subject: [PATCH 0/3] drm/exynos: Kconfig dependency fixes
In-Reply-To: <56FA03A3.1090205@samsung.com>
References: <1459214937-18686-1-git-send-email-javier@osg.samsung.com>
 <56F9DE63.6050808@samsung.com> <56F9EB3E.5080000@osg.samsung.com>
 <56FA03A3.1090205@samsung.com>
Message-ID: <56FA9843.70806@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Seung-Woo,

On 03/29/2016 12:25 AM, Seung-Woo Kim wrote:
> Hello Javier,
> 
> On 2016? 03? 29? 11:41, Javier Martinez Canillas wrote:
>> Hello Seung-Woo,
>>
>> Thanks a lot for your feedback.
>>
>> On 03/28/2016 09:46 PM, Seung-Woo Kim wrote:
>>> Hi Javier,
>>>
>>> On 2016? 03? 29? 10:28, Javier Martinez Canillas wrote:
>>>> Hello Inki,
>>>>
>>>> This patch series contains some fixes for the Kconfig symbol dependencies
>>>> of the Exynos DRM driver. They make sure that the Exynos DRM components
>>>> and the media platform drivers that makes use of the same HW IP block are
>>>> not enabled at the same time.
>>>>
>>>> Best regards,
>>>> Javier
>>>>
>>>>
>>>> Javier Martinez Canillas (3):
>>>>   drm/exynos: Use VIDEO_SAMSUNG_S5P_G2D=n as G2D Kconfig dependency
>>>>   drm/exynos: Use VIDEO_SAMSUNG_EXYNOS_GSC=n as GSC Kconfig dependency
>>>>   drm/exynos: Make DRM_EXYNOS_FIMC depend on VIDEO_S5P_FIMC=n
>>>
>>> In G2D case, there is only one instance, but for the other cases, there
>>> are several instances and in my environment, I enable both drivers on
>>> v4l2 and drm FIMC/GSC.
>>>
>>> So, IMHO, the not-enabled v4l2 dependency is not really required for drm
>>> fimc and drm gsc.
>>>
>>
>> I'm confused, it was you who added the depends on !VIDEO_SAMSUNG_EXYNOS_GSC
>> for DRM_EXYNOS_GSC in commit aeefb36832e5 ("drm/exynos: gsc: add device tree
>> support and remove usage of static mappings").
> 
> Yes, you are right. Originally, my goal on the GSC was bringing optional
> flag for setting isp mode or wb mode like FIMC in tizen.org git tree.
> 
> https://review.tizen.org/git/?p=platform/kernel/linux-exynos.git;a=blobdiff;f=Documentation/devicetree/bindings/media/exynos5-gsc.txt;h=d526777a3abd04d244c46fdd729e3df93bb86917;hp=0604d42f38d1941526d47ad11a958a2a83797f97;hb=751cd6d88d9620c83042641b52fdd244408a3947;hpb=7c7ab44f86d64ba6a6733da8f201a26a6c0e807f
> 
> But only devicetree part of GSC was upstreamed and simultaneous enabling
> both v4l2 gsc and drm gsc driver is removed. The only reason I set both
> driver simultaneously was enabling video codec, exynos-mfc with gsc to
> convert RGB plane.
> 
> I know Marek already has plan to integrate yuv plane feature of GSC to
> DRM KMS. Also, for GSC, simultaneous setup is alredy remove, so your
> patch seems better.
>

Ok, thanks for the confirmation. So at least patch 1/3 and 3/3 are needed then.
 
>>
>> >From the commit message "The driver cannot be used simultaneously with V4L2
>> Mem2Mem GScaller driver thought". Did that assumption changed and the depend
>> should be removed then? or maybe I misunderstood what you meant.
>>
>> Now, I'm not really sure about FIMC either, it was feedback I got from this
>> patch [0]. Could you please take a look to that and let me know if enabling
>> these drivers simultaneously makes sense then?
> 
> About FIMC, there is still simultaneous setup for both v4l2 and drm
> driver with devicetree binding flags, samsung,isp-wb and samsung,lcd-wb.
> 
> If on the FIMC instance of dt node, samsung,lcd-wb is set, then drm
> driver is probed, otherwise v4l2 driver is probed.
> 

Interesting, I didn't know about these DT properties. I see that some FIMC nodes
are using both though like in arch/arm/boot/dts/exynos4x12.dtsi. Is that a bug?

So if both the DRM and V4L2 drivers can be enabled at the same time for FIMC,
then patch 3/3 should be dropped and instead the exynos_defconfig patch that
enables CONFIG_VIDEO_S5P_FIMC should be picked IMHO.

> Simultaneous FIMC driver is also only for RGB converting of video codec
> planes like GSC at least to me.
> 
> Marek, do you have any idea about the simultaneous setup for fimc and gsc?
> 
> Best Regards,
> - Seung-Woo Kim
> 
>>
>>> Best Regards,
>>> - Seung-Woo Kim
>>>
>>>>
>>>>  drivers/gpu/drm/exynos/Kconfig | 6 +++---
>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>
>>
>> [0]: https://lkml.org/lkml/2016/3/23/292
>>
>> Best regards,
>>
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
