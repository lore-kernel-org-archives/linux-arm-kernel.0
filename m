From: takuya.yoshikawa@gmail.com (Takuya Yoshikawa)
Date: Mon, 3 Nov 2014 12:01:49 +0900
Subject: [PATCH v12 2/6] KVM: Add generic support for dirty page logging
In-Reply-To: <54528F24.6060602@samsung.com>
References: <1414017251-5772-1-git-send-email-m.smarduch@samsung.com>
 <1414017251-5772-3-git-send-email-m.smarduch@samsung.com>
 <20141030131430.5b50a7c0.cornelia.huck@de.ibm.com>
 <54528F24.6060602@samsung.com>
Message-ID: <20141103120149.01a61560dabe267b89a2478a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 Oct 2014 12:19:00 -0700
Mario Smarduch <m.smarduch@samsung.com> wrote:

> On 10/30/2014 05:14 AM, Cornelia Huck wrote:
> > On Wed, 22 Oct 2014 15:34:07 -0700
> > Mario Smarduch <m.smarduch@samsung.com> wrote:
> > 
> >> This patch defines KVM_GENERIC_DIRTYLOG, and moves dirty log read function
> >> to it's own file virt/kvm/dirtylog.c. x86 is updated to use the generic
> >> dirty log interface, selecting KVM_GENERIC_DIRTYLOG in its Kconfig and 
> >> makefile. No other architectures are affected, each uses it's own version.
> >> This changed from previous patch revision where non-generic architectures 
> >> were modified.
> >>
> >> In subsequent patch armv7 does samething. All other architectures continue
> >> use architecture defined version.
> >>
> > 
> > Hm.
> > 
> > "The x86 specific version of dirty page logging is generic enough to be
> > used by other architectures, noteably ARMv7. So let's move the x86 code
> > under virt/kvm/ and make it depend on KVM_GENERIC_DIRTYLOG. Other
> > architectures continue to use their own implementations."
> > 
> > ?
> 
> I'll update descriptions for both patches, with the more concise
> descriptions.

I don't think it's so generic.

Especially, the relationship between mmu_lock and TLB flushing has
been changed a few times for optimizing x86 mmu code, and it may change
in the future again.

Since how mmu_lock is used is depends on each arch, it's not so
simple to make the function generic IMO.

Thanks,
	Takuya

> 
> Thanks.
> 
> > 
> >>
> >> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
> >> ---
> >>  arch/x86/include/asm/kvm_host.h |    3 --
> >>  arch/x86/kvm/Kconfig            |    1 +
> >>  arch/x86/kvm/Makefile           |    1 +
> >>  arch/x86/kvm/x86.c              |   86 ------------------------------
> >>  include/linux/kvm_host.h        |    4 ++
> >>  virt/kvm/Kconfig                |    3 ++
> >>  virt/kvm/dirtylog.c             |  112 +++++++++++++++++++++++++++++++++++++++
> >>  7 files changed, 121 insertions(+), 89 deletions(-)
> >>  create mode 100644 virt/kvm/dirtylog.c
> >>
> > 
> >> diff --git a/virt/kvm/dirtylog.c b/virt/kvm/dirtylog.c
> >> new file mode 100644
> >> index 0000000..67ffffa
> >> --- /dev/null
> >> +++ b/virt/kvm/dirtylog.c
> >> @@ -0,0 +1,112 @@
> >> +/*
> >> + * kvm generic dirty logging support, used by architectures that share
> >> + * comman dirty page logging implementation.
> > 
> > s/comman/common/
> > 
> > The approach looks sane to me, especially as it does not change other
> > architectures needlessly.
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Takuya Yoshikawa <takuya.yoshikawa@gmail.com>
