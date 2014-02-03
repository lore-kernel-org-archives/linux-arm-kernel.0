From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 3 Feb 2014 08:26:48 -0800
Subject: [PATCH v2 2/3] ARM/ARM64: KVM: Add support for PSCI v0.2 emulation
In-Reply-To: <20140203105409.GF30209@e106331-lin.cambridge.arm.com>
References: <1391078479-7406-1-git-send-email-anup.patel@linaro.org>
 <1391078479-7406-3-git-send-email-anup.patel@linaro.org>
 <20140203105409.GF30209@e106331-lin.cambridge.arm.com>
Message-ID: <20140203162648.GC4167@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 03, 2014 at 10:54:09AM +0000, Mark Rutland wrote:
> On Thu, Jan 30, 2014 at 10:41:18AM +0000, Anup Patel wrote:
> > Currently, the in-kernel PSCI emulation provides PSCI v0.1 interface to
> > VCPUs. This patch extends current in-kernel PSCI emulation to provide
> > PSCI v0.2 interface to VCPUs.
> > 
> > By default, ARM/ARM64 KVM will always provide PSCI v0.1 interface for
> > keeping the ABI backward-compatible.
> > 
> > To select PSCI v0.2 interface for VCPUs, the user space (i.e. QEMU or
> > KVMTOOL) will have to set KVM_ARM_VCPU_PSCI_0_2 feature when doing VCPU
> > init using KVM_ARM_VCPU_INIT ioctl.
> 
> I have an issue with this. PSCI 0.2 makes all but two functions (MIGRATE
> and MIGRATE_INFO_CPU_UP) mandatory, and hence not allowed to return
> NOT_SUPPORTED.
> 
> Additionally, for correct behaviour across a kexec in future, we'll
> require AFFINITY_INFO for PSCI 0.2+ systems to determint when a CPU is
> actually dead (and cannot affect the cache hierarchy). I'd very much
> like to make that a hard requirement to ensure correctness.
> 
> I would very much like to see at least trivial implementations of those
> mandatory functions, so that we don't need a
> KVM_ARM_VCPU_PSCI_REALLY_0_2 or similar in future. As it stands this
> series does not implement PSCI 0.2.
> 
I didn't realize that PSCI 0.2 mandates more functions, that should
clearly be implemented first, and the patch series should also be
ordered with first supporting the implementation and then finally
exposing the functionality to user space.

Thanks,
-Christoffer
