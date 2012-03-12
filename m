From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 12 Mar 2012 12:09:43 -0600
Subject: [PATCH v2 2/2] arm/tegra: add timeout to PCIe PLL lock detection
 loop
In-Reply-To: <1331287760-10546-1-git-send-email-mad_soft@inbox.ru>
References: <20120306201538.GA14350@rainbow>
 <1331287760-10546-1-git-send-email-mad_soft@inbox.ru>
Message-ID: <4F5E3BE7.4080207@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/2012 03:09 AM, Dmitry Artamonow wrote:
> Tegra PCIe driver waits for PLL to lock using busy loop.
> If PLL fails to lock for some reason, this leads to silent lockup
> while booting (PCIe code is not modular).
> 
> Fix by adding timeout, so if PLL doesn't lock in a couple
> of seconds, just PCIe driver fails and machine continues to boot.
> 
> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>

> diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c

>  	/* Wait for the PLL to lock */
> +	timeout = 2000;
>  	do {
>  		val = pads_readl(PADS_PLL_CTL);
> +		usleep_range(1000, 1000);
> +		if (--timeout == 0) {
> +			pr_err("Tegra PCIe error: timeout waiting for PLL\n");
> +			return -EBUSY;
> +		}
>  	} while (!(val & PADS_PLL_CTL_LOCKDET));

Thierry pointed out that one of NVIDIA's downstream kernels uses a
timeout of 300 here, rather than 2000 above. Do you see a specific need
for this timeout for be 2000 rather than 300? It might be nice to be
consistent.

Olof, I notice you've already applied V1 of this, which has the return
statement issue. Can you replace it with this, or should Dmitry send an
incremental patch?
