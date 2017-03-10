From: will.deacon@arm.com (Will Deacon)
Date: Fri, 10 Mar 2017 17:52:30 +0000
Subject: [RFC arm64] samples/bpf: explicitly exclude sysreg sections with
 asm macros
In-Reply-To: <1489101492-15653-1-git-send-email-andy@greyhouse.net>
References: <1489101492-15653-1-git-send-email-andy@greyhouse.net>
Message-ID: <20170310175229.GC18894@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On Thu, Mar 09, 2017 at 06:18:12PM -0500, Andy Gospodarek wrote:
> The previous fix to workaround compilation issues for samples/bpf on arm64 was
> to prevent inclusion of code in sysregs.h.  This is not sustainable at this
> point since other header files need access to sysregs.h for multiple
> defintions.  The fact that the bpf samples cannot be compiled on arm64 is
> fairly well documented on the iovisor-dev mailing and other places without a
> clear-cut solution other than waiting for the llvm fix.  This attempts to
> resolve that by dropping the fix to define _ASM_SYSREG_H on the clang command
> line, and replace it with one that is wrapped around the offending code.  I
> recognize this feels a bit fragile, but the current situation is not great
> either and it seems that we are more likely to see users if the current code
> actually compiles and runs.

Why does asm cause compilation to fail?

> Despite now being able to compile and run bpf programs on arm64 there
> are still known warnings when building:
> 
> ./include/net/sock.h:2322:35: warning: value size does not match
> register size specified by the constraint and modifier
> [-Wasm-operand-widths]
>         smp_store_release(&sk->sk_state, newstate);
>                                          ^
> ./include/net/sock.h:2322:2: note: use constraint modifier "w"
>         smp_store_release(&sk->sk_state, newstate);
>         ^
> ./include/asm-generic/barrier.h:157:33: note: expanded from macro
>                                 ^
> ./arch/arm64/include/asm/barrier.h:62:23: note: expanded from macro
> '__smp_store_release'
>                 asm volatile ("stlr %1, %0"                     \

I don't think this is relevant to the message for this commit.

> Discussed here: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63359
> 
> Fixes: 30b50aa61201 ("bpf: samples: exclude asm/sysreg.h for arm64")
> Signed-off-by: Andy Gospodarek <gospo@broadcom.com>
> ---
>  arch/arm64/include/asm/sysreg.h | 3 ++-
>  samples/bpf/Makefile            | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index ac24b6e..91ee2db 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -287,6 +287,7 @@
>  #else
>  
>  #include <linux/types.h>
> +#ifndef __AVOID_ASM_MACROS__

Yeah, this is pretty horrible. It would prefer to have a script that
generates the header files needed by clang, without adding these ifdefs
whenever something new fails to compile, but I don't understand why things
are failing at all at the moment.

Will
