From: adrian.wenl@gmail.com (Lei Wen)
Date: Mon, 13 Sep 2010 19:56:14 +0800
Subject: [PATCH 1/6] pxa3xx_nand: make scan procedure more clear
In-Reply-To: <AANLkTinGdpt3kiCas6tpEZPbTknEe1Upz9D_aLgfNWo_@mail.gmail.com>
References: <1283179285-6539-1-git-send-email-haojian.zhuang@marvell.com>
	<AANLkTinGdpt3kiCas6tpEZPbTknEe1Upz9D_aLgfNWo_@mail.gmail.com>
Message-ID: <AANLkTimJOT1AozJEgsvZZ=gCKhKyHgGa3FckOWaDpX20@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 9, 2010 at 9:59 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Mon, Aug 30, 2010 at 10:41 PM, Haojian Zhuang
> <haojian.zhuang@gmail.com> wrote:
>> From: Lei Wen <leiwen@marvell.com>
>>
>> Signed-off-by: Lei Wen <leiwen@marvell.com>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>> Cc: Eric Miao <eric.y.miao@gmail.com>
>> Cc: David Woodhouse <dwmw2@infradead.org>
>> ---
>> ?drivers/mtd/nand/pxa3xx_nand.c | ? 88 ++++++++++++++++++++++-----------------
>> ?1 files changed, 50 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
>> index 5d24968..3468a3d 100644
>> --- a/drivers/mtd/nand/pxa3xx_nand.c
>> +++ b/drivers/mtd/nand/pxa3xx_nand.c
>> @@ -126,6 +126,7 @@ struct pxa3xx_nand_info {
>> ? ? ? ?unsigned int ? ? ? ? ? ?buf_start;
>> ? ? ? ?unsigned int ? ? ? ? ? ?buf_count;
>>
>> + ? ? ? struct mtd_info ? ? ? ? *mtd;
>> ? ? ? ?/* DMA information */
>> ? ? ? ?int ? ? ? ? ? ? ? ? ? ? drcmr_dat;
>> ? ? ? ?int ? ? ? ? ? ? ? ? ? ? drcmr_cmd;
>> @@ -1044,21 +1045,13 @@ static void pxa3xx_nand_init_mtd(struct mtd_info *mtd,
>> ? ? ? ?this->chip_delay = 25;
>> ?}
>>
>> -static int pxa3xx_nand_probe(struct platform_device *pdev)
>> +static int alloc_nand_resource(struct platform_device *pdev)
>> ?{
>> - ? ? ? struct pxa3xx_nand_platform_data *pdata;
>> + ? ? ? struct pxa3xx_nand_platform_data *pdata = pdev->dev.platform_data;
>> ? ? ? ?struct pxa3xx_nand_info *info;
>> - ? ? ? struct nand_chip *this;
>> ? ? ? ?struct mtd_info *mtd;
>> ? ? ? ?struct resource *r;
>> - ? ? ? int ret = 0, irq;
>> -
>> - ? ? ? pdata = pdev->dev.platform_data;
>> -
>> - ? ? ? if (!pdata) {
>> - ? ? ? ? ? ? ? dev_err(&pdev->dev, "no platform data defined\n");
>> - ? ? ? ? ? ? ? return -ENODEV;
>> - ? ? ? }
>> + ? ? ? int ret, irq;
>>
>> ? ? ? ?mtd = kzalloc(sizeof(struct mtd_info) + sizeof(struct pxa3xx_nand_info),
>> ? ? ? ? ? ? ? ? ? ? ? ?GFP_KERNEL);
>> @@ -1070,8 +1063,8 @@ static int pxa3xx_nand_probe(struct platform_device *pdev)
>> ? ? ? ?info = (struct pxa3xx_nand_info *)(&mtd[1]);
>> ? ? ? ?info->pdev = pdev;
>>
>> - ? ? ? this = &info->nand_chip;
>> ? ? ? ?mtd->priv = info;
>> + ? ? ? info->mtd = mtd;
>> ? ? ? ?mtd->owner = THIS_MODULE;
>>
>> ? ? ? ?info->clk = clk_get(&pdev->dev, NULL);
>> @@ -1149,27 +1142,9 @@ static int pxa3xx_nand_probe(struct platform_device *pdev)
>> ? ? ? ?}
>>
>> ? ? ? ?pxa3xx_nand_init_mtd(mtd, info);
>> + ? ? ? platform_set_drvdata(pdev, info);
>>
>> - ? ? ? platform_set_drvdata(pdev, mtd);
>> -
>> - ? ? ? if (nand_scan(mtd, 1)) {
>> - ? ? ? ? ? ? ? dev_err(&pdev->dev, "failed to scan nand\n");
>> - ? ? ? ? ? ? ? ret = -ENXIO;
>> - ? ? ? ? ? ? ? goto fail_free_irq;
>> - ? ? ? }
>> -
>> - ? ? ? if (mtd_has_cmdlinepart()) {
>> - ? ? ? ? ? ? ? static const char *probes[] = { "cmdlinepart", NULL };
>> - ? ? ? ? ? ? ? struct mtd_partition *parts;
>> - ? ? ? ? ? ? ? int nr_parts;
>> -
>> - ? ? ? ? ? ? ? nr_parts = parse_mtd_partitions(mtd, probes, &parts, 0);
>> -
>> - ? ? ? ? ? ? ? if (nr_parts)
>> - ? ? ? ? ? ? ? ? ? ? ? return add_mtd_partitions(mtd, parts, nr_parts);
>> - ? ? ? }
>> -
>> - ? ? ? return add_mtd_partitions(mtd, pdata->parts, pdata->nr_parts);
>> + ? ? ? return 0;
>>
>> ?fail_free_irq:
>> ? ? ? ?free_irq(irq, info);
>> @@ -1194,8 +1169,8 @@ fail_free_mtd:
>>
>> ?static int pxa3xx_nand_remove(struct platform_device *pdev)
>> ?{
>> - ? ? ? struct mtd_info *mtd = platform_get_drvdata(pdev);
>> - ? ? ? struct pxa3xx_nand_info *info = mtd->priv;
>> + ? ? ? struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
>> + ? ? ? struct mtd_info *mtd = info->mtd;
>> ? ? ? ?struct resource *r;
>> ? ? ? ?int irq;
>>
>> @@ -1224,11 +1199,48 @@ static int pxa3xx_nand_remove(struct platform_device *pdev)
>> ? ? ? ?return 0;
>> ?}
>>
>> +static int pxa3xx_nand_probe(struct platform_device *pdev)
>> +{
>> + ? ? ? struct pxa3xx_nand_platform_data *pdata;
>> + ? ? ? struct pxa3xx_nand_info *info;
>> + ? ? ? int ret;
>> +
>> + ? ? ? pdata = pdev->dev.platform_data;
>> + ? ? ? if (!pdata) {
>> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "no platform data defined\n");
>> + ? ? ? ? ? ? ? return -ENODEV;
>> + ? ? ? }
>> +
>> + ? ? ? ret = alloc_nand_resource(pdev);
>
> Hrm... I'd rather this being something like:
>
> ? ? ? ?info = alloc_nand_info(pdev);
> ? ? ? ?if (info == NULL)
> ? ? ? ? ? ? ? ?blah ... blah ...
>
> Otherwise looks all good to me.
>

That make sense.
How about the other five patches.  :-)

