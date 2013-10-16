From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Wed, 16 Oct 2013 23:47:04 +0300
Subject: .align may cause data to be interpreted as instructions
In-Reply-To: <20131016192512.GB21726@localhost.localdomain>
References: <20131016192512.GB21726@localhost.localdomain>
Message-ID: <525EFB48.40002@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16/2013 10:25 PM, Dave Martin wrote:
> Unfortunately, objdump can and does get confused about data/instruction
> boundaries, so the output you see above may be misleading.
> 
> Displaying the symbol table with --special-syms will list the magic
> symbols that mark the instruction and data boundaries, to help debug
> this kind of situation.
> 
> 
> However, in this case, I think you've found a bug in the assembler,
> as shown below.
> 
> Before linking, the final $a symbol (indicating the start of ARM
> instructions) is at address 8, so in this case objdump is correct
> to show 0x12345678 as an instruction.
> 
> After linking, the mapping symbols ($[atd]) remain as before, and
> the linker has byteswapped this "instruction" (as it should).
> 
> This is likely related to the magic for inserting the extensible
> NOP-padding fragment which implements the .align in code sections.
> That is code, and requires a $a mapping symbol, but that somehow
> goes AWOL or gets displaced after the alignment padding ...
> 
> I can't quite get my head around what is going on in
> binutils/gas/config/tc-arm.c.  We would need to understand that
> before we can identify a reliable workaround.

Thanks for confirming the issue.
Does it makes sense to file a GCC bug?
