From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Jul 2010 11:55:08 +0100
Subject: Kernel crashing in tcp_sendmsg()
In-Reply-To: <20100709095329.GA22845@n2100.arm.linux.org.uk>
References: <AANLkTilD3M7d6VFiM9Z-iv7rVyjl7wrjdy9ECh00dfbI@mail.gmail.com>
	<20100709095329.GA22845@n2100.arm.linux.org.uk>
Message-ID: <20100726105508.GA23399@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Fixes generally don't get merged unless they're tested as working.
Can you please report back on whether this patch resolves your issue?

Thanks.

On Fri, Jul 09, 2010 at 10:53:29AM +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 09, 2010 at 11:25:13AM +0200, Bosko Radivojevic wrote:
> > I have Atmel's AT91SAM9260 based system, Linux 2.6.33.4 kernel with
> > applied at91 patch. When the system is on a heavy load it happens
> > quite often to see kernel crashed during web server execution. It
> > seems the problem it is tcp related. I tried two different web servers
> > (thttpd and lighttpd) with the same results. I tried to debug the
> > problem, but without success. Any ideas or hitns how to proceed in
> > this situtation are more than welcome.
> 
> csum_partial_copy_from_user's exception path is broken.  It has this
> function prototype:
> 
> unsigned int csum_partial_copy_from_user(const char *src, char *dst,
>   int len, int sum, int *err_ptr);
> 
> So, r0=src, r1=dst, r2=len, r3=sum, [sp]=err_ptr.
> 
> On function entry, it stacks registers like so:
> 
>                 stmfd   sp!, {r1, r2, r4 - r8, lr}
> 
> On exception:
> 
> 9001:           mov     r4, #-EFAULT
>                 ldr     r5, [fp, #4]            @ *err_ptr
>                 str     r4, [r5]
> 
> This only works if the code is using frame pointers.  This should fix it.
> Please test and provide a Tested-by: line.
> 
> Subject: Fix csum_partial_copy_from_user()
> 
> Using the parent functions frame pointer to access our arguments is
> completely wrong, whether or not we're building with frame pointers
> or not.  What we should be using is the stack pointer to get at the
> word above the registers we stacked ourselves.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/lib/csumpartialcopyuser.S |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/lib/csumpartialcopyuser.S b/arch/arm/lib/csumpartialcopyuser.S
> index 59ff6fd..7d08b43 100644
> --- a/arch/arm/lib/csumpartialcopyuser.S
> +++ b/arch/arm/lib/csumpartialcopyuser.S
> @@ -71,7 +71,7 @@
>  		.pushsection .fixup,"ax"
>  		.align	4
>  9001:		mov	r4, #-EFAULT
> -		ldr	r5, [fp, #4]		@ *err_ptr
> +		ldr	r5, [sp, #8*4]		@ *err_ptr
>  		str	r4, [r5]
>  		ldmia	sp, {r1, r2}		@ retrieve dst, len
>  		add	r2, r2, r1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
