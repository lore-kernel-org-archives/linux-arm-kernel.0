From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 10 Apr 2013 20:33:01 -0400
Subject: [PATCHv2 08/10] arm: kirkwood: convert QNAP TS219 to use DT
 for the PCIe interface
In-Reply-To: <1365632436-25367-9-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1365632436-25367-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1365632436-25367-9-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130411003301.GH28693@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 12:20:34AM +0200, Thomas Petazzoni wrote:
> Now that the PCIe mvebu driver is usable on Kirkwood, use it instead
> of the legacy PCIe code, since it allows to describe the PCIe
> interfaces in the Device Tree.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/kirkwood-ts219.dtsi |    7 +++++++
>  arch/arm/mach-kirkwood/board-ts219.c  |   10 ----------
>  2 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-ts219.dtsi b/arch/arm/boot/dts/kirkwood-ts219.dtsi
> index 64ea27c..341e1d8 100644
> --- a/arch/arm/boot/dts/kirkwood-ts219.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-ts219.dtsi
> @@ -74,5 +74,12 @@
>  			status = "okay";
>  			nr-ports = <2>;
>  		};
> +		pcie-controller {
> +			status = "okay";
> +
> +			pcie at 1,0 {
> +				status = "okay";
> +			};
> +		};
>  	};
>  };
> diff --git a/arch/arm/mach-kirkwood/board-ts219.c b/arch/arm/mach-kirkwood/board-ts219.c
> index acb0187..4695d5f 100644
> --- a/arch/arm/mach-kirkwood/board-ts219.c
> +++ b/arch/arm/mach-kirkwood/board-ts219.c
> @@ -41,13 +41,3 @@ void __init qnap_dt_ts219_init(void)
>  
>  	pm_power_off = qnap_tsx1x_power_off;
>  }
> -
> -/* FIXME: Will not work with DT. Maybe use MPP40_GPIO? */
> -static int __init ts219_pci_init(void)
> -{
> -	if (machine_is_ts219())
> -		kirkwood_pcie_init(KW_PCIE0);
> -
> -	return 0;
> -}
> -subsys_initcall(ts219_pci_init);

This doesn't look right.  There are two dts files, one for 6281, and one
for 6282...

thx,

Jason.
