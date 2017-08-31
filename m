From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 31 Aug 2017 12:23:28 +0200
Subject: [PATCH] arm64: relax assembly code alignment from 16 byte to 4
 byte
In-Reply-To: <1504173383-8367-1-git-send-email-yamada.masahiro@socionext.com>
References: <1504173383-8367-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20170831122328.2334a4de@karo-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 31 Aug 2017 18:56:23 +0900 Masahiro Yamada wrote:
> Aarch64 instructions must be word aligned.  The current 16 byte
> alignment is more than enough.  Relax it into 4 byte alignment.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> I do not know why arm64 Linux requires 16 byte alignment.
> 
> I dug git-history of arch/arm64/include/asm/linkage.h
> and the only commit I see is:
> 
>   commit aeed41a9371ee02257b608eb06a9058507a7d0f4
>   Author: Marc Zyngier <Marc.Zyngier@arm.com>
>   Date:   Fri Oct 19 17:33:27 2012 +0100
> 
>       arm64: fix alignment padding in assembly code
> 
> It just opt out of the asm-generic variant to remove 0x90.
> So, the amount of alignment might not be not optimized yet.
> 
> Please correct me if I am missing something.
> 
> 
>  arch/arm64/include/asm/linkage.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/linkage.h b/arch/arm64/include/asm/linkage.h
> index 636c1bc..1b26629 100644
> --- a/arch/arm64/include/asm/linkage.h
> +++ b/arch/arm64/include/asm/linkage.h
> @@ -1,7 +1,7 @@
>  #ifndef __ASM_LINKAGE_H
>  #define __ASM_LINKAGE_H
>  
> -#define __ALIGN		.align 4
> -#define __ALIGN_STR	".align 4"
> +#define __ALIGN		.align 2
> +#define __ALIGN_STR	".align 2"
>  
>  #endif
>
My math tells me, that 2 is one half of 4 but 4 is one fourth of 16, so
this change doesn't line up with your commit message, or am I missing
something?


Lothar Wa?mann
