From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 9 Jul 2018 16:15:49 +0100
Subject: [RFC PATCH 05/16] KVM: arm: Add arch init/uninit hooks
In-Reply-To: <877em88yxf.fsf@linaro.org>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
 <1529593060-542-6-git-send-email-Dave.Martin@arm.com>
 <877em88yxf.fsf@linaro.org>
Message-ID: <20180709151548.GF9486@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2018 at 11:02:20AM +0100, Alex Benn?e wrote:
> 
> Dave Martin <Dave.Martin@arm.com> writes:
> 
> > In preparation for adding support for SVE in guests on arm64, hooks
> > for allocating and freeing additional per-vcpu memory are needed.
> >
> > kvm_arch_vcpu_setup() could be used for allocation, but this
> > function is not clearly balanced by un "unsetup" function, making
> 
> Isn't that a double negative there? Surely it would be balanced by a
> kvm_arch_vcpu_unsetup() or possibly better named function.

Yes, but there is no such function, and it wasn't clear what the
semantics of the existing hooks is supposed to be... so I didn't
feel comfortable adding an _unsetup().

I was trying to be minimally invasive while I got things working...

> > it unclear where memory allocated in this function should be freed.
> >
> > To keep things simple, this patch defines backend hooks
> > kvm_arm_arch_vcpu_{,un}unint(), and plumbs them in appropriately.
> 
> Is {,un} a notation for dropping un? This might be why I'm confused. I
> would have written it as kvm_arm_arch_vcpu_[un]init() or even
> kvm_arm_arch_vcpu_[init|uninit].

That should be kvm_arm_arch_vcpu_{,un}init().

Whether this is readily understood by people is another question.
This is the bash brace-expansion syntax which I'm in the habit of
using, partly because it looks nothing like C syntax, thus
"reducing" confusion.

Personally I make heavy use of this in the shell, like

	mv .config{,.old}

etc.  But that's me.  Maybe other people don't.

Too obscure?  I have a number of patches that follow this convention
upstream.

> > The exusting kvm_arch_vcpu_init() function now calls
> 
> /existing/
> 
> > kvm_arm_arch_vcpu_init(), while an explicit kvm_arch_vcpu_uninit()
> > is added which current does nothing except to call
> > kvm_arm_arch_vcpu_uninit().
> 
> OK I'm a little confused by this. It seems to me that KVM already has
> the provision for an init/uninit. What does the extra level on
> indirection buy you that keeping the static inline
> kvm_arm_arch_vcpu_uninit in arm/kvm_host.h and a concrete implementation
> in arm64/kvm/guest.c doesn't?

There isn't an intentional extra level of indirection, but the existing
code feels strangely factored due to the somewhat random use of
prefixes in function names (i.e., kvm_arch_*() is sometimes a hook from
KVM core into virt/kvm/arm/, some a hook from virt/kvm/arm/ into the
arm or arm64 backend, and sometimes a hook from KVM core directly into
the arm or arm64 backend).

So, I wasn't really sure where to put things initially.

This patch was always a bit of a bodge, and the series as posted
doesn't fully make use of it anyway... so I'll need to revisit.

Cheers
---Dave
