From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 18 May 2015 15:26:38 +0200
Subject: [PATCH v6 00/25] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
In-Reply-To: <CABxcv=mpCQKyuJOFsUgMdhD50yYdH+WwnEbYUNXByErMHpUuYA@mail.gmail.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
 <CABxcv=mpCQKyuJOFsUgMdhD50yYdH+WwnEbYUNXByErMHpUuYA@mail.gmail.com>
Message-ID: <5559E88E.9050108@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2015-05-11 18:00, Javier Martinez Canillas wrote:
> Hello Marek,
>
> On Mon, May 4, 2015 at 10:15 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> Hello Everyone,
>>
>> This is yet another attempt to get Exynos SYSMMU driver with integrated
>> with IOMMU & DMA-mapping subsystems. The main change from previous
>> version is addition of the patches to define iommu-mapping, which need
>> to be created during system boot to avoid IOMMU fault by devices, which
>> has been left enabled by bootloader (i.e. framebuffer displaying slash
>> screen).
>>
>> Patches has been also rebased onto v4.1-rc2 with 'arm: dma-mapping: fix
>> off-by-one check in arm_setup_iommu_dma_ops' patch applied (see commit
>> 1424532b2163bf1580f4b1091a5801e12310fac5 on fixes branch in
>> git://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-arm.git,
>> more information:
>> http://www.spinics.net/lists/arm-kernel/msg414722.html).
>>
>> All patches are also available in the following git repository:
>> https://git.linaro.org/people/marek.szyprowski/linux-srpol.git
>> branch v4.1-exynos-iommu.
>>
> Thanks for the new series, this time I didn't get a system hang when I
> enabled both CONFIG_DRM_EXYNOS_FIMD and CONFIG_DRM_EXYNOS_DP on my
> Exynos5420 Peach Pit Chromebook.
>
> The system finished booting and I have both a console on the HDMI and
> eDP/LVDS displays. But if I try to start X or weston, I again have a
> completele system hang with no output on the serial console. This
> works correctly without your IOMMU series.
>
> And again disabling CONFIG_DRM_EXYNOS_DP or CONFIG_DRM_EXYNOS_FIMD
> avoids the system to hang. If I only have CONFIG_DRM_EXYNOS_HDMI
> enabled, then I can start X with out issues and is displayed correctly
> in the HDMI output.
>
> So it seems your workaround for the boot-loader leaving the FIMD dma
> engine enabled is not enough? I'm not a graphics person so I can think
> of the top of my head what could trigger the system hang when X or
> weston are executed so I wondered if you have any ideas.

This means that there are more bugs in Exynos DRM driver. Once Exynos DRM
driver is probed, the initial iommu domain with identity mapping is 
destroyed
and Exynos DRM manages it's own iommu domain, so it has nothing to my
mentioned patch.

I will try to check this issue.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
