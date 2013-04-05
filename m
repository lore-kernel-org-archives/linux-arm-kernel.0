From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 5 Apr 2013 08:03:51 +0200
Subject: [PATCH v3 07/12] PCI: tegra: Move PCIe driver to drivers/pci/host
In-Reply-To: <515DF0D9.40007@wwwdotorg.org>
References: <1365000318-28256-1-git-send-email-thierry.reding@avionic-design.de>
 <1365000318-28256-8-git-send-email-thierry.reding@avionic-design.de>
 <515DF096.2000703@wwwdotorg.org> <515DF0D9.40007@wwwdotorg.org>
Message-ID: <20130405060351.GA15848@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 04, 2013 at 03:30:01PM -0600, Stephen Warren wrote:
> On 04/04/2013 03:28 PM, Stephen Warren wrote:
> > On 04/03/2013 08:45 AM, Thierry Reding wrote:
> >> Move the PCIe driver from arch/arm/mach-tegra into the drivers/pci/host
> >> directory. The motivation is to collect various host controller drivers
> >> in the same location in order to facilitate refactoring.
> >>
> >> The Tegra PCIe driver has been largely rewritten, both in order to turn
> >> it into a proper platform driver and to add MSI (based on code by
> >> Krishna Kishore <kthota@nvidia.com>) as well as device tree support.
> > 
> >>  arch/arm/boot/dts/tegra20.dtsi                     |   53 +
> > 
> > I guess this has to touch both the driver and the dtsi file so that
> > bisectabilty isn't broken? I guess that's OK.
> 
> Actually, can't you move all the *.dts/*.dtsi changes to the start of
> the series, then put the driver conversion patch last, to avoid any
> bisectability issues and still keep code and DT changes separate?

I'm not sure if that'll work. There's this oddity in the Harmony DTS
where the regulator at 3 is disabled with a comment that this is a hack
required until board-harmony-pcie.c is removed. If we change the DTS
before the driver rewrite I think that would break requesting the GPIO
in the board file.

A possible workaround I can think of is accessing the regulator from
board-harmony-pcie.c instead of the GPIO directly. But perhaps such an
attempt already failed (deferred probing getting in the way?).

Since it looks like this series will not make it into 3.10, maybe we
should try and at least get these things ironed out so that the merge
can be done more easily in 3.11. One big step in that direction would
obviously be if we could get the DTS changes merged already which, as
you point out, should be independent of the driver rewrite itself.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130405/7d95d3ec/attachment.sig>
