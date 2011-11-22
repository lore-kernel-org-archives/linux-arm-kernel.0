From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 22 Nov 2011 12:02:52 +0000
Subject: [PATCH 2/4] ARM: extract out insn generation code from ftrace
In-Reply-To: <1321888429-3519-2-git-send-email-rabin@rab.in>
References: <1321888429-3519-1-git-send-email-rabin@rab.in>
 <1321888429-3519-2-git-send-email-rabin@rab.in>
Message-ID: <20111122120252.GE2066@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2011 at 08:43:47PM +0530, Rabin Vincent wrote:
> Extract out the instruction generation code so that it can be used
> for jump labels too.
> 
> Signed-off-by: Rabin Vincent <rabin@rab.in>
> ---
>  arch/arm/kernel/Makefile |    5 ++-
>  arch/arm/kernel/ftrace.c |   61 +++-------------------------------------------
>  arch/arm/kernel/insn.c   |   60 +++++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/kernel/insn.h   |   19 ++++++++++++++
>  4 files changed, 86 insertions(+), 59 deletions(-)
>  create mode 100644 arch/arm/kernel/insn.c
>  create mode 100644 arch/arm/kernel/insn.h
> 
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile

[...]

>  static int ftrace_modify_code(unsigned long pc, unsigned long old,
> @@ -256,7 +203,7 @@ static int __ftrace_modify_caller(unsigned long *callsite,
>  {
>  	unsigned long caller_fn = (unsigned long) func;
>  	unsigned long pc = (unsigned long) callsite;
> -	unsigned long branch = ftrace_gen_branch(pc, caller_fn, false);
> +	unsigned long branch = arm_gen_branch(pc, caller_fn);
>  	unsigned long nop = 0xe1a00000;	/* mov r0, r0 */

Does this code get used in Thumb-2 kernels?  So far as I can tell, this
code is used... but it looks like it shouldn't work, due to the ARM
specifics.

Cheers
---Dave
