From: sboyd@kernel.org (Stephen Boyd)
Date: Sat, 01 Sep 2018 12:13:26 -0700
Subject: [PATCH 2/2] clk: bd718x7: Initial support for ROHM
 bd71837/bd71847 PMIC clock
In-Reply-To: <20180831102123.GA2472@localhost.localdomain>
References: <0e6f19f99a4321d37472635c9210f6c13ac53147.1535630942.git.matti.vaittinen@fi.rohmeurope.com>
 <201808310820.GfPfChXp%fengguang.wu@intel.com>
 <20180831102123.GA2472@localhost.localdomain>
Message-ID: <153582920636.19113.4389105687778850598@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Matti Vaittinen (2018-08-31 03:21:23)
> Hello All,
> 
> Just wanted to point out for the reviewers that this patch depends on
> not yet accepted MFD/regulator patch. (struct/defines in
> include/linux/mfd/rohm-bd718x7.h were changed)
> https://lore.kernel.org/lkml/cover.1535545377.git.matti.vaittinen at fi.rohmeurope.com/
> 
> On Fri, Aug 31, 2018 at 09:18:19AM +0800, kbuild test robot wrote:
> > Hi Matti,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on clk/clk-next]
> > [also build test ERROR on v4.19-rc1 next-20180830]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> Thus this error was expected. What is the generally best way to work
> when there is changes to more than one subsystem? With this approach
> the patch set here won't compile until MFD part gets applied. But if
> I use old definitions/structs here, then clk tree gets broken when
> MFD/regulator part changes defines. I see only bad and worse options =)
> Anyways, I guess sending this patch with new defines (and applying it
> only after MFD) is still better than applying this with old defines and
> breaking it when MFD changes. (Assuming all of the patches get applied
> at some point).
> 

Does anything besides the clk driver need the defines that are in the
header which are used in this file? If not, then it's better to put
those defines in the C file for the clk driver so we don't have to hop
between files and have merge dependencies. Also, the regmap could
possibly by grabbed from the dev->parent pointer instead of passing it
down through an mfd structure, allowing this driver to be more generic
assuming it is always a child of some mfd device that has a regmap.
