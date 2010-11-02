From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 2 Nov 2010 22:21:11 +0000
Subject: [PATCH 2/2] ARM: imx: Add mx53 support to common msl functions.
In-Reply-To: <1288736227-800-2-git-send-email-Dinh.Nguyen@freescale.com>
References: <1288736227-800-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1288736227-800-2-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <20101102222111.GA5169@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 02, 2010 at 05:17:07PM -0500, Dinh.Nguyen at freescale.com wrote:
>  static void query_silicon_parameter(void)
>  {
> -	void __iomem *rom = ioremap(MX51_IROM_BASE_ADDR, MX51_IROM_SIZE);
> +	void __iomem *rom;
>  	u32 rev;
>  
> +	if (cpu_is_mx51())
> +		rom = ioremap(MX51_IROM_BASE_ADDR, MX51_IROM_SIZE);
> +	else if (cpu_is_mx53())
> +		rom = ioremap(MX53_IROM_BASE_ADDR, MX53_IROM_SIZE);

	else
		rom is uninitialized;

I'd also suggest that the above set two variables - base and size, rather
than repeating the ioremap.  If you look at the generated code, I suspect
you'll find that the above generates two ioremap calls, whereas using
variables for base and size, and having a common ioremap will reduce the
code size.
