From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 19 Feb 2014 16:26:43 +0100
Subject: [PATCH v6 00/18] ahci: library-ise ahci_platform, add sunxi driver
 and cleanup imx driver
In-Reply-To: <20140219150249.GG10134@htj.dyndns.org>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
 <20140219150249.GG10134@htj.dyndns.org>
Message-ID: <5304CD33.1080704@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/19/2014 04:02 PM, Tejun Heo wrote:
> Hello,
> 
> On Wed, Feb 19, 2014 at 01:01:42PM +0100, Hans de Goede wrote:
>> Here is v6 of my patchset for adding ahci-sunxi support. This has been
>> tested with Allwinner A10, Allwinner A20 and Freeware imx6x SoCs, including
>> suspend / resume. Note that since my last revision the ahci_imx driver has
>> also grown imx53 sata support, it would be good if some-one could test that
>> with this series.
> 
> Stopping review here.  I really like where it's headed in general and
> most review points,

Thanks for the review. I'll respin the patchset taking the various remarks into
account. I hope to have a new version ready at the end of the coming weekend
at the latest.

> except for lack of devres usage, are rather
> cosmetic.  I'm not completely decided yet whether we can defer devres
> until later or should go for it in the first round.

The devres usage are really 2 different issues:

1) There is the issue that we're getting clocks by index (this is by design as
clk-names are not generic), but there is no devm_get_clk_by_index (or some
such), this is a shortcoming of the clk-core, which needs a separate patch
to fix. I would rather not delay this patch-set based on getting a patch
into another subsys.

Note that even with devm_get_clk_by_index we can unfortunately not get rid of
ahci_platform_put_resources() as in Roger's follow-up patches it gets used for
putting some runtime pm related resources too.

I guess this argues for simply turning ahci_platform_get_resources into a
devm_ahci_platform_get_resources doing its own devm handling, and then
making ahci_platform_put_resources a private function called by the devm
framework. If you agree I can do that for the next patch-set.

2) In some comments you also seem to want devm variants of enable / disable
resources, or at least have ahci_platform_put_resources do the disable
automatically. The problem is that most of the functions called here need to
be balanced, they increment / decrement usage counters in the clk / regulator
subsystems, so we cannot simply unconditional do an ahci_platform_disable_resources
in ahci_platform_put_resources

Doing the disable automatically requires tracking the enable state, and doing this
per resource, since the whole idea of having a separate ahci_platform_enable_resources
is that some drivers may want to override its behavior doing things in a different
order.

To ensure proper tracking we would then need to offer ahci_platform_enable_regulator,
etc. functions, and ensure that all drivers using the ahci_platform framework
always go through these, rather then calling directly into the relevant framework.

This is all doable, and I'm not against doing this but before spending a couple of
hours coding this all up, I would like to hear back from you whether you would like
to see this, or would rather keep things as is.

Regards,

Hans
