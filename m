From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 07 Sep 2012 09:37:30 -0600
Subject: [PATCH V2] ARM: dt: tegra: harmony: add regulators
In-Reply-To: <1346972447-7096-1-git-send-email-swarren@wwwdotorg.org>
References: <1346972447-7096-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <504A14BA.9070109@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2012 05:00 PM, Stephen Warren wrote:
> From: Laxman Dewangan <ldewangan@nvidia.com>
> 
> Harmony uses a TPS6586x regulator. Instantiate this, and hook up a
> couple of fixed GPIO-controlled regulators too.
> 
> Based on Ventana regulator patch by Stephen Warren <swarren@nvidia.com>
> and converted to Harmony.
> 
> swarren made the following changes:
> * Added ldo0 regulator configuration to device tree, and updated
>   board-harmony-pcie.c for the new regulator name.
> * Fixed vdd_1v05's voltage from 10.5V to 1.05V.
> * Modified board-harmony-pcie.c to obtain the en_vdd_1v05 GPIO number at
>   run-time from device tree instead of hard-coding it.
> * Removed board-harmony{-power.c,.h} now that they're unused.
> * Disabled vdd_1v05 regulator; the code in board-harmony-pcie.c hijacks
>   this GPIO for now. This will be fixed when the PCIe driver is re-
>   written as a driver. The code can't regulator_get("vdd_1v05") right
>   now, because the vdd_1v05 regulator's probe gets deferred due to its
>   supply being the PMIC, which gets probed after the regulator the first
>   time around, and this dependency is only resolved by repeated probing,
>   which happens when deferred_probe_initcall() is called, which happens
>   in a late initcall, whose runtime order relative to harmony_pcie_init()
>   is undefined, since that's also called from a late initcall.
> * Removed unused harmony_pcie_initcall().
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Applied to Tegra's for-3.7/board-removal branch (since it relies on
patches there, and allows board-harmony-power.c to be removed).
