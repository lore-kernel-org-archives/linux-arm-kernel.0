From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 15 Nov 2018 16:40:31 +0000
Subject: [RFC PATCH v2 05/23] KVM: arm: Add arch vcpu uninit hook
In-Reply-To: <20181102080536.GQ12057@e113682-lin.lund.arm.com>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
 <1538141967-15375-6-git-send-email-Dave.Martin@arm.com>
 <20181102080536.GQ12057@e113682-lin.lund.arm.com>
Message-ID: <20181115164031.GN3505@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 02, 2018 at 09:05:36AM +0100, Christoffer Dall wrote:
> On Fri, Sep 28, 2018 at 02:39:09PM +0100, Dave Martin wrote:
> > In preparation for adding support for SVE in guests on arm64, a
> > hook is needed for freeing additional per-vcpu memory when a vcpu
> > is freed.
> 
> Can this commit motivate why we can't do the work in kvm_arch_vcpu_free,
> which we use for freeing other data structures?
> 
> (Presumably, uninit is needed when you need to do something at the very
> last step after releasing the struct pid.

It wasn't to do with that.

Rather, the division of responsibility between the vcpu_uninit and
vcpu_free paths is not very clear.

In the earlier version of the series, I think SVE state may have been
allocated rather early and we may have needed to free it in the failure
path of kvm_arch_vcpu_create() (which just calls kvm_vcpu_uninit()).
(Alternatively, I may just have been wrong.)

Now, the vcpu must be fully created before the KVM_ARM_SVE_CONFIG ioctl
on it (which is what allocates sve_state) can succeed anyway.

So the distinction between these two teardown phases is probably no
longer important.

I'll see whether I can get rid of this hook and free the SVE state in
kvm_arch_vcpu_free() instead.

Does that make sense?

Cheers
---Dave
