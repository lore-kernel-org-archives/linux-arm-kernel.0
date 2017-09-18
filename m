From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 18 Sep 2017 14:20:02 +0200
Subject: [PATCH] mtd: oxnas_nand: Fix error handling in oxnas_nand_probe()
In-Reply-To: <87e7ab4e-d3fa-9207-c90c-c2c55b75aaed@baylibre.com>
References: <1504908038-26285-1-git-send-email-khoroshilov@ispras.ru>
 <20170918121409.03e4b978@bbrezillon>
 <87e7ab4e-d3fa-9207-c90c-c2c55b75aaed@baylibre.com>
Message-ID: <20170918142002.5aad038e@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Sep 2017 12:24:38 +0200
Neil Armstrong <narmstrong@baylibre.com> wrote:

> On 09/18/2017 12:14 PM, Boris Brezillon wrote:
> > Hi Alexey,
> > 
> > On Sat,  9 Sep 2017 01:00:38 +0300
> > Alexey Khoroshilov <khoroshilov@ispras.ru> wrote:
> >   
> >> oxnas_nand_probe() does not disable clock on error paths.
> >> The patch adds disabling using devm interface.
> >>
> >> Found by Linux Driver Verification project (linuxtesting.org).
> >>
> >> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> >> ---
> >>  drivers/mtd/nand/oxnas_nand.c | 22 +++++++++++++++-------
> >>  1 file changed, 15 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/mtd/nand/oxnas_nand.c b/drivers/mtd/nand/oxnas_nand.c
> >> index 1b207aac840c..8abc69a285dd 100644
> >> --- a/drivers/mtd/nand/oxnas_nand.c
> >> +++ b/drivers/mtd/nand/oxnas_nand.c
> >> @@ -103,16 +103,26 @@ static int oxnas_nand_probe(struct platform_device *pdev)
> >>  	if (IS_ERR(oxnas->io_base))
> >>  		return PTR_ERR(oxnas->io_base);
> >>  
> >> -	oxnas->clk = devm_clk_get(&pdev->dev, NULL);
> >> -	if (IS_ERR(oxnas->clk))
> >> -		oxnas->clk = NULL;
> >> -
> >>  	/* Only a single chip node is supported */
> >>  	count = of_get_child_count(np);
> >>  	if (count > 1)
> >>  		return -EINVAL;
> >>  
> >> -	clk_prepare_enable(oxnas->clk);
> >> +	oxnas->clk = devm_clk_get(&pdev->dev, NULL);
> >> +	if (IS_ERR(oxnas->clk)) {
> >> +		oxnas->clk = NULL;
> >> +	} else {
> >> +		err = clk_prepare_enable(oxnas->clk);
> >> +		if (err)
> >> +			return err;
> >> +
> >> +		err = devm_add_action_or_reset(&pdev->dev,
> >> +				(void(*)(void *))clk_disable_unprepare,
> >> +				oxnas->clk);
> >> +		if (err)
> >> +			return err;
> >> +	}
> >> +  
> > 
> > Looks like something that should be made available at the CCF level
> > either with a devm_clk_get_prepare_enable() or with a
> > devm_clk_prepare_enable() helper. Would you care proposing this change
> > to the CCF ML?
> > 
> > In the meantime can you provide a simpler fix that just adds the
> > missing clk_disable_unprepare() call in the error path?
> >   
> >>  	device_reset_optional(&pdev->dev);
> >>  
> >>  	for_each_child_of_node(np, nand_np) {
> >> @@ -167,8 +177,6 @@ static int oxnas_nand_remove(struct platform_device *pdev)
> >>  	if (oxnas->chips[0])
> >>  		nand_release(nand_to_mtd(oxnas->chips[0]));
> >>  
> >> -	clk_disable_unprepare(oxnas->clk);
> >> -
> >>  	return 0;
> >>  }
> >>    
> >   
> 
> Hi Boris,
> 
> I would also like this to be simpler, but this is the actual way to workaround the lack of advanced devm_ calls from CCF.

I did not realized that when I reviewed the patch this morning,
but the bug has already been fixed by 24c9cd8f8d26 ("mtd: oxnas_nand:
Handle clk_prepare_enable/clk_disable_unprepare."), which you acked.

> 
> Is it an issue to keep this change ?

Well, let's assume the patch was really fixing a bug. If it's
targeting an -rc or is meant to be backported, the patch should be as
simple as possible, which not the case here.
Another reason to keep the existing pattern is that, once you've added
the appropriate devm_ function to the CCF, you can automate the
adoption of this function throughout the whole kernel tree using a
coccinelle script. If you start modifying some call-site that makes yet
another pattern to detect in the cocci script.
