From: raghavendra.kt@linux.vnet.ibm.com (Raghavendra K T)
Date: Wed, 09 Oct 2013 14:42:45 +0530
Subject: [PATCH v2 0/2] KVM: Yield CPU when vcpu executes a WFE
In-Reply-To: <1381253894-18114-1-git-send-email-marc.zyngier@arm.com>
References: <1381253894-18114-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <52551E0D.6040004@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2013 11:08 PM, Marc Zyngier wrote:
> This is a respin of a patch I posted a long while ago, this time with
> numbers that I hope to be convincing enough.
>
> The basic idea is that spinning on WFE in a guest is a waste of
> resource, and that we're better of running another vcpu instead. This
> specially shows when the system is oversubscribed. The guest vcpus can
> be seen spinning, waiting for a lock to be released while the lock
> holder is nowhere near a physical CPU.
>
> This patch series just enables WFE trapping on both ARM and arm64, and
> calls kvm_vcpu_on_spin(). This is enough to boost other vcpus, and
> dramatically reduce the overhead.
>
> Branch available at:
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/wfe-trap
>
> Changes from v1:
> - Added CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT, as it seems to give
>    slightly better results (Thanks to Raghavendra K T)
> - Updated commit message with results of 8x configuration
>
> Marc Zyngier (2):
>    ARM: KVM: Yield CPU when vcpu executes a WFE
>    arm64: KVM: Yield CPU when vcpu executes a WFE

Using PLE handler and enabling CPU_RELAX_INTERCEPT part of the patches
looks fine.
