From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Sep 2012 16:18:34 -0600
Subject: [PATCH v3 2/9] pinctrl: mvebu: dove pinctrl driver
In-Reply-To: <1347266386-16229-3-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1345623750-10645-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347266386-16229-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347266386-16229-3-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <504FB8BA.1010703@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/2012 02:39 AM, Sebastian Hesselbarth wrote:
> This patch adds a SoC specific pinctrl driver for Marvell Dove SoCs
> plus DT binding documentation. This driver will use the mvebu pinctrl
> driver core.

> diff --git a/drivers/pinctrl/pinctrl-dove.c b/drivers/pinctrl/pinctrl-dove.c

> +static int dove_mpp4_ctrl_get(struct mvebu_mpp_ctrl *ctrl,
> +			      unsigned long *config)
> +{
> +	unsigned long mpp4 = readl(DOVE_MPP_CTRL4_VIRT_BASE);
> +	unsigned long mask;
> +
> +	switch (ctrl->pid) {
> +	case 24: /* mpp_camera */
> +		mask = DOVE_CAM_GPIO_SEL;
> +		break;
> +	case 40: /* mpp_sdio0 */
> +		mask = DOVE_SD0_GPIO_SEL;
> +		break;
> +	case 46: /* mpp_sdio1 */
> +		mask = DOVE_SD1_GPIO_SEL;
> +		break;
> +	case 58: /* mpp_spi0 */
> +		mask = DOVE_SPI_GPIO_SEL;
> +		break;
> +	case 62: /* mpp_uart1 */
> +		mask = DOVE_UART1_GPIO_SEL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

Wouldn't it be better to use #defines instead of the constants in the
case statements, and also share those #defines with:


> +static struct mvebu_mpp_ctrl dove_mpp_controls[] = {
> +	MPP_FUNC_CTRL(0, 0, "mpp0", dove_pmu_mpp_ctrl),
                      ^^^^

> +static struct mvebu_mpp_mode dove_mpp_modes[] = {
> +	MPP_MODE(0,
                 ^^
