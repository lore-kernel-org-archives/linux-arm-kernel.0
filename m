From: matti.vaittinen@fi.rohmeurope.com (Matti Vaittinen)
Date: Mon, 12 Nov 2018 09:45:53 +0200
Subject: [PATCH 2/2] clk: bd718x7: Initial support for ROHM
 bd71837/bd71847 PMIC clock
In-Reply-To: <20180903063843.GD2472@localhost.localdomain>
References: <0e6f19f99a4321d37472635c9210f6c13ac53147.1535630942.git.matti.vaittinen@fi.rohmeurope.com>
 <201808310820.GfPfChXp%fengguang.wu@intel.com>
 <20180831102123.GA2472@localhost.localdomain>
 <153582920636.19113.4389105687778850598@swboyd.mtv.corp.google.com>
 <20180903063843.GD2472@localhost.localdomain>
Message-ID: <20181112074553.GB31573@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Stephen & All,

On Mon, Sep 03, 2018 at 09:38:43AM +0300, Matti Vaittinen wrote:
> 
> On Sat, Sep 01, 2018 at 12:13:26PM -0700, Stephen Boyd wrote:
> > Quoting Matti Vaittinen (2018-08-31 03:21:23)
> > > Hello All,
> > > 
> > > Just wanted to point out for the reviewers that this patch depends on
> > > not yet accepted MFD/regulator patch. (struct/defines in
> > > include/linux/mfd/rohm-bd718x7.h were changed)
> > > https://lore.kernel.org/lkml/cover.1535545377.git.matti.vaittinen at fi.rohmeurope.com/
> > 
> > Does anything besides the clk driver need the defines that are in the
> > header which are used in this file?
> 
> The register address for clk enable and bit mask are not used by any
> other driver. But I'd like to keep all the register addresses in one
> enum. That eases checking changes when new chips come.
> 
> The private data for MFD (which contains for example the regmap and chip
> type) are required by other drivers too.
> 
> > If not, then it's better to put
> > those defines in the C file for the clk driver so we don't have to hop
> > between files and have merge dependencies. Also, the regmap could
> > possibly by grabbed from the dev->parent pointer instead of passing it
> > down through an mfd structure, allowing this driver to be more generic
> > assuming it is always a child of some mfd device that has a regmap.
> 
> Currently clk only uses regmap directly from the struct bd718xx. But I
> would like to have the access to chip_type as well. And even if we forget
> the chip_type. Well, I only see two bad ways of omitting the struct
> bd718xx:
> 
> 1. Always keep the regmap as first member in parent device's driver_data.
> Then we can just get the driver data and do cast to regmap. I am not fan
> of this as it breaks as fast as someone changes the struct bd718xx - and
> as this is part of MFD - well, there is no guarantees the clk people are
> even reviewing such change. Also if we need the chip type we are back
> using the struct.
> 
> 2. Use some regmnap wrapper functions which would only take the parent
> dev pointer and dig out the regmap details. This would be doable but
> then we still have dependency to these wrappers (so dependency is not
> solved). Additionally these wrappers are something we decided to get rid
> of few patch versions ago.
> 
> I don't expect much renamings to take place after the latest patch set
> to MFD/regulator tree has been applied. So maybe the clk patch set can
> just wait untill MFD/regulator stuff gets integrated. I would be
> gratefull if we could review the clk patch set already now though so I
> could do improvements/changes to clk side while waiting for
> MFD/regulator to get applied. Also, the devm_ functions (patch 1) are
> not depending on MFD - so maybe we can get them reviewed/applied? If I
> have the spare time I can look if I can clean up some of those not freed
> clkdev lookups.
> 
The MFD renaming patch has now been merged to clk-next. So dependencies
to MFD should now be in-tree. I will rebase this to clk-next and do
resend. This patch still requires the devm variants for clkdev lookups
an devm variant of "parent of provider"-registration. I did submit those
as part of the cleanup series:
https://lore.kernel.org/linux-clk/cover.1541161503.git.matti.vaittinen at fi.rohmeurope.com/

My question is if you prefer me to add this driver in that series and
resend the series as v4? Or do you want me to send this in own
individual patch with just a note about the dependency?

Best Regards
	Matti Vaittinen

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
