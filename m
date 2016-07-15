From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Fri, 15 Jul 2016 09:56:59 +0800
Subject: [PATCH] spi: rockchip: limit transfers to (64K - 1) bytes
In-Reply-To: <1468546259-136659-1-git-send-email-briannorris@chromium.org>
References: <1468546259-136659-1-git-send-email-briannorris@chromium.org>
Message-ID: <131afa39-4287-0fb8-61f4-146283dc7cf0@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ huibing

? 2016/7/15 9:30, Brian Norris ??:
> The Rockchip SPI controller's length register only supports 16-bits,
> yielding a maximum length of 64KiB (the CTRLR1 register holds "length -
> 1"). Trying to transfer more than that (e.g., with a large SPI flash
> read) will cause the driver to hang.

Brian, are you using dma or pio?

 From huibing's feedback for rk3399, you can see...

root at rk3399:/ # echo read 0 1 0x10001 > /sys/slt/SPI.0/SPI.0 

[148360.004332] f0041200:       DMAMOV CCR 0x804200
[148360.004772] f0041206:       DMAMOV SAR 0xff1d0800
[148360.005161] f004120c:       DMAMOV DAR 0xc9f60000
[148360.005549] f0041212:       DMALP_0 255
[148360.005866] f0041214:       DMALP_1 255
[148360.006178] f0041216:       DMAWFPB 13
[148360.006483] f0041218:       DMALDPB 13
[148360.006788] f004121a:       DMASTA
[148360.007061] f004121b:       DMAFLUSHP 13
[148360.007380] f004121d:       DMALPENDA_1 bjmpto_7
[148360.007763] f004121f:       DMALPENDA_0 bjmpto_b
[148360.008144] f0041221:       DMAWFPB 13
[148360.008448] f0041223:       DMALDPB 13
[148360.008752] f0041225:       DMASTA
[148360.009026] f0041226:       DMAFLUSHP 13
[148360.009344] f0041228:       DMASEV 1
[148360.009633] f004122a:       DMAEND
[148360.147993] slt_spi_test spi32766.0: SPI transfer timed out
[148360.148653] spi read 65537*1 cost 144493us speed:453KB/S
root at rk3399:/ #
root at rk3399:/ # echo read 0 1 0x10000 > /sys/slt/SPI.0/SPI.0 

[148365.172429] f0041200:       DMAMOV CCR 0x804200
[148365.172863] f0041206:       DMAMOV SAR 0xff1d0800
[148365.173252] f004120c:       DMAMOV DAR 0xc9f90000
[148365.173641] f0041212:       DMALP_0 255
[148365.173958] f0041214:       DMALP_1 255
[148365.174270] f0041216:       DMAWFPB 13
[148365.174574] f0041218:       DMALDPB 13
[148365.174878] f004121a:       DMASTA
[148365.175152] f004121b:       DMAFLUSHP 13
[148365.175471] f004121d:       DMALPENDA_1 bjmpto_7
[148365.175852] f004121f:       DMALPENDA_0 bjmpto_b
[148365.176234] f0041221:       DMASEV 1
[148365.176522] f0041223:       DMAEND
[148365.207421] spi read 65536*1 cost 35144us speed:1864KB/S



>
> Now, it seems that while theoretically we should be able to program
> CTRLR1 with 0xffff, and get a 64KiB transfer, but that also seems to
> cause the core to choke, so stick with a maximum of 64K - 1 bytes --
> i.e., 0xffff.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  drivers/spi/spi-rockchip.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index d840324bcc9f..0f89c2169c24 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -142,6 +142,12 @@
>  /* sclk_out: spi master internal logic in rk3x can support 50Mhz */
>  #define MAX_SCLK_OUT		50000000
>
> +/*
> + * SPI_CTRLR1 is 16-bits, so we should support lengths of 0xffff + 1. However,
> + * the controller seems to hang when given 0x10000, so stick with this for now.
> + */
> +#define ROCKCHIP_SPI_MAX_TRANLEN		0xffff
> +
>  enum rockchip_ssi_type {
>  	SSI_MOTO_SPI = 0,
>  	SSI_TI_SSP,
> @@ -573,6 +579,11 @@ static void rockchip_spi_config(struct rockchip_spi *rs)
>  	dev_dbg(rs->dev, "cr0 0x%x, div %d\n", cr0, div);
>  }
>
> +static size_t rockchip_spi_max_transfer_size(struct spi_device *spi)
> +{
> +	return ROCKCHIP_SPI_MAX_TRANLEN;
> +}
> +
>  static int rockchip_spi_transfer_one(
>  		struct spi_master *master,
>  		struct spi_device *spi,
> @@ -589,6 +600,11 @@ static int rockchip_spi_transfer_one(
>  		return -EINVAL;
>  	}
>
> +	if (xfer->len > ROCKCHIP_SPI_MAX_TRANLEN) {
> +		dev_err(rs->dev, "Transfer is too long (%d)\n", xfer->len);
> +		return -EINVAL;
> +	}
> +
>  	rs->speed = xfer->speed_hz;
>  	rs->bpw = xfer->bits_per_word;
>  	rs->n_bytes = rs->bpw >> 3;
> @@ -730,6 +746,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
>  	master->prepare_message = rockchip_spi_prepare_message;
>  	master->unprepare_message = rockchip_spi_unprepare_message;
>  	master->transfer_one = rockchip_spi_transfer_one;
> +	master->max_transfer_size = rockchip_spi_max_transfer_size;
>  	master->handle_err = rockchip_spi_handle_err;
>
>  	rs->dma_tx.ch = dma_request_chan(rs->dev, "tx");
>


-- 
Best Regards
Shawn Lin
