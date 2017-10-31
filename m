From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Oct 2017 17:16:29 +0000
Subject: [PATCH 3/3] ARM: early_printk: use printascii() rather than
 printch()
In-Reply-To: <nycvar.YSQ.7.76.1710311302370.21665@knanqh.ubzr>
References: <20171002020618.23924-1-nicolas.pitre@linaro.org>
 <20171002020618.23924-4-nicolas.pitre@linaro.org>
 <PS1PR06MB1162212F37C8BA7EE367FE828A5E0@PS1PR06MB1162.apcprd06.prod.outlook.com>
 <nycvar.YSQ.7.76.1710311211540.21665@knanqh.ubzr>
 <80bc8c16-321a-43ea-6cbb-257dbeee485b@arm.com>
 <nycvar.YSQ.7.76.1710311302370.21665@knanqh.ubzr>
Message-ID: <20171031171629.GI9463@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 31, 2017 at 01:06:35PM -0400, Nicolas Pitre wrote:
> That's easy to veryfy with this patch:

Unfortunately not that easy, this patch breaks printch.

> diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
> index ea9646cc2a..40023a4871 100644
> --- a/arch/arm/kernel/debug.S
> +++ b/arch/arm/kernel/debug.S
> @@ -79,18 +79,21 @@ hexbuf:		.space 16
>  

The new code is:

>  ENTRY(printascii)
>  		addruart_current r3, r1, r2
> +1:		teq	r0, #0
>  		ldrneb	r1, [r0], #1
>  		teqne	r1, #0
> +		reteq	lr
> +		teq     r1, #'\n'
> +		bne	2f
> +		mov	r1, '\r'
> +		waituart r2, r3
> +		senduart r1, r3
> +		busyuart r2, r3
> +		mov	r1, '\n'
> +2:		waituart r2, r3
> +		senduart r1, r3
> +		busyuart r2, r3
> +		b	1b
>  ENDPROC(printascii)

and printch jumps to the 1: label with r0 = 0 and r1 = character.  Your
change has the effect that the "reteq" will always be taken when called
by printch.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
