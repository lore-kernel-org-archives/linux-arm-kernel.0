From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Tue, 06 Mar 2018 12:04:41 +0100
Subject: [PATCH] mtd: nand: marvell: Fix clock resource by adding a
 register clock
In-Reply-To: <20180301183520.4251439a@bbrezillon> (Boris Brezillon's message
 of "Thu, 1 Mar 2018 18:35:20 +0100")
References: <20180228143553.12485-1-gregory.clement@bootlin.com>
 <20180301183520.4251439a@bbrezillon>
Message-ID: <874llt5ut2.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,
 
 On jeu., mars 01 2018, Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> Hi Greg,
>
> On Wed, 28 Feb 2018 15:35:53 +0100
> Gregory CLEMENT <gregory.clement@bootlin.com> wrote:
>
>> On Armada 7K/8K we need to explicitly enable the register clock. This
>> clock is optional because not all the SoCs using this IP need it but at
>> least for Armada 7K/8K it is actually mandatory.
>> 
>> The binding documentation is updated accordingly.
>> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> ---
>>  Documentation/devicetree/bindings/mtd/marvell-nand.txt |  6 +++++-
>>  drivers/mtd/nand/marvell_nand.c                        | 14 ++++++++++++++
>>  2 files changed, 19 insertions(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/mtd/marvell-nand.txt b/Documentation/devicetree/bindings/mtd/marvell-nand.txt
>> index c08fb477b3c6..4ee9813bf88f 100644
>> --- a/Documentation/devicetree/bindings/mtd/marvell-nand.txt
>> +++ b/Documentation/devicetree/bindings/mtd/marvell-nand.txt
>> @@ -14,7 +14,11 @@ Required properties:
>>  - #address-cells: shall be set to 1. Encode the NAND CS.
>>  - #size-cells: shall be set to 0.
>>  - interrupts: shall define the NAND controller interrupt.
>> -- clocks: shall reference the NAND controller clock.
>> +- clocks: shall reference the NAND controller clocks, the second one is
>> +  optional but needed for the Armada 7K/8K SoCs
>> +- clock-names: mandatory if there is a second clock, in this case the
>> +   name must be "core" for the first clock and "reg" for the second
>> +   one
>
> Hm, not sure this is a good idea to impose a specific order. I know you

It would be a problem if the use of this clock would be at dts level
for each board. But here we only setup this property in the dtsi at SoC
level. So enforcing the order is not a problem as the dtsi are all well
reviewed and remains pretty rare.

> do that to avoid changing the code requesting the core clk, but I'd
> prefer to have a solution where we first search for a clock named
> "core" (devm_clk_get(&pdev->dev, "core")), and if it's missing,
> fall back to devm_clk_get(&pdev->dev, NULL).

I really wanted to avoid adding more code only for legacy reason.

>
>>  - marvell,system-controller: Set to retrieve the syscon node that handles
>>    NAND controller related registers (only required with the
>>    "marvell,armada-8k-nand[-controller]" compatibles).
>> diff --git a/drivers/mtd/nand/marvell_nand.c b/drivers/mtd/nand/marvell_nand.c
>> index 2196f2a233d6..be874c636b5f 100644
>> --- a/drivers/mtd/nand/marvell_nand.c
>> +++ b/drivers/mtd/nand/marvell_nand.c
>> @@ -321,6 +321,7 @@ struct marvell_nfc {
>>  	struct device *dev;
>>  	void __iomem *regs;
>>  	struct clk *ecc_clk;
>> +	struct clk *reg_clk;
>>  	struct completion complete;
>>  	unsigned long assigned_cs;
>>  	struct list_head chips;
>> @@ -2747,6 +2748,17 @@ static int marvell_nfc_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		return ret;
>>  
>> +	nfc->reg_clk = devm_clk_get(&pdev->dev, "reg");
>
> Can we move that before the "core" clock (which for some unknown reason
> is called ecc_clk in the driver) is prepared, so that you don't have to
> call clk_disable_unprepare() here.
>
>> +	if (IS_ERR(nfc->reg_clk) && PTR_ERR(nfc->reg_clk) == -EPROBE_DEFER) {
>> +		clk_disable_unprepare(nfc->ecc_clk);
>> +		return -EPROBE_DEFER;
>> +	}
>
> Why not:
>
> 	if (IS_ERR(nfc->reg_clk) && PTR_ERR(nfc->reg_clk) != -ENOENT)
> 		return PTR_ERR(nfc->reg_clk);
>
> ?
>
> AFAIR, if the clk is not defined, ENOENT is returned, and you want to
> propagate all error codes, not only EPROBE_DEFER otherwise.


Indeed it makes sens.

>
> Another solution would be to retrieve the reg clk only on platforms
> that need it (based on the compatible). This way you won't have to test
> for -ENOENT and could simply propagate the error to the upper layer.

We can't do this because we need to be bacwkard compatible.

>
>> +	if (!IS_ERR(nfc->reg_clk)) {
>> +		ret = clk_prepare_enable(nfc->reg_clk);
>> +		if (ret)
>> +			goto unprepare_clk;
>
> This is wrong: you've put a clk_disable_unprepare(nfc->reg_clk) call in
> the unprepare_clk path, which means you'll disable/unprepare a clk that
> has not been successfully prepared/enabled => unbalanced refcounting.
>
> Please define a new label and rename the old one.


OK

Thanks,

Gregory-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
