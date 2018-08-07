From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 7 Aug 2018 12:17:13 +0100
Subject: [RFC PATCH 14/16] KVM: arm64/sve: Add SVE support to register
 access ioctl interface
In-Reply-To: <20180806132557.GD5985@e113682-lin.lund.arm.com>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
 <1529593060-542-15-git-send-email-Dave.Martin@arm.com>
 <20180806132557.GD5985@e113682-lin.lund.arm.com>
Message-ID: <20180807111713.GE9097@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2018 at 03:25:57PM +0200, Christoffer Dall wrote:
> On Thu, Jun 21, 2018 at 03:57:38PM +0100, Dave Martin wrote:
> > This patch adds the following registers for access via the
> > KVM_{GET,SET}_ONE_REG interface:
> > 
> >  * KVM_REG_ARM64_SVE_ZREG(n, i) (n = 0..31) (in 2048-bit slices)
> >  * KVM_REG_ARM64_SVE_PREG(n, i) (n = 0..15) (in 256-bit slices)
> >  * KVM_REG_ARM64_SVE_FFR(i) (in 256-bit slices)
> > 
> > In order to adapt gracefully to future architectural extensions,
> > the registers are divided up into slices as noted above:  the i
> > parameter denotes the slice index.
> > 
> > For simplicity, bits or slices that exceed the maximum vector
> > length supported for the vcpu are ignored for KVM_SET_ONE_REG, and
> > read as zero for KVM_GET_ONE_REG.
> > 
> > For the current architecture, only slice i = 0 is significant.  The
> > interface design allows i to increase to up to 31 in the future if
> > required by future architectural amendments.
> > 
> > The registers are only visible for vcpus that have SVE enabled.
> > They are not enumerated by KVM_GET_REG_LIST on vcpus that do not
> > have SVE.  In all cases, surplus slices are not enumerated by
> > KVM_GET_REG_LIST.
> > 
> > Accesses to the FPSIMD registers via KVM_REG_ARM_CORE are
> > redirected to access the underlying vcpu SVE register storage as
> > appropriate.  In order to make this more straightforward, register
> > accesses that straddle register boundaries are no longer guaranteed
> > to succeed.  (Support for such use was never deliberate, and
> > userspace does not currently seem to be relying on it.)
> 
> Could you add documentation to Documentation/virtual/kvm/api.txt for
> this as well under the KVM_SET_ONE_REG definitions explaining the use
> for arm64 ?

I plan to add documentation for all these additions, but didn't want
to do that while the API was still subject to change, to avoid having
to write it twice.

So, the documentation should be in the next spin if I consider it
mature enough.

Cheers
---Dave
