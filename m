From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 16 Jun 2013 13:51:08 +0200
Subject: [PATCH 3/4] ARM: mxs: dt: Add the Crystalfontz CFA-10055 device
 tree
In-Reply-To: <1371131025-12200-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1371131025-12200-1-git-send-email-maxime.ripard@free-electrons.com>
 <1371131025-12200-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130616135108.229d216e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Maxime Ripard,

Some nitpicking below.

On Thu, 13 Jun 2013 15:43:44 +0200, Maxime Ripard wrote:

> -static void __init cfa10049_init(void)
> -{
> -	update_fec_mac_prop(OUI_CRYSTALFONTZ);
> -}
> -
> -static void __init cfa10037_init(void)
> +static void __init crystalfontz_init(void)
>  {
>  	update_fec_mac_prop(OUI_CRYSTALFONTZ);
>  }
> @@ -368,10 +363,10 @@ static void __init mxs_machine_init(void)
>  		imx28_evk_init();
>  	else if (of_machine_is_compatible("bluegiga,apx4devkit"))
>  		apx4devkit_init();
> -	else if (of_machine_is_compatible("crystalfontz,cfa10037"))
> -		cfa10037_init();
> -	else if (of_machine_is_compatible("crystalfontz,cfa10049"))
> -		cfa10049_init();
> +	else if (of_machine_is_compatible("crystalfontz,cfa10037") ||
> +		 of_machine_is_compatible("crystalfontz,cfa10049") ||
> +		 of_machine_is_compatible("crystalfontz,cfa10055"))
> +		crystalfontz_init();

Maybe this could be something like:

	else if (of_machine_is_compatible("crystalfontz,cfa10036"))
		crystalfontz_init();

with crystalfontz_init() something like:

	if (mac0 has status = "okay")
		update_fec_mac_prop(OUI_CRYSTALFONTZ);

This way, for all Crystalfontz boards that have an Ethernet interface,
it would call update_fec_mac_prop() without having to update mach-mxs.c
every time.

(Of course, this is based on the assumption that all Crystalfontz .dts
files have "crystalfontz,cfa10036" in their compatible string list)

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
