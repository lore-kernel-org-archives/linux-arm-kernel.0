From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 27 Aug 2015 14:40:05 -0700
Subject: [PATCH 8/9] ARM: entry: provide uaccess assembly macro hooks
In-Reply-To: <E1ZSmQB-0002zT-A6@rmk-PC.arm.linux.org.uk>
References: <20150821133043.GV7557@n2100.arm.linux.org.uk>
 <E1ZSmQB-0002zT-A6@rmk-PC.arm.linux.org.uk>
Message-ID: <20150827214005.GX19120@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/21, Russell King wrote:
> @@ -400,6 +402,10 @@ ENDPROC(__fiq_abt)
>   ARM(	stmdb	r0, {sp, lr}^			)
>   THUMB(	store_user_sp_lr r0, r1, S_SP - S_PC	)
>  
> +	.if \uaccess

This \u seems to trip up my clang build. It seems that the
assembler thinks \u is escaping for unicode or something?

 arch/arm/kernel/entry-armv.S:202:
 Error: non-constant expression in ".if" statement

Looking at the intermediate assembly file I see:

 .if ??ss
 uaccess_disable ip
 .endif

Changing 'uaccess' to 'access' seems to make the problem go away.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
