From: mcuos.com@gmail.com (Wan ZongShun)
Date: Fri, 20 Nov 2009 17:49:06 +0800
Subject: [PATCH v2]: NUC900: Add spi driver support for nuc900
In-Reply-To: <8fb2581d0911200018v53bad77aob74d0c33a7c14716@mail.gmail.com>
References: <4B062887.90803@gmail.com>
	<8fb2581d0911200018v53bad77aob74d0c33a7c14716@mail.gmail.com>
Message-ID: <e68bb3470911200149m2f16a529o4701c77d3550abfc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi LI jie,

2009/11/20 Li Jie <eltshanli@gmail.com>:
> On Fri, Nov 20, 2009 at 1:26 PM, Wan ZongShun <mcuos.com@gmail.com> wrote:
>> Dear sirs,
>> + ? ? ? err = request_irq(hw->irq, w90p910_spi_irq, 0, pdev->name, hw);
>> + ? ? ? if (err) {
>> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "Cannot claim IRQ\n");
>> + ? ? ? ? ? ? ? goto err_irq;
>> + ? ? ? }
>> +
>> + ? ? ? hw->clk = clk_get(&pdev->dev, "spi");
>> + ? ? ? if (IS_ERR(hw->clk)) {
>> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "No clock for device\n");
>> + ? ? ? ? ? ? ? err = PTR_ERR(hw->clk);
>> + ? ? ? ? ? ? ? goto err_clk;
>> + ? ? ? }
>> +
>> + ? ? ? mfp_set_groupg(&pdev->dev);
>> + ? ? ? w90p910_init_spi(hw);
>> +
>> + ? ? ? err = spi_bitbang_start(&hw->bitbang);
>> + ? ? ? if (err) {
>> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "Failed to register SPI master\n");
>> + ? ? ? ? ? ? ? goto err_register;
>> + ? ? ? }
>> +
>> + ? ? ? return 0;
>> +
>> +err_register:
>> + ? ? ? clk_disable(hw->clk);
>> + ? ? ? clk_put(hw->clk);
>> +err_clk:
>> + ? ? ? free_irq(hw->irq, hw);
>> +err_irq:
>> + ? ? ? iounmap(hw->regs);
>> +err_iomap:
>> + ? ? ? release_resource(hw->ioarea);
>> + ? ? ? kfree(hw->ioarea);
>
> I think release_mem_region() is better than release_resource() after
> request_mem_region().
> After all, they are a couple :)
>

Thank you,
That sounds not bad. :)

>> +err_pdata:
>> + ? ? ? spi_master_put(hw->master);;
>> +
>> +err_nomem:
>> + ? ? ? return err;
>> +}
>> +
>



-- 
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
