From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Tue, 12 Dec 2017 11:26:08 -0700
Subject: mainline/master boot bisection: v4.15-rc3 on peach-pi
 #3228-staging
In-Reply-To: <beef1026-3dbe-5284-d2fa-a2298c52e7c0@osg.samsung.com>
References: <680389204.71.1512980755810.JavaMail.jenkins@ip-172-30-0-246>
 <51e6d7fb-ac9e-a59f-ea63-ad06219b429d@collabora.com>
 <CAKMK7uFcGftSeQjkKu9SZmkQd8-irbUTMcOnUwi7HZtb5TePag@mail.gmail.com>
 <CABxcv=mUHgTxvYpOYstE7rQn8fKS3QGiTT=FzBUc8DREvVuTeQ@mail.gmail.com>
 <CABxcv=m-fYZvYN4gLwBf8NwHvJb7PtNdVKR+SXgVKExZGtW4Qw@mail.gmail.com>
 <20171211225829.GA1959@n2100.armlinux.org.uk>
 <20171211230213.GB1959@n2100.armlinux.org.uk>
 <CGME20171211232533epcas1p1821f8808ca6da7bd28c57fb4121d36fa@epcas1p1.samsung.com>
 <2df0fc74-8b79-5cca-7a8a-9e005b44d8d8@osg.samsung.com>
 <2139f436-5646-7f9f-a6cb-285a0fd31969@samsung.com>
 <CABxcv=n9PvoYr1xwB8CHBmE00XaTUqT642g7F8nuZd-d031h5Q@mail.gmail.com>
 <88bebc9d-a889-403b-a742-c11ad6617638@samsung.com>
 <beef1026-3dbe-5284-d2fa-a2298c52e7c0@osg.samsung.com>
