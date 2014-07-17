From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 17 Jul 2014 12:52:45 +0200
Subject: [PATCH v4 1/8] of: Add NVIDIA Tegra SATA controller binding
In-Reply-To: <53C7A433.4070404@redhat.com>
References: <1405500863-19696-2-git-send-email-mperttunen@nvidia.com>
 <1405510814-31928-1-git-send-email-mperttunen@nvidia.com>
 <53C666E5.6030009@redhat.com> <20140716131306.GB23384@ulmo>
 <53C6908A.2050200@redhat.com> <20140716195136.GB5212@mithrandir>
 <53C77263.7050903@redhat.com> <20140717073956.GA18640@ulmo>
 <53C7A433.4070404@redhat.com>
Message-ID: <20140717105244.GG17877@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 12:23:47PM +0200, Hans de Goede wrote:
> On 07/17/2014 09:39 AM, Thierry Reding wrote:
> > On Thu, Jul 17, 2014 at 08:51:15AM +0200, Hans de Goede wrote:
[...]
> > > I realize that this changes the reset-deassert vs clock enabling ordering,
> > > if this is an issue please add reset support to libahci-platform.c I believe
> > > that is something which we will need to do soonish anyways (reset controllers
> > > are popping up everywhere in newer SoCs).
> > 
> > I think we could safely move the reset deassert after the call to
> > ahci_platform_enable_resources().
> 
> Will the resets not interfere with the phy_init / power_on which is done from
> ahci_platform_enable_resources().

The PHY is a completely different hardware block and I think the only
requisite is that the regulator be turned on. Resets from SATA don't
influence it.

> >> This means that the sata_clk will get enabled twice, but that is harmless
> >> as long as we disable it twice too. This means that we need to add an
> >> extra disable to tegra_ahci_power_off because tegra_powergate_power_off
> >> seems to not do this (unlike power-on, which is rather unsymmetrical
> >> it would be nice to fix this).
> > 
> > We've never had a need for it because the exact power down sequence
> > isn't nearly as important. But I guess we could add a new function
> > tegra_powergate_sequence_power_down() that takes care of disabling the
> > clock and asserting the reset.
> 
> Ok, no need to add it for my sake, I was just wondering about the non
> symmetry of the API.

There are discussions on how to make powergates work with PM domains.
They aren't an ideal fit, but if we manage to make it work the powergate
API will likely go away anyway.

> > One other thing that I've been thinking about is whether it would make
> > sense to make the ahci_platform library use a list of clock names that
> > it should request. This would better mirror the clock bindings
> > convention and allow drivers (such as the Tegra one) to take ownership
> > of clocks that need special handling while at the same time leaving it
> > to the helpers to do the bulk of the work.
> > 
> > One way I can think of to handle this would be by adding a struct
> > ahci_platform_resources * parameter to ahci_platform_get_resources(),
> > sowewhat like this:
> > 
> > 	struct ahci_platform_resources {
> > 		const char *const *clocks;
> > 		unsigned int num_clocks;
> > 
> > 		const char *const *resets;
> > 		unsigned int num_resets;
> > 	};
> > 
> > 	struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
> > 							   const struct ahci_platform_resources *res)
> > 	{
> > 		...
> > 
> > 		for (i = 0; i < res->num_clocks; i++) {
> > 			clk = clk_get(&pdev->dev, res->clocks[i]);
> > 			...
> > 		}
> > 
> > 		...
> > 
> > 		for (i = 0; i < res->num_resets; i++) {
> > 			rst = reset_control_get(&pdev->dev, res->resets[i]);
> > 			...
> > 		}
> > 
> > 		...
> > 	}
> 
> Interesting, I think this is a quite good idea. I do see some pitfalls though,
> to answers Mikko's question from his followup :
> 
> On 07/17/2014 09:56 AM, Mikko Perttunen wrote:
> > Also: is there a reason to not use the devm_* variants? I note that the helper code has not been able to prevent any of the ahci_platform drivers from messing up by not calling ahci_platform_put_resources.
> 
> The libahci_platform.c code / ahci_platform.c code is also used for
> devices going way back who may not yet be using the new clk framework,
> so where we need to use clk_get(dev, NULL); quoting from libahci_platform.c :
> 
>         for (i = 0; i < AHCI_MAX_CLKS; i++) {
>                 /*
>                  * For now we must use clk_get(dev, NULL) for the first clock,
>                  * because some platforms (da850, spear13xx) are not yet
>                  * converted to use devicetree for clocks.  For new platforms
>                  * this is equivalent to of_clk_get(dev->of_node, 0).
>                  */
>                 if (i == 0)
>                         clk = clk_get(dev, NULL);
>                 else
>                         clk = of_clk_get(dev->of_node, i);
> 
>                 if (IS_ERR(clk)) {
>                         rc = PTR_ERR(clk);
>                         if (rc == -EPROBE_DEFER)
>                                 goto err_out;
>                         break;
>                 }
>                 hpriv->clks[i] = clk;
>         }
> 
> And there is no devm variant of that, nor is there one to get clocks by index.
> Note that we also need ahci_platform_put_resources for runtime pm support, so
> that one is going to stay around anyways and thus there is not that much value
> in fixing this.
> 
> So although I like Thierry's idea, if we go this way (which sounds good), we
> should add support for taking a NULL ahci_platform_resources argument and in
> that case behave as before, esp. because of the platforms needing the old
> style clock handling. An advantage of doing this, is that we can simply patch
> all existing users to pass NULL.

Isn't the "legacy" case really just this:

	static const char *const legacy_ahci_clocks[] = {
		NULL
	};

	static const struct ahci_platform_resources legacy_ahci_resources = {
		.num_clocks = ARRAY_SIZE(legacy_ahci_clocks),
		.clocks = legacy_ahci_clocks,
	};

?

> > 	static const char *const tegra_ahci_clocks[] = {
> > 		"sata-oob", "cml1", pll_e",
> > 	};
> 
> Note you could also put the "sata" clock here, since then you will
> know its index, and can use hpriv->clks to access it. Not putting
> it here has the advantage of not doing the double enable / disable
> (and the disadvantage of needing to the clk_get yourself).

Right, the intention here was that we wouldn't have it managed by the
ahci_platform library because it needs special handling anyway. Having
it in this table would therefore be redundant.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/5b5707fa/attachment.sig>
