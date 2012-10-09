From: m.olbrich@pengutronix.de (Michael Olbrich)
Date: Tue, 9 Oct 2012 10:52:18 +0200
Subject: Problem with 64-bit registers on i.MX53
In-Reply-To: <20121008171011.GA4625@n2100.arm.linux.org.uk>
References: <20121008160841.GM19651@pengutronix.de>
 <20121008170124.GZ4625@n2100.arm.linux.org.uk>
 <20121008171011.GA4625@n2100.arm.linux.org.uk>
Message-ID: <20121009085218.GO19651@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2012 at 06:10:11PM +0100, Russell King - ARM Linux wrote:
> On Mon, Oct 08, 2012 at 06:01:24PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Oct 08, 2012 at 06:08:41PM +0200, Michael Olbrich wrote:
> > > I have a problem that looks like that 64-bit registers (I think) are not
> > > saved/restored correctly on a context switch. I've reduced it to the
> > > following test case:
> > > 
> > > - Latest Linux mainline kernel (v3.6-8559-ge9eca4d)
> > >   v3.5 is also affected
> > > - imx_v6_v7_defconfig
> > > - arch/arm/boot/dts/imx53-evk.dts
> > > 
> > > The following test program is compiled with "-mcpu=cortex-a8 -mfpu=neon
> > > -O2".
> > > ------------------------>8--------------------------------
> > > #include <inttypes.h>
> > > #include <assert.h>
> > > 
> > > volatile int x = 2;
> > > volatile int64_t y = 2;
> > > 
> > > int main() {
> > > 	volatile int a = 0;
> > > 	volatile int64_t b = 0;
> > > 	while (1) {
> > > 		a = (a + x) % (1 << 30);
> > > 		b = (b + y) % (1 << 30);
> > > 		assert(a == b);
> > > 	}
> > > }
> > > ------------------------>8--------------------------------
> > > The ".. (b + y) .." should result in "vadd.i64 d19, d18, d16" or
> > > something like that.
> > 
> > Hmm.
> > 
> > Can you send me the output of 'grep ^Features /proc/cpuinfo' please?

Features        : swp half thumb fastmult vfp edsp neon vfpv3 tls 

> You may also like to try the patch below... it will probably fix your
> problem.

This does indeed fix my problem. Is this a real fix or just a test to
narrow down the issue? I don't really understand what it does.
If it is a real fix,

Tested-By: Michael Olbrich <m.olbrich@pengutronix.de>

Regards,
Michael

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
>  	addne	\base, \base, #32*4		    @ step over unused register space
>  #else
>  	VFPFMRX	\tmp, MVFR0			    @ Media and VFP Feature Register 0

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
