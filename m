From: will.deacon@arm.com (Will Deacon)
Date: Fri, 25 Feb 2011 11:56:57 +0000
Subject: [PATCH 1/4] msm: scm: Mark inline asm as volatile
In-Reply-To: <1298573085-23217-2-git-send-email-sboyd@codeaurora.org>
References: <1298573085-23217-1-git-send-email-sboyd@codeaurora.org>
	<1298573085-23217-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <1298635017.958.0.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Thu, 2011-02-24 at 18:44 +0000, Stephen Boyd wrote:
> We don't want the compiler to remove these asm statements or
> reorder them in any way. Mark them as volatile to be sure.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/arm/mach-msm/scm.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-msm/scm.c b/arch/arm/mach-msm/scm.c
> index f4b9bc9..ba57b5a 100644
> --- a/arch/arm/mach-msm/scm.c
> +++ b/arch/arm/mach-msm/scm.c
> @@ -174,7 +174,7 @@ static u32 smc(u32 cmd_addr)
>         register u32 r0 asm("r0") = 1;
>         register u32 r1 asm("r1") = (u32)&context_id;
>         register u32 r2 asm("r2") = cmd_addr;
> -       asm(
> +       asm volatile(
>                 __asmeq("%0", "r0")
>                 __asmeq("%1", "r0")
>                 __asmeq("%2", "r1")
> @@ -271,7 +271,7 @@ u32 scm_get_version(void)
>                 return version;
> 
>         mutex_lock(&scm_lock);
> -       asm(
> +       asm volatile(
>                 __asmeq("%0", "r1")
>                 __asmeq("%1", "r0")
>                 __asmeq("%2", "r1")


These asm blocks all have sensible looking output constraints. Why
do they need to be marked volatile?

Will
