From: ray.jui@broadcom.com (Ray Jui)
Date: Tue, 22 Nov 2016 09:42:05 -0800
Subject: [PATCH 1/2] PCI: iproc: fix 32-bit build
In-Reply-To: <20161122141844.1655574-1-arnd@arndb.de>
References: <20161122141844.1655574-1-arnd@arndb.de>
Message-ID: <e03e5c52-f321-916e-4650-c8bb271cd041@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/22/2016 6:17 AM, Arnd Bergmann wrote:
> The newly added code to setup the inbound ranges causes a link error
> on 32-bit machines from a 32-bit division:
> 
> drivers/pci/host/pcie-iproc.o: In function `iproc_pcie_setup_ib':
> pcie-iproc.c:(.text.iproc_pcie_setup_ib+0x14c): undefined reference to `__aeabi_uldivmod'
> 
> As both sides of the division are always power-of-two numbers and
> we already rely on that, we can use a shift instead.
> 
> Fixes: 87c240b19bba ("PCI: iproc: Add inbound DMA mapping support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pci/host/pcie-iproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index d10e6aa32e0d..857ff5198317 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -865,7 +865,7 @@ static int iproc_pcie_ib_write(struct iproc_pcie *pcie, int region_idx,
>  	 * Now program the IMAP registers.  Each IARR region may have one or
>  	 * more IMAP windows.
>  	 */
> -	size /= nr_windows;
> +	size >>= ilog2(nr_windows);
>  	for (window_idx = 0; window_idx < nr_windows; window_idx++) {
>  		val = readl(pcie->base + imap_offset);
>  		val |= lower_32_bits(axi_addr) | IMAP_VALID;
> 

Hmmm, somehow we've never seen this link error for the ARM32 based
platforms that we build for. Does it behave differently between
different versions of compilers?

Nevertheless, this is a good change to take, thanks!

Acked-by: Ray Jui <ray.jui@broadcom.com>
