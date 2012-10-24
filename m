From: hechtb@googlemail.com (Bastian Hecht)
Date: Wed, 24 Oct 2012 17:04:46 +0200
Subject: Possible regression in arm/io.h
In-Reply-To: <20121024135854.GD7339@mudshark.cambridge.arm.com>
References: <CABYn4syj0GZAsDYVQfXg_qKAFkbrxPLoZWpKRzwf3gfRkMGZkQ@mail.gmail.com>
 <20121024105223.GC23775@mudshark.cambridge.arm.com>
 <CABYn4swp9JBEHgGTOkoe=tOh3Mf1dq5WYr=2xuKNpTmLX5LcFQ@mail.gmail.com>
 <20121024130957.GB7339@mudshark.cambridge.arm.com>
 <CABYn4sz4v7Uf07am=MtPAKAvvAjwt+-bTRaLrBjoiRuyR9cfZw@mail.gmail.com>
 <20121024135854.GD7339@mudshark.cambridge.arm.com>
Message-ID: <CABYn4sxnwzj8KFfELzCLzQMcAjiqS3_Vr2kStkm-na8G1noPHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> > Ok, I'll have a look at the impact of moving exclusively to "Q" when I get a
>> > chance. Which toolchain are you using?
>>
>> gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5)
>> For a more verbose info take a look at the bug report link.
>
> Ok, thanks. One other thing you could try while I try to find a copy of that
> toolchain is changing the "+" modifier to an "=", like I proposed in this
> version of the patch:

So if alter it to fit to your patch scheme the result is:

  CC      arch/arm/kernel/asm-offsets.s
In file included from include/linux/scatterlist.h:10,
                 from include/linux/dma-mapping.h:9,
                 from arch/arm/kernel/asm-offsets.c:15:
/home/basti/renesas/flctl_patch/arch/arm/include/asm/io.h: In function
'__raw_readb':
/home/basti/renesas/flctl_patch/arch/arm/include/asm/io.h:100: error:
output operand constraint lacks '='
/home/basti/renesas/flctl_patch/arch/arm/include/asm/io.h:98: error:
output operand constraint lacks '='
/home/basti/renesas/flctl_patch/arch/arm/include/asm/io.h:98: error:
invalid lvalue in asm output 0
/home/basti/renesas/flctl_patch/arch/arm/include/asm/io.h: In function
'__raw_readl':
/home/basti/renesas/flctl_patch/arch/arm/include/asm/io.h:109: error:
output operand constraint lacks '='
/home/basti/renesas/flctl_patch/arch/arm/include/asm/io.h:107: error:
output operand constraint lacks '='
/home/basti/renesas/flctl_patch/arch/arm/include/asm/io.h:107: error:
invalid lvalue in asm output 0

and if I just replace all +Q with =Q it's this:
  LD      kernel/time/built-in.o
drivers/sh/intc/access.c: In function 'test_8':
drivers/sh/intc/access.c:78: warning: passing argument 1 of
'__raw_readb' makes pointer from integer without a cast
/home/basti/renesas/flctl_patch/arch/arm/include/asm/io.h:95: note:
expected 'const volatile void *' but argument is of type 'long
unsigned int'
drivers/sh/intc/access.c: In function 'test_16':
drivers/sh/intc/access.c:84: warning: passing argument 1 of
'__raw_readw' makes pointer from integer without a cast
/home/basti/renesas/flctl_patch/arch/arm/include/asm/io.h:71: note:
expected 'const volatile void *' but argument is of type 'long
unsigned int'
drivers/sh/intc/access.c: In function 'test_32':
drivers/sh/intc/access.c:90: warning: passing argument 1 of
'__raw_readl' makes pointer from integer without a cast
/home/basti/renesas/flctl_patch/arch/arm/include/asm/io.h:104: note:
expected 'const volatile void *' but argument is of type 'long
unsigned int'
drivers/sh/intc/access.c: In function 'write_8':
drivers/sh/intc/access.c:96: warning: passing argument 2 of
'__raw_writeb' makes pointer from integer without a cast
/home/basti/renesas/flctl_patch/arch/arm/include/asm/io.h:81: note:
expected 'volatile void *' but argument is of type 'long unsigned int'
... and so on

cheers,

 Bastian
