From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 24 Feb 2011 22:32:06 +0300
Subject: [PATCH 4/4] msm: scm: Get cacheline size from CTR
In-Reply-To: <1298573085-23217-5-git-send-email-sboyd@codeaurora.org>
References: <1298573085-23217-1-git-send-email-sboyd@codeaurora.org>
	<1298573085-23217-5-git-send-email-sboyd@codeaurora.org>
Message-ID: <4D66B236.4030003@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Stephen Boyd wrote:

> Instead of hardcoding the cacheline size as 32, get the cacheline
> size from the CTR register.

> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/arm/mach-msm/scm.c |   17 ++++++++++++-----
>  1 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-msm/scm.c b/arch/arm/mach-msm/scm.c
> index cfa808d..0528c71 100644
> --- a/arch/arm/mach-msm/scm.c
> +++ b/arch/arm/mach-msm/scm.c
[...]
> @@ -207,6 +204,14 @@ static int __scm_call(const struct scm_command *cmd)
>  	return ret;
>  }
>  
> +static inline u32 dcache_line_size(void)
> +{
> +	u32 ctr;
> +
> +	asm volatile("mrc p15, 0, %0, c0, c0, 1" : "=r" (ctr));
> +	return 4 << ((ctr >> 16) & 0xf);
> +}

    Won't generic cache_line_size() macro do instead? It's defined as 
L1_CACHE_BYTES.

WBR, Sergei
