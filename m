From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Sep 2011 20:12:40 +0100
Subject: Link failures due to __bug_table in current -next
In-Reply-To: <20110919185809.GA16381@n2100.arm.linux.org.uk>
References: <20110919120954.GA20314@opensource.wolfsonmicro.com>
	<20110919184027.GZ16381@n2100.arm.linux.org.uk>
	<20110919184230.GF540@opensource.wolfsonmicro.com>
	<20110919185809.GA16381@n2100.arm.linux.org.uk>
Message-ID: <20110919191240.GA15786@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2011 at 07:58:09PM +0100, Russell King - ARM Linux wrote:
> What you're actually after is:
> 
> 	7c8a25b (CRIS: Discard exit.text and .data at runtime)

You're talking about this:

        SECURITY_INIT

+       /* .exit.text is discarded at runtime, not link time,
+        * to deal with references from __bug_table
+        */
+       .exit.text : {
+               EXIT_TEXT
+       }
+       .exit.data : {
+               EXIT_DATA
+       }
+

This "fix" won't work for us - the exit text is being discarded
by the very first /DISCARD/ statement due to merging of /DISCARD/
output sections in the linker script, as I explained in my initial
reply to you.

include/asm-generic/vmlinux.lds.S:

#define EXIT_TEXT                                                       \
        *(.exit.text)                                                   \
        DEV_DISCARD(exit.text)                                          \
        CPU_DISCARD(exit.text)                                          \
        MEM_DISCARD(exit.text)

#define DISCARDS                                                        \
        /DISCARD/ : {                                                   \
        EXIT_TEXT                                                       \
        EXIT_DATA                                                       \
        EXIT_CALL                                                       \
        *(.discard)                                                     \
        *(.discard.*)                                                   \
        }

and our vmlinux.lds.S:

SECTIONS
{
        /*
         * unwind exit sections must be discarded before the rest of the
         * unwind sections get included.
         */
        /DISCARD/ : {
                *(.ARM.exidx.exit.text)
                *(.ARM.extab.exit.text)
                ARM_CPU_DISCARD(*(.ARM.exidx.cpuexit.text))
                ARM_CPU_DISCARD(*(.ARM.extab.cpuexit.text))
#ifndef CONFIG_HOTPLUG
                *(.ARM.exidx.devexit.text)
                *(.ARM.extab.devexit.text)
#endif
#ifndef CONFIG_MMU
                *(.fixup)
                *(__ex_table)
#endif
#ifndef CONFIG_SMP_ON_UP
                *(.alt.smp.init)
#endif
        }
...
        .exit.text : {
                ARM_EXIT_KEEP(EXIT_TEXT)
        }
...
        /* Default discards */
        DISCARDS
}

This is functionally equivalent with *current* linkers to:

SECTIONS
{
        /*
         * unwind exit sections must be discarded before the rest of the
         * unwind sections get included.
         */
        /DISCARD/ : {
                *(.ARM.exidx.exit.text)
                *(.ARM.extab.exit.text)
                ARM_CPU_DISCARD(*(.ARM.exidx.cpuexit.text))
                ARM_CPU_DISCARD(*(.ARM.extab.cpuexit.text))
#ifndef CONFIG_HOTPLUG
                *(.ARM.exidx.devexit.text)
                *(.ARM.extab.devexit.text)
#endif
#ifndef CONFIG_MMU
                *(.fixup)
                *(__ex_table)
#endif
#ifndef CONFIG_SMP_ON_UP
                *(.alt.smp.init)
#endif
	        EXIT_TEXT
        	EXIT_DATA
	        EXIT_CALL
        	*(.discard)
	        *(.discard.*)
        }
...
        .exit.text : {
                ARM_EXIT_KEEP(EXIT_TEXT)
        }
...
}

and as *current* linker behaviour is the first input section found in
order in its internal list of output sections matches, the result is
that .exit.text is _always_ discarded irrespective of whether we want
it or not.

As an additional note, I can find nothing in the linker manual which
defines the behaviour of:

	/DISCARD/ : {
		*(.this.section.should.be.discarded)
	}

	.keep : {
		*(.this.section.*)
	}

It is entirely undefined whether ".this.section.should.be.discarded"
would be discarded or whether it ends up in .keep - it all depends on
the internal - undocumented - behaviour of the linker when assigning
input sections to output sections.  As I mention above, that's
observably internal-merged-output-section-order,
input-section-order-within-output-section with current linkers but
there's no guarantee it'll remain that way.

I think we're running into some fundamental problems here, and I think
we need to get binutils people to come out with a statement concerning
how input sections are matched to output sections when there's multiple
statements in the linker script which match (eg, the most specific
match gets priority) and then we need to ensure that the kernels linker
scripts do not rely on section ordering.
