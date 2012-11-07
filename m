From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Nov 2012 11:05:42 +0000
Subject: [RFC PATCH 1/4] ARM: kernel: add device tree init map function
In-Reply-To: <20121107102349.GC17831@e102568-lin.cambridge.arm.com>
References: <1350393709-23546-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1350393709-23546-2-git-send-email-lorenzo.pieralisi@arm.com>
 <20121106215044.GB21764@mudshark.cambridge.arm.com>
 <20121107102349.GC17831@e102568-lin.cambridge.arm.com>
Message-ID: <20121107110542.GH23305@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2012 at 10:23:49AM +0000, Lorenzo Pieralisi wrote:
> On Tue, Nov 06, 2012 at 09:50:44PM +0000, Will Deacon wrote:
> > > +	while ((dn = of_find_node_by_type(dn, "cpu")) && cpu <= nr_cpu_ids) {
> > > +		const u32 *hwid;
> > > +		int len;
> > > +
> > > +		pr_debug("  * %s...\n", dn->full_name);
> > > +
> > > +		hwid = of_get_property(dn, "reg", &len);
> > > +
> > > +		if (!hwid || len != 4) {
> > > +			pr_err("  * %s missing reg property\n", dn->full_name);
> > > +			continue;
> > > +		}
> > > +		/*
> > > +		 * We want to assign the boot CPU logical id 0.
> > > +		 * Boot CPU checks its own MPIDR and if matches the current
> > > +		 * cpu node "reg" value it sets the logical cpu index to 0
> > > +		 * and stores the physical id accordingly.
> > > +		 * If MPIDR does not match, assign sequential cpu logical
> > > +		 * id (starting from 1) and increments it.
> > > +		 */
> > > +		i = (be32_to_cpup(hwid) == (read_cpuid_mpidr() & 0xffffff))
> > > +							? 0 : cpu++;
> > > +
> > > +		if (!i)
> > > +			printk(KERN_INFO "Booting Linux on CPU HWID 0x%x\n",
> > > +					be32_to_cpup(hwid));
> > 
> > I don't think we should bother with this print -- we already print something
> > in smp_setup_processor_id, which cannot differ for the boot CPU, If you want
> > the full mpidr, we could change that code to include it as well.
> 
> Yes, it is duplicate code, I will remove it. Extending the printk in
> smp_setup_processor_id() to include the entire MPIDR should be done
> though, otherwise we might have printk aliases on system with multiple
> clusters.

Feel free to make that change. You could also replace NR_CPUS in
smp_setup_processor_id with nr_cpu_ids for consistency (they'll be the same
this early on).

> > 
> > We might also want some sanity checking that we do indeed end up with
> > logical id 0 for the boot CPU. If not, I think we should scream and fall
> > back on the simple mapping created earlier.
> 
> Well, this basically means that we have to make sure this function is
> executed on the boot CPU (and it is as the code stands now), right ?

Yes, smp is not up yet which is why we're allowed to play with the logical
map.

> Since we are reading the MPIDR of the CPU parsing the tree and assign logical
> cpu 0 accordingly I think we have this check carried out automatically,
> unless for any given reason someone calls this function on a CPU that is
> not the boot one (Why ?).
> 
> Basically I could add a check like:
> 
> if (WARN_ON(smp_processor_id())
> 	return;
> 
> to fall back to the previous mapping, but that's overkill IMHO.

No, I was thinking about what happens if the devicetree doesn't contain an
mpidr property that matches the boot cpu. In this case, we will fail to
assign logical ID 0, right? If this happens, we should complain about an
invalid devicetree and try to fall back on the logical_map that was
generated earlier on.

Will
