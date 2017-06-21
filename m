From: will.deacon@arm.com (Will Deacon)
Date: Wed, 21 Jun 2017 10:08:03 +0100
Subject: [PATCH 1/1] iommu/arm-smmu-v3: replace writel with
 writel_relaxed in queue_inc_prod
In-Reply-To: <5949CBB7.1030908@huawei.com>
References: <1497956694-11784-1-git-send-email-thunder.leizhen@huawei.com>
 <acafb87c-4ba9-4a44-f868-c8f882717ab1@arm.com>
 <5949CBB7.1030908@huawei.com>
Message-ID: <20170621090803.GB3768@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 09:28:23AM +0800, Leizhen (ThunderTown) wrote:
> On 2017/6/20 19:35, Robin Murphy wrote:
> > On 20/06/17 12:04, Zhen Lei wrote:
> >> This function is protected by spinlock, and the latter will do memory
> >> barrier implicitly. So that we can safely use writel_relaxed. In fact, the
> >> dmb operation will lengthen the time protected by lock, which indirectly
> >> increase the locking confliction in the stress scene.
> > 
> > If you remove the DSB between writing the commands (to Normal memory)
> > and writing the pointer (to Device memory), how can you guarantee that
> > the complete command is visible to the SMMU and it isn't going to try to
> > consume stale memory contents? The spinlock is irrelevant since it's
> > taken *before* the command is written.
> OK, I see, thanks. Let's me see if there are any other methods. And I think
> that this may should be done well by hardware.

FWIW, I did use the _relaxed variants wherever I could when I wrote the
driver. There might, of course, be bugs, but it's not like the normal case
for drivers where the author didn't consider the _relaxed accessors
initially.

Will
