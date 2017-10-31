From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Oct 2017 17:53:44 +0000
Subject: [PATCH 3/3] ARM: early_printk: use printascii() rather than
 printch()
In-Reply-To: <nycvar.YSQ.7.76.1710311346190.21665@knanqh.ubzr>
References: <20171002020618.23924-1-nicolas.pitre@linaro.org>
 <20171002020618.23924-4-nicolas.pitre@linaro.org>
 <PS1PR06MB1162212F37C8BA7EE367FE828A5E0@PS1PR06MB1162.apcprd06.prod.outlook.com>
 <nycvar.YSQ.7.76.1710311211540.21665@knanqh.ubzr>
 <80bc8c16-321a-43ea-6cbb-257dbeee485b@arm.com>
 <nycvar.YSQ.7.76.1710311302370.21665@knanqh.ubzr>
 <20171031171629.GI9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311346190.21665@knanqh.ubzr>
Message-ID: <20171031175344.GJ9463@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 31, 2017 at 01:48:01PM -0400, Nicolas Pitre wrote:
> On Tue, 31 Oct 2017, Russell King - ARM Linux wrote:
> 
> > On Tue, Oct 31, 2017 at 01:06:35PM -0400, Nicolas Pitre wrote:
> > > That's easy to veryfy with this patch:
> > 
> > Unfortunately not that easy, this patch breaks printch.
> 
> Right, missed that.
> 
> New patch below:
> 
> diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
> index ea9646cc2a..0d1cef4b6e 100644
> --- a/arch/arm/kernel/debug.S
> +++ b/arch/arm/kernel/debug.S
> @@ -79,25 +79,28 @@ hexbuf:		.space 16
>  
>  ENTRY(printascii)
>  		addruart_current r3, r1, r2
> -		b	2f
> -1:		waituart r2, r3
> -		senduart r1, r3
> -		busyuart r2, r3
> -		teq	r1, #'\n'
> -		moveq	r1, #'\r'
> -		beq	1b
> -2:		teq	r0, #0
> +1:		teq	r0, #0
>  		ldrneb	r1, [r0], #1
>  		teqne	r1, #0
> -		bne	1b
> -		ret	lr
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
>  
>  ENTRY(printch)
>  		addruart_current r3, r1, r2
>  		mov	r1, r0
>  		mov	r0, #0
> -		b	1b
> +		b	2b
>  ENDPROC(printch)

Still, not quite!  printch('\n') with the old code would do this
(in terms of executed instructions):

 		mov	r1, r0
 		mov	r0, #0
		b	1b
1:		waituart r2, r3
		senduart r1, r3
		busyuart r2, r3
		teq	r1, #'\n'
		moveq	r1, #'\r'
		beq	1b
1:		waituart r2, r3
		senduart r1, r3
		busyuart r2, r3
		teq	r1, #'\n'
		...
2:		teq	r0, #0
		ret	lr

So a printch('\n') produces "\n\r" on the UART.  If we're fixing
printascii() to emit "\r\n" instead of "\n\r" for a '\n', then
printch() should have the same fix, and should not truncate to
just '\n'.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
