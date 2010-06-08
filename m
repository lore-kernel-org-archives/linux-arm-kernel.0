From: joe@perches.com (Joe Perches)
Date: Tue, 08 Jun 2010 10:38:51 -0700
Subject: [PATCH] Marvell OpenRD-Ultimate machine support
In-Reply-To: <4c0e7d5a.0c3ddf0a.2771.ffffd485@mx.google.com>
References: <4c0e7d5a.0c3ddf0a.2771.ffffd485@mx.google.com>
Message-ID: <1276018731.1571.518.camel@Joe-Laptop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-06-08 at 20:24 +0300, Dmytro Milinevskyy wrote:
> @@ -73,9 +81,14 @@ static void __init openrd_init(void)
>  
>  	kirkwood_ehci_init();
>  
> -	kirkwood_ge00_init(&openrd_ge00_data);
> -	if (machine_is_openrd_client())
> -		kirkwood_ge01_init(&openrd_ge01_data);
> +	if (machine_is_openrd_ultimate()) {
> +		kirkwood_ge00_init(&openrd_ultimate_ge00_data);
> +		kirkwood_ge01_init(&openrd_ultimate_ge01_data);
> +	} else {
> +		kirkwood_ge00_init(&openrd_ge00_data);
> +		if (machine_is_openrd_client())
> +			kirkwood_ge01_init(&openrd_ge01_data);
> +	}

Perhaps some utility functions like:

	if (kirkwood_has_multiple_ethernets())?

> @@ -84,7 +97,7 @@ static void __init openrd_init(void)
>  
>  static int __init openrd_pci_init(void)
>  {
> -	if (machine_is_openrd_base() || machine_is_openrd_client())
> +	if (machine_is_openrd_base() || machine_is_openrd_client() || machine_is_openrd_ultimate())

	if (kirkwood_has_pcie()?
