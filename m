From: dahi@linux.vnet.ibm.com (David Hildenbrand)
Date: Fri, 15 May 2015 19:33:15 +0200
Subject: [PATCH v4 02/12] KVM: define common KVM_GUESTDBG_USE_SW/HW_BP bits
In-Reply-To: <555613F2.9060204@de.ibm.com>
References: <1431700035-23479-1-git-send-email-alex.bennee@linaro.org>
 <1431700035-23479-3-git-send-email-alex.bennee@linaro.org>
 <555613F2.9060204@de.ibm.com>
Message-ID: <20150515193315.6d3e82d2@thinkpad-w530>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Am 15.05.2015 um 16:27 schrieb Alex Benn?e:
> > +++ b/arch/s390/include/uapi/asm/kvm.h
> > @@ -114,8 +114,6 @@ struct kvm_fpu {
> >  	__u64 fprs[16];
> >  };
> > 
> > -#define KVM_GUESTDBG_USE_HW_BP		0x00010000
> [...]
> > +++ b/include/uapi/linux/kvm.h
> [...]
> > +#define KVM_GUESTDBG_USE_SW_BP		(1 << 16)
> > +#define KVM_GUESTDBG_USE_HW_BP		(1 << 17)
> 
> This is an ABI break for s390, no?
> 
> David, do you remember why we do not use KVM_GUESTDBG_USE_SW_BP?
> 

We never had to tell the kernel about software breakpoints as this is all
handled via 4 byte DIAG instructions until now. We don't have to turn this
mechanism on. QEMU can directly insert the desired DIAG instructions and gets
notified when they are about to get executed.

(But we still have 2 byte breakpoint support todo - still tbd how exactly this
will be realized - could be turned on via such a mechanism)

The problem is, that these bits are arch specific, now Alex wants to unify
them for all archs.

So yes, this is an ABI break for us and breaks hardware breakpoints.(I think
the first version of this patch didn't contain this ABI break when I had a look)

I wonder if it wouldn't make more sense to

- introduce new bits in the arch-unspecific section
- rework the existing implementers to accept both bits

Or to simply leave stuff as it is and handle it via arch specific bits.

David
