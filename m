From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Wed, 2 Nov 2011 10:22:04 -0500
Subject: [PATCH v3 4/4] OMAP3/4: iommu: adapt to runtime pm
In-Reply-To: <CAJ0PZbSpxtp1bvbdWxK-hsg=XUbfodgY-7D37rOn=s3yB-Upjw@mail.gmail.com>
References: <1320185752-568-1-git-send-email-omar.ramirez@ti.com>
	<1320185752-568-5-git-send-email-omar.ramirez@ti.com>
	<CAJ0PZbSpxtp1bvbdWxK-hsg=XUbfodgY-7D37rOn=s3yB-Upjw@mail.gmail.com>
Message-ID: <CAB-zwWgsL1aLxg62vy8EnQ_CrotQ4qVFpw-p0DxkweUPQ+poQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi MyungJoo,

On Wed, Nov 2, 2011 at 5:16 AM, MyungJoo Ham <myungjoo.ham@gmail.com> wrote:
> On Wed, Nov 2, 2011 at 7:15 AM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
>> Use runtime PM functionality interfaced with hwmod enable/idle
>> functions, to replace direct clock operations, reset and sysconfig
>> handling.
>>
>> Tidspbridge uses a macro removed with this patch, for now the value
>> is hardcoded to avoid breaking compilation.
>>
>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>> ---
>> ?arch/arm/mach-omap2/iommu2.c ? ? ? ? ? ? ? ? ? ? ?| ? 17 --------
>> ?arch/arm/mach-omap2/omap-iommu.c ? ? ? ? ? ? ? ? ?| ? ?1 -
>> ?arch/arm/plat-omap/include/plat/iommu.h ? ? ? ? ? | ? ?2 -
>> ?arch/arm/plat-omap/include/plat/iommu2.h ? ? ? ? ?| ? ?2 -
>> ?drivers/iommu/omap-iommu.c ? ? ? ? ? ? ? ? ? ? ? ?| ? 46 ++++++++-------------
>> ?drivers/staging/tidspbridge/core/tiomap3430_pwr.c | ? ?2 +-
>> ?6 files changed, 19 insertions(+), 51 deletions(-)
>>
>> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
>> index bbbf747..3c55be0 100644
>> --- a/drivers/iommu/omap-iommu.c
>> +++ b/drivers/iommu/omap-iommu.c
>> @@ -123,11 +123,11 @@ static int iommu_enable(struct omap_iommu *obj)
>> ? ? ? ?if (!arch_iommu)
>> ? ? ? ? ? ? ? ?return -ENODEV;
>>
>> - ? ? ? clk_enable(obj->clk);
>> + ? ? ? pm_runtime_enable(obj->dev);
>> + ? ? ? pm_runtime_get_sync(obj->dev);
>>
>> ? ? ? ?err = arch_iommu->enable(obj);
>>
>> - ? ? ? clk_disable(obj->clk);
>> ? ? ? ?return err;
>> ?}
>>
>> @@ -136,11 +136,10 @@ static void iommu_disable(struct omap_iommu *obj)
>> ? ? ? ?if (!obj)
>> ? ? ? ? ? ? ? ?return;
>>
>> - ? ? ? clk_enable(obj->clk);
>> -
>> ? ? ? ?arch_iommu->disable(obj);
>>
>> - ? ? ? clk_disable(obj->clk);
>> + ? ? ? pm_runtime_put_sync(obj->dev);
>> + ? ? ? pm_runtime_disable(obj->dev);
>> ?}
> I'm just curious here... Is there any reason to do
> pm_runtime_enable/disable at iommu_enable/iommu_disable which are
> called by iommu_attach/detach?
> I thought that normally, ideal locations of pm_runtime_enable/disable
> for such devices are in probe/remove() because it assures that the
> device is suspended after the probe.
> It seems that the device might be kept on after probe and before the
> first iommu_attach if it is default-on.

The default state of these MMUs is on reset and needs to be deasserted
to be used, but you're right, it makes more sense to move
pm_runtime_enable/disable calls to probe/remove. I'll wait a bit, do
this change and resubmit.

Thanks for the comment,

Omar
