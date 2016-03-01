From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 1 Mar 2016 14:57:00 +1100
Subject: linux-next: manual merge of the clk tree with the arm-soc tree
Message-ID: <20160301145700.784f5fcf@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the clk tree got a conflict in:

  drivers/clk/at91/clk-main.c

between commit:

  99a81706526f ("clk: at91: remove IRQ handling and use polling")

from the arm-soc tree and commit:

  8c1b1e54faed ("clk: at91: Remove impossible checks for of_clk_get_parent_count()")

from the clk tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell

diff --cc drivers/clk/at91/clk-main.c
index 4bfc94d6c26e,b85f43529396..000000000000
--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@@ -572,12 -611,12 +572,12 @@@ static void __init of_at91sam9x5_clk_ma
  {
  	struct clk *clk;
  	const char *parent_names[2];
- 	int num_parents;
+ 	unsigned int num_parents;
 -	unsigned int irq;
  	const char *name = np->name;
 +	struct regmap *regmap;
  
  	num_parents = of_clk_get_parent_count(np);
- 	if (num_parents <= 0 || num_parents > 2)
+ 	if (num_parents == 0 || num_parents > 2)
  		return;
  
  	of_clk_parent_fill(np, parent_names, num_parents);
