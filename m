From: will.deacon@arm.com (Will Deacon)
Date: Thu, 18 May 2017 13:38:41 +0100
Subject: [PATCH] arm64: cpufeature: check translation granule size based
 on kernel config
In-Reply-To: <20170518113627.GC25294@leoy-ThinkPad-T440>
References: <1495102873-10858-1-git-send-email-leo.yan@linaro.org>
 <c0c8bd7b-647d-092d-65ac-08a90000e30c@arm.com>
 <20170518113627.GC25294@leoy-ThinkPad-T440>
Message-ID: <20170518123840.GD21359@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 07:36:27PM +0800, Leo Yan wrote:
> On Thu, May 18, 2017 at 11:39:01AM +0100, Suzuki K Poulose wrote:
> > On 18/05/17 11:21, Leo Yan wrote:
> > >In the big.LITTLE system with two clusters, one is CA53 cluster and
> > >another is CA73 cluster. CA53 doesn't support 16KB memory translation
> > >granule size (4.3.21 AArch64 Memory Model Feature Register 0, EL1; ARM
> > >DDI 0500F), but CA73 supports this feature (4.3.27 AArch64 Memory Model
> > >Feature Register 0, EL1; ARM 100048_0002_04_en). As result, the kernel
> > >reports log for "Unexpected variation" as below.
> > >
> > >[    0.182113] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU4: 0x00000000101122
> > 
> > >
> > >This patch is to change the checking CPU feature for memory translation
> > >granule size based on kernel configuration. If kernel configuration has
> > >selected to use one specific memory translation granule size, then we
> > >will do strict sanity checking cross all CPUs. Otherwise we can skip to
> > >check unused features for memory translation granule size if kernel
> > >doesn't use it.
> > >
> > 
> > If we were to suppress the warning (more on that below), we could simply
> > make this feature a NON_STRICT, since the unsupported CPUs won't boot
> > with 16K to hit this sanity check.
> > 
> > However, there is a problem with disabling this warning. If a VM starts
> > using 16KB page size on a 4K/64K host, the VM could end up in unknown
> > failures when it switches to an unsupported CPU (after it has booted).
> > Of course the real fix lies in making the KVM exposing the safe value
> > for granule support to the VCPUs (which is currently being worked on by
> > Douglas in Cc). So, when we have that ready, we could make it NON_STRICT
> > instead of this approach.
> 
> Thanks for the info :)
> 
> I will use below patch for production branch temporarily. You could
> work out one formal patch for upstreaming when the dependency patches
> are get ready:

The other thing we could do is change the way we taint on mismatch so that
we don't dump the scary (and pointless) backtrace.

Will
