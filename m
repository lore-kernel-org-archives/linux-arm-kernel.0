From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 21 Apr 2013 17:47:04 +0200
Subject: [PATCH] Enable PCIe port 1 on QNAP TS-11x/TS-21x
In-Reply-To: <20130421152802.GA1408@jirafa.cyrius.com>
References: <20130421152802.GA1408@jirafa.cyrius.com>
Message-ID: <20130421154704.GV2824@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 21, 2013 at 04:28:02PM +0100, Martin Michlmayr wrote:
> Enable KW_PCIE1 on QNAP TS-11x/TS-21x devices as newer revisions
> (rev 1.3) have a USB 3.0 chip from Etron on PCIe port 1.  Thanks
> to Marek Vasut for identifying this issue!
> 
> Cc: <stable@kernel.org>
> Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
> Tested-by: Marek Vasut <marex@denx.de>
> 
> diff --git a/arch/arm/mach-kirkwood/board-ts219.c b/arch/arm/mach-kirkwood/board-ts219.c
> index acb0187..651e6b3 100644
> --- a/arch/arm/mach-kirkwood/board-ts219.c
> +++ b/arch/arm/mach-kirkwood/board-ts219.c
> @@ -46,7 +46,7 @@ void __init qnap_dt_ts219_init(void)
>  static int __init ts219_pci_init(void)
>  {
>  	if (machine_is_ts219())
> -		kirkwood_pcie_init(KW_PCIE0);
> +		kirkwood_pcie_init(KW_PCIE1 | KW_PCIE0);
>  

Hi Martin

For the DT based board, this will not help. Did you notice the FIXME?

Now that i know both ports are needed, i will fix the DT for 3.11 when
we introduce PCI bindings via DT.

>  	return 0;
>  }
> diff --git a/arch/arm/mach-kirkwood/ts219-setup.c b/arch/arm/mach-kirkwood/ts219-setup.c
> index 283abff..e1267d6 100644
> --- a/arch/arm/mach-kirkwood/ts219-setup.c
> +++ b/arch/arm/mach-kirkwood/ts219-setup.c
> @@ -124,7 +124,7 @@ static void __init qnap_ts219_init(void)
>  static int __init ts219_pci_init(void)
>  {
>  	if (machine_is_ts219())
> -		kirkwood_pcie_init(KW_PCIE0);
> +		kirkwood_pcie_init(KW_PCIE1 | KW_PCIE0);

This looks correct. Please could you submit a new version with just
this hunk. Since its a fix, we can probably get it quickly into 3.10
and then into stable.

Thanks
	Andrew
