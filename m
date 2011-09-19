From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Sep 2011 19:40:27 +0100
Subject: Link failures due to __bug_table in current -next
In-Reply-To: <20110919120954.GA20314@opensource.wolfsonmicro.com>
References: <20110919120954.GA20314@opensource.wolfsonmicro.com>
Message-ID: <20110919184027.GZ16381@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2011 at 01:09:54PM +0100, Mark Brown wrote:
> I'm seeing linker failures in -next as of today:
> 
> `.exit.text' referenced in section `__bug_table' of fs/built-in.o:
> defined in discarded section `.exit.text' of fs/built-in.o
> `.exit.text' referenced in section `__bug_table' of crypto/built-in.o:
> defined in discarded section `.exit.text' of crypto/built-in.o
> `.exit.text' referenced in section `__bug_table' of net/built-in.o:
> defined in discarded section `.exit.text' of net/built-in.o
> `.exit.text' referenced in section `__bug_table' of net/built-in.o:
> defined in discarded section `.exit.text' of net/built-in.o
> 
> which appears to be due to the chnage to use generic BUG() introduced in
> commit 5254a3 (ARM: 7017/1: Use generic BUG() handler), reverting that
> commit resolves the issue for me.

It's a known issue - there's been an earlier thread about it:

http://lists.arm.linux.org.uk/lurker/thread/20110808.184931.a38e1c4e.en.html

The asm-generic/vmlinux.lds.S is basically relying on undefined behaviour
from the linker, which is biting us.  There is no guaranteed ordering of
matching input sections to output sections, so listing the same section
more than once in the linker script is asking for problems.

The unfortunate thing is that the linker internally groups the /DISCARD/
sections together into one section, all grouped at the first mention of
the /DISCARD/ section.  This means if you have several /DISCARD/ sections
scattered throughout the linker script, and you rely on the order in which
they appear, you're going to be disappointed because they'll all be merged
into the same position as the first one.

Practically, and observably, this means that for this linker script:

#undef DISCARD_EXIT_TEXT
#ifdef FOO
	/DISCARD/ : {
		*(.foo)
	}
#endif

	.foo : {
		*(.foo)
	}

	.exit.text : {
#ifndef DISCARD_EXIT_TEXT
		*(.exit.text)
#endif
	}

	/DISCARD/ : {
		*(.exit.text)
	}

If FOO is set, .exit.text will be discarded along with .foo.  If FOO is
unset, both .exit.text and .foo will be kept.

Practically, this is what's happening - the DISCARD macro from the
asm-generic/vmlinux.lds.S lists input sections which _may_ be discarded
with the assumption that if they are required, they'll be mentioned
_before_ any discards.  _That_ in itself is undefined linker behaviour.

> I'm wondering if we need something like 7c8a25 (CRIS: Discard exit.text
> and .data at runtime) but figuring it out is a bit beyond my ld skills
> right now.

fatal: ambiguous argument '7c8a25': unknown revision or path not in the working
tree.

Maybe you could be more specific?
