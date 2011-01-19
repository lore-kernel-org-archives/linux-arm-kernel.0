From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Jan 2011 00:05:56 +0000
Subject: [PATCH V4 25/62] ST SPEAr: Added PCIE host controller base
	driver support.
In-Reply-To: <2c8dc40cb00bd8c6253ce45888ce1c331968d0e7.1295333958.git.viresh.kumar@st.com>
References: <cover.1295333957.git.viresh.kumar@st.com>
	<2c8dc40cb00bd8c6253ce45888ce1c331968d0e7.1295333958.git.viresh.kumar@st.com>
Message-ID: <20110119000556.GQ16980@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 18, 2011 at 12:41:52PM +0530, Viresh Kumar wrote:
> +			clk = clk_get_sys("pcie1", NULL);
> +			if (!clk) {

IS_ERR(clk)

> +				pr_err("%s:couldn't get clk for pcie1\n",
> +						__func__);
> +				continue;
> +			}
> +			if (clk_enable(clk)) {
> +				pr_err("%s:couldn't enable clk for pcie1\n",
> +						__func__);
> +				continue;
> +			}
> +		} else if (port == 2) {
> +			/* Ideally CFG Clock should have been also enabled
> +			 * here. But it is done currently during board
> +			 * init routne*/
> +			clk = clk_get_sys("pcie2", NULL);
> +			if (!clk) {

IS_ERR(clk)

> +				pr_err("%s:couldn't get clk for pcie2\n",
> +						__func__);
> +				continue;
> +			}
> +			if (clk_enable(clk)) {
> +				pr_err("%s:couldn't enable clk for pcie2\n",
> +						__func__);
> +				continue;
> +			}
> +		}
> +
> +		if ((*pcie_port_is_host)(port))
> +			add_pcie_port(port, spr_pcie_base[port],
> +					spr_pcie_app_base[port]);
> +	}
...
> +#ifdef CONFIG_PCIEPORTBUS
> +/* PCIE0 clock always needs to be enabled if any of the three PCIE port
> + * have to be used. So call this function from the board initilization
> + * file. Ideally , all controller should have been independent from
> + * others with respect to clock.
> + */
> +int enable_pcie0_clk(void)
> +{
> +	struct clk *clk;
> +	/*Enable all CLK in CFG registers here only. Idealy only PCIE0
> +	 * should have been enabled. But Controler does not work
> +	 * properly if PCIE1 and PCIE2's CFG CLK is enabled in stages.
> +	 */
> +	writel(PCIE0_CFG_VAL | PCIE1_CFG_VAL | PCIE2_CFG_VAL, PCIE_CFG);
> +	clk = clk_get_sys("pcie0", NULL);
> +	if (!clk) {

IS_ERR(clk)
