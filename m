From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 6 Jun 2013 12:27:45 +0200
Subject: [PATCH 5/8] arm: mvebu: don't hardcode a physical address in
 headsmp.S
In-Reply-To: <20130606091327.GF15208@mudshark.cambridge.arm.com>
References: <1370415901-4721-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370415901-4721-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130606091327.GF15208@mudshark.cambridge.arm.com>
Message-ID: <20130606122745.3c94d43e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Will Deacon,

On Thu, 6 Jun 2013 10:13:27 +0100, Will Deacon wrote:

> > +		struct resource res;
> >  		pr_info("Initializing Coherency fabric\n");
> > +		of_address_to_resource(np, 0, &res);
> > +		coherency_phys_base = res.start;
> 
> So you have the primary CPU writing this address, before it is
> coherent...

[...]

> >  ENTRY(armada_xp_secondary_startup)
> > +	/* Get coherency fabric base physical address */
> > +	adr	r0, 1f
> > +	ldmia	r0, {r1, r2}
> > +	sub	r0, r0, r1
> > +	add	r2, r2, r0
> > +	ldr	r0, [r2]
> 
> ... and the secondaries reading it, before they are coherent.
> How do you ensure that the write is indeed visible?

Indeed. As discussed on IRC, I've fixed that by adding a sync_cache_w()
on the coherency_phys_base variable after it has been updated by the
boot CPU. By the time the secondary CPUs read their value, the MMU is
not enabled, so the caches aren't enabled, so they are directly seeing
the contents of the memory. So hopefully, this should solve your
concern.

> Furthermore, it's worth noting that of_find_matching_node takes the
> devtree_lock spinlock, so you need to be careful calling that if
> you're not coherent.

Also as discussed on IRC, we're not coherent with regard to the
secondary CPUs, but those other CPUs have not started yet. And being
part of the coherency unit is apparently not required for strex and al.
to operate properly.

I've just sent a v2 of this patch that adds the sync_cache_w(), and
also adjust the assembly code as per the suggestions of Nicolas Pitre.

Thanks for your comments!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
