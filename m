From: m.smarduch@samsung.com (Mario Smarduch)
Date: Wed, 11 Jun 2014 20:02:52 -0700
Subject: [RESEND PATCH v7 3/4] arm: dirty log write protect management
 support
In-Reply-To: <20140611070352.GC24286@lvm>
References: <1401837567-5527-1-git-send-email-m.smarduch@samsung.com>
 <1402076021-9425-1-git-send-email-m.smarduch@samsung.com>
 <20140608120522.GG3279@lvm> <539663A0.9080507@samsung.com>
 <20140610092240.GF1388@lvm> <53974998.70001@samsung.com>
 <20140611070352.GC24286@lvm>
Message-ID: <5399185C.3010503@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paolo,
   for ARM dirty page logging we have couple functions
that are generic.

- kvm_vm_ioctl_get_dirty_log - is identical to x86 version
- kvm_flush_remote_tlbs - ARM version does hardware broadcast
  it's different from the generic one in kvm_main.c

How to proceed to make these generic? Please see below
from Christoffer.

Current patch moves kvm_vm_ioctl_get_dirty_log() into kvm_main.c
and labels it and kvm_flush_remote_tlbs weak.

Please advise.

Thanks,
- Mario


> So I don't see a lot of use of weak symbols in kvm_main.c (actually on
> kvmarm/next I don't see any), but we do want to share code when more
> than one architecture implements something in the exact same way, like
> it seems x86 and ARM is doing here for this particular function.
> 
> I think the KVM scheme is usually to check for some define, like:
> 
> #ifdef KVM_ARCH_HAVE_GET_DIRTY_LOG
> 	ret = kvm_arch_get_dirty_log(...);
> #else
> 	ret = kvm_get_dirty_log(...);
> #endif
> 
> but Paolo may have a more informed oppinion of how to deal with these.
> 
> Thanks,
> -Christoffer
> 
