From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 20 Mar 2017 18:00:40 +0100
Subject: [PATCH 3/5] soc/tegra: Move Tegra flowctrl driver
In-Reply-To: <c0b18931-1377-813d-c8a3-60aea4379aa6@nvidia.com>
References: <1489584715-23138-1-git-send-email-jonathanh@nvidia.com>
 <1489584715-23138-4-git-send-email-jonathanh@nvidia.com>
 <20170320141434.GC28203@ulmo.ba.sec>
 <c0b18931-1377-813d-c8a3-60aea4379aa6@nvidia.com>
Message-ID: <20170320170040.GC14787@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 04:37:58PM +0000, Jon Hunter wrote:
> 
> 
> On 20/03/17 14:14, Thierry Reding wrote:
> > * PGP Signed by an unknown key
> > 
> > On Wed, Mar 15, 2017 at 01:31:53PM +0000, Jon Hunter wrote:
> > [...]
> >> +static int __init tegra_flowctrl_init(void)
> >> +{
> >> +	/* hardcoded fallback if device tree node is missing */
> >> +	unsigned long base = 0x60007000;
> >> +	unsigned long size = SZ_4K;
> >> +	struct device_node *np;
> >> +
> >> +	if (!soc_is_tegra())
> >> +		return 0;
> >> +
> >> +	np = of_find_matching_node(NULL, matches);
> >> +	if (np) {
> >> +		struct resource res;
> >> +
> >> +		if (of_address_to_resource(np, 0, &res) == 0) {
> >> +			size = resource_size(&res);
> >> +			base = res.start;
> >> +		}
> >> +
> >> +		of_node_put(np);
> >> +	}
> >> +
> >> +	tegra_flowctrl_base = ioremap_nocache(base, size);
> >> +
> >> +	if (!tegra_flowctrl_base)
> >> +		return -ENXIO;
> >> +
> >> +	return 0;
> >> +}
> >> +early_initcall(tegra_flowctrl_init);
> > 
> > Do we want to implement a hand-off to a proper driver at some point,
> > similar to what we have for PMC?
> 
> Yes I can add, it won't do much apart from remap the io-space, but at
> least it is registered as a device then.

Yeah, the same is true for PMC, but I find it quite convenient to have a
struct device * around. Ideally, of course, we'd be able to somehow have
deferred probe take care of the dependencies so that we wouldn't have to
muck about with these initcalls, but I don't think we're there yet. That
"partial" driver would at least be some way in the right direction.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/182906aa/attachment.sig>
