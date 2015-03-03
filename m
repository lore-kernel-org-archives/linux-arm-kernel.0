From: puck.chen@hisilicon.com (chenfeng)
Date: Tue, 3 Mar 2015 11:49:31 +0800
Subject: Alignment issue with ldmia
Message-ID: <54F52F4B.3060402@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is an alignment issue with ldmia in A32 user-space with A64 
Kernel. Since the famous taobao apk use this instruction, so we want to 
emulate this to make it work well.

I make a simple test case to reproduce this issue.
-----------------------------------------------------------------------
#include <stdio.h>
#include <stdlib.h>

int main()
{
         char src_addr[1024];
         char dst_addr[1024];
         printf("--------%lx %lx\n",src_addr,dst_addr);
         unsigned long src_reg = (unsigned long)src_addr | 1;
         unsigned long dst_reg = (unsigned long)dst_addr | 1;
         printf("--------%lx %lx\n",src_reg,dst_reg);
         asm volatile("mov  r1, %0\n": : "r" (src_reg));
         asm volatile("mov  r2, %0\n": : "r" (dst_reg));
         asm volatile("ldmia r1!,{r2}");
         printf("--------------------------\n");

         return 0;
}
------------------------------------------------------------------------

I use the test case on A32 kernel with A32 user-space. It works 
well,becase of that is a do_alignment_ldmstm emulate in 
arch/arm/mm/alignment.c

So, I want to porting the code to arch/arm64.

The first step is getting the machine code of the unalignment 
instruction. However I have no idea how to do this.

There is a commit on google master L branch to emulate the undef 
instruction. I use these code for getting the instruction of unalignment
case. But I found the code in arch/arm/alignment.c get the instruction 
is 0xe8b10004 and the code in arch/arm64/kernel/traps.c is different.


Since I arm not professional for the code, I am writting for asking is 
there a way to get the thumb instruction when traps in kernel mode.
