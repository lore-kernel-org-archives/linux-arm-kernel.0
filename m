From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 28 Dec 2016 09:04:07 +0100
Subject: [PATCH] arm64: Do not include linux/uaccess.h from assembler files
In-Reply-To: <1482748268-10399-1-git-send-email-linux@roeck-us.net>
References: <1482748268-10399-1-git-send-email-linux@roeck-us.net>
Message-ID: <20161228090407.515543df@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 26 Dec 2016 02:31:08 -0800, Guenter Roeck wrote:
> Including linux/uaccess.h from assembler files in arm64 builds results
> in the following build errors.
> 
> In file included from arm64/include/asm/asm-offsets.h:1:0,
>                  from arch/arm64/include/asm/assembler.h:26,
> 		 from arch/arm64/include/asm/alternative.h:68,
> 		 from arch/arm64/kernel/entry.S
> 
> include/linux/sched/prio.h: Assembler messages:
> include/linux/sched/prio.h:47: Error:
> 	unknown mnemonic `static' --
> 		`static inline long nice_to_rlimit(long nice)'
> build/include/linux/sched/prio.h:48: Error:
> 	junk at end of line, first unrecognized character is `{'
> 
> [and many more]
> 
> If asm/uaccess.h is not included, many of the affected files fail to build
> with errors such as the following.
> 
> arch/arm64/lib/copy_to_user.S: Assembler messages:
> arch/arm64/lib/copy_to_user.S:66: Error:
> 	unknown mnemonic `uaccess_enable_not_uao' --
> 		`uaccess_enable_not_uao x3,x4'
> arch/arm64/lib/copy_template.S:71: Error:
> 	unknown mnemonic `uao_user_alternative' --
> 		`uao_user_alternative 9998f,strb,st trb,tmp1w,dst,#1'
> 
> Either drop the include if unnecessary or, if needed, replace with
> asm/uaccess.h.
> 
> Fixes: 7c0f6ba682b9 ("Replace <asm/uaccess.h> with <linux/uaccess.h> globally")
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
 (fixes the arm64 build, result boot tested on real HW)

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