Message-ID: <fcab4daa-678c-ee48-a5ec-9d22c535ff29@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2017 07:47 AM, Shuah Khan wrote:
> On 12/12/2017 01:47 AM, Marek Szyprowski wrote:
>> Hi Javier,
>>
>> On 2017-12-12 09:00, Javier Martinez Canillas wrote:
>>> On Tue, Dec 12, 2017 at 8:54 AM, Marek Szyprowski
>>> <m.szyprowski@samsung.com> wrote:
>>>> On 2017-12-12 00:25, Shuah Khan wrote:
>>>>> On 12/11/2017 04:02 PM, Russell King - ARM Linux wrote:
>>>>>> On Mon, Dec 11, 2017 at 10:58:29PM +0000, Russell King - ARM Linux wrote:
>>>>>>> On Mon, Dec 11, 2017 at 11:54:48PM +0100, Javier Martinez Canillas
>>>>>>> wrote:
>>>>>>>> So I gave a quick look to this, and at the very least there's a bug in
>>>>>>>> the Exynos5800 Peach Pi DTS caused by commit 1cb686c08d12 ("ARM: dts:
>>>>>>>> exynos: Add status property to Exynos 542x Mixer nodes").
>>>>>>>>
>>>>>>>> I've posted a fix for that:
>>>>>>>>
>>>>>>>> https://patchwork.kernel.org/patch/10105921/
>>>>>>>>
>>>>>>>> I believe this could be also be the cause for the boot failure, since
>>>>>>>> I see in the boot log that things start to go wrong after exynos-drm
>>>>>>>> fails to bind the HDMI component:
>>>>>>>>
>>>>>>>> [ 2.916347] exynos-drm exynos-drm: failed to bind 14530000.hdmi (ops
>>>>>>>> 0xc1398690): -1
>>>>>>> Umm, -1 ?? Looking that error code up in
>>>>>>> include/uapi/asm-generic/errno-base.h says it's -EPERM.
>>>>>>>
>>>>>>> I suspect that's someone just returning -1 because they're lazy...
>>>>>>> which is real bad form and needs fixing.
>>>>>> Oh, it really is -EPERM:
>>>>>>
>>>>>> struct exynos_drm_crtc *exynos_drm_crtc_get_by_type(struct drm_device
>>>>>> *drm_dev,
>>>>>> ???????????????????????????????????????? enum exynos_drm_output_type
>>>>>> out_type)
>>>>>> {
>>>>>> ????????? struct drm_crtc *crtc;
>>>>>>
>>>>>> ????????? drm_for_each_crtc(crtc, drm_dev)
>>>>>> ????????????????? if (to_exynos_crtc(crtc)->type == out_type)
>>>>>> ????????????????????????? return to_exynos_crtc(crtc);
>>>>>>
>>>>>> ????????? return ERR_PTR(-EPERM);
>>>>>> }
>>>>>>
>>>>>> Does "Operation not permitted" really convey the error here?? It doesn't
>>>>>> look like a permission error to me.
>>>>>>
>>>>>> Can we please avoid abusing errno codes?
>>>>> I tried 4.15-rc3 on odroid-xu4 after seeing drm issues reported. 4.15-rc2+
>>>>> with top commit g968edbd worked just fine for me last Friday. I ran
>>>>> several
>>>>> tests and everything checked out except the exynos-gsc lockdep issue I
>>>>> sent
>>>>> a 4.14 patch for.
>>>>>
>>>>> However, with 4.15-rc3, dmesg is gets filled with
>>>>>
>>>>> [? 342.337181] [drm] Non-contiguous allocation is not supported without
>>>>> IOMMU, falling back to contiguous buffer
>>>>> [? 342.337470] [drm] Non-contiguous allocation is not supported without
>>>>> IOMMU, falling back to contiguous buffer
>>>>> [? 342.337851] [drm] Non-contiguous allocation is not supported without
>>>>> IOMMU, falling back to contiguous buffer
>>>>> [? 402.382346] [drm] Non-contiguous allocation is not supported without
>>>>> IOMMU, falling back to contiguous buffer
>>>>> [? 402.396682] [drm] Non-contiguous allocation is not supported without
>>>>> IOMMU, falling back to contiguous buffer
>>>>> [? 402.399244] [drm] Non-contiguous allocation is not supported without
>>>>> IOMMU, falling back to contiguous buffer
>>>>> [? 402.399496] [drm] Non-contiguous allocation is not supported without
>>>>> IOMMU, falling back to contiguous buffer
>>>>> [? 402.399848] [drm] Non-contiguous allocation is not supported without
>>>>> IOMMU, falling back to contiguous buffer
>>>>> [? 402.400163] [drm] Non-contiguous allocation is not supported without
>>>>> IOMMU, falling back to contiguous buffer
>>>>> [? 402.400495] [drm] Non-contiguous allocation is not supported without
>>>>> IOMMU, falling back to contiguous buffer
>>>>> [? 402.401294] [drm] Non-contiguous allocation is not supported without
>>>>> IOMMU, falling back to contiguous buffer
>>>>> [? 402.401595] [drm] Non-contiguous allocation is not supported without
>>>>> IOMMU, falling back to contiguous buffer
>>>>>
>>>>> Something broke in 4.15-rc3 on odroix-xu4 badly with exynos_defconfig.
>>>>>
>>>>> I will start bisect and try to isolate the problem. I suspect this is
>>>>> related to dts
>>>>> changes perhaps? I used to this problem a while back and it has been
>>>>> fixed.
>>>>
>>>> This warning has been added intentionally, see following discussions:
>>>> https://patchwork.kernel.org/patch/10034919/
>>>> https://patchwork.kernel.org/patch/10070475/
>>>>
>>>> This means that your test apps should be updated or you should enable Exynos
>>>> IOMMU support in your config. Maybe it is a good time to finally enable it
>>>> in exynos_defconfig.
>>>>
>>> Has the issue that the boot-loader keeps the display controller
>>> enabled and scanning pages on the Exynos Chromebooks resolved?
>>>
>>> I think that's that preventing to enable it by default in
>>> exynos_defconfig since it caused boot failures when enabled on these
>>> machines. I don't follow exynos development too closely nowadays so
>>> maybe there's a fix in place now.
>>
>> Not directly. I still didn't find time to properly add support for
>> devices, which were left in-working state (with active DMA
>> transactions) by bootloader, but due to some other changes in the
>> order of operations during boot process, power domains are
>> initialized very early and due to temporary lack of devices (which
>> are not yet added to the system), are turned off. This practically
>> stops FIMD for scanning framebuffer and "solves" this issue.
>>
>> I've checked now and Exynos Snow Chromebook boots fine with IOMMU
>> support enabled, both with v4.15-rc3 and linux-next.

Would it make sense to enable EXYNOS_IOMMU in exynos_defconfig. I sent
a patch to do that a while back. The decision at the time to not pull
that patch is was based on systems not booting with it enabled.

Is it time to revisit that or the recommendation is for IOMMU to be
enabled in configs manually on systems it is safe to do so?

thanks,
-- Shuah
