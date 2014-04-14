From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 14 Apr 2014 11:30:06 +0200
Subject: [PATCH 04/29] memory: mvebu-devbus: fix the conversion of the
 bus width
In-Reply-To: <1397400006-4315-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <534BAA9E.2040201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/2014 04:39 PM, Thomas Petazzoni wrote:
> According to the Armada 370 and Armada XP datasheets, the part of the
> Device Bus register that configure the bus width should contain 0 for
> a 8 bits bus width, and 1 for a 16 bits bus width (other values are
> unsupported/reserved).
>
> However, the current conversion done in the driver to convert from a
> bus width in bits to the value expected by the register leads to
> setting the register to 1 for a 8 bits bus, and 2 for a 16 bits bus.
>
> This commit fixes that by adjusting the conversion logic.
>
> This patch fixes a bug that was introduced in
> 3edad321b1bd2e6c8b5f38146c115c8982438f06 ('drivers: memory: Introduce
> Marvell EBU Device Bus driver'), which was merged in v3.11.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: stable at vger.kernel.org
> ---
>   drivers/memory/mvebu-devbus.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/memory/mvebu-devbus.c b/drivers/memory/mvebu-devbus.c
> index 110c036..b82cdf1 100644
> --- a/drivers/memory/mvebu-devbus.c
> +++ b/drivers/memory/mvebu-devbus.c
> @@ -108,8 +108,12 @@ static int devbus_set_timing_params(struct devbus *devbus,
>   			node->full_name);
>   		return err;
>   	}
> -	/* Convert bit width to byte width */
> -	r.bus_width /= 8;
> +
> +	/*
> +	 * The bus width is encoded into the register as 0 for 8 bits,
> +	 * and 1 for 16 bits, so we do the necessary conversion here.
> +	 */
> +	r.bus_width = (r.bus_width / 8) - 1;

I guess the next larger register value would be 0x2 for 32b? I cannot
tell, if there is any SoC spending 32 pins on this, but the correct
formula would possibly include ld().

Sebastian

>
>   	err = get_timing_param_ps(devbus, node, "devbus,badr-skew-ps",
>   				 &r.badr_skew);
>
