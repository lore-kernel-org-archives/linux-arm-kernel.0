From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 2 Oct 2017 16:28:38 +0100
Subject: [PATCH 3/4] nvmem: add a driver for the Amlogic
 Meson6/Meson8/Meson8b SoCs
In-Reply-To: <20171001125700.1520-4-martin.blumenstingl@googlemail.com>
References: <20171001125700.1520-1-martin.blumenstingl@googlemail.com>
 <20171001125700.1520-4-martin.blumenstingl@googlemail.com>
Message-ID: <8f1f5a45-951c-7434-44d5-4ef2a61ec038@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Minor comments!!

On 01/10/17 13:56, Martin Blumenstingl wrote:
> This adds a driver to access the efuse on Amlogic Meson6, Meson8 and
> Meson8b SoCs.
> These SoCs are accessing the efuse IP block directly through the
> registers in the "secbus" region. This makes it different from the Meson
> GX efuse driver which uses the "secure monitor" firmware to access the
> efuse.
> 
> The efuse on Meson6 can only read one byte at a time, while the efuse on
> Meson8 and Meson8b always reads 4 bytes at a time. The new driver
> supports both, but due to lack of hardware Meson6 support was not tested.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>   drivers/nvmem/Kconfig          |  10 ++
>   drivers/nvmem/Makefile         |   2 +
>   drivers/nvmem/meson-mx-efuse.c | 272 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 284 insertions(+)
>   create mode 100644 drivers/nvmem/meson-mx-efuse.c
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> +	
> +
> +static void meson_mx_efuse_mask_bits(struct meson_mx_efuse *efuse, u32 reg,
> +				     u32 mask, u32 set)
> +{
> +	u32 data;
> +
> +	data = readl(efuse->base + reg);
> +	data &= ~mask;
> +	data |= (set & mask);
> +
> +	writel(data, efuse->base + reg);
> +}
> +
> +static int meson_mx_efuse_hw_enable(struct meson_mx_efuse *efuse)
> +{
> +	int err;
> +
> +	err = clk_prepare_enable(efuse->core_clk);
> +	if (err)
> +		return err;
> +
> +	/* power up the efuse */
> +	meson_mx_efuse_mask_bits(efuse, MESON_MX_EFUSE_CNTL1,
> +				 MESON_MX_EFUSE_CNTL1_PD_ENABLE, 0);
> +
> +	meson_mx_efuse_mask_bits(efuse, MESON_MX_EFUSE_CNTL4,
> +				 MESON_MX_EFUSE_CNTL4_ENCRYPT_ENABLE, 0);
> +
> +	return 0;
> +}
> +
> +static void meson_mx_efuse_hw_disable(struct meson_mx_efuse *efuse)
> +{
> +	meson_mx_efuse_mask_bits(efuse, MESON_MX_EFUSE_CNTL1,
> +				 MESON_MX_EFUSE_CNTL1_PD_ENABLE,
> +				 MESON_MX_EFUSE_CNTL1_PD_ENABLE);
> +
> +	clk_disable_unprepare(efuse->core_clk);
> +}
> +
> +static int meson_mx_efuse_read_addr(struct meson_mx_efuse *efuse,
> +				    unsigned int addr, u32 *value)
> +{
> +	int err;
> +	u32 regval;
> +
> +	/* write the address to read */
> +	regval = FIELD_PREP(MESON_MX_EFUSE_CNTL1_BYTE_ADDR_MASK, addr);
> +	meson_mx_efuse_mask_bits(efuse, MESON_MX_EFUSE_CNTL1,
> +				 MESON_MX_EFUSE_CNTL1_BYTE_ADDR_MASK, regval);
> +
> +	/* inform the hardware that we changed the address */
> +	meson_mx_efuse_mask_bits(efuse, MESON_MX_EFUSE_CNTL1,
> +				 MESON_MX_EFUSE_CNTL1_BYTE_ADDR_SET,
> +				 MESON_MX_EFUSE_CNTL1_BYTE_ADDR_SET);
> +	meson_mx_efuse_mask_bits(efuse, MESON_MX_EFUSE_CNTL1,
> +				 MESON_MX_EFUSE_CNTL1_BYTE_ADDR_SET, 0);
> +
> +	/* start the read process */
> +	meson_mx_efuse_mask_bits(efuse, MESON_MX_EFUSE_CNTL1,
> +				 MESON_MX_EFUSE_CNTL1_AUTO_RD_START,
> +				 MESON_MX_EFUSE_CNTL1_AUTO_RD_START);
> +	meson_mx_efuse_mask_bits(efuse, MESON_MX_EFUSE_CNTL1,
> +				 MESON_MX_EFUSE_CNTL1_AUTO_RD_START, 0);
> +
> +	/*
> +	 * perform a dummy read to ensure that the HW has the RD_BUSY bit set
> +	 * when polling for the status below.
> +	 */
> +	readl(efuse->base + MESON_MX_EFUSE_CNTL1);
> +
> +	err = readl_poll_timeout_atomic(efuse->base + MESON_MX_EFUSE_CNTL1,
> +			regval,
> +			(!(regval & MESON_MX_EFUSE_CNTL1_AUTO_RD_BUSY)),
> +			1, 1000);
> +	if (err) {
> +		dev_err(efuse->config.dev,
> +			"Timeout while reading efuse address %u\n", addr);
> +		return err;
> +	}
> +
> +	*value = readl(efuse->base + MESON_MX_EFUSE_CNTL2);
> +
> +	return 0;
> +}
> +
> +static int meson_mx_efuse_read(void *context, unsigned int offset,
> +			       void *buf, size_t bytes)
> +{
> +	struct meson_mx_efuse *efuse = context;
> +	u32 tmp;
> +	int err, i, addr;
> +
> +	err = meson_mx_efuse_hw_enable(efuse);
> +	if (err)
> +		return err;
> +
> +	meson_mx_efuse_mask_bits(efuse, MESON_MX_EFUSE_CNTL1,
> +				 MESON_MX_EFUSE_CNTL1_AUTO_RD_ENABLE,
> +				 MESON_MX_EFUSE_CNTL1_AUTO_RD_ENABLE);
> +
> +	for (i = offset; i < offset + bytes; i += efuse->config.word_size) {
> +		addr = i / efuse->config.word_size;
> +
> +		err = meson_mx_efuse_read_addr(efuse, addr, &tmp);
> +		if (err)
> +			break;
> +
> +		memcpy(buf + i, &tmp, efuse->config.word_size);
> +	}
> +
> +	meson_mx_efuse_mask_bits(efuse, MESON_MX_EFUSE_CNTL1,
> +				 MESON_MX_EFUSE_CNTL1_AUTO_RD_ENABLE, 0);
> +
> +	meson_mx_efuse_hw_disable(efuse);
> +
> +	return err;
> +}
...
> +
> +static int meson_mx_efuse_probe(struct platform_device *pdev)
> +{
> +	const struct meson_mx_efuse_platform_data *drvdata;
> +	struct meson_mx_efuse *efuse;
> +	struct resource *res;
> +

...

> +
> +	efuse->core_clk = devm_clk_get(&pdev->dev, "core");
> +	if (IS_ERR(efuse->core_clk)) {
> +		dev_err(&pdev->dev, "Failed to get core clock\n");
> +		return PTR_ERR(efuse->core_clk);
> +	}
> +
> +	efuse->nvmem = nvmem_register(&efuse->config);
> +	if (IS_ERR(efuse->nvmem)) {
> +		clk_unprepare(efuse->core_clk);

Do you need this???

> +		return PTR_ERR(efuse->nvmem);
> +	}
> +
> +	platform_set_drvdata(pdev, efuse);
> +
> +	return 0;
> +}
> +
> +static int meson_mx_efuse_remove(struct platform_device *pdev)
> +{
> +	struct meson_mx_efuse *efuse = platform_get_drvdata(pdev);
> +	int err;
> +
> +	err = nvmem_unregister(efuse->nvmem);
> +
> +	clk_unprepare(efuse->core_clk);

Do you need this disable here? AFAIU, this driver would never leave the 
clk prepared unless we are in the middle of read.

> +
> +	return err;
> +}
> +
