From: lsanfil@marvell.com (sanfilippo)
Date: Wed, 4 Mar 2015 12:40:34 +0100
Subject: [RFC PATCH 0/1] Wrong structure alignment due to compiler
 attribute "section"
In-Reply-To: <20150303144130.GB5177@e103592.cambridge.arm.com>
References: <1425290502-2322-1-git-send-email-lsanfil@marvell.com>
 <20150303144130.GB5177@e103592.cambridge.arm.com>
Message-ID: <54F6EF32.7080306@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03.03.2015 15:41, Dave Martin wrote:

Dave,

thanks for your response.

> For the element _size_ issue, I'm confused.  On 32-bit, that
> structure is clearly 196 bytes in size, with the alignment requirement
> of void * (4 bytes)... so there's no clear reason why the linker
> shouldn't be inserting extra padding.
>
> I can't reproduce this with my current tools (upstream binutils-2.24,
> gcc-4.9.2).
>
>
> Can you try to track down where this discrepancy is coming from?
>
> i.e.,
>
>   * If you're juggling with multiple kernel trees, make sure there
>     are not differences between them that could be causing this, such
>     as changes to linker scripts or header files that are involved
>     in building these arrays.

I can reproduce this with a vanilla kernel (3.19) from kernel.org. What 
I do is:

- configure the kernel with mvebu_v5_defconfig
- compile it

However this issue occurs (so far) only with this special toolchain:
http://www.plugcomputer.org/405/us/gplugd/tool-chain/arm-marvell-linux-gnueabi.tar.bz2

If you like you can try this yourself. I am sure that you will get the 
same results.

I tried the same with three other toolchains but with those the problem 
did not occur. I also tried other kernel configurations with that 
"problematic" toolchain, but also the problem did not occur any more.

So I think its either a bug in that compiler/linker or the current 
solution in vmlinux.lds.h does not work correct under some special 
circumstances.

>
>   * See what the input to the assembler looks like, with regard to
>     .align directives.
>
>   * See what the alignment of the affected sections is in each individual
>     .o file.

Not sure what exactly I should check here. Could you be a bit more precise?

>   * See what __alignof__(struct of_device_id) evaluates to.

It evaluates to "4" even for the bad case.

Regards,
Lino
