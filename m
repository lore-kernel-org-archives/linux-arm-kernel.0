From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Thu, 6 Oct 2016 19:48:42 -0700
Subject: [PATCH 1/3] fpga manager: Add cyclonespi driver for Altera fpgas
In-Reply-To: <4b4432c04b4ea92a2af814e3d7866c33f2eb12ea.1475783742.git.stillcompiling@gmail.com>
References: <cover.1475783742.git.stillcompiling@gmail.com>
 <4b4432c04b4ea92a2af814e3d7866c33f2eb12ea.1475783742.git.stillcompiling@gmail.com>
Message-ID: <CAAtXAHcWLpn3DFP6YLWqBxsMQ0O=HNNCmB+kHbHhyAHFHQUbwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joshua,

couple of nits inline below:

On Thu, Oct 6, 2016 at 1:34 PM, Joshua Clayton <stillcompiling@gmail.com> wrote:

> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index cd84934..ccad5b1 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -13,6 +13,12 @@ config FPGA
>
>  if FPGA
>
> +config FPGA_MGR_CYCLONE_SPI
> +       tristate "Altera Cyclone V SPI"
> +       depends on SPI
> +       help
> +         FPGA manager driver support for Altera Cyclone V over SPI
> +
>  config FPGA_MGR_SOCFPGA
>         tristate "Altera SOCFPGA FPGA Manager"
>         depends on ARCH_SOCFPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 8d83fc6..c03f40de 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -6,5 +6,6 @@
>  obj-$(CONFIG_FPGA)                     += fpga-mgr.o
>
>  # FPGA Manager Drivers
> +obj-$(CONFIG_FPGA_MGR_CYCLONE_SPI)     += cyclonespi.o
>  obj-$(CONFIG_FPGA_MGR_SOCFPGA)         += socfpga.o
>  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)       += zynq-fpga.o
> diff --git a/drivers/fpga/cyclonespi.c b/drivers/fpga/cyclonespi.c
> new file mode 100644
> index 0000000..1ffa67c
> --- /dev/null
> +++ b/drivers/fpga/cyclonespi.c
> @@ -0,0 +1,173 @@
> +/**
> + * Copyright (c) 2015 United Western Technologies, Corporation
> + *
> + * Joshua Clayton <stillcompiling@gmail.com>
> + *
> + * Manage Altera fpga firmware that is loaded over spi.
> + * Firmware must be in binary "rbf" format.
> + * Works on Cyclone V. Should work on cyclone series.
> + * May work on other Altera fpgas.

I think at one point we decided it's gonna be 'FPGA' to be consistent.

> +
> +static const struct of_device_id of_ef_match[] = {
> +       { .compatible = "altr,cyclonespi-fpga-mgr", },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, of_ef_match);
> +
> +static enum fpga_mgr_states cyclonespi_state(struct fpga_manager *mgr)
> +{
> +       return mgr->state;
> +}
> +
> +static inline u32 revbit8x4(u32 n)
> +{
> +       n = ((n & 0xF0F0F0F0UL) >> 4) | ((n & 0x0F0F0F0FUL) << 4);
> +       n = ((n & 0xCCCCCCCCUL) >> 2) | ((n & 0x33333333UL) << 2);
> +       n = ((n & 0xAAAAAAAAUL) >> 1) | ((n & 0x55555555UL) << 1);
> +       return n;
> +}

During the Zynq FPGA manager reviews we decided that manipulating the bitstream
to be consumable by the driver is userland's job.

> +
> +static int cyclonespi_write_init(struct fpga_manager *mgr, u32 flags,
> +                               const char *buf, size_t count)
> +{
> +       struct cyclonespi_conf *conf = (struct cyclonespi_conf *)mgr->priv;
> +       u32 *fw32 = (u32 *)buf;
> +       const u32 *fw_end = (u32 *)(buf + count);
> +
> +       if (flags & FPGA_MGR_PARTIAL_RECONFIG) {
> +               dev_err(&mgr->dev, "Partial reconfiguration not supported.\n");
> +               return -EINVAL;

-ENOTSUPP?
> +       }
> +
> +       gpiod_set_value(conf->reset, 0);
> +       udelay(50);

Should that value either be configurable, or a named constant?
> +       msleep(1);

See above.

> +       /* set buffer to lsb first */
> +       while (fw32 < fw_end) {
> +               *fw32 = revbit8x4(*fw32);
> +               fw32++;
> +       }

See above.
> +
> +       return 0;
> +}
> +
> +static int cyclonespi_write(struct fpga_manager *mgr, const char *buf,
> +                          size_t count)
> +{
> +       struct cyclonespi_conf *conf = (struct cyclonespi_conf *)mgr->priv;
> +       const char *fw_data = buf;
> +       const char *fw_data_end = fw_data + count;
> +
> +       while (fw_data < fw_data_end) {
> +               int ret;
> +               int stride = fw_data_end - fw_data;
> +
> +               if (stride > SZ_4K)
> +                       stride = SZ_4K;
> +
> +               ret = spi_write(conf->spi, fw_data, stride);
> +               if (ret) {
> +                       dev_err(&mgr->dev, "spi error in firmware write: %d\n",
> +                                       ret);
> +                       return ret;
> +               }
> +               fw_data += stride;
> +       }
> +
> +       return 0;
> +}
> +
> +static int cyclonespi_write_complete(struct fpga_manager *mgr, u32 flags)
> +{
> +       struct cyclonespi_conf *conf = (struct cyclonespi_conf *)mgr->priv;
> +
> +       if (gpiod_get_value(conf->status) == 0) {
> +               dev_err(&mgr->dev, "Error during configuration.\n");
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct fpga_manager_ops cyclonespi_ops = {
> +       .state = cyclonespi_state,
> +       .write_init = cyclonespi_write_init,
> +       .write = cyclonespi_write,
> +       .write_complete = cyclonespi_write_complete,
> +};
> +
> +static int cyclonespi_probe(struct spi_device *spi)
> +{
> +       struct cyclonespi_conf *conf = devm_kzalloc(&spi->dev, sizeof(*conf),
> +                                               GFP_KERNEL);
> +
> +       if (!conf)
> +               return -ENOMEM;
> +
> +       conf->spi = spi;
> +       conf->reset = devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_LOW);
> +       if (IS_ERR(conf->reset)) {
> +               dev_err(&spi->dev, "Failed to get reset gpio: %ld\n",
> +                       PTR_ERR(conf->reset));
> +               return PTR_ERR(conf->reset);
> +       }
> +
> +       conf->status = devm_gpiod_get(&spi->dev, "status", GPIOD_IN);
> +       if (IS_ERR(conf->status)) {
> +               dev_err(&spi->dev, "Failed to get status gpio: %ld\n",
> +                               PTR_ERR(conf->status));
> +               return PTR_ERR(conf->status);
> +       }
> +
> +       return fpga_mgr_register(&spi->dev, "Altera SPI FPGA Manager",
> +                                &cyclonespi_ops, conf);

Nit: Altera >Cyclone< SPI FPGA Manager

Thanks ... reminds me I wanted to submit my patch for the icoboard ;-)

Moritz
