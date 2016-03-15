From: james.morse@arm.com (James Morse)
Date: Tue, 15 Mar 2016 18:47:52 +0000
Subject: [PATCH v11 3/9] arm64: add copy_to/from_user to kprobes blacklist
In-Reply-To: <1457501543-24197-4-git-send-email-dave.long@linaro.org>
References: <1457501543-24197-1-git-send-email-dave.long@linaro.org>
 <1457501543-24197-4-git-send-email-dave.long@linaro.org>
Message-ID: <56E858D8.8030300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On 09/03/16 05:32, David Long wrote:
> From: "David A. Long" <dave.long@linaro.org>
> diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
> index 4699cd7..0ac2131 100644
> --- a/arch/arm64/lib/copy_from_user.S
> +++ b/arch/arm64/lib/copy_from_user.S
> @@ -66,6 +66,7 @@
>  	.endm
>  
>  end	.req	x5
> +	.section .kprobes.text,"ax",%progbits
>  ENTRY(__copy_from_user)
>  ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN, \
>  	    CONFIG_ARM64_PAN)
> diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
> index 7512bbb..e4eb84c 100644
> --- a/arch/arm64/lib/copy_to_user.S
> +++ b/arch/arm64/lib/copy_to_user.S
> @@ -65,6 +65,7 @@
>  	.endm
>  
>  end	.req	x5
> +	.section .kprobes.text,"ax",%progbits
>  ENTRY(__copy_to_user)
>  ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN, \
>  	    CONFIG_ARM64_PAN)
> 

If I understand this correctly -  you can't kprobe these ldr/str instructions as
the fault handler wouldn't find kprobe's out-of line version of the instruction
in the exception table... but why only these two functions? (for library
functions, we also have clear_user() and copy_in_user()...)

The get_user()/put_user() stuff in uaccess.h gets inlined all over the kernel, I
don't think its feasible to put all of these in a separate section.

Is it feasible to search the exception table at runtime instead? If an
address-to-be-kprobed appears in the list, we know it could generate exceptions,
so we should report that we can't probe this address. That would catch all of
the library functions, all the places uaccess.h was inlined, and anything new
that gets invented in the future.


> Currrently taking exceptions when accessing user data from a kprobe'd

(Nit: Currently)


Thanks,

James
