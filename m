From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Mon, 7 Sep 2015 19:32:18 +0200
Subject: [PATCH v4 2/5] irqchip, gicv3: Workaround for Cavium ThunderX
 erratum 23154
In-Reply-To: <55EDC4DC.4040405@arm.com>
References: <1439576885-15621-1-git-send-email-rric@kernel.org>
 <1439576885-15621-3-git-send-email-rric@kernel.org>
 <55EDC12E.8000408@arm.com> <55EDC4DC.4040405@arm.com>
Message-ID: <20150907173218.GV1820@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.09.15 18:09:48, Marc Zyngier wrote:
> On 07/09/15 17:54, Suzuki K. Poulose wrote:
> > On 14/08/15 19:28, Robert Richter wrote:
> >> From: Robert Richter <rrichter@cavium.com>

> >> +static void gicv3_enable_quirks(void)
> >> +{
> >> +	if (cpus_have_cap(ARM64_WORKAROUND_CAVIUM_23154))
> >> +		static_key_slow_inc(&is_cavium_thunderx);
> > 
> > May be you could use the enable() method added to struct arm64_cpu_capability
> > here to perform the above operation, added by James :
> > 
> > commit 1c0763037f1e1caef739e36e09c6d41ed7b61b2d
> > Author: James Morse <james.morse@arm.com>
> > Date:   Tue Jul 21 13:23:28 2015 +0100
> > 
> >      arm64: kernel: Add cpufeature 'enable' callback
> > 
> > 
> >> +}
> >> +
> >>   static int __init gic_of_init(struct device_node *node, struct device_node *parent)
> >>   {
> >>   	void __iomem *dist_base;
> >> @@ -825,6 +863,8 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
> >>   	gic_data.nr_redist_regions = nr_redist_regions;
> >>   	gic_data.redist_stride = redist_stride;
> >>
> >> +	gicv3_enable_quirks();
> >> +
> > 
> > than adding a hook here ?
> 
> It feels like a good idea, except that it creates a weird dependency
> between the core arch code and the GIC driver. Can you think of an
> elegant way to deal with this?

The only chance I see is to move it all to the driver and adding
enable() calls to the caps in gicv3_errata:

static void gicv3_enable_quirks(void)
{
        check_cpu_capabilities(gicv3_errata, "enabling workaround for");
}

Here the code is kept in the driver and called during driver init.

But current solution looks more elegant and simpler to me. So I would
not change it.

-Robert
