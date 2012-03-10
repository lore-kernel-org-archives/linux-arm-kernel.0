From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 10 Mar 2012 18:21:44 +0000
Subject: [PATCH] pxa/hx4700: Reduce sleep mode power consumption by 35%
In-Reply-To: <1331403080.2319.YahooMailClassic@web29002.mail.ird.yahoo.com>
References: <1331403080.2319.YahooMailClassic@web29002.mail.ird.yahoo.com>
Message-ID: <20120310182144.GA20013@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 10, 2012 at 06:11:20PM +0000, Paul Parsons wrote:
> Drive the two Bluetooth UART output GPIOs (GPIO43_BTUART_TXD,
> GPIO45_BTUART_RTS) LOW during sleep mode instead of HIGH. This
> reduces sleep mode power consumption from approximately 46 mA/h
> to approximately 30 mA/h.

What are you saying here?  I think you're confusing power with current.
Also, current is measured in amps, not amps per second (or a scaled
version of that.)

> Signed-off-by: Oliver Winker <oliver@oli1170.net>
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> ---
> 
> Thanks to Oliver Winker for finding this.
> 
> diff -uprN clean-3.3-rc6/arch/arm/mach-pxa/hx4700.c linux-3.3-rc6/arch/arm/mach-pxa/hx4700.c
> --- clean-3.3-rc6/arch/arm/mach-pxa/hx4700.c	2012-03-04 01:08:09.000000000 +0000
> +++ linux-3.3-rc6/arch/arm/mach-pxa/hx4700.c	2012-03-10 15:44:18.597238757 +0000
> @@ -97,9 +97,9 @@ static unsigned long hx4700_pin_config[]
>  
>  	/* BTUART */
>  	GPIO42_BTUART_RXD,
> -	GPIO43_BTUART_TXD,
> +	GPIO43_GPIO | MFP_AF2 | MFP_LPM_DRIVE_LOW,

I don't believe that's right.

This expands to:

	MFP_CFG_IN(GPIO43, AF0) | MFP_AF2 | MFP_LPM_DRIVE_LOW

and:

	(MFP_CFG_DEFAULT & ~(MFP_AF_MASK | MFP_DIR_MASK)) |
	(MFP_PIN(MFP_PIN_GPIO43) | MFP_AF0 | MFP_DIR_IN)
	| MFP_AF2 | MFP_LPM_DRIVE_LOW

Note the presence of both MFP_AF2 and MFP_AF0 in there.

The default for GPIO43_BTUART_TXD is:

	MFP_CFG_OUT(GPIO43, AF2, DRIVE_HIGH)

and I'd suggest defining a new GPIO43_BTUART_TXD_LPM_LOW to cover your
case.
