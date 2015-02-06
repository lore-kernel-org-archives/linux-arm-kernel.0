From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 6 Feb 2015 03:28:45 -0800
Subject: [PATCH 1/20] mtd: s3c2410: fix misspelling of current function
 in string
In-Reply-To: <54856C75.1050309@nod.at>
References: <1417980062-25151-1-git-send-email-Julia.Lawall@lip6.fr>
 <1417980062-25151-2-git-send-email-Julia.Lawall@lip6.fr>
 <CAFLxGvyiqxQ6U6p-A-JW8Nv8OvXFGsna93afUu-Gek0EV3gATA@mail.gmail.com>
 <alpine.DEB.2.02.1412080809400.2100@localhost6.localdomain6>
 <54856C75.1050309@nod.at>
Message-ID: <20150206112845.GF4434@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 08, 2014 at 10:16:37AM +0100, Richard Weinberger wrote:
> Am 08.12.2014 um 08:11 schrieb Julia Lawall:
> >>> diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
> >>> index 35aef5e..0a9c41f 100644
> >>> --- a/drivers/mtd/nand/s3c2410.c
> >>> +++ b/drivers/mtd/nand/s3c2410.c
> >>> @@ -948,7 +948,7 @@ static int s3c24xx_nand_probe(struct platform_device *pdev)
> >>>
> >>>         cpu_type = platform_get_device_id(pdev)->driver_data;
> >>>
> >>> -       pr_debug("s3c2410_nand_probe(%p)\n", pdev);
> >>> +       pr_debug("%s(%p)\n", __func__, pdev);
> >>
> >> I think we can drop the line completely.
> >> We have ftrace to trace function calls...
> > 
> > Should the "initialised ok" at the end of the function be remove as well?
> > 
> > Will it be confusing if this cleanup is done in this function, but not in 
> > others where it may be useful?  Perhaps s3c2410_nand_update_chip, for 
> > example?
> 
> Hmm, this driver seems to have a lot of debugging printks().
> IMHO we can remove them.
> Let's see what Brain says.

I'm a little late for this one, but I can apply this instead:

From: Brian Norris <computersforpeace@gmail.com>
Date: Fri, 6 Feb 2015 03:25:28 -0800
Subject: [PATCH] mtd: s3c2410: drop useless / misspelled debug prints

s3c2410_nand_probe is not the name of the function.

These prints have little utility, so let's just kill them.

Reported-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/mtd/nand/s3c2410.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
index 35aef5edb588..0e02be47ce1d 100644
--- a/drivers/mtd/nand/s3c2410.c
+++ b/drivers/mtd/nand/s3c2410.c
@@ -948,8 +948,6 @@ static int s3c24xx_nand_probe(struct platform_device *pdev)
 
 	cpu_type = platform_get_device_id(pdev)->driver_data;
 
-	pr_debug("s3c2410_nand_probe(%p)\n", pdev);
-
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
 	if (info == NULL) {
 		err = -ENOMEM;
@@ -1045,7 +1043,6 @@ static int s3c24xx_nand_probe(struct platform_device *pdev)
 		s3c2410_nand_clk_set_state(info, CLOCK_SUSPEND);
 	}
 
-	pr_debug("initialised ok\n");
 	return 0;
 
  exit_error:
-- 
2.3.0
