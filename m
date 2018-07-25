From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 25 Jul 2018 15:12:12 +0100
Subject: [RFC PATCH 12/16] KVM: arm64/sve: Context switch the SVE registers
In-Reply-To: <20180725135733.wx4eqrp7cyghcigq@kamzik.brq.redhat.com>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
 <1529593060-542-13-git-send-email-Dave.Martin@arm.com>
 <20180719131338.jsgezassnjhdbotd@kamzik.brq.redhat.com>
 <20180725115045.GJ4240@e103592.cambridge.arm.com>
 <20180725135733.wx4eqrp7cyghcigq@kamzik.brq.redhat.com>
Message-ID: <20180725141212.GL4240@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2018 at 03:57:33PM +0200, Andrew Jones wrote:
> On Wed, Jul 25, 2018 at 12:50:45PM +0100, Dave Martin wrote:
> > > > +	if (system_supports_sve() && guest_has_sve)
> > 
> > As elsewhere, the system_supports_sve() check uses a static key and
> > should be very cheap (or free in a CONFIG_ARM64_SVE=n kernel).
> >
> 
> Yup, I'm clear on that now. Thanks again for explaining. It might
> be nice for a small helper function in this case in order to avoid
> the 'system_supports_sve() &&' everywhere and the chance that the
> order of the checks gets swapped during some code refactoring someday.

This is what guest_has_sve() is for.

In hyp_switch_fpsimd() I wanted to avoid runtime checks wherever
possible, but it may be overkill to keep checking system_supports_sve()
like this.

It might take some benchmarking to figure out whether the extra checks
have any merit here...

Cheers
---Dave
