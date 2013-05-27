From: gang.chen@asianux.com (Chen Gang)
Date: Mon, 27 May 2013 09:42:27 +0800
Subject: [PATCH] arch: arm64: kernel: sprintf(), 'str' needs additional
 1 byte for failure processing
In-Reply-To: <51A1E3B3.4060901@asianux.com>
References: <51A1E3B3.4060901@asianux.com>
Message-ID: <51A2BA03.4030006@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/26/2013 06:28 PM, Chen Gang wrote:
> 
> When failure occurs at the last looping cycle (when 'i == 0'), it will
> print "bad PC value" instead of "(%08x) ", which needs additional 1
> byte.
> 
> If not add 1 byte, the str will not be NUL terminated, and the next
> printk() will cause issue.
> 

Oh, I type incorrect contents. It should be "If not add 1 byte, it will
memory overflow"

I will send patch v2.

> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm64/kernel/traps.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 61d7dd2..c2f68d2 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -100,7 +100,7 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
>  {
>  	unsigned long addr = instruction_pointer(regs);
>  	mm_segment_t fs;
> -	char str[sizeof("00000000 ") * 5 + 2 + 1], *p = str;
> +	char str[sizeof("00000000 ") * 5 + 2 + 1 + 1], *p = str;
>  	int i;
>  
>  	/*
> 


-- 
Chen Gang

Asianux Corporation
