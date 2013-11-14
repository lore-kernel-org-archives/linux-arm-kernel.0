From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Thu, 14 Nov 2013 10:20:36 +0900
Subject: [PATCH v2 10/13] kprobes: Remove uneeded kernel dependency
 on struct arch_specific_insn
In-Reply-To: <1381871068-27660-11-git-send-email-dave.long@linaro.org>
References: <1381871068-27660-1-git-send-email-dave.long@linaro.org>
 <1381871068-27660-11-git-send-email-dave.long@linaro.org>
Message-ID: <52842564.4040305@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2013/10/16 6:04), David Long wrote:
> From: "David A. Long" <dave.long@linaro.org>
> 
> Instead of depending on include/asm/kprobes.h to provide a dummy definition
> for struct arch_specific_insn, do so in include/linux/kprobes.h.

Nak, why do we need ugly #ifdef again there?
And also, please cc to the original maintainers.

Thank you,

> 
> Signed-off-by: David A. Long <dave.long@linaro.org>
> ---
>  include/linux/kprobes.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 925eaf2..4b5a74d 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -52,9 +52,6 @@
>  
>  #else /* CONFIG_KPROBES */
>  typedef int kprobe_opcode_t;
> -struct arch_specific_insn {
> -	int dummy;
> -};
>  #endif /* CONFIG_KPROBES */
>  
>  struct kprobe;
> @@ -110,7 +107,11 @@ struct kprobe {
>  	kprobe_opcode_t opcode;
>  
>  	/* copy of the original instruction */
> +#ifdef CONFIG_KPROBES
>  	struct arch_specific_insn ainsn;
> +#else
> +	int ainsn;
> +#endif
>  
>  	/*
>  	 * Indicates various status flags.
> 


-- 
Masami HIRAMATSU
IT Management Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com
