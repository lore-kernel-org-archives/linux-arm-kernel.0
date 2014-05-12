From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 12 May 2014 17:18:24 +0200
Subject: [PATCH 2/2] ARM: mvebu: mvebu-soc-id: keep clock enabled if PCIe
 unit is enabled
In-Reply-To: <1399903900-29977-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399903900-29977-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1399903900-29977-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5370E640.9050706@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 12/05/2014 16:11, Thomas Petazzoni wrote:
> Since the mvebu-soc-id code in mach-mvebu/ was introduced, several
> users have noticed a regression: the PCIe card connected in the first
> PCIe interface is not detected properly.
> 
> This is due to the fact that the mvebu-soc-id code enables the PCIe
> clock of the first PCIe interface, reads the SoC device ID and
> revision number (yes this information is made available as part of
> PCIe registers), and then disables the clock. However, by doing this,
> we gate the clock and therefore loose the complex PCIe configuration
> that was done by the bootloader.
> 
> Unfortunately, as of today, the kernel is not capable of doing this
> complex configuration by itself, so we really need to keep the PCIe
> clock enabled. However, we don't want to keep it enabled
> unconditionally: if the PCIe interface is not enabled or PCI support
> is not compiled into the kernel, there is no reason to keep the PCIe
> clock running.
> 
> This issue was discussed with Kevin Hilman, and the suggested solution
> was to make the mvebu-soc-id code keep the clock enabled in case it
> will be needed for PCIe. This is therefore the solution implemented in
> this patch.
> 
> Long term, we hope to make the kernel more capable in terms of PCIe
> configuration for this platform, which will anyway be needed to
> support the compilation of the PCIe host controller driver as a
> module. In the mean time however, we don't have much other choice than
> to implement the currently proposed solution.

It fixed the detection issue I had on the Armada 385 DB board:
Tetsed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

And as I also agree with the code:

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

> 
> Reported-by: Neil Greatorex <neil@fatboyfat.co.uk>
> Cc: Neil Greatorex <neil@fatboyfat.co.uk>
> Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> Cc: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: <stable@vger.kernel.org> # 3.14+
> Fixes: af8d1c63afcbf36eea06789c92e22d4af118d2fb ('ARM: mvebu: Add support to get the ID and the revision of a SoC')
> ---
>  arch/arm/mach-mvebu/mvebu-soc-id.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mvebu/mvebu-soc-id.c b/arch/arm/mach-mvebu/mvebu-soc-id.c
> index b52af6f..09520e1 100644
> --- a/arch/arm/mach-mvebu/mvebu-soc-id.c
> +++ b/arch/arm/mach-mvebu/mvebu-soc-id.c
> @@ -108,8 +108,18 @@ static int __init mvebu_soc_id_init(void)
>  	iounmap(pci_base);
>  
>  res_ioremap:
> -	clk_disable_unprepare(clk);
> -	clk_put(clk);
> +	/*
> +	 * If the PCIe unit is actually enabled and we have PCI
> +	 * support in the kernel, we intentionally do not release the
> +	 * reference to the clock. We want to keep it running since
> +	 * the bootloader does some PCIe link configuration that the
> +	 * kernel is for now unable to do, and gating the clock would
> +	 * make us loose this precious configuration.
> +	 */
> +	if (!of_device_is_available(child) || !IS_ENABLED(CONFIG_PCI_MVEBU)) {
> +		clk_disable_unprepare(clk);
> +		clk_put(clk);
> +	}
>  
>  clk_err:
>  	of_node_put(child);
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
