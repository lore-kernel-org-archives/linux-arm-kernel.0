From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 5 Mar 2014 07:55:48 +0000
Subject: [PATCH 4/4] phy: miphy365x: Provide support for the MiPHY356x
 Generic PHY
In-Reply-To: <1392377036-12816-4-git-send-email-lee.jones@linaro.org>
References: <1392377036-12816-1-git-send-email-lee.jones@linaro.org>
 <1392377036-12816-4-git-send-email-lee.jones@linaro.org>
Message-ID: <20140305075548.GG20016@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 11:23:56AM +0000, Lee Jones wrote:
> The MiPHY365x is a Generic PHY which can serve various SATA or PCIe
> devices. It has 2 ports which it can use for either; both SATA, both
> PCIe or one of each in any configuration.
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/phy/Kconfig         |  10 +
>  drivers/phy/Makefile        |   1 +
>  drivers/phy/phy-miphy365x.c | 614 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 625 insertions(+)
>  create mode 100644 drivers/phy/phy-miphy365x.c

[...]

> +enum miphy_sata_gen {
> +       SATA_GEN1 = 1,
> +       SATA_GEN2,
> +       SATA_GEN3
> +};

It would be nice to have a comment here that these values are ABI and
cannot change.

[...]

> +static struct phy *miphy365x_phy_xlate(struct device *dev,
> +                                      struct of_phandle_args *args)
> +{
> +       struct miphy365x_dev *state = dev_get_drvdata(dev);
> +       u8 port = args->args[0];
> +       u8 type = args->args[1];

In case of a bad dt, it would be nice to check args->arg_count == 2.

ALso, we throw away the top 24 bits, which may have been set
erroneously. If we want to make use of those in future we should test
they are clear here to force people to do the right thing.

Otherwise, this looks fine to me.

With those additions:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Cheers,
Mark.
