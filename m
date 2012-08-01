From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 1 Aug 2012 08:35:45 +0200
Subject: [PATCH v3 00/10] ARM: tegra: Add PCIe device tree support
In-Reply-To: <50180547.9040603@wwwdotorg.org>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <50180547.9040603@wwwdotorg.org>
Message-ID: <20120801063545.GA26791@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 10:18:15AM -0600, Stephen Warren wrote:
> On 07/26/2012 01:55 PM, Thierry Reding wrote:
> > This patch series adds support for device tree based probing of the PCIe
> > controller found on Tegra SoCs.
> 
> Thierry,
> 
> I think one thing that would help here would be to split up this series
> into one per subsystem, and to get all the dependencies merged by the
> respective maintainers. Preferably, each subsystem would export a stable
> branch (perhaps consisting of just these patches) that I can then merge
> into the Tegra tree and use as a basis for the PCIe driver itself.
> Hopefully this approach will get more traction on all the non-Tegra
> changes. Does that sound like a good plan?

I don't understand. The series is already split up into per-subsystem
patches. I just didn't want to post them separately so everybody on Cc
would be able to see the big picture and the reason why the patch was
required.

> Or, I can just take it all through the Tegra tree, but I'll definitely
> need acks on all/most of the non-Tegra patches, since although the
> patches themselves are quite small, I'd like to be sure that maintainers
> are OK with the conceptual changes, like initializing PCI controllers
> later than at present etc.

Taking the patches through the individual trees should be fine. Only so
far other subsystem maintainers haven't commented on this.

As to when the PCI controller is initialized, there really aren't many
options. On Harmony (and TEC, which in this respect, and others, is very
similar) the VDD is supplied by a GPIO of the PMU, so it is currently
necessary to probe it at least after the PMU. And unless we want to
work around these issues using different initcall ordering we need to
rely on deferred probing, which turns out to be done after the init
phase often (always?).

Also I had been toying with making the Tegra PCIe driver work as a
module, but that doesn't work currently with MSI support. However it
might be nice to allow MSI controllers to register at runtime generally,
which wouldn't be all that difficult to do I think. Of course somebody
more knowledgeable may disagree.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120801/e010e09f/attachment.sig>
