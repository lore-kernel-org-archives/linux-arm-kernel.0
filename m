From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Thu, 16 Feb 2012 22:24:00 +0530
Subject: [PATCH v6] I2C: add CSR SiRFprimaII on-chip I2C controllers driver
In-Reply-To: <1328714915-12287-1-git-send-email-21cnbao@gmail.com>
References: <1328714915-12287-1-git-send-email-21cnbao@gmail.com>
Message-ID: <CAM=Q2ct7EHht06uCHVpR_HoO39WZjO2+N6DhxuMthRQRQBRnyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Feb 8, 2012 at 8:58 PM, Barry Song <21cnbao@gmail.com> wrote:
> From: Zhiwu Song <Zhiwu.Song@csr.com>
>
> SiRFprimaII is the latest generation application processor from CSR?s
> multi-function SoC product family.
> The SoC support codes are in arch/arm/mach-prima2 from Linux mainline
> 3.0.
> There are two I2C controllers on primaII, features include:
> * Two I2C controller modules are on chip
> * RISC I/O bus read write register
> * Up to 16 bytes data buffer for issuing commands and writing data
> ?at the same time
> * Up to 16 commands, and receiving read data 16 bytes at a time
> * Error INT report (ACK check)
> * No-ACK bus protocols (SCCB bus protocols)
>
> Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
> Signed-off-by: Xiangzhen Ye <Xiangzhen.Ye@csr.com>
> Signed-off-by: Yuping Luo <Yuping.Luo@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
> ?-v6:
> ?fix/cleanup lots of minor issues pointed out by wolfram;
> ?add OF property clock-frequency to support freq setting by DT;
> ?add lost devicetree binding document;
>
> ?Documentation/devicetree/bindings/i2c/sirf-i2c.txt | ? 19 +
> ?drivers/i2c/busses/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? | ? 10 +
> ?drivers/i2c/busses/Makefile ? ? ? ? ? ? ? ? ? ? ? ?| ? ?1 +
> ?drivers/i2c/busses/i2c-sirf.c ? ? ? ? ? ? ? ? ? ? ?| ?459 ++++++++++++++++++++
> ?4 files changed, 489 insertions(+), 0 deletions(-)
> ?create mode 100644 Documentation/devicetree/bindings/i2c/sirf-i2c.txt
> ?create mode 100644 drivers/i2c/busses/i2c-sirf.c
>
> diff --git a/Documentation/devicetree/bindings/i2c/sirf-i2c.txt b/Documentation/devicetree/bindings/i2c/sirf-i2c.txt
> new file mode 100644
> index 0000000..7baf9e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/sirf-i2c.txt
<snip>

> +
> + ? ? ? ? ? ? ? if (i2c_stat & SIRFSOC_I2C_STAT_NACK)
> + ? ? ? ? ? ? ? ? ? ? ? dev_err(&siic->adapter.dev, "ACK not received\n");
Could we send stop here?
> + ? ? ? ? ? ? ? else
> + ? ? ? ? ? ? ? ? ? ? ? dev_err(&siic->adapter.dev, "I2C error\n");
> +
> + ? ? ? ? ? ? ? complete(&siic->done);
<Snip>

> +static int i2c_sirfsoc_resume(struct device *dev)
> +{
> + ? ? ? struct platform_device *pdev = to_platform_device(dev);
> + ? ? ? struct i2c_adapter *adapter = platform_get_drvdata(pdev);
> + ? ? ? struct sirfsoc_i2c *siic = adapter->algo_data;
> +
> + ? ? ? clk_enable(siic->clk);
> + ? ? ? writel(SIRFSOC_I2C_RESET, siic->base + SIRFSOC_I2C_CTRL);
Could you explain why is a reset needed.
Or am I missing something.

> + ? ? ? writel(SIRFSOC_I2C_CORE_EN | SIRFSOC_I2C_MASTER_MODE,
> + ? ? ? ? ? ? ? siic->base + SIRFSOC_I2C_CTRL);
> + ? ? ? writel(siic->clk_div, siic->base + SIRFSOC_I2C_CLK_CTRL);
> + ? ? ? writel(siic->sda_delay, siic->base + SIRFSOC_I2C_SDA_DELAY);
> + ? ? ? clk_disable(siic->clk);
> + ? ? ? return 0;
> +}
> +
> +static const struct dev_pm_ops i2c_sirfsoc_pm_ops = {
> + ? ? ? .suspend = i2c_sirfsoc_suspend,
> + ? ? ? .resume = i2c_sirfsoc_resume,
Could we use simple dev_pm ops here?

> +};
> +#endif
> +
> +static const struct of_device_id sirfsoc_i2c_of_match[] __devinitconst = {
> + ? ? ? { .compatible = "sirf,prima2-i2c", },
