From: mcuos.com@gmail.com (Wan ZongShun)
Date: Sun, 22 Nov 2009 01:38:55 +0800
Subject: [PATCH v2]: NUC900: Add spi driver support for nuc900
In-Reply-To: <8fb2581d0911210610j125b5700ydeb25e72efa88eac@mail.gmail.com>
References: <4B062887.90803@gmail.com>
	<8fb2581d0911210610j125b5700ydeb25e72efa88eac@mail.gmail.com>
Message-ID: <e68bb3470911210938v2a91b39ax1f1073edab150c11@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Li Jie,


2009/11/21 Li Jie <eltshanli@gmail.com>:
> On Fri, Nov 20, 2009 at 1:26 PM, Wan ZongShun <mcuos.com@gmail.com> wrote:
>>
>> +static void w90p910_init_spi(struct w90p910_spi *hw)
>> +{
>> + ? ? ? clk_enable(hw->clk);
>> + ? ? ? spin_lock_init(&hw->lock);
>> +
>> + ? ? ? w90p910_tx_edge(hw, hw->pdata->txneg);
>> + ? ? ? w90p910_rx_edge(hw, hw->pdata->rxneg);
>> + ? ? ? w90p910_send_first(hw, hw->pdata->lsb);
>> + ? ? ? w90p910_set_sleep(hw, hw->pdata->sleep);
>> + ? ? ? w90p910_spi_setup_txbitlen(hw, hw->pdata->txbitlen);
>> + ? ? ? w90p910_spi_setup_txnum(hw, hw->pdata->txnum);
>> + ? ? ? w90p910_set_divider(hw);
>> + ? ? ? w90p910_enable_int(hw, 1);
>> +}
>> +
>> +static int __devinit w90p910_spi_probe(struct platform_device *pdev)
>> +{
>> + ? ? ? struct w90p910_spi *hw;
>> + ? ? ? struct spi_master *master;
>> + ? ? ? struct resource *res;
>> + ? ? ? int err = 0;
>> +
>> + ? ? ? master = spi_alloc_master(&pdev->dev, sizeof(struct w90p910_spi));
>> + ? ? ? if (master == NULL) {
>> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "No memory for spi_master\n");
>> + ? ? ? ? ? ? ? err = -ENOMEM;
>> + ? ? ? ? ? ? ? goto err_nomem;
>> + ? ? ? }
>> +
>> + ? ? ? hw = spi_master_get_devdata(master);
>> + ? ? ? memset(hw, 0, sizeof(struct w90p910_spi));
>> +
>> + ? ? ? hw->master = spi_master_get(master);
>> + ? ? ? hw->pdata ?= pdev->dev.platform_data;
>
> Seems that platform_data is necessary in your driver,
> but I found it is not initialized in mach-w90x900/dev.c:
>
> static struct platform_device nuc900_device_spi = {
> ? ? ? ?.name ? ? ? ? ? = "nuc900-spi",
> ? ? ? ?.id ? ? ? ? ? ? = -1,
> ? ? ? ?.num_resources ?= ARRAY_SIZE(nuc900_spi_resource),
> ? ? ? ?.resource ? ? ? = nuc900_spi_resource,
> };
>

Yes , you are right, I tested the spi driver via 'm25p80', so I must
add some its definition  to my dev.c and use 'spi_register_board_info'
to register this type flash info.

So, I just want to add the platform_data definition patch along with
above and I think I will submit it later.

Anyway, thanks a lot for your careful reviewing my patch.

> --
> Regards
> Li Jie
>



-- 
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
