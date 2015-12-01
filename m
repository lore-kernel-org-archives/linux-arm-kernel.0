From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 1 Dec 2015 13:27:45 +0100
Subject: [PATCH v2 11/25] coccinelle: nand: detect and correct drivers
 embedding an mtd_info object
In-Reply-To: <alpine.DEB.2.10.1512011207580.2736@hadrien>
References: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
 <1448967802-25796-12-git-send-email-boris.brezillon@free-electrons.com>
 <alpine.DEB.2.10.1512011207580.2736@hadrien>
Message-ID: <20151201132745.2bc1e294@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 1 Dec 2015 12:17:44 +0100 (CET)
Julia Lawall <julia.lawall@lip6.fr> wrote:

> 
> 
> On Tue, 1 Dec 2015, Boris Brezillon wrote:
> 
> > Add nand-priv-no-mtd.cocci to detect and correct NAND controller drivers
> > directly embedding an mtd_info struct in their private struct.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Cc: Julia Lawall <Julia.Lawall@lip6.fr>
> > ---
> > Hi Julia,
> >
> > Not sure this is the correct way to detect and fix offending drivers,
> > but I get some warnings when launching coccicheck in org or report mode:
> >
> > "warning: fix2: inherited metavariable __chipfield not used in the -, +,
> > or context code"
> >
> > Note that I don't get those warnings when running in patch mode.
> >
> > Any idea (feel free to propose a better solution to detect and fix those
> > offending drivers)?
> 
> Hi,
> 
> Is this code generated with sgen?  If so, could you send me the original
> semantic patch?

Nope, it's been hand written, which might explain the warnings :-/.
Didn't know about sgen, I thought those scripts were all hand written.

> 
> Another thing that is immediately apparent is that you have <... ...> on
> the outside of one of the rules.  This should never be needed.
> 
> The warning suggests that your org and report versions are not doing as
> much as the patch version.  If you have used sgen to generate the semantic
> patch then that would be strange.  If you have hand written the whole
> thing, then maybe you could simplify it to just do the patch version, and
> then I can check it and run sgen on it to make a complete version.

Sure, here it is:

--->8---
virtual patch

@fix1@
identifier __chipfield, __mtdfield;
type __type;
@@
(
	__type {
		...
		struct nand_chip __chipfield;
		...
-		struct mtd_info __mtdfield;
		...
	};
|
	__type {
		...
-		struct mtd_info __mtdfield;
		...
		struct nand_chip __chipfield;
		...
	};
)

@fix2 depends on fix1@
identifier fix1.__chipfield, fix1.__mtdfield;
identifier __subfield;
type fix1.__type;
__type *__priv;
@@
(
-	__priv->__mtdfield.__subfield
+	nand_to_mtd(&__priv->__chipfield)->__subfield
|
-	&(__priv->__mtdfield)
+	nand_to_mtd(&__priv->__chipfield)
)
--->8---

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
