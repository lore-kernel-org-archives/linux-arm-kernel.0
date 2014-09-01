From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 01 Sep 2014 14:07:34 +0200
Subject: [PATCH 10/29] drivers: add DRIVER_HAS_OWN_IOMMU_MANAGER flag
In-Reply-To: <5493968.dbuSPSqts4@wuerfel>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
 <4621634.jlJLccozTJ@wuerfel> <54044EAC.6010701@samsung.com>
 <5493968.dbuSPSqts4@wuerfel>
Message-ID: <54046186.5030407@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-09-01 13:56, Arnd Bergmann wrote:
> On Monday 01 September 2014 12:47:08 Marek Szyprowski wrote:
>>> Who do you think needs to set this flag, and who needs to read it?
>> In the proposed solution Exynos IOMMU driver creates a separate IO
>> address space
>> for every client device in a system and binds it to the default
>> dma-mapping space
>> for the given device. When drivers are doing its own management of IO
>> address
>> space, instead of relying on what is available by default with dma-mapping
>> interface, this will require releasing of the previously created default
>> structures and resources. So this flag is set by the driver doing its own
>> management of io address space. The flags is then checked by Exynos
>> IOMMU driver
>> to avoid creating the default dma-mapping address space for devices
>> which driver
>> does its own management.
> I don't completely understand it yet. I would assume the device
> to be added to the default domain at device creation time
> (of_platform_populate), way before we know which device driver
> is going to be used. How can this prevent the iommu driver
> from doing the association with the domain?

of_platform_populate() is too early to do the association, because that 
time the
exynos iommu driver is even not yet probed.

The association with default dma-mapping domain is done in
IOMMU_GROUP_NOTIFY_BIND_DRIVER notifier, just before binding the driver 
to the
given device. This way iommu driver can check dev->driver->flags and 
skip creating
default dma-mapping domain if driver announces that it wants to handle it by
itself.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
