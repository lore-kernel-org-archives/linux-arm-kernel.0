From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Fri, 23 Dec 2011 10:30:53 -0600
Subject: [PATCH v4 4/4] OMAP3/4: iommu: adapt to runtime pm
In-Reply-To: <CAMP44s0hYWiZ8OnjQ6Jy_W7MCveP+WyHG18Tt2jRGzxSwoQP3w@mail.gmail.com>
References: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
 <1323922709-6986-5-git-send-email-omar.ramirez@ti.com>
 <CAMP44s3Jb9DZLUyDVU_HmQbaJKp=2qym7Z6uauNchJh0fPL4hQ@mail.gmail.com>
 <CAB-zwWhpmwRP2mNu-CdX-RVgmTRjw0UsYckAVsM+qztmVdvc7A@mail.gmail.com>
 <CAMP44s0hYWiZ8OnjQ6Jy_W7MCveP+WyHG18Tt2jRGzxSwoQP3w@mail.gmail.com>
Message-ID: <CAB-zwWio5iMTyofv3Hx5Q7G7rYY5cRU4kXNQzMF0NRprEd8=5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 10:27 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Fri, Dec 16, 2011 at 5:18 AM, Ramirez Luna, Omar <omar.ramirez@ti.com> wrote:
>> On Thu, Dec 15, 2011 at 6:53 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> On Thu, Dec 15, 2011 at 6:18 AM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
>>>> Use runtime PM functionality interfaced with hwmod enable/idle
>>>> functions, to replace direct clock operations, reset and sysconfig
>>>> handling.
>>>>
>>>> Removed clk handling during interrupt, given that in order to receive one,
>>>> the device should be powered on in advance. Now doing pm_runtime_get/put
>>>> on iommu_enable/disable so it doesn't rely on others to keep the clocks on.
>>>>
>>>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>>>> ---
>>>> ?arch/arm/mach-omap2/iommu2.c ? ? ? ? ? ? | ? 17 -----------
>>>> ?arch/arm/mach-omap2/omap-iommu.c ? ? ? ? | ? ?1 -
>>>> ?arch/arm/plat-omap/include/plat/iommu.h ?| ? ?2 -
>>>> ?arch/arm/plat-omap/include/plat/iommu2.h | ? ?2 -
>>>> ?drivers/iommu/omap-iommu.c ? ? ? ? ? ? ? | ? 44 ++++++++++++-----------------
>>>> ?5 files changed, 18 insertions(+), 48 deletions(-)
>>>
>>> Shouldn't pm_runtime_enable() be called in omap_iommu_init(), and
>>> omap_iommu_probe() call pm_runtime_get_sync()/put() on the sections
>>> where the device should be active?
>>
>> omap_iommu_init is called on module init however omap_iommu_probe is
>> called by driver instance (isp, iva), on probe pm_runtime_enable
>> activates runtime for both isp and iva devices, one at a time.
>
> Yes, but omap_iommu_init() will *always* be called at boot time and
> will register the data for all the devices.

There are 2 omap_iommu_init :/ Thought you were talking about the one
in drivers/iommu/omap-iommu.c.

> If the 'iommu' module is
> never loaded, then the devices will remain active the whole time.

oma-iommu is meant to be built-in as part of the kernel, there is no
option for module anymore.

Regards,

Omar
