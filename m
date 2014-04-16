From: david@gibson.dropbear.id.au (David Gibson)
Date: Wed, 16 Apr 2014 17:30:53 +1000
Subject: [PATCH] dtc: add ability to make nodes conditional on them being
 referenced
In-Reply-To: <199290403.sj4aYrj8FC@diego>
References: <199290403.sj4aYrj8FC@diego>
Message-ID: <20140416073053.GB12216@voom.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 16, 2014 at 10:22:02PM +0100, Heiko St?bner wrote:
> From: Heiko Stuebner <heiko.stuebner@bq.com>
> 
> On i.MX, which carries a lot of pin-groups of which most are unused on
> individual boards, they noticed that this plethora of nodes also results
> in the runtime-lookup-performance also degrading [0].
> 
> A i.MX-specific solution defining the pingroups in the board files but
> using macros to reference the pingroup-data was not well received.
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
> 	/delete-unreferenced/ pinctrl_ecspi1_1: ecspi1grp-1 {
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

Sorry for the delay - I'm pretty busy with non-dtc things.

Concept looks fine to me.  It's perhaps a bit special use case, but
the syntax is well isolated (that is, unlikely to mix badly with other
possible syntax changes), so I'm happy enough to include it for those
who want it.

Maybe change the keyword to /delete-if-unreferenced/, it's a little
bit more accurate.  It's a bit long-winded, but I can't think of a
more succinct term, so it will do.

It needs testcases.

There are a few minor problems in the implementation.

With those things fixed, I'd be happy to apply.

Some detailed comments on the implementation below:

[snip]
> @@ -472,6 +472,8 @@ static void fixup_phandle_references(struct check *c, struct node *dt,
>  
>  		phandle = get_node_phandle(dt, refnode);
>  		*((cell_t *)(prop->val.val + m->offset)) = cpu_to_fdt32(phandle);
> +
> +		reference_node(refnode);

This may have some slightly unexpected behaviour when combined with
/delete-node/ and or /delete-prop/.  At worst it should include the
unnecessary node though, so I don't think it's a big problem.

[snip]
> +struct node *check_node_referenced(struct node *node)

This function needs a different name, since it doesn't actually check
anything (it just triggers a later check).  Maybe
mark_node_needs_reference().

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140416/3608e549/attachment.sig>
