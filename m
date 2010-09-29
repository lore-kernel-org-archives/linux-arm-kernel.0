From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Wed, 29 Sep 2010 22:12:24 +0300
Subject: [PATCH 05/11] omap3: Remove non-existent config option
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930234006B4C@dbde02.ent.ti.com>
References: <20100924014938.10325.35279.stgit@baageli.muru.com>
	<20100924015056.10325.95854.stgit@baageli.muru.com>
	<AANLkTik+Qgn5dYd+p_PvEUQFhcwQ2NVxW-fhEdurO6s+@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F70753CB@dbde02.ent.ti.com>
	<AANLkTinF=iV8p=jmg-YntCpX_BHmavLD3gu2LhhBFRq6@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930233C361B4@dbde02.ent.ti.com>
	<AANLkTim9Y3i7M9Jjo6RZs7zMNVZUkFm1P7P=h0y2J=Nj@mail.gmail.com>
	<8F7AF80515AF0D4D93307E594F3CB40E5F6A365B@dlee03.ent.ti.com>
	<AANLkTimD_MRbuTnBMPzAKPTmrDwjLkLVmr9bTSNROb5L@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930234006B4C@dbde02.ent.ti.com>
Message-ID: <AANLkTinZqx2nFuoYoCYpD4+PG7_J=ACLBxAwOvpVm4c9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 29, 2010 at 4:28 PM, Marathe, Yogesh <yogesh_marathe@ti.com> wrote:
> dsplink and syslink (two drivers who use iommu) should not enable
> CONFIG_MPU_BRIDGE_IOMMU as dspbridge and dsplink /syslink
> can not co-exist as they are using same resources. Not applying patch
> breaks dsplink/sylink any one which is being used. Defining this config
> makes them co-exist.

No, for dsp-link you would have:
CONFIG_TIDSPBRIDGE=n
CONFIG_OMAP_IOMMU_IVA2=y

It would be exactly the same as applying your patch.

And tidspbridge is not using iommu right now.

And AFAIK syslink is not for omap3, so omap3_devices is not relevant.

> I'm ok with changing name to CONFIG_OMAP_IOMMU_IVA2 but ideally
> then that will also break the dspbridge.

No, grep for MPU_BRIDGE_IOMMU on the current tidspbridge in mainline;
it's not defined anywhere, so CONFIG_OMAP_IOMMU_IVA2, or
CONFIG_FOOBAR, it doesn't matter for tidspbridge right now. And
MPU_BRIDGE_IOMMU doesn't depend on tidspbridge on any way.

> One more way would be to soure revert the patch and apply on dspbridge branch if it breaks the builds on that branch rather than
> breaking others in master.

There is no tidspbrige branch; it's in mainline:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=tree;f=drivers/staging/tidspbridge

But that doesn't matter, even if it was in a branch, iommu should not
break either tidspbridge, or dsp-link, and driver branches should not
modify anything outside their domain (ideally).

All you need to do is 'select OMAP_IOMMU_IVA2', although the attached
patch would be needed.

-- 
Felipe Contreras
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-omap-iommu-make-iva2-iommu-selectable.patch
Type: text/x-patch
Size: 1354 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100929/78b784ae/attachment.bin>
