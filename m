From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 27 Jun 2014 13:15:16 +0200
Subject: [RFC 04/10] memory: Add Tegra124 memory controller support
In-Reply-To: <9283417.yKmnrljUYI@wuerfel>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
 <1403815790-8548-5-git-send-email-thierry.reding@gmail.com>
 <9283417.yKmnrljUYI@wuerfel>
Message-ID: <20140627111514.GE2797@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 01:07:04PM +0200, Arnd Bergmann wrote:
> On Thursday 26 June 2014 22:49:44 Thierry Reding wrote:
> > +static const struct tegra_mc_client tegra124_mc_clients[] = {
> > +       {
> > +               .id = 0x01,
> > +               .name = "display0a",
> > +               .swgroup = TEGRA_SWGROUP_DC,
> > +               .smmu = {
> > +                       .reg = 0x228,
> > +                       .bit = 1,
> > +               },
> > +               .latency = {
> > +                       .reg = 0x2e8,
> > +                       .shift = 0,
> > +                       .mask = 0xff,
> > +                       .def = 0xc2,
> > +               },
> > +       }, {
> 
> This is a rather long table that I assume would need to get duplicated
> and modified for each specific SoC. Have you considered to put the information
> into DT instead, as auxiliary data in the iommu specifier as provided by
> the device?

Most of this data really is register information and I don't think that
belongs in DT. Also since this is fixed for a given SoC and in no way
configurable (well, with the exception of the .def field above) I don't
see any point in parsing this from device tree.

Also only the .smmu substruct is immediately relevant to the IOMMU part
of the driver. The .swgroup field could possibly also be moved into that
substructure since it is only relevant to the IOMMU.

So essentially what this table does is map SWGROUPs (which are provided
in the IOMMU specifier) to the clients and registers that the IOMMU
programming needs. As an analogy it corresponds roughly to the pins and
pingroups tables of pinctrl drivers. Those don't belong in device tree
either.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140627/26343dbd/attachment.sig>
