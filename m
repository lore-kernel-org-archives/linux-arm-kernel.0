From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Tue, 13 Mar 2018 11:29:34 +0100
Subject: [PATCH v2] mtd: nand: marvell: Fix clock resource by adding a
 register clock
In-Reply-To: <20180312203529.7963ef29@bbrezillon> (Boris Brezillon's message
 of "Mon, 12 Mar 2018 20:35:29 +0100")
References: <20180307161316.14612-1-gregory.clement@bootlin.com>
 <20180307204418.014622b8@bbrezillon> <87vae11bep.fsf@bootlin.com>
 <20180312203529.7963ef29@bbrezillon>
Message-ID: <87o9js1d69.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,
 
 On lun., mars 12 2018, Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> On Mon, 12 Mar 2018 17:55:26 +0100
> Gregory CLEMENT <gregory.clement@bootlin.com> wrote:
>
>> >  
>> >>  	struct completion complete;
>> >>  	unsigned long assigned_cs;
>> >>  	struct list_head chips;
>> >> @@ -2747,12 +2748,24 @@ static int marvell_nfc_probe(struct platform_device *pdev)
>> >>  	if (ret)
>> >>  		return ret;
>> >>  
>> >> +	nfc->reg_clk = devm_clk_get(&pdev->dev, "reg");
>> >> +	if (PTR_ERR(nfc->reg_clk) != -ENOENT) {
>> >> +		if (!IS_ERR(nfc->reg_clk)) {
>> >> +			ret = clk_prepare_enable(nfc->reg_clk);
>> >> +			if (ret)
>> >> +				goto unprepare_clk;  
>> >
>> > I already suggested to move the devm_clk_get(&pdev->dev, "reg") before
>> > the clk_prepare_enable(nfc->ecc_clk) one to simplify the error path.
>> >  
>> 
>> Actually I started to implement your suggestion but unlike what you
>> though it made the code less simpler. Indeed by having the mandatory
>> clock first than in case of failure we can directly exit the function.
>> 
>> If the reg clock was initialized first, then if the core/ecc clock fail
>> in soem case we woudl need to daisbel the reg clock and in other case we
>> could directly exit.
>
> Well, it's pretty much the same problem if you do it in the order you
> propose here: if the core clk enable fails, you'll have to disable the

So if it is the same no need to change! :)

> reg clk. Plus, I'm not a big fan of if/else block imbrications when we
> can avoid them.


Your solution to avoid if/else block is to add extra code and extra test
which do not bring anything except removing an if/else bloc.

For the record it was

	nfc->reg_clk = devm_clk_get(&pdev->dev, "reg");
	if (PTR_ERR(nfc->reg_clk) == -ENOENT)
		nfc->reg_clk = NULL;
--> here you set to NULL whereas it is useless


	if (IS_ERR(nfc->reg_clk))
		return PTR_ERR(nfc->reg_clk);
--> here you test again the return value even if it was previously set
to -ENOENT

	...

	ret = clk_prepare_enable(nfc->reg_clk);
--> here if reg_clk was NULL due to the beginning of the block you do a
useless call to clk_prepare_enable

	if (ret)
		goto unprepare_ecc_clk;


Gregory

>
>> 
>> 
>> >> +		} else {
>> >> +			ret = PTR_ERR(nfc->reg_clk);
>> >> +			goto unprepare_clk;
>> >> +		}
>> >> +	}  



-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
