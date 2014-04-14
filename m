From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 14 Apr 2014 12:57:52 +0200
Subject: [PATCH 22/29] ARM: orion5x: use DT to describe EHCI on edmini_v2
In-Reply-To: <1397400006-4315-23-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-23-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <534BBF30.1000307@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/2014 04:39 PM, Thomas Petazzoni wrote:
> This commit converts the already partially DT-converted edmini_v2
> platform to use the Device Tree for USB.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>   arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts | 4 ++++
>   arch/arm/mach-orion5x/edmini_v2-setup.c                   | 2 --
>   2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> index f077b7b..ff90b01 100644
> --- a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> +++ b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> @@ -73,6 +73,10 @@
>   				status = "okay";
>   			};
>
> +			ehci at 50000 {

Node label reference again.

If you wonder why I insist on it, if you ever realize there is
something wrong with the original bus node structure in orion5x.dtsi,
you don't have to change 40+ board files, too. This is what makes
cleaning up kirkwood.dtsi so tricky ;)

Sebastian

> +				status = "okay";
> +			};
> +
>   			sata at 80000 {
>   				pinctrl-0 = <&pmx_sata0 &pmx_sata1>;
>   				pinctrl-names = "default";
> diff --git a/arch/arm/mach-orion5x/edmini_v2-setup.c b/arch/arm/mach-orion5x/edmini_v2-setup.c
> index 75648ab..2eebc0c 100644
> --- a/arch/arm/mach-orion5x/edmini_v2-setup.c
> +++ b/arch/arm/mach-orion5x/edmini_v2-setup.c
> @@ -104,8 +104,6 @@ void __init edmini_v2_init(void)
>   	/*
>   	 * Configure peripherals.
>   	 */
> -	orion5x_ehci0_init();
> -
>   	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
>   				    ORION_MBUS_DEVBUS_BOOT_ATTR,
>   				    EDMINI_V2_NOR_BOOT_BASE,
>
