From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Feb 2014 20:22:15 +0100
Subject: [RFC] dtc: add ability to make nodes conditional on them being
 referenced
In-Reply-To: <1578575.rVWgTPdq1W@phil>
References: <1578575.rVWgTPdq1W@phil>
Message-ID: <20140203192215.GA25625@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 30, 2014 at 01:25:56PM +0100, Heiko St?bner wrote:
> From: Heiko Stuebner <heiko.stuebner@bqreaders.com>
> 
> On i.MX, which carries a lot of pin-groups of which most are unused on
> individual boards, they noticed that this plehora of nodes also results
> in the runtime-lookup-performance also degrading [0].
> 
> A i.MX-specific solution defining the pingroups in the board files but
> using macros to reference the pingroup-data was not well received
> 
> This patch is trying to solve this issue in a more general way, by
> adding the ability to mark nodes as needing to be referenced somewhere
> in the tree.
> 
> To mark a node a needing to be referenced it must be prefixed with
> /delete-unreferenced/. This makes dtc check the nodes reference-status
> when creating the flattened tree, dropping it if unreferenced.
> 
> For example, the i.MX6SL pingroup
> 
> 	/delete-uneferenced/ pinctrl_ecspi1_1: ecspi1grp-1 {
> 		fsl,pins = <
> 			MX6SL_PAD_ECSPI1_MISO__ECSPI1_MISO 0x100b1
> 			MX6SL_PAD_ECSPI1_MOSI__ECSPI1_MOSI 0x100b1
> 			MX6SL_PAD_ECSPI1_SCLK__ECSPI1_SCLK 0x100b1
> 		>;
> 	};
> 
> would only be included in the dtb if it got referenced somewhere
> as pingroup via
> 
> 	node {
> 		pinctrl-0 <&pinctrl_ecscpi1_1>;
> 	};
> 
> [0] http://thread.gmane.org/gmane.linux.ports.arm.kernel/275912/
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@bqreaders.com>
> ---
> This is just the idea I had in [1] explored a bit more. I'm definitely
> not sure if this is a valid approach to the problem.
> Also this is my first venture into dtc as well as flex and bison :-) .
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg303731.html

This is a nice feature to have :)

However, I wonder wether it's the right way of implementing it. I'd
have another use case for this, which would be to embed a DT in a
first-stage bootloader. We have around 7kB available currently for the
DT, and this is actually less than any of our (very small already)
DTBs. So having this of feature makes complete sense to us
too. However, we also have some other tools that require most of the
nodes to be in the DTB.

So I guess turning wether we should delete a node if unreferenced into
a dtc option would make sense, since every DT user will be able to
choose, without having to duplicate the DT and make conflicting
changes.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140203/4771d4c2/attachment-0001.sig>
