From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 3 Mar 2015 14:41:30 +0000
Subject: [RFC PATCH 0/1] Wrong structure alignment due to compiler
 attribute "section"
In-Reply-To: <1425290502-2322-1-git-send-email-lsanfil@marvell.com>
References: <1425290502-2322-1-git-send-email-lsanfil@marvell.com>
Message-ID: <20150303144130.GB5177@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 11:01:41AM +0100, Lino Sanfilippo wrote:
> 
> Hi,
> 
> I came across a problem concerning structure alignment on ARM architectures (in
> this case the "clock_provider" struct) when structures are placed by means of the
> "section" compiler attribute. I noticed that with a certain cross compiler one
> byte padding is inserted in between the structures:
> 
> <snip> System.map
> c074cec0 T __clk_of_table
> c074cec0 t __of_table_fixed_factor_clk
> c074cec0 T __stop_kprobe_blacklist
> c074cf88 t __of_table_fixed_clk
> c074d050 t __of_table_gpio_gate_clk
> c074d118 t __of_table_mv88f6180_clk
> c074d1e0 t __of_table_kirkwood_clk
> c074d2a8 t __clk_of_table_sentinel
> <snap>
> 
> As one can see the difference between the adresses are 200 bytes although a
> clock_provider only is 196 bytes in size. 
> 
> The problem is that in of_clk_init() the __clk_of_table is used as the base of
> an array. Due to the padding the values in all array elements but the first one
> are corruped. However with another cross compiler I could not trigger this. So
> this issue seems to be compiler/linker dependent. With the attached patch
> applied the layout is correct: 
> 
> c074ce58 T __clk_of_table
> c074ce58 t __of_table_fixed_factor_clk
> c074ce58 T __stop_kprobe_blacklist
> c074cf1c t __of_table_fixed_clk
> c074cfe0 t __of_table_gpio_gate_clk
> c074d0a4 t __of_table_mv88f6180_clk
> c074d168 t __of_table_kirkwood_clk
> c074d22c t __clk_of_table_sentinel
> 
> I can trigger the issue with this compiler:
> wget http://www.plugcomputer.org/405/us/gplugd/tool-chain/arm-marvell-linux-gnueabi.tar.bz2
> 
> Note that this issue popped up some years ago for x86 too:
> http://lkml.iu.edu/hypermail/linux/kernel/0706.2/2552.html

^ I think this describes a separate (though related) issue whereby
this sequence inside an output section description in the linker
script:

	__foo = .;
	*(__foo)

... may leave padding between __foo and the included sections.


vmlinux.lds.h works around this by doing:

	. = ALIGN(8);
	__foo = .;
	*(__foo)

This works so long as none of the included sections requires >8 byte
alignment.

A slightly cleaner alternative would be to create a separate output
section for each array like this:

	.data.foo : {
		__foo = .;
		*(__foo)
	}

... the alignment for section .data.foo is then the maximum
alignment of all of the included sections, and __foo is at that
alignment because it's part of that specific output section.  That
should ensure that there is no padding before the included sections.

Switching to this method would involve some churn though -- ALIGN(8) has
been pasted all over the place, and there may be bits of asm code that
assume an alignment of 8 bytes for some of these arrays even when the
compiler does not require it.

... anyway ...

For the element _size_ issue, I'm confused.  On 32-bit, that
structure is clearly 196 bytes in size, with the alignment requirement
of void * (4 bytes)... so there's no clear reason why the linker
shouldn't be inserting extra padding.

I can't reproduce this with my current tools (upstream binutils-2.24,
gcc-4.9.2).


Can you try to track down where this discrepancy is coming from?

i.e.,

 * If you're juggling with multiple kernel trees, make sure there
   are not differences between them that could be causing this, such
   as changes to linker scripts or header files that are involved
   in building these arrays.

 * See what the input to the assembler looks like, with regard to
   .align directives.

 * See what the alignment of the affected sections is in each individual
   .o file.

 * See what __alignof__(struct of_device_id) evaluates to.

You could also try vanilla upstream versions of the tools, including
the upstream ancestors of the affected toolchain (gcc-4.4, binutils-2.20
IIUC)


> 
> I am not sure that this is the right fix though, thats why I sent that as an
> RFC.

Good try, but the compiler should be marking all those sections with the
correct alignment value anyway.  Either it isn't, or something else is
going wrong somewhere...

Cheers
---Dave

[...]
