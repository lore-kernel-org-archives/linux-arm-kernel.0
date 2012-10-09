From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 9 Oct 2012 11:02:37 +0200
Subject: Problem with 64-bit registers on i.MX53
In-Reply-To: <20121008171011.GA4625@n2100.arm.linux.org.uk>
References: <20121008160841.GM19651@pengutronix.de>
 <20121008170124.GZ4625@n2100.arm.linux.org.uk>
 <20121008171011.GA4625@n2100.arm.linux.org.uk>
Message-ID: <20121009090237.GI18531@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Oct 08, 2012 at 06:10:11PM +0100, Russell King - ARM Linux wrote:
> On Mon, Oct 08, 2012 at 06:01:24PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Oct 08, 2012 at 06:08:41PM +0200, Michael Olbrich wrote:
> You may also like to try the patch below... it will probably fix your
> problem.
> 
> diff --git a/arch/arm/include/asm/vfpmacros.h b/arch/arm/include/asm/vfpmacros.h
> index a7aadbd..6a6f1e4 100644
> --- a/arch/arm/include/asm/vfpmacros.h
> +++ b/arch/arm/include/asm/vfpmacros.h
> @@ -28,7 +28,7 @@
>  	ldr	\tmp, =elf_hwcap		    @ may not have MVFR regs
>  	ldr	\tmp, [\tmp, #0]
>  	tst	\tmp, #HWCAP_VFPv3D16
> -	ldceq	p11, cr0, [\base],#32*4		    @ FLDMIAD \base!, {d16-d31}
> +	ldceql	p11, cr0, [\base],#32*4		    @ FLDMIAD \base!, {d16-d31}
>  	addne	\base, \base, #32*4		    @ step over unused register space
>  #else
>  	VFPFMRX	\tmp, MVFR0			    @ Media and VFP Feature Register 0
> @@ -52,7 +52,7 @@
>  	ldr	\tmp, =elf_hwcap		    @ may not have MVFR regs
>  	ldr	\tmp, [\tmp, #0]
>  	tst	\tmp, #HWCAP_VFPv3D16
> -	stceq	p11, cr0, [\base],#32*4		    @ FSTMIAD \base!, {d16-d31}
> +	stceql	p11, cr0, [\base],#32*4		    @ FSTMIAD \base!, {d16-d31}
According to the ARMARM for v7-A and v7-R (ARM DDI 0406B errata 2010 Q2)
the syntax is "STC{L}<c> ...", with a note "The pre-UAL syntax STC<c>L
is equivalent to STCL<c>.". Maybe the UAL-syntax should better be used?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
