From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Jul 2018 18:47:28 +0100
Subject: [PATCH 4/5] net: add support for nvmem to
 eth_platform_get_mac_address()
In-Reply-To: <20180718161035.7005-5-brgl@bgdev.pl>
References: <20180718161035.7005-1-brgl@bgdev.pl>
 <20180718161035.7005-5-brgl@bgdev.pl>
Message-ID: <20180719174728.GK6920@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2018 at 06:10:34PM +0200, Bartosz Golaszewski wrote:
> @@ -544,6 +548,31 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>  			from = "arch callback";
>  	}
>  
> +	if (!addr) {
> +		nvmem = nvmem_cell_get(dev, "mac-address");
> +		if (IS_ERR(nvmem) && PTR_ERR(nvmem) == -EPROBE_DEFER)

This is way too verbose.  To quote Al Viro from earlier today:

<viro> sigh...
<viro>         if (IS_ERR(link) && PTR_ERR(link) == -EEXIST)
<viro> what the hell is wrong with if (link == ERR_PTR(-EEXIST))?

I wonder why so many people haven't heard of pointer comparison... ;)

IS_ERR(ERR_PTR(-EPROBE_DEFER)) is always true - if it wasn't, then
we'd be in for problems.

So, if you're asserting that nvmem is ERR_PTR(-EPROBE_DEFER) then
there's no need to do the IS_ERR(nvmem) must also be true.  Hence, a
simple pointer comparison is sufficient:

		if (nvmem == ERR_PTR(-EPROBE_DEFER))
			return -EPROBE_DEFER;

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
