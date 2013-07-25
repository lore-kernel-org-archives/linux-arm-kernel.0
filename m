From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Jul 2013 10:54:26 +0100
Subject: [PATCH 13/14] ARM: module: correctly relocate instructions in BE8
In-Reply-To: <1374661682-9349-14-git-send-email-ben.dooks@codethink.co.uk>
References: <1374661682-9349-1-git-send-email-ben.dooks@codethink.co.uk>
 <1374661682-9349-14-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130725095425.GF27613@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 11:28:01AM +0100, Ben Dooks wrote:
> When in BE8 mode, our instructions are not in the same ordering as the
> data, so use <asm/opcodes.h> to take this into account.
> 
> Note, also requires modules to be built --be8

This seems fairly methodical to me.

> @@ -132,7 +136,7 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
>  
>  		case R_ARM_MOVW_ABS_NC:
>  		case R_ARM_MOVT_ABS:
> -			offset = *(u32 *)loc;
> +			offset = tmp = __mem_to_opcode_arm(*(u32 *)loc);
>  			offset = ((offset & 0xf0000) >> 4) | (offset & 0xfff);
>  			offset = (offset ^ 0x8000) - 0x8000;

I find the double assignment a bit gratuitous, but that's just a cosmetic
issue.

  Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
