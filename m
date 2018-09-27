From: joel@jms.id.au (Joel Stanley)
Date: Thu, 27 Sep 2018 07:11:59 +0400
Subject: [PATCH i2c-next v3 2/3] i2c: aspeed: Add 'aspeed,timeout' DT
 property reading code
In-Reply-To: <20180926215842.23125-3-jae.hyun.yoo@linux.intel.com>
References: <20180926215842.23125-1-jae.hyun.yoo@linux.intel.com>
 <20180926215842.23125-3-jae.hyun.yoo@linux.intel.com>
Message-ID: <CACPK8XcKms88EcpT3soE6wLyAmvyiLfVkNeOQT0FgmY4eZoDrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Sep 2018 at 01:58, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>
> This commit adds reading code of the 'aspeed,timeout' DT property
> to set 'timeout' value in adapter configuration. This value still
> case be configured through an I2C_TIMEOUT ioctl on cdev too.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-aspeed.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 8dc9161ced38..0d934ce0c028 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -115,6 +115,9 @@
>  /* 0x18 : I2CD Slave Device Address Register   */
>  #define ASPEED_I2CD_DEV_ADDR_MASK                      GENMASK(6, 0)
>
> +/* Timeout */
> +#define ASPEED_I2C_BUS_TIMEOUT_US_DEFAULT              (5 * 1000 * 1000)

The 5 seconds time out is way too long. On a system that doesn't have
functional i2c, this holds up boot for a long time as most i2c client
drivers try to initialise their device and fail. I realise you're not
changing the value, but we should pick a better default. 1 second?
Half a second?

> +
>  enum aspeed_i2c_master_state {
>         ASPEED_I2C_MASTER_INACTIVE,
>         ASPEED_I2C_MASTER_START,
> @@ -885,6 +888,7 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
>         struct clk *parent_clk;
>         struct resource *res;
>         int irq, ret;
> +       u32 timeout_us;
>
>         bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
>         if (!bus)
> @@ -918,6 +922,11 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
>                 bus->bus_frequency = 100000;
>         }
>
> +       ret = of_property_read_u32(pdev->dev.of_node, "aspeed,timeout",
> +                                  &timeout_us);

Can we make this binding generic? It's not specific to aspeed's
hardware. Getting the value could even part of the i2c core.

I read the previous thread with Wolfram. I think this would still fit
with what Wolfram suggested, but please forgive my jetlagged brain if
I've missed something.

Cheers,

Joel
> +       if (ret)
> +               timeout_us = ASPEED_I2C_BUS_TIMEOUT_US_DEFAULT;
> +
>         match = of_match_node(aspeed_i2c_bus_of_table, pdev->dev.of_node);
>         if (!match)
>                 bus->get_clk_reg_val = aspeed_i2c_24xx_get_clk_reg_val;
> @@ -930,7 +939,7 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
>         init_completion(&bus->cmd_complete);
>         bus->adap.owner = THIS_MODULE;
>         bus->adap.retries = 0;
> -       bus->adap.timeout = 5 * HZ;
> +       bus->adap.timeout = usecs_to_jiffies(timeout_us);
>         bus->adap.algo = &aspeed_i2c_algo;
>         bus->adap.dev.parent = &pdev->dev;
>         bus->adap.dev.of_node = pdev->dev.of_node;
> --
> 2.19.0
>
