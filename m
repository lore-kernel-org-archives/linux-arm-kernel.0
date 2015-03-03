From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 3 Mar 2015 12:36:57 +0000
Subject: Alignment issue with ldmia
In-Reply-To: <54F52F4B.3060402@hisilicon.com>
References: <54F52F4B.3060402@hisilicon.com>
Message-ID: <20150303123638.GA5177@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 03, 2015 at 11:49:31AM +0800, chenfeng wrote:
> There is an alignment issue with ldmia in A32 user-space with A64
> Kernel. Since the famous taobao apk use this instruction, so we want

You're exactly right, there is an issue _in userspace_.
If userspace code is triggering an alignment fault, userspace (or
the compiler used for building userspace) must be buggy.

Have you identified _why_ a misaligned LDM is happening?


arch/arm/ contains fixup code for emulating some unaligned accesses, 
but it is only there for historical reasons.  No modern software
should rely on it.

Since compat on arm64 is not supposed to be a 100%-accurate emulation of
arch/arm/, we should not pull in things like misalignment fixup code
unless there is a really compelling reason...

Cheers
---Dave

> to emulate this to make it work well.
> 
> I make a simple test case to reproduce this issue.
> -----------------------------------------------------------------------
> #include <stdio.h>
> #include <stdlib.h>
> 
> int main()
> {
>         char src_addr[1024];
>         char dst_addr[1024];
>         printf("--------%lx %lx\n",src_addr,dst_addr);
>         unsigned long src_reg = (unsigned long)src_addr | 1;
>         unsigned long dst_reg = (unsigned long)dst_addr | 1;
>         printf("--------%lx %lx\n",src_reg,dst_reg);
>         asm volatile("mov  r1, %0\n": : "r" (src_reg));
>         asm volatile("mov  r2, %0\n": : "r" (dst_reg));
>         asm volatile("ldmia r1!,{r2}");
>         printf("--------------------------\n");

This will trigger an alignment fault -- but this does not mean that
userspace should expect this code sequence to work.


Cheers
---Dave

> 
>         return 0;
> }
> ------------------------------------------------------------------------
> 
> I use the test case on A32 kernel with A32 user-space. It works
> well,becase of that is a do_alignment_ldmstm emulate in
> arch/arm/mm/alignment.c
> 
> So, I want to porting the code to arch/arm64.
> 
> The first step is getting the machine code of the unalignment
> instruction. However I have no idea how to do this.
> 
> There is a commit on google master L branch to emulate the undef
> instruction. I use these code for getting the instruction of
> unalignment
> case. But I found the code in arch/arm/alignment.c get the
> instruction is 0xe8b10004 and the code in arch/arm64/kernel/traps.c
> is different.
> 
> 
> Since I arm not professional for the code, I am writting for asking
> is there a way to get the thumb instruction when traps in kernel
> mode.
> 
> 
> 
> 
> 
> 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
