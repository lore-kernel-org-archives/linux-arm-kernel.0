From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 2 Dec 2013 09:52:58 +0100
Subject: [PATCH 01/31] ARM: tegra: add missing clock documentation to DT
 bindings
In-Reply-To: <529B8888.3010801@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-2-git-send-email-swarren@wwwdotorg.org>
 <20131129114900.GN22771@ulmo.nvidia.com>
 <529B8888.3010801@wwwdotorg.org>
Message-ID: <20131202085257.GA17834@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 01, 2013 at 12:05:44PM -0700, Stephen Warren wrote:
> On 11/29/2013 04:49 AM, Thierry Reding wrote:
> > On Fri, Nov 15, 2013 at 01:53:56PM -0700, Stephen Warren wrote: 
> > [...]
> >> @@ -60,6 +81,12 @@ of the following host1x client modules: -
> >> compatible: "nvidia,tegra<chip>-dc" - reg: Physical base address
> >> and length of the controller's registers. - interrupts: The
> >> interrupt outputs from the controller. +  - clocks : Must contain
> >> an entry for each entry in clock-names. +    See
> >> ../clocks/clock-bindings.txt for details. +  - clock-names : Must
> >> include the following entries: +    - disp1 or disp2 (depending
> >> on the controller instance)
> > 
> > I'm not sure if this makes sense. The name could be the same
> > independent of which controller uses it. If it isn't then the
> > driver would need additional code to find out which instance it is
> > and construct a dynamic string.
> > 
> > Any objection to just make this entry "disp", or "dc"?
> 
> This patch simply documents the binding that the various drivers
> already require and/or whatever is already in the DT files if there
> are any clocks the drivers don't currently use. I did consider fixing
> up all the current usage to actually be sane, but that would require
> even more driver changes (in addition to those required for the reset
> framework patches).

Okay, I understand. I still think we should change the usage for this
particular use-case subsequently. In retrospect the entry in clock-names
wasn't thought out very well. It seems like the reason for using disp1
and disp2 respectively was so that it would match the system-wide clock
name, rather than the clock's label within the display controller's
context.

Just to clarify what I mean, if we stick to the above, then we'll need
to add code to the driver along the lines of:

	char clock_name[6];

	if (regs->start == 0x54200000)
		index = 1;
	else
		index = 2;

	sprintf(clock_name, "disp%u", index);

	clk = devm_clk_get(&pdev->dev, clock_name);

rather than the much more simple and elegant:

	clk = devm_clk_get(&pdev->dev, "disp");

The whole purpose of the clock consumer ID is to be generic and as such
independent of the specific IP block or instance thereof.

> >> diff --git
> >> a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
> >> b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt 
> >> index 91ff771c7e77..d4f2d534934b 100644 ---
> >> a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt 
> >> +++
> >> b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt 
> >> @@ -6,8 +6,10 @@ Required properties: - interrupts: Should
> >> contain SPI interrupts. - nvidia,dma-request-selector : The Tegra
> >> DMA controller's phandle and request selector for this SPI
> >> controller. -- This is also require clock named "spi" as per
> >> binding document -
> >> Documentation/devicetree/bindings/clock/clock-bindings.txt +-
> >> clocks : Must contain an entry for each entry in clock-names. +
> >> See ../clocks/clock-bindings.txt for details. +- clock-names :
> >> Must include the following entries: +  - spi
> > 
> > This is inconsistent with other bindings that require only a
> > single clock entry. I suppose that this is required because of the
> > driver requesting a specifically named clock, in which case that's
> > fine.
> 
> This driver does clk_get(dev, "spi") rather than clk_get(dev, NULL),
> so this requires a specific name. Again, I did consider updating all
> drivers to use names, but decided I didn't want to do even more driver
> changes, but instead just document what was currently required.

Yes, I realized that as well. Oh well, I guess that's part of the "pain"
for not doing it right from the start. Although, admittedly, this really
isn't a big issue.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131202/0b6bf11c/attachment-0001.sig>
