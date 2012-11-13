From: will.deacon@arm.com (Will Deacon)
Date: Tue, 13 Nov 2012 10:43:40 +0000
Subject: [PATCH V2 1/5] arm: mvebu: Added support for coherency fabric in
 mach-mvebu
In-Reply-To: <50A15A33.60405@free-electrons.com>
References: <1351545108-18954-1-git-send-email-gregory.clement@free-electrons.com>
 <1351545108-18954-2-git-send-email-gregory.clement@free-electrons.com>
 <20121105140258.GO3351@mudshark.cambridge.arm.com>
 <50A15A33.60405@free-electrons.com>
Message-ID: <20121113104340.GD3940@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 08:21:07PM +0000, Gregory CLEMENT wrote:
> On 11/05/2012 03:02 PM, Will Deacon wrote:
> > On Mon, Oct 29, 2012 at 09:11:44PM +0000, Gregory CLEMENT wrote:
> >> +int set_cpu_coherent(unsigned int hw_cpu_id, int smp_group_id)
> >> +{
> >> +	int reg;
> >> +
> >> +	if (!coherency_base) {
> >> +		pr_warn("Can't make CPU %d cache coherent.\n", hw_cpu_id);
> >> +		pr_warn("Coherency fabric is not initialized\n");
> >> +		return 1;
> >> +	}
> >> +
> >> +	/* Enable the CPU in coherency fabric */
> >> +	reg = readl(coherency_base + COHERENCY_FABRIC_CTL_OFFSET);
> >> +	reg |= 1 << (24 + hw_cpu_id);
> >> +	writel(reg, coherency_base + COHERENCY_FABRIC_CTL_OFFSET);
> >> +
> >> +	/* Add CPU to SMP group */
> >> +	reg = readl(coherency_base + COHERENCY_FABRIC_CFG_OFFSET);
> >> +	reg |= 1 << (16 + hw_cpu_id + (smp_group_id == 0 ? 8 : 0));
> >> +	writel(reg, coherency_base + COHERENCY_FABRIC_CFG_OFFSET);
> >> +
> >> +	return 0;
> >> +}
> > 
> > These writels may expand to code containing calls to outer_sync(), which
> > will attempt to take a spinlock for the aurora l2. Given that the CPU isn't
> > coherent, how does this play out with the exclusive store instruction in the
> > lock?
> 
> I dug a little this subject: and I am not sure there is problem. In SMP mode,
> only the system cache mode of Aurora is used. In this mode, outer_cache.sync
> is void then outer_sync() won't call any function, so there will be no
> access to any spinlock.

Hmm, that is pretty subtle and it doesn't really solve the bigger picture.
printk takes logbuf_lock, for example, and I'm sure that by the time you get
to this code you will have relied on exclusives behaving correctly.

Will
