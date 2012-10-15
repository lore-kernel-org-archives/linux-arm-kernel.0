From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 15 Oct 2012 09:59:08 +0200
Subject: [PATCH 1/1] MTD: atmel_nand: use devm_xxx gpio kzalloc, gpio
 and ioremap
In-Reply-To: <1350129982-12106-1-git-send-email-plagnioj@jcrosoft.com>
References: <1350129982-12106-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <507BC24C.9090006@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/13/2012 02:06 PM, Jean-Christophe PLAGNIOL-VILLARD :
> this will allow to simply the error and remove path
> 
> Cc: linux-mtd at lists.infradead.org
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Please also add Josh to the Cc list: he has made a great effort
supporting this driver and I guess that he is interested by this rework...

> ---
>  drivers/mtd/nand/atmel_nand.c |  163 ++++++++++++++---------------------------
>  1 file changed, 54 insertions(+), 109 deletions(-)
> 
> diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
> index 92623ac..2b43656 100644
> --- a/drivers/mtd/nand/atmel_nand.c
> +++ b/drivers/mtd/nand/atmel_nand.c
> @@ -364,43 +364,33 @@ static void __devinit __iomem *pmecc_get_alpha_to(struct atmel_nand_host *host)
>  			table_size * sizeof(int16_t);
>  }
>  
> -static void pmecc_data_free(struct atmel_nand_host *host)
> -{
> -	kfree(host->pmecc_partial_syn);
> -	kfree(host->pmecc_si);
> -	kfree(host->pmecc_lmu);
> -	kfree(host->pmecc_smu);
> -	kfree(host->pmecc_mu);
> -	kfree(host->pmecc_dmu);
> -	kfree(host->pmecc_delta);
> -}
> -
>  static int __devinit pmecc_data_alloc(struct atmel_nand_host *host)
>  {
>  	const int cap = host->pmecc_corr_cap;
> +	int size;
> +
> +	size = (2 * cap + 1) * sizeof(int16_t);
> +	host->pmecc_partial_syn = devm_kzalloc(host->dev, size, GFP_KERNEL);
> +	host->pmecc_si = devm_kzalloc(host->dev, size, GFP_KERNEL);
> +	host->pmecc_lmu = devm_kzalloc(host->dev,
> +			(cap + 1) * sizeof(int16_t), GFP_KERNEL);
> +	host->pmecc_smu = devm_kzalloc(host->dev,
> +			(cap + 2) * (2 * cap + 1) * sizeof(int16_t), GFP_KERNEL);
> +	size = (cap + 1) * sizeof(int);
> +	host->pmecc_mu = devm_kzalloc(host->dev, size, GFP_KERNEL);
> +	host->pmecc_dmu = devm_kzalloc(host->dev, size, GFP_KERNEL);
> +	host->pmecc_delta = devm_kzalloc(host->dev, size, GFP_KERNEL);
> +
> +	if (!host->pmecc_partial_syn ||
> +		!host->pmecc_si ||
> +		!host->pmecc_lmu ||
> +		!host->pmecc_smu ||
> +		!host->pmecc_mu ||
> +		!host->pmecc_dmu ||
> +		!host->pmecc_delta)
> +		return -ENOMEM;
>  
> -	host->pmecc_partial_syn = kzalloc((2 * cap + 1) * sizeof(int16_t),
> -					GFP_KERNEL);
> -	host->pmecc_si = kzalloc((2 * cap + 1) * sizeof(int16_t), GFP_KERNEL);
> -	host->pmecc_lmu = kzalloc((cap + 1) * sizeof(int16_t), GFP_KERNEL);
> -	host->pmecc_smu = kzalloc((cap + 2) * (2 * cap + 1) * sizeof(int16_t),
> -					GFP_KERNEL);
> -	host->pmecc_mu = kzalloc((cap + 1) * sizeof(int), GFP_KERNEL);
> -	host->pmecc_dmu = kzalloc((cap + 1) * sizeof(int), GFP_KERNEL);
> -	host->pmecc_delta = kzalloc((cap + 1) * sizeof(int), GFP_KERNEL);
> -
> -	if (host->pmecc_partial_syn &&
> -			host->pmecc_si &&
> -			host->pmecc_lmu &&
> -			host->pmecc_smu &&
> -			host->pmecc_mu &&
> -			host->pmecc_dmu &&
> -			host->pmecc_delta)
> -		return 0;
> -
> -	/* error happened */
> -	pmecc_data_free(host);
> -	return -ENOMEM;
> +	return 0;
>  }
>  
>  static void pmecc_gen_syndrome(struct mtd_info *mtd, int sector)
> @@ -923,27 +913,25 @@ static int __init atmel_pmecc_nand_init_params(struct platform_device *pdev,
>  		return 0;
>  	}
>  
> -	host->ecc = ioremap(regs->start, resource_size(regs));
> +	host->ecc = devm_request_and_ioremap(&pdev->dev, regs);
>  	if (host->ecc == NULL) {
>  		dev_err(host->dev, "ioremap failed\n");
>  		err_no = -EIO;
> -		goto err_pmecc_ioremap;
> +		goto err;
>  	}
>  
>  	regs_pmerr = platform_get_resource(pdev, IORESOURCE_MEM, 2);
>  	regs_rom = platform_get_resource(pdev, IORESOURCE_MEM, 3);
>  	if (regs_pmerr && regs_rom) {
> -		host->pmerrloc_base = ioremap(regs_pmerr->start,
> -			resource_size(regs_pmerr));
> -		host->pmecc_rom_base = ioremap(regs_rom->start,
> -			resource_size(regs_rom));
> +		host->pmerrloc_base = devm_request_and_ioremap(&pdev->dev, regs_pmerr);
> +		host->pmecc_rom_base = devm_request_and_ioremap(&pdev->dev, regs_rom);
>  	}
>  
>  	if (!host->pmerrloc_base || !host->pmecc_rom_base) {
>  		dev_err(host->dev,
>  			"Can not get I/O resource for PMECC ERRLOC controller or ROM!\n");
>  		err_no = -EIO;
> -		goto err_pmloc_ioremap;
> +		goto err;
>  	}
>  
>  	/* ECC is calculated for the whole page (1 step) */
> @@ -968,7 +956,7 @@ static int __init atmel_pmecc_nand_init_params(struct platform_device *pdev,
>  		if (nand_chip->ecc.bytes > mtd->oobsize - 2) {
>  			dev_err(host->dev, "No room for ECC bytes\n");
>  			err_no = -EINVAL;
> -			goto err_no_ecc_room;
> +			goto err;
>  		}
>  		pmecc_config_ecc_layout(&atmel_pmecc_oobinfo,
>  					mtd->oobsize,
> @@ -993,7 +981,7 @@ static int __init atmel_pmecc_nand_init_params(struct platform_device *pdev,
>  	if (err_no) {
>  		dev_err(host->dev,
>  				"Cannot allocate memory for PMECC computation!\n");
> -		goto err_pmecc_data_alloc;
> +		goto err;
>  	}
>  
>  	nand_chip->ecc.read_page = atmel_nand_pmecc_read_page;
> @@ -1003,15 +991,7 @@ static int __init atmel_pmecc_nand_init_params(struct platform_device *pdev,
>  
>  	return 0;
>  
> -err_pmecc_data_alloc:
> -err_no_ecc_room:
> -err_pmloc_ioremap:
> -	iounmap(host->ecc);
> -	if (host->pmerrloc_base)
> -		iounmap(host->pmerrloc_base);
> -	if (host->pmecc_rom_base)
> -		iounmap(host->pmecc_rom_base);
> -err_pmecc_ioremap:
> +err:
>  	return err_no;
>  }
>  
> @@ -1315,7 +1295,7 @@ static int __init atmel_hw_nand_init_params(struct platform_device *pdev,
>  		return 0;
>  	}
>  
> -	host->ecc = ioremap(regs->start, resource_size(regs));
> +	host->ecc = devm_request_and_ioremap(&pdev->dev, regs);
>  	if (host->ecc == NULL) {
>  		dev_err(host->dev, "ioremap failed\n");
>  		return -EIO;
> @@ -1380,20 +1360,19 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Allocate memory for the device structure (and zero it) */
> -	host = kzalloc(sizeof(struct atmel_nand_host), GFP_KERNEL);
> +	host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
>  	if (!host) {
>  		printk(KERN_ERR "atmel_nand: failed to allocate device structure.\n");
>  		return -ENOMEM;
>  	}
>  
> -	host->io_phys = (dma_addr_t)mem->start;
> -
> -	host->io_base = ioremap(mem->start, resource_size(mem));
> +	host->io_base = devm_request_and_ioremap(&pdev->dev, mem);
>  	if (host->io_base == NULL) {
>  		printk(KERN_ERR "atmel_nand: ioremap failed\n");
>  		res = -EIO;
>  		goto err_nand_ioremap;
>  	}
> +	host->io_phys = (dma_addr_t)mem->start;
>  
>  	mtd = &host->mtd;
>  	nand_chip = &host->nand_chip;
> @@ -1401,7 +1380,7 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
>  	if (pdev->dev.of_node) {
>  		res = atmel_of_init_port(host, pdev->dev.of_node);
>  		if (res)
> -			goto err_ecc_ioremap;
> +			goto err_nand_ioremap;
>  	} else {
>  		memcpy(&host->board, pdev->dev.platform_data,
>  		       sizeof(struct atmel_nand_data));
> @@ -1420,44 +1399,42 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
>  	if (IS_ERR(pinctrl)) {
>  		dev_err(host->dev, "Failed to request pinctrl\n");
>  		res = PTR_ERR(pinctrl);
> -		goto err_ecc_ioremap;
> +		goto err_nand_ioremap;
>  	}
>  
>  	if (gpio_is_valid(host->board.rdy_pin)) {
> -		res = gpio_request(host->board.rdy_pin, "nand_rdy");
> +		res = devm_gpio_request(&pdev->dev,
> +				host->board.rdy_pin, "nand_rdy");
>  		if (res < 0) {
>  			dev_err(&pdev->dev,
> -				"can't request rdy gpio %d\n",
> -				host->board.rdy_pin);
> -			goto err_ecc_ioremap;
> +				"can't request rdy gpio %d\n", host->board.rdy_pin);
> +			goto err_nand_ioremap;
>  		}
>  
>  		res = gpio_direction_input(host->board.rdy_pin);
>  		if (res < 0) {
>  			dev_err(&pdev->dev,
> -				"can't request input direction rdy gpio %d\n",
> -				host->board.rdy_pin);
> -			goto err_ecc_ioremap;
> +				"can't request input direction rdy gpio %d\n", host->board.rdy_pin);

Why do you modify the log message presentation: it was okay before?
Moreover, it is not related to the topic of the patch...


> +			goto err_nand_ioremap;
>  		}
>  
>  		nand_chip->dev_ready = atmel_nand_device_ready;
>  	}
>  
>  	if (gpio_is_valid(host->board.enable_pin)) {
> -		res = gpio_request(host->board.enable_pin, "nand_enable");
> +		res = devm_gpio_request(&pdev->dev,
> +				host->board.enable_pin, "nand_enable");
>  		if (res < 0) {
>  			dev_err(&pdev->dev,
> -				"can't request enable gpio %d\n",
> -				host->board.enable_pin);
> -			goto err_ecc_ioremap;
> +				"can't request enable gpio %d\n", host->board.enable_pin);

Ditto.

> +			goto err_nand_ioremap;
>  		}
>  
>  		res = gpio_direction_output(host->board.enable_pin, 1);
>  		if (res < 0) {
>  			dev_err(&pdev->dev,
> -				"can't request output direction enable gpio %d\n",
> -				host->board.enable_pin);
> -			goto err_ecc_ioremap;
> +				"can't request output direction enable gpio %d\n", host->board.enable_pin);

Ditto.

> +			goto err_nand_ioremap;
>  		}
>  	}
>  
> @@ -1474,19 +1451,18 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
>  	atmel_nand_enable(host);
>  
>  	if (gpio_is_valid(host->board.det_pin)) {
> -		res = gpio_request(host->board.det_pin, "nand_det");
> +		res = devm_gpio_request(&pdev->dev,
> +				host->board.det_pin, "nand_det");
>  		if (res < 0) {
>  			dev_err(&pdev->dev,
> -				"can't request det gpio %d\n",
> -				host->board.det_pin);
> +				"can't request det gpio %d\n", host->board.det_pin);

Ditto.

>  			goto err_no_card;
>  		}
>  
>  		res = gpio_direction_input(host->board.det_pin);
>  		if (res < 0) {
>  			dev_err(&pdev->dev,
> -				"can't request input direction det gpio %d\n",
> -				host->board.det_pin);
> +				"can't request input direction det gpio %d\n", host->board.det_pin);

Ditto.

>  			goto err_no_card;
>  		}
>  
> @@ -1552,16 +1528,8 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
>  		return res;
>  
>  err_scan_tail:
> -	if (host->has_pmecc && host->nand_chip.ecc.mode == NAND_ECC_HW) {
> +	if (host->has_pmecc && host->nand_chip.ecc.mode == NAND_ECC_HW)
>  		pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
> -		pmecc_data_free(host);
> -	}
> -	if (host->ecc)
> -		iounmap(host->ecc);
> -	if (host->pmerrloc_base)
> -		iounmap(host->pmerrloc_base);
> -	if (host->pmecc_rom_base)
> -		iounmap(host->pmecc_rom_base);
>  err_hw_ecc:
>  err_scan_ident:
>  err_no_card:
> @@ -1569,10 +1537,7 @@ err_no_card:
>  	platform_set_drvdata(pdev, NULL);
>  	if (host->dma_chan)
>  		dma_release_channel(host->dma_chan);
> -err_ecc_ioremap:
> -	iounmap(host->io_base);
>  err_nand_ioremap:
> -	kfree(host);
>  	return res;
>  }
>  
> @@ -1592,31 +1557,11 @@ static int __exit atmel_nand_remove(struct platform_device *pdev)
>  		pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
>  		pmerrloc_writel(host->pmerrloc_base, ELDIS,
>  				PMERRLOC_DISABLE);
> -		pmecc_data_free(host);
>  	}
>  
> -	if (gpio_is_valid(host->board.det_pin))
> -		gpio_free(host->board.det_pin);
> -
> -	if (gpio_is_valid(host->board.enable_pin))
> -		gpio_free(host->board.enable_pin);
> -
> -	if (gpio_is_valid(host->board.rdy_pin))
> -		gpio_free(host->board.rdy_pin);
> -
> -	if (host->ecc)
> -		iounmap(host->ecc);
> -	if (host->pmecc_rom_base)
> -		iounmap(host->pmecc_rom_base);
> -	if (host->pmerrloc_base)
> -		iounmap(host->pmerrloc_base);
> -
>  	if (host->dma_chan)
>  		dma_release_channel(host->dma_chan);
>  
> -	iounmap(host->io_base);
> -	kfree(host);
> -
>  	return 0;
>  }

Otherwise, looks good.

Bye,
-- 
Nicolas Ferre
