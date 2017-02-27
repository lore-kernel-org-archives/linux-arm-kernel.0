From: ddaney@caviumnetworks.com (David Daney)
Date: Mon, 27 Feb 2017 10:57:03 -0800
Subject: [PATCH] jump_label: align jump_entry table to at least 4-bytes
In-Reply-To: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
Message-ID: <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2017 10:49 AM, Jason Baron wrote:
> The core jump_label code makes use of the 2 lower bits of the
> static_key::[type|entries|next] field. Thus, ensure that the jump_entry
> table is at least 4-byte aligned.
>
[...]
> diff --git a/arch/mips/include/asm/jump_label.h b/arch/mips/include/asm/jump_label.h
> index e77672539e8e..243791f3ae71 100644
> --- a/arch/mips/include/asm/jump_label.h
> +++ b/arch/mips/include/asm/jump_label.h
> @@ -31,6 +31,7 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
>  	asm_volatile_goto("1:\t" NOP_INSN "\n\t"
>  		"nop\n\t"
>  		".pushsection __jump_table,  \"aw\"\n\t"
> +		".balign 4\n\t"
>  		WORD_INSN " 1b, %l[l_yes], %0\n\t"
>  		".popsection\n\t"
>  		: :  "i" (&((char *)key)[branch]) : : l_yes);
> @@ -45,6 +46,7 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
>  	asm_volatile_goto("1:\tj %l[l_yes]\n\t"
>  		"nop\n\t"
>  		".pushsection __jump_table,  \"aw\"\n\t"
> +		".balign 4\n\t"
>  		WORD_INSN " 1b, %l[l_yes], %0\n\t"
>  		".popsection\n\t"
>  		: :  "i" (&((char *)key)[branch]) : : l_yes);


I will speak only for the MIPS part.

If the section is not already properly aligned, this change will add 
padding, which is probably not what we want.

Have you ever seen a problem with misalignment in the real world?

If so, I think a better approach might be to set properties on the 
__jump_table section to force the proper alignment, or do something in 
the linker script.

David Daney
