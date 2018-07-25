From: drjones@redhat.com (Andrew Jones)
Date: Wed, 25 Jul 2018 18:52:56 +0200
Subject: [RFC PATCH 16/16] KVM: arm64/sve: Report and enable SVE API
 extensions for userspace
In-Reply-To: <20180725152749.GQ4240@e103592.cambridge.arm.com>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
 <1529593060-542-17-git-send-email-Dave.Martin@arm.com>
 <20180719145921.oasa3a57at5nnwya@kamzik.brq.redhat.com>
 <20180725152749.GQ4240@e103592.cambridge.arm.com>
Message-ID: <20180725165256.k2kcrazgyt7y4i4o@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2018 at 04:27:49PM +0100, Dave Martin wrote:
> On Thu, Jul 19, 2018 at 04:59:21PM +0200, Andrew Jones wrote:
> > On Thu, Jun 21, 2018 at 03:57:40PM +0100, Dave Martin wrote:
> > > -	/*
> > > -	 * For now, we don't return any features.
> > > -	 * In future, we might use features to return target
> > > -	 * specific features available for the preferred
> > > -	 * target type.
> > > -	 */
> > > +	/* KVM_ARM_VCPU_SVE understood by KVM_VCPU_INIT */
> > > +	init->features[0] = 1 << KVM_ARM_VCPU_SVE;
> > > +
> > 
> > We shouldn't need to do this. The "preferred" target type isn't defined
> > well (that I know of), but IMO it should probably be the target that
> > best matches the host, minus optional features. The best base target. We
> > may use these features to convey that the preferred target should enable
> > some optional feature if that feature is necessary to workaround a bug,
> > i.e. using the "feature" bit as an erratum bit someday, but that'd be
> > quite a debatable use, so maybe not even that. Most likely we'll never
> > need to add features here.
> 
> init->features[] has no semantics yet so we can define it how we like,
> but I agree that the way I use it here is not necessarily the most
> natural.
> 
> OTOH, we cannot use features[] for "mandatory" features like erratum
> workarounds, because current userspace just ignores these bits.

It would have to learn to look here if that's how we started using it,
but it'd be better to invent something else that wouldn't appear as
abusive if we're going to teach userspace new stuff anyway.

> 
> Rather, these bits would be for features that are considered beneficial
> but must be off by default (due to incompatibility risks across nodes,
> or due to ABI impacts).  Just blindly using the preferred target
> already risks configuring a vcpu that won't work across all nodes in
> your cluster.

KVM usually advertises optional features through capabilities. A device
(vcpu device, in this case) ioctl can also be used to check for feature
availability.

> 
> So I'm not convinced that there is any useful interpretation of
> features[] unless we interpret it as suggested in this patch.
> 
> Can you elaborate why you think it should be used with a more
> concrete example?

I'm advocating that it *not* be used here. I think it should be used
like the PMU feature uses it - and the PMU feature doesn't set a bit
here.

> 
> > That said, I think defining the feature bit makes sense. ATM, I'm feeling
> > like we'll want to model the user interface for SVE like PMU (using VCPU
> > device ioctls).
> 
> Some people expressed concerns about the ioctls becoming order-sensitive.
> 
> In the SVE case we don't want people enabling/disabling/reconfiguring
> "silicon" features like SVE after the vcpu starts executing.
> 
> We will need an extra ioctl() for configuring the allowed SVE vector
> lengths though.  I don't see a way around that.  So maybe we have to
> solve the ordering problem anyway.

Yes, that's why I'm thinking that the vcpu device ioctls is probably the
right way to go. The SVE group can have its own "finalize" request that
allows all other SVE ioctls to be in any order prior to it.

> 
> 
> By current approach (not in this series) was to have VCPU_INIT return
> -EINPROGRESS or similar if SVE is enabled in features[]: this indicates
> that certain setup ioctls are required before the vcpu can run.
> 
> This may be overkill / not the best approach though.  I can look at
> vcpu device ioctls as an alternative.

With a "finalize" attribute if SVE isn't finalized by VCPU_INIT or
KVM_RUN time, then SVE just won't be enabled for that VCPU.

Thanks,
drew
