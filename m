From: manabian@gmail.com (Joachim Eastwood)
Date: Mon, 31 Oct 2016 12:12:42 +0100
Subject: [PATCH v2 1/2] net: stmmac: Add OXNAS Glue Driver
In-Reply-To: <20161031105442.17228-1-narmstrong@baylibre.com>
References: <20161031105345.16711-1-narmstrong@baylibre.com>
 <20161031105442.17228-1-narmstrong@baylibre.com>
Message-ID: <CAGhQ9VyAaqUy06kb_Mxewo+BbJnxe=e6=x8pFsVSY0Z6C-h=cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

On 31 October 2016 at 11:54, Neil Armstrong <narmstrong@baylibre.com> wrote:
> Add Synopsys Designware MAC Glue layer for the Oxford Semiconductor OX820.
>
> Acked-by: Joachim Eastwood <manabian@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
> +static int oxnas_dwmac_init(struct oxnas_dwmac *dwmac)
> +{
> +       unsigned int value;
> +       int ret;
> +
> +       /* Reset HW here before changing the glue configuration */
> +       ret = device_reset(dwmac->dev);
> +       if (ret)
> +               return ret;
> +
> +       ret = clk_prepare_enable(dwmac->clk);
> +       if (ret)
> +               return ret;
> +
> +       ret = regmap_read(dwmac->regmap, OXNAS_DWMAC_CTRL_REGOFFSET, &value);
> +       if (ret < 0)
> +               return ret;

If regmap reading fails here, the clock will be left on as probe fails.


> +
> +       /* Enable GMII_GTXCLK to follow GMII_REFCLK, required for gigabit PHY */
> +       value |= BIT(DWMAC_CKEN_GTX)            |
> +                /* Use simple mux for 25/125 Mhz clock switching */
> +                BIT(DWMAC_SIMPLE_MUX)          |
> +                /* set auto switch tx clock source */
> +                BIT(DWMAC_AUTO_TX_SOURCE)      |
> +                /* enable tx & rx vardelay */
> +                BIT(DWMAC_CKEN_TX_OUT)         |
> +                BIT(DWMAC_CKEN_TXN_OUT)        |
> +                BIT(DWMAC_CKEN_TX_IN)          |
> +                BIT(DWMAC_CKEN_RX_OUT)         |
> +                BIT(DWMAC_CKEN_RXN_OUT)        |
> +                BIT(DWMAC_CKEN_RX_IN);
> +       regmap_write(dwmac->regmap, OXNAS_DWMAC_CTRL_REGOFFSET, value);
> +
> +       /* set tx & rx vardelay */
> +       value = DWMAC_TX_VARDELAY(4)    |
> +               DWMAC_TXN_VARDELAY(2)   |
> +               DWMAC_RX_VARDELAY(10)   |
> +               DWMAC_RXN_VARDELAY(8);
> +       regmap_write(dwmac->regmap, OXNAS_DWMAC_DELAY_REGOFFSET, value);
> +
> +       return 0;
> +}


regards,
Joachim Eastwood
