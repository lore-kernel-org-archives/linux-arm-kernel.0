From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 23 May 2017 15:19:40 +0800
Subject: [PATCH] clk: sunxi-ng: select SUNXI_CCU_MULT for sun8i-a83t
In-Reply-To: <20170523005553.GH20170@codeaurora.org>
References: <20170522202951.2896280-1-arnd@arndb.de>
 <20170523005553.GH20170@codeaurora.org>
Message-ID: <20170523071940.xbnahikb4d5dge7v@wens.csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 05:55:53PM -0700, Stephen Boyd wrote:
> On 05/22, Arnd Bergmann wrote:
> > We get a link error when CCU_MULT is not set with the
> > newly added driver:
> > 
> > drivers/clk/sunxi-ng/ccu-sun8i-a83t.o:(.data.__compound_literal.1+0x4): undefined reference to `ccu_mult_ops'
> > drivers/clk/sunxi-ng/ccu-sun8i-a83t.o:(.data.__compound_literal.3+0x4): undefined reference to `ccu_mult_ops'
> > 
> > Fixes: 46b492116666 ("clk: sunxi-ng: Add driver for A83T CCU")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Chen-Yu Tsai <wens@csie.org>

> Is there any way we can automate finding these build errors and
> prevent them from creeping into the tree? It may be asking too
> much, but it seems like we should be able to find these
> particular problems with some script that greps for ccu_*_ops and
> checks that any file's Kconfig symbol also has that selected.
> 
> Anyway, I'm just tired of seeing these sorts of things in my
> inbox.

The (ugly) script below does the trick, though it does give results
for some symbols that are indirectly selected:

SUN5I_CCU uses SUNXI_CCU_GATE but does not select it
SUN5I_CCU uses SUNXI_CCU_MUX but does not select it
SUN5I_CCU uses SUNXI_CCU_NKMP but does not select it
SUN6I_A31_CCU uses SUNXI_CCU_GATE but does not select it
SUN6I_A31_CCU uses SUNXI_CCU_MUX but does not select it
SUN8I_A23_CCU uses SUNXI_CCU_GATE but does not select it
SUN8I_A23_CCU uses SUNXI_CCU_MUX but does not select it
SUN8I_A33_CCU uses SUNXI_CCU_GATE but does not select it
SUN8I_A33_CCU uses SUNXI_CCU_MUX but does not select it
SUN8I_A83T_CCU uses SUNXI_CCU_MULT but does not select it
SUN8I_H3_CCU uses SUNXI_CCU_GATE but does not select it
SUN8I_H3_CCU uses SUNXI_CCU_MUX but does not select it
SUN8I_V3S_CCU uses SUNXI_CCU_GATE but does not select it
SUN8I_V3S_CCU uses SUNXI_CCU_MUX but does not select it
SUN9I_A80_CCU uses SUNXI_CCU_MUX but does not select it

------------------------------------------------------------------------

#!/bin/bash

LANG=C

for i in drivers/clk/sunxi-ng/ccu-*.o; do
	FILE=`basename $i`
	CLKS=`nm -g $i | grep -P -o "ccu_.*(?=_ops)" | tr [a-z] [A-Z]`
	CFG=`grep $FILE drivers/clk/sunxi-ng/Makefile |
		grep -P -o "(?<=CONFIG_)SUN[A-Z0-9_]*"`

	for clk in $CLKS; do
		perl -0777 -ne "/$CFG(.*?)^(?:config|endif)/sm; print \$1" \
			drivers/clk/sunxi-ng/Kconfig | grep -q "SUNXI_$clk" ||
			echo "$CFG uses SUNXI_$clk but does not select it"
	done
done

------------------------------------------------------------------------


Regards
ChenYu
