From: dongas86@gmail.com (Dong Aisheng)
Date: Sat, 14 Apr 2012 02:17:13 +0800
Subject: [PATCH 1/3] pinctrl: pinctrl-imx: add imx pinctrl core driver
In-Reply-To: <1334333915-1174-1-git-send-email-b29396@freescale.com>
References: <1334333915-1174-1-git-send-email-b29396@freescale.com>
Message-ID: <CAA+hA=QaD=wzJoeNUxDqwAJ1grBiPxSKY+_cwYgNMBuaF4OJ6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 14, 2012 at 12:18 AM, Dong Aisheng <b29396@freescale.com> wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
>
> The driver has mux and config support while the gpio is still
> not supported.
> For select input setting, the driver will handle it internally
> and do not need user to take care of it.
>
> The pinctrl-imx core driver will parse the dts file and dynamically
> create the pinmux functions and groups.
>
> Each IMX SoC pinctrl driver should register pins with a pin register map
> including mux register and config register and select input map to core
> for proper operations.
>
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> ---
> ?.../bindings/pinctrl/fsl,imx6q-pinctrl.txt ? ? ? ? | ?201 ++++++
> ?drivers/pinctrl/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ? ?| ? ?4 +
> ?drivers/pinctrl/Makefile ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ?1 +
> ?drivers/pinctrl/pinctrl-imx.c ? ? ? ? ? ? ? ? ? ? ?| ?716 ++++++++++++++++++++
> ?drivers/pinctrl/pinctrl-imx.h ? ? ? ? ? ? ? ? ? ? ?| ?117 ++++
> ?5 files changed, 1039 insertions(+), 0 deletions(-)
> ?create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx6q-pinctrl.txt
> ?create mode 100644 drivers/pinctrl/pinctrl-imx.c
> ?create mode 100644 drivers/pinctrl/pinctrl-imx.h
>
.........
> +static int __devinit imx_pmx_parse_functions(struct device_node *np,
> + ? ? ? ? ? ? ? ? ? ? ? struct imx_pinctrl_info *info, u32 index)
> +{
> + ? ? ? struct device_node *child;
> + ? ? ? struct imx_pmx_func *func;
> + ? ? ? struct imx_pin_group *grp;
> + ? ? ? int ret;
> + ? ? ? static u32 grp_index;
> + ? ? ? u32 i = 0;
> +
> + ? ? ? dev_dbg(info->dev, "parse function(%d): %s\n", index, np->name);
> +
> + ? ? ? func = &info->functions[index];
> +
> + ? ? ? /* Initialise function */
> + ? ? ? func->name = np->name;
> + ? ? ? func->num_groups = of_get_child_count(np);
The driver depends on another dt patch which seems missed the 3.4 kernel.
[PATCH V3 1/1] dt: add of_get_child_count helper function
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/084327.html
I just sent out the mail to check with Rob.

Regards
Dong Aisheng
