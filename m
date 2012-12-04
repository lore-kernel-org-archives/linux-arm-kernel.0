From: will.deacon@arm.com (Will Deacon)
Date: Tue, 4 Dec 2012 12:40:47 +0000
Subject: [RFC PATCH 2/2] ARM: SMP support for mach-virt
In-Reply-To: <50BD1FD7.9040000@gmail.com>
References: <1354557160-20144-1-git-send-email-will.deacon@arm.com>
 <1354557160-20144-3-git-send-email-will.deacon@arm.com>
 <50BD1FD7.9040000@gmail.com>
Message-ID: <20121204124047.GM23368@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 03, 2012 at 09:55:35PM +0000, Rob Herring wrote:
> On 12/03/2012 11:52 AM, Will Deacon wrote:
> > From: Marc Zyngier <marc.zyngier@arm.com>
> > 
> > This patch adds support for SMP to mach-virt.
> > 
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > 

[...]

> > +/*
> > + * This provides a "holding pen" into which all secondary cores are held
> > + * until we're ready for them to initialise.
> > + */
> > +ENTRY(virt_secondary_startup)
> > +	mrc	p15, 0, r0, c0, c0, 5
> > +	and	r0, r0, #15
> > +	adr	r4, 1f
> > +	ldmia	r4, {r5, r6}
> > +	sub	r4, r4, r5
> > +	add	r6, r6, r4
> > +pen:	ldr	r7, [r6]
> > +	cmp	r7, r0
> > +	bne	pen
> 
> Why is the pen is needed? It should only be needed for hotplug on
> systems that can't reset their cores. I'd hope you could design good
> virtual h/w.

It's not so much about designing good virtual h/w as it is avoiding tying
the platform to it. What we don't want is to mandate that in order to boot
this machine, you *must* implement an emulation of some virtual
power-controller or SMP booting device. If we go down that route, there's
less advantage from having the virtual platform in the first place.

There's also less of a problem with the pen approach to booting because
ultimately the virtual CPUs executing there are just pthreads and will be
scheduled appropriately by the hypervisor (in contrast to a real system
where there may be concerns about power consumption and memory bandwidth).

For hotplug, sure, we could have an *optional* virtio-based device for
dealing with that if we want to. We could even have some early probing code
for it and use it for SMP boot if we find a matching DT node, but we'd still
need to keep the pen code lying around as a fallback.

> > +/*
> > + * Enumerate the possible CPU set from the device tree.
> > + */
> > +static void __init virt_smp_init_cpus(void)
> > +{
> > +	const char *enable_method;
> > +	struct device_node *dn = NULL;
> > +	int cpu = 0;
> > +	u32 release_addr;
> > +
> > +	while ((dn = of_find_node_by_type(dn, "cpu"))) {
> > +		if (cpu >= NR_CPUS)
> > +			goto next;
> > +
> > +		/*
> > +		 * We currently support only the "spin-table" enable-method.
> > +		 */
> > +		enable_method = of_get_property(dn, "enable-method", NULL);
> > +		if (!enable_method || strcmp(enable_method, "spin-table")) {
> 
> Are these documented?

It's part of the EPAPR spec iirc and follows the booting protocol used by
arm64.

Will
