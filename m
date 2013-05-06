From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 6 May 2013 12:07:43 -0400
Subject: [PATCH 0/7] mv643xx_eth: device tree bindings
In-Reply-To: <1367854420-8006-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1365071235-11611-1-git-send-email-florian@openwrt.org>
 <1367854420-8006-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130506160743.GV31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

Thanks for picking this up!  A few comments about merging strategy:

On Mon, May 06, 2013 at 05:33:33PM +0200, Sebastian Hesselbarth wrote:
> This patch set picks up work by Florian Fainelli bringing full DT
> support to mv643xx_eth and Marvell SoCs using it.
> 
> The current patch set drops Florian's device tree conversions for
> Kirkwood, Dove, and Orion5x in favour of split patches for board
> files and board descriptor files.
> 
> Device tree conversion for Dove and Kirkwood is added. Dove has
> been fully tested, while Kirkwood is compile-tested only.
> 
> Florian Fainelli (2):
>   net: mv643xx_eth: add Device Tree bindings
>   net: mv643xx_eth: update Device Tree bindings documentation

Obviously, these will go through -net once the submission window opens.

> Sebastian Hesselbarth (5):
(reordered for clarity)

>   ARM: dove: remove legacy mv643xx_eth setup
>   ARM: kirkwood: remove legacy mv643xx_eth board setup
>   ARM: kirkwood: remove legacy clk alias for mv643xx_eth

mvebu/boards or /soc.

>   ARM: kirkwood: add gigabit ethernet and mvmdio device tree nodes
>   ARM: dove: add gigabit ethernet and mvmdio device tree nodes

mvebu/dt


mvebu/dt and -net are fine.  They have no dependencies.  The problem is
mvebu/boards.  To boot with networking, it needs -net *and* mvebu/dt.
Otherwise, the board needs to do legacy init.

I'd like to attempt to remove this dependency-hell with code.  eg some
quick pseudo-code:

	if (!dt_node_present("marvell,mv643xx_eth") ||
	    !mvebu_dt_bindings_present())
		kirkwood_ge00_init();

The advantages of figuring this out are:
 - *no* branch dependencies
 - whole conversion done in one merge window

The drawbacks:
 - need to remember to do a follow-on patch if all branches are
   successfuly merged, removing the unneeded logic (after -rc1)
 - considered churn?

The easy answer is to merge mvebu/dt, and -net, wait one cycle, and
merge the board stuff as you have it now (with Thomas' comment).

If we can figure this out, I'd like to do the same for the kirkwood-pcie
series.

thoughts?

thx,

Jason.
