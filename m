From: ldv@altlinux.org (Dmitry V. Levin)
Date: Thu, 12 Apr 2018 20:35:58 +0300
Subject: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via
 kill() returns wrong values in si_pid and si_uid
In-Reply-To: <CA+55aFxdg2bYHtbKXb4mT5UuP2GH_qjkc=WeZY-RYHWZFQ2Gng@mail.gmail.com>
References: <20180409152253.GD10489@altlinux.org>
 <20180412013435.GA21219@altlinux.org>
 <20180412095811.GC16141@n2100.armlinux.org.uk>
 <20180412110314.GA28070@altlinux.org>
 <20180412121949.GD16141@n2100.armlinux.org.uk>
 <20180412124928.GA29458@altlinux.org>
 <20180412131404.GE16141@n2100.armlinux.org.uk>
 <CA+55aFxdg2bYHtbKXb4mT5UuP2GH_qjkc=WeZY-RYHWZFQ2Gng@mail.gmail.com>
Message-ID: <20180412173558.GB31781@altlinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2018 at 09:50:26AM -0700, Linus Torvalds wrote:
> Does this attached patch perhaps fix the ARM case?
> 
> It just uses FPE_FLTUNK as the default si_code for SIGFPE, which seems
> sane enough. And then gets rid of FPE_FIXME, which should resolve the
> nasty case.
> 
> Hmm? Entirely untested, and I didn't really look at the test-case in
> question since I can't really run it anyway.
> 
> Well, I could run it all on x86-64, but it doesn't have that FPE_FIXME
> case at all.
> 
>                  Linus

>  arch/arm/include/uapi/asm/siginfo.h | 7 -------
>  arch/arm/vfp/vfpmodule.c            | 4 ++--
>  2 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/include/uapi/asm/siginfo.h b/arch/arm/include/uapi/asm/siginfo.h
> index d0513880be21..d87beeedb4c4 100644
> --- a/arch/arm/include/uapi/asm/siginfo.h
> +++ b/arch/arm/include/uapi/asm/siginfo.h
> @@ -3,11 +3,4 @@
>  
>  #include <asm-generic/siginfo.h>
>  
> -/*
> - * SIGFPE si_codes
> - */
> -#ifdef __KERNEL__
> -#define FPE_FIXME	0	/* Broken dup of SI_USER */
> -#endif /* __KERNEL__ */
> -
>  #endif

Looks like the whole file should go away.

> diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> index 4c375e11ae95..012c6e690303 100644
> --- a/arch/arm/vfp/vfpmodule.c
> +++ b/arch/arm/vfp/vfpmodule.c
> @@ -251,13 +251,13 @@ static void vfp_panic(char *reason, u32 inst)
>   */
>  static void vfp_raise_exceptions(u32 exceptions, u32 inst, u32 fpscr, struct pt_regs *regs)
>  {
> -	int si_code = 0;
> +	int si_code = FPE_FLTUNK;

Note that this change would affect the following code
at the end of vfp_raise_exceptions:

	if (si_code)
		vfp_raise_sigfpe(si_code, regs);

>  	pr_debug("VFP: raising exceptions %08x\n", exceptions);
>  
>  	if (exceptions == VFP_EXCEPTION_ERROR) {
>  		vfp_panic("unhandled bounce", inst);
> -		vfp_raise_sigfpe(FPE_FIXME, regs);
> +		vfp_raise_sigfpe(si_code, regs);
>  		return;
>  	}
>  

To be on the safe side, I'd just change it this way:

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 4c375e1..66a73ba 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -257,7 +257,7 @@ static void vfp_raise_exceptions(u32 exceptions, u32 inst, u32 fpscr, struct pt_
 
 	if (exceptions == VFP_EXCEPTION_ERROR) {
 		vfp_panic("unhandled bounce", inst);
-		vfp_raise_sigfpe(FPE_FIXME, regs);
+		vfp_raise_sigfpe(FPE_FLTUNK, regs);
 		return;
 	}

-- 
ldv
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180412/8a5a5062/attachment.sig>
