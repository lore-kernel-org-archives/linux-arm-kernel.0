From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Oct 2017 23:50:39 +0000
Subject: [PATCH 3/3] ARM: early_printk: use printascii() rather than
 printch()
In-Reply-To: <nycvar.YSQ.7.76.1710311918100.21665@knanqh.ubzr>
References: <20171031171629.GI9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311346190.21665@knanqh.ubzr>
 <20171031175344.GJ9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311355000.21665@knanqh.ubzr>
 <20171031182024.GK9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311432120.21665@knanqh.ubzr>
 <SG2PR06MB1165AE45FB289039E55D03028A5E0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <nycvar.YSQ.7.76.1710311527280.21665@knanqh.ubzr>
 <20171031215018.GL9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311918100.21665@knanqh.ubzr>
Message-ID: <20171031235038.GM9463@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 31, 2017 at 07:35:56PM -0400, Nicolas Pitre wrote:
> On Tue, 31 Oct 2017, Russell King - ARM Linux wrote:
> 
> > On Tue, Oct 31, 2017 at 03:28:11PM -0400, Nicolas Pitre wrote:
> > > Good!  Queued as patch #8717.
> > 
> > I was going to say that there's another implementation of the
> > same in arch/arm/boot/compressed/head.S, and if we fix one we
> > should apply the same fix to the other.
> 
> Let's make a separate patch for that one. Something like:
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 8a756870c2..28a48ad3dd 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -1296,19 +1296,24 @@ phex:		adr	r3, phexbuf
>  
>  @ puts corrupts {r0, r1, r2, r3}
>  puts:		loadsp	r3, r1
> -1:		ldrb	r2, [r0], #1
> -		teq	r2, #0
> +1:		teq	r0, #0
> +		ldrneb	r2, [r0], #1
> +		teqne	r2, #0
>  		moveq	pc, lr
> -2:		writeb	r2, r3
> +2:		teq	r2, #'\n'
> +		bne	4f
> +		mov	r2, #'\r'
> +		writeb	r2, r3
>  		mov	r1, #0x00020000
>  3:		subs	r1, r1, #1
>  		bne	3b
> -		teq	r2, #'\n'
> -		moveq	r2, #'\r'
> -		beq	2b
> -		teq	r0, #0
> -		bne	1b
> -		mov	pc, lr
> +		mov	r2, #'\n'
> +4:		writeb	r2, r3
> +		mov	r1, #0x00020000
> +5:		subs	r1, r1, #1
> +		bne	5b
> +		b	1b
> +
>  @ putc corrupts {r0, r1, r2, r3}
>  putc:
>  		mov	r2, r0
> 
> Please review as this is untested.

Looks good from a quick read through, thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
