From: kyle@redhat.com (Kyle McMartin)
Date: Fri, 17 Jan 2014 11:22:52 -0500
Subject: [PATCH] arm64: fix strnlen_user when count <= strlen
In-Reply-To: <20140117105107.GC16003@mudshark.cambridge.arm.com>
References: <20140116234817.GP18705@redacted.bos.redhat.com>
 <20140117105107.GC16003@mudshark.cambridge.arm.com>
Message-ID: <20140117162252.GR18705@redacted.bos.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 10:51:07AM +0000, Will Deacon wrote:
> Actually, I have removed strnlen_user for 3.14. Could you try your test case
> with our for-next branch please?
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> 

This will work fine, I believe (I can't easily test on HW since we're
dependent on $vendor drivers that aren't upstream yet) but in my testing
yesterday I parroted the x86 word-at-a-time.h and lib/strnlen_user.c and
that seemed to work.

> As for the issue you spotted, we probably need a fix for that to go into
> stable kernels. Does the following (smaller patch) work for you?
> 

This gets the count == 0 case wrong still, I believe.

=== count = 0 ===
strnlen_user = 0
__strnlen_user = 1

(Where strnlen_user is the lib/strnlen_user.c implementation.)

Testing if (n <= 0) return 0; before __strnlen_user fixes it though.

Given this is called in, I think, only two places in the kernel, maybe
we should just backport the switch to generic for stable? I can't
imagine it conflicting with anything.

regards, Kyle

> Will
> 
> --->8
> 
> diff --git a/arch/arm64/lib/strnlen_user.S b/arch/arm64/lib/strnlen_user.S
> index 7f7b176a5646..73f3335a2a45 100644
> --- a/arch/arm64/lib/strnlen_user.S
> +++ b/arch/arm64/lib/strnlen_user.S
> @@ -37,6 +37,7 @@ ENTRY(__strnlen_user)
>  USER(9f, ldrb	w3, [x0], #1	)
>  	cbnz	w3, 1b
>  2:	sub	x0, x0, x2
> +	cinc	x0, x0, mi
>  	ret
>  ENDPROC(__strnlen_user)
>  
