From: dirk.behme@gmail.com (Dirk Behme)
Date: Sat, 30 Mar 2013 13:12:14 +0100
Subject: PCI support for IMX6
In-Reply-To: <20130330113703.GA21042@amd.pavel.ucw.cz>
References: <20130329185500.GB30029@amd.pavel.ucw.cz>
 <20130330113703.GA21042@amd.pavel.ucw.cz>
Message-ID: <5156D69E.3050600@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 30.03.2013 12:37, schrieb Pavel Machek:
> Hi!
>
>> What is the state of PCI support for IMX6? I have board that has
>> e1000e connected via PCI, and I'd like to get network to work.
>>
>> I'm currently trying to port PCI support from 3.0, but it does not
>> look exactly easy.
>
> This is what I ended up with. Currently it is unable to turn on clock
> for PCI, thus it hangs. If someone has any ideas, let me know...
...
> +static void imx_pcie_enable_controller(struct device *dev)
> +{
> +	struct clk *pcie_clk;
...
> +/* FIXME */
> +#define PCIE_CLK "pcie_ref"
> +	/* enable the clks */
> +	pcie_clk = clk_get(NULL, PCIE_CLK);
> +	if (IS_ERR(pcie_clk)) {
> +		pr_err("no pcie (?) clock.\n");
> +	} else if (clk_enable(pcie_clk)) {
> +		pr_err("can't enable pcie clock.\n");
> +		clk_put(pcie_clk);
> +	}

I'm not sure, Shawn might be the expert on this ;)

But have you tried using 'pcie_ref_125m'? And/or, as a test only, to 
add pcie_ref and/or pcie_ref_125m to clks_init_on:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/mach-imx/clk-imx6q.c#n174

?

Best regards

Dirk