Thanks,
Lei
>> + ? ? ? if (ret)
>> + ? ? ? ? ? ? ? return ret;
>> +
>> + ? ? ? info = platform_get_drvdata(pdev);
>> + ? ? ? if (nand_scan(info->mtd, 1)) {
>> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "failed to scan nand\n");
>> + ? ? ? ? ? ? ? pxa3xx_nand_remove(pdev);
>> + ? ? ? ? ? ? ? return -ENODEV;
>> + ? ? ? }
>> +
>> + ? ? ? if (mtd_has_cmdlinepart()) {
>> + ? ? ? ? ? ? ? static const char *probes[] = { "cmdlinepart", NULL };
>> + ? ? ? ? ? ? ? struct mtd_partition *parts;
>> + ? ? ? ? ? ? ? int nr_parts;
>> +
>> + ? ? ? ? ? ? ? nr_parts = parse_mtd_partitions(info->mtd, probes, &parts, 0);
>> +
>> + ? ? ? ? ? ? ? if (nr_parts)
>> + ? ? ? ? ? ? ? ? ? ? ? return add_mtd_partitions(info->mtd, parts, nr_parts);
>> + ? ? ? }
>> +
>> + ? ? ? return add_mtd_partitions(info->mtd, pdata->parts, pdata->nr_parts);
>> +}
>> +
>> ?#ifdef CONFIG_PM
>> ?static int pxa3xx_nand_suspend(struct platform_device *pdev, pm_message_t state)
>> ?{
>> - ? ? ? struct mtd_info *mtd = (struct mtd_info *)platform_get_drvdata(pdev);
>> - ? ? ? struct pxa3xx_nand_info *info = mtd->priv;
>> + ? ? ? struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
>> + ? ? ? struct mtd_info *mtd = info->mtd;
>>
>> ? ? ? ?if (info->state != STATE_READY) {
>> ? ? ? ? ? ? ? ?dev_err(&pdev->dev, "driver busy, state = %d\n", info->state);
>> @@ -1240,8 +1252,8 @@ static int pxa3xx_nand_suspend(struct platform_device *pdev, pm_message_t state)
>>
>> ?static int pxa3xx_nand_resume(struct platform_device *pdev)
>> ?{
>> - ? ? ? struct mtd_info *mtd = (struct mtd_info *)platform_get_drvdata(pdev);
>> - ? ? ? struct pxa3xx_nand_info *info = mtd->priv;
>> + ? ? ? struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
>> + ? ? ? struct mtd_info *mtd = info->mtd;
>>
>> ? ? ? ?nand_writel(info, NDTR0CS0, info->ndtr0cs0);
>> ? ? ? ?nand_writel(info, NDTR1CS0, info->ndtr1cs0);
>> --
>> 1.7.0.4
>>
>>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
