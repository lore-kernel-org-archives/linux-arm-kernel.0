From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Aug 2013 09:36:22 +0100
Subject: Kexec: BE kernel on ARM VE TC2
In-Reply-To: <CALicx6u4cOLCzia8oxKKCrC=d+pxJmWWvLH++ZXVkvNVWV65DA@mail.gmail.com>
References: <CALicx6ueLxCFCeun1grdtcC21HSkCDfenLWOSfuoSJnhx9GZ6w@mail.gmail.com>
 <51FFC490.5090907@codethink.co.uk>
 <CALicx6u4cOLCzia8oxKKCrC=d+pxJmWWvLH++ZXVkvNVWV65DA@mail.gmail.com>
Message-ID: <20130808083622.GI23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 08, 2013 at 11:46:03AM +0530, Vijay Kilari wrote:
> Yes, you are right. I see that memcpy() works. However I see strange issue
> with  Kexec on BE kernel. If I put debug print in arch/arm/kernel/head.S code
> before turning on MMU, KEXEC works. if I remove the debug print kexec
> boot hangs.
> So I could not relate how calling printascii is solving the problem
> 
> Any suggestion?
> 
> If printascii is called after turning on mmu, kexec hangs. Below is my
> debug code
> 
> diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
> index 5b391a6..15d4504 100644
> --- a/arch/arm/kernel/head-common.S
> +++ b/arch/arm/kernel/head-common.S
> @@ -175,6 +175,15 @@ __lookup_processor_type_data:
>         .long   __proc_info_end
>         .size   __lookup_processor_type_data, . - __lookup_processor_type_data
> 
> +__print_debug:
> +       stmfd   sp!, {r0 - r6, r9, lr}
> +       adr r0, str_p3
> +       bl printascii
> +       ldmfd   sp!, {r0 - r6, r9, pc}
> +str_p3: .asciz "\nHere"
> +       .align
> +ENDPROC(__print_debug)
> +

This is rather broken.  Who says you have a stack here to store those
registers?  The answer is - you generally won't have a stack.  So this
is going to scribble on whatever memory 'sp' happens to be pointing at
at the time the kernel is entered.

printascii is designed to avoid disrupting as many registers as possible.
It will only modify r0-r3 and of course lr.  I'm sure you can temporarily
move r1/r2 to a different register pair, and move the above inline, and
then move these back.  The comment just after where you place it documents
the 'live' registers.

I'm not saying anything about the problem you're reporting; I'm trying
to teach you how to use the early debug correctly.
