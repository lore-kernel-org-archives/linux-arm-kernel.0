From: drjones@redhat.com (Andrew Jones)
Date: Wed, 26 Nov 2014 18:47:33 +0100
Subject: [PATCH 2/7] KVM: arm: guest debug, define API headers
In-Reply-To: <547603CD.6060708@redhat.com>
References: <1416931805-23223-1-git-send-email-alex.bennee@linaro.org>
 <1416931805-23223-3-git-send-email-alex.bennee@linaro.org>
 <20141126143122.GB3245@hawk.usersys.redhat.com>
 <87sih6knzr.fsf@linaro.org> <547603CD.6060708@redhat.com>
Message-ID: <20141126174732.GH3245@hawk.usersys.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 05:46:05PM +0100, Paolo Bonzini wrote:
> 
> 
> On 26/11/2014 15:58, Alex Benn?e wrote:
> > 
> > Andrew Jones <drjones@redhat.com> writes:
> > 
> >> On Tue, Nov 25, 2014 at 04:10:00PM +0000, Alex Benn?e wrote:
> >>> This commit defines the API headers for guest debugging. There are two
> >>> architecture specific debug structures:
> > <snip>
> >>> +/* Architecture related debug defines - upper 16 bits of
> >>> + * kvm_guest_debug->control
> >>> + */
> >>> +#define KVM_GUESTDBG_USE_SW_BP_SHIFT	16
> >>> +#define KVM_GUESTDBG_USE_SW_BP		(1 << KVM_GUESTDBG_USE_SW_BP_SHIFT)
> >>> +#define KVM_GUESTDBG_USE_HW_BP_SHIFT	17
> >>> +#define KVM_GUESTDBG_USE_HW_BP		(1 << KVM_GUESTDBG_USE_HW_BP_SHIFT)
> >>> +
> >>
> >> I see this are defined in arch/x86/include/uapi/asm/kvm.h,
> >> so you needed to reproduce them here, but shouldn't they
> >> be promoted to include/uapi/linux/kvm.h instead?
> > 
> > Well if we move them to common uapi we either restrict the $ARCH
> > specific options that don't have SW/HW BKPTS (would be weird but...) or
> > make them generic in the lower 16 bits (breaks API).
> > 
> > But in principle I have no objection if other don't.
> 
> I think it's a matter of personal taste.  "Architecture-specific" means
> "not all architectures may support it", but it's certainly a good idea
> to reuse the same value if multiple architectures do support a #define.
> 
> What you did is fine, another possibility is to do
> 
>     #define __KVM_GUESTDBG_USE_SW_BP   (1 << 16)
> 
> in include/uapi/linux/kvm.h, and
> 
>     #define KVM_GUESTDBG_USE_SW_BP __KVM_GUESTDBG_USE_SW_BP
> 
> in the arch-specific file.  Andrew, is this closer to what you intended?
>

I just reread Documentation/virtual/kvm/api.txt a bit more closely and
see that these fall in the "architecture specific control" region of the
field. So forget what I said. But your suggestion of __KVM_GUESTDBG_USE_SW_BP
looks like a good idea to me.

drew
