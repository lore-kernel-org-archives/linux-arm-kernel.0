From: anish198519851985@gmail.com (anish kumar)
Date: Thu, 17 Mar 2011 23:57:24 +0900
Subject: Questions about this patch: [PATCH] ARM: Use generic BUG() handler
References: <1300307259-834-1-git-send-email-sjg@chromium.org>
Message-ID: <92C2E94F6F494872A3D66D05E1AB76B7@your6c359a3bdc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

https://lkml.org/lkml/2011/2/28/565

I have tested this patch on my system(linux 2.6.35-android) and it is 
working
perfectly fine so wanted to understand this patch.Will this patch be 
included in
mainline?

I have few question from this thread.As my understanding of assembly is
bit limited I would appreciate if someone can just say yes/no and probably 
add
bit of words.

> This implementation uses an undefined instruction to implement BUG, and 
> sets up
> a bug table containing the relevant information. Many version of gcc do 
> not
> support %c properly for ARM (inserting a # when they shouldn't) so we work
> around this using distasteful macro magic.

This undefined instruction should cause data abort ?


> +#define BUG() _BUG(__FILE__, __LINE__, BUG_INSTR_VALUE)
> +#define _BUG(file, line, value) __BUG(file, line, value)
> +#define __BUG(__file, __line, __value) \
> +do { \
> + BUILD_BUG_ON(sizeof(struct bug_entry) != 12); \
> + asm volatile("1:\t" BUG_INSTR_TYPE #__value "\n" \
> + ".pushsection .rodata.str, \"aMS\", 1\n" \
> + "2:\t.asciz " #__file "\n" \
> + ".popsection\n" \
> + ".pushsection __bug_table,\"a\"\n" \
> + "3:\t.word 1b, 2b\n" \
> + "\t.hword " #__line ", 0\n" \
> + ".popsection"); \
> + unreachable(); \
> +} while (0)

Above piece of code i couldn't understand.As i understand this should do 
same as
original BUG() definition plus it should print the function where BUG() had 
originally
happened instead of "PC at _bug".I think in this code some 
data(guess:function name
,line no) is pushed on the stack and then popped but how this data is 
printed on console?

So kindly enlighten me on this piece of code or some pointers.Is there any 
thread which
explains about kernel fault process? 
