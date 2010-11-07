From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Sun, 7 Nov 2010 09:43:59 -0600
Subject: [PATCH 0/6] omap: iommu: hwmod support and code reorganization
In-Reply-To: <4CD59F04.2000406@ti.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
	<4CD59F04.2000406@ti.com>
Message-ID: <AANLkTinzR9uj816_o+j-1121Aw8Qc_p4uBGHRA31LU7f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 6, 2010 at 1:31 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> s/ducati/ipu/
> s/tesla/dsp/
>
> Please do not use internal codename for the changelog or even for the code.

I picked this terminology from the driver, I didn't want to cause
confusion, agree to the change.

> On 11/5/2010 9:19 PM, Ramirez Luna, Omar wrote:
>>
>> Boot tested on omap 3430 and 3630, functionality on iva2 only.
>>
>> Introduced hwmod data and support for omap3 (iva2 mmu& ?isp mmu) and
>> omap4 (ducati mmu& ?tesla mmu).
>>
>> Minor cleanup due to this changes.
>>
>> There is an issue (present without patches too):
>>
>> Doing a cycle of insmod-rmmod to iommu module and then full
>> insmod of bridgedriver (with all dependencies) causes the next
>> read of iommu registers to dump an unhandled fault log; this,
>> because when rmmod of iommu is called it tries to clean the
>> iommu tables and flush any old entry prior to removing the driver,
>> however these reads/writes are attempted while the MMU is under
>> reset and will timeout on the L3 IVA target agent, which will leave
>> MMU unusable until the proper restore sequence to clear this L3
>> error is executed.
>>
>> Fix would be to move page table allocation to iommu get and its
>> correspondent free to iommu put, however it will fall entirely
>> under iommu user responsibility, as it needs to clear the mmu
>> reset bit, before calling iommu functions that read/write into
>> mmu registers (which should apply only for first boot or on
>> baseimage reload); trading this restriction in order to keep
>> the same generic iommu code for all omap iommu devices.
>>
>> This issue has been seen on omap3 iva2 mmu, same restriction should
>
> I'm still not really understanding that issue.
> In theory, the reset is deasserted when the omap_device is enabled and will
> be re-asserted when the omap_device will be disable.

Probably I'm missing the bits telling hwmod to handle its reset bit, I
will recheck.

> Why is the mmu already under reset when the iommu is trying to clean the
> tables?

However, the driver disables the device on a call named iommu_put
(where, from your comment, reset should be re-asserted ), and cleans
the TLBs and page tables on removal of the driver (after iommu_put).

> Could please describe the complete sequence?

I'm assuming the dependencies are installed.

on boot up:
1. insmod iommu.ko
- device_enable is not called, unless a call to iommu_get is given,
this will mean that the driver has one user and thus device_enable is
called (however right now it doesn't matter if you call iommu_get or
not)

2. rmmod iommu.ko
- remove function will try to cleanup the TLBs writing into MMU
registers, since MMU is on reset it will trigger a timeout on its TA.

3. insmod bridgedriver.ko
- it is dependent on iommu.ko so it should have been installed before.
Whenever bridge calls iommu_get, the external abort will be caused due
to a read to MMU.

As I commented, cleaning the page tables could be moved from driver's
remove function to iommu_put, if omap device enable/disable is
handling the reset bit probably this issue shouldn't be hit.

Regards,

Omar
