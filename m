From: will.deacon@arm.com (Will Deacon)
Date: Fri, 8 Nov 2013 09:40:18 +0000
Subject: [PATCH] ARM: kexec: Use the right ISA for relocate_new_kernel
In-Reply-To: <1383857496-32672-1-git-send-email-Dave.Martin@arm.com>
References: <1383857496-32672-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20131108094017.GA17461@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On Thu, Nov 07, 2013 at 08:51:36PM +0000, Dave Martin wrote:
> Copying a function with memcpy() and then trying to execute the
> result isn't trivially portable to Thumb.
> 
> This patch modifies the kexec soft restart code to copy its
> assembler trampoline relocate_new_kernel() using fncpy() instead,
> so that relocate_new_kernel can be in the same ISA as the rest of
> the kernel without problems.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

[...]

> @@ -168,16 +171,16 @@ void machine_kexec(struct kimage *image)
>  
>  
>  	/* copy our kernel relocation code to the control code page */
> -	memcpy(reboot_code_buffer,
> -	       relocate_new_kernel, relocate_new_kernel_size);
> +	reboot_entry = fncpy(reboot_code_buffer,
> +			     reboot_entry,
> +			     relocate_new_kernel_size);

My only slight gripe with this is that relocate_new_kernel_size also
includes a bunch of data following the function (which you have now delimited
with ENTRY/ENDPROC), so using fncpy for that feels a bit awkward.

Will
