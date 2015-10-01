From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 01 Oct 2015 15:48:22 +0200
Subject: [PATCH 1/1] ARM: orion5x: use mac_pton() helper
In-Reply-To: <1443705223-85421-1-git-send-email-andriy.shevchenko@linux.intel.com>
 (Andy Shevchenko's message of "Thu, 1 Oct 2015 16:13:43 +0300")
References: <1443705223-85421-1-git-send-email-andriy.shevchenko@linux.intel.com>
Message-ID: <877fn6og2h.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,
 
 On jeu., oct. 01 2015, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Instead of custom approach let's use generic helper function.

This patch looks good, however did you tested it on one of these board?

Thanks,
gregory

>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Detlef Vollmann <dv@vollmann.ch>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/mach-orion5x/dns323-setup.c | 53 ++----------------------------------
>  arch/arm/mach-orion5x/tsx09-common.c | 49 +++------------------------------
>  2 files changed, 7 insertions(+), 95 deletions(-)
>
> diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
> index f267e58..bc279a8 100644
> --- a/arch/arm/mach-orion5x/dns323-setup.c
> +++ b/arch/arm/mach-orion5x/dns323-setup.c
> @@ -173,42 +173,10 @@ static struct mv643xx_eth_platform_data dns323_eth_data = {
>  	.phy_addr = MV643XX_ETH_PHY_ADDR(8),
>  };
>  
> -/* dns323_parse_hex_*() taken from tsx09-common.c; should a common copy of these
> - * functions be kept somewhere?
> - */
> -static int __init dns323_parse_hex_nibble(char n)
> -{
> -	if (n >= '0' && n <= '9')
> -		return n - '0';
> -
> -	if (n >= 'A' && n <= 'F')
> -		return n - 'A' + 10;
> -
> -	if (n >= 'a' && n <= 'f')
> -		return n - 'a' + 10;
> -
> -	return -1;
> -}
> -
> -static int __init dns323_parse_hex_byte(const char *b)
> -{
> -	int hi;
> -	int lo;
> -
> -	hi = dns323_parse_hex_nibble(b[0]);
> -	lo = dns323_parse_hex_nibble(b[1]);
> -
> -	if (hi < 0 || lo < 0)
> -		return -1;
> -
> -	return (hi << 4) | lo;
> -}
> -
>  static int __init dns323_read_mac_addr(void)
>  {
>  	u_int8_t addr[6];
> -	int i;
> -	char *mac_page;
> +	void __iomem *mac_page;
>  
>  	/* MAC address is stored as a regular ol' string in /dev/mtdblock4
>  	 * (0x007d0000-0x00800000) starting at offset 196480 (0x2ff80).
> @@ -217,23 +185,8 @@ static int __init dns323_read_mac_addr(void)
>  	if (!mac_page)
>  		return -ENOMEM;
>  
> -	/* Sanity check the string we're looking at */
> -	for (i = 0; i < 5; i++) {
> -		if (*(mac_page + (i * 3) + 2) != ':') {
> -			goto error_fail;
> -		}
> -	}
> -
> -	for (i = 0; i < 6; i++)	{
> -		int byte;
> -
> -		byte = dns323_parse_hex_byte(mac_page + (i * 3));
> -		if (byte < 0) {
> -			goto error_fail;
> -		}
> -
> -		addr[i] = byte;
> -	}
> +	if (!mac_pton((__force const char *) mac_page, addr))
> +		goto error_fail;
>  
>  	iounmap(mac_page);
>  	printk("DNS-323: Found ethernet MAC address: %pM\n", addr);
> diff --git a/arch/arm/mach-orion5x/tsx09-common.c b/arch/arm/mach-orion5x/tsx09-common.c
> index 24b2959..d42e006 100644
> --- a/arch/arm/mach-orion5x/tsx09-common.c
> +++ b/arch/arm/mach-orion5x/tsx09-common.c
> @@ -53,53 +53,12 @@ struct mv643xx_eth_platform_data qnap_tsx09_eth_data = {
>  	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
>  };
>  
> -static int __init qnap_tsx09_parse_hex_nibble(char n)
> -{
> -	if (n >= '0' && n <= '9')
> -		return n - '0';
> -
> -	if (n >= 'A' && n <= 'F')
> -		return n - 'A' + 10;
> -
> -	if (n >= 'a' && n <= 'f')
> -		return n - 'a' + 10;
> -
> -	return -1;
> -}
> -
> -static int __init qnap_tsx09_parse_hex_byte(const char *b)
> -{
> -	int hi;
> -	int lo;
> -
> -	hi = qnap_tsx09_parse_hex_nibble(b[0]);
> -	lo = qnap_tsx09_parse_hex_nibble(b[1]);
> -
> -	if (hi < 0 || lo < 0)
> -		return -1;
> -
> -	return (hi << 4) | lo;
> -}
> -
>  static int __init qnap_tsx09_check_mac_addr(const char *addr_str)
>  {
>  	u_int8_t addr[6];
> -	int i;
>  
> -	for (i = 0; i < 6; i++) {
> -		int byte;
> -
> -		/*
> -		 * Enforce "xx:xx:xx:xx:xx:xx\n" format.
> -		 */
> -		if (addr_str[(i * 3) + 2] != ((i < 5) ? ':' : '\n'))
> -			return -1;
> -
> -		byte = qnap_tsx09_parse_hex_byte(addr_str + (i * 3));
> -		if (byte < 0)
> -			return -1;
> -		addr[i] = byte;
> -	}
> +	if (!mac_pton(addr_str, addr))
> +		return -1;
>  
>  	printk(KERN_INFO "tsx09: found ethernet mac address %pM\n", addr);
>  
> @@ -118,12 +77,12 @@ void __init qnap_tsx09_find_mac_addr(u32 mem_base, u32 size)
>  	unsigned long addr;
>  
>  	for (addr = mem_base; addr < (mem_base + size); addr += 1024) {
> -		char *nor_page;
> +		void __iomem *nor_page;
>  		int ret = 0;
>  
>  		nor_page = ioremap(addr, 1024);
>  		if (nor_page != NULL) {
> -			ret = qnap_tsx09_check_mac_addr(nor_page);
> +			ret = qnap_tsx09_check_mac_addr((__force const char *)nor_page);
>  			iounmap(nor_page);
>  		}

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
