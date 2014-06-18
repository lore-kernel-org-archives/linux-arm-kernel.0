From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Wed, 18 Jun 2014 12:53:31 +0300
Subject: [PATCH v4 2/4] pinctrl: Add NVIDIA Tegra XUSB pad controller
 support
In-Reply-To: <1403006877-19850-2-git-send-email-thierry.reding@gmail.com>
References: <1403006877-19850-1-git-send-email-thierry.reding@gmail.com>
 <1403006877-19850-2-git-send-email-thierry.reding@gmail.com>
Message-ID: <53A1619B.8080806@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/06/14 15:07, Thierry Reding wrote:
> +static int tegra_xusb_padctl_pinconf_group_get(struct pinctrl_dev *pinctrl,
> +                                              unsigned int group,
> +                                              unsigned long *config)
> +{
> +       struct tegra_xusb_padctl *padctl = pinctrl_dev_get_drvdata(pinctrl);
> +       const struct tegra_xusb_padctl_lane *lane;
> +       enum tegra_xusb_padctl_param param;
> +       u32 value;
> +
> +       param = TEGRA_XUSB_PADCTL_UNPACK_PARAM(*config);
> +       lane = &padctl->soc->lanes[group];
> +
> +       switch (param) {
> +       case TEGRA_XUSB_PADCTL_IDDQ:
> +               value = padctl_readl(padctl, lane->offset);
> +               value = (value >> lane->iddq) & 0x1;
> +               *config = TEGRA_XUSB_PADCTL_PACK(param, value);
> +               break;
> +
> +       default:
> +               dev_err(padctl->dev, "invalid configuration parameter: %04x\n",
> +                       param);
> +               return -ENOTSUPP;
> +       }
> +
> +       return 0;
> +}

I guess `value' should also be negated here?
