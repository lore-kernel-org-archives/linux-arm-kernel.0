From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Sep 2011 08:59:16 +0100
Subject: Link failures due to __bug_table in current -next
In-Reply-To: <CAPnjgZ3+b=nhApZxV1aBGejxEr7MGN1e8neP-ychtVO2Ego2yQ@mail.gmail.com>
References: <20110919120954.GA20314@opensource.wolfsonmicro.com>
	<20110919200317.GC16381@n2100.arm.linux.org.uk>
	<CAPnjgZ3+b=nhApZxV1aBGejxEr7MGN1e8neP-ychtVO2Ego2yQ@mail.gmail.com>
Message-ID: <20110920075916.GD16381@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2011 at 12:06:22AM -0700, Simon Glass wrote:
> Hi Russell,
> 
> On Mon, Sep 19, 2011 at 1:03 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Sep 19, 2011 at 01:09:54PM +0100, Mark Brown wrote:
> >> I'm seeing linker failures in -next as of today:
> >>
> >> `.exit.text' referenced in section `__bug_table' of fs/built-in.o:
> >> defined in discarded section `.exit.text' of fs/built-in.o
> >> `.exit.text' referenced in section `__bug_table' of crypto/built-in.o:
> >> defined in discarded section `.exit.text' of crypto/built-in.o
> >> `.exit.text' referenced in section `__bug_table' of net/built-in.o:
> >> defined in discarded section `.exit.text' of net/built-in.o
> >> `.exit.text' referenced in section `__bug_table' of net/built-in.o:
> >> defined in discarded section `.exit.text' of net/built-in.o
> >>
> >> which appears to be due to the chnage to use generic BUG() introduced in
> >> commit 5254a3 (ARM: 7017/1: Use generic BUG() handler), reverting that
> >> commit resolves the issue for me.
> 
> Gosh this does seem a bit odd. Ordering seems to be clearly implied by
> the file syntax and I agree we should seek guidance from binutils
> people.

I'm not sure that there's any value in seeking guidance from the linker
folk - we can see what's going on with a few experiments.  That's fine
to find out what current linker behaviour is, but unless the manual
documents it, its something that shouldn't be relied upon.

Here's where I researched what the manual says and what practically happens
with the linker:

http://lists.arm.linux.org.uk/lurker/message/20110808.195805.a073e07d.en.html

> I added the BUG condition to CONFIG_SMP_ON_UP and
> CONFIG_DEBUG_SPINLOCK which were already there. If BUG is causing
> problems, I wonder why these are not? Have we just been lucky, or have
> I crossed a line? Or perhaps there are no spinlocks in exit text?

The other stuff is also having problems.  Rob Herring's report was about
the SMP alternatives causing the same problem:

http://lists.arm.linux.org.uk/lurker/message/20110808.184931.a38e1c4e.en.html

> One option is to keep all exit text around - i.e. never discard it at
> link time. From memory it is only 4-8KB. Doubtless many would be upset
> with this, but it could be an option until this binutils behaviour is
> resolved.

We are trying to keep .exit.text around (when certain config options are
set - and they are set - but the linker is deciding to discard it for us
anyway, because asm-generic/vmlinux.lds.S always lists .exit.text in its
discard section.

As we have a discard section at the beginning of the file to discard the
unwinder information for other sections, the one from the generic file
gets merged at the _start_ of the linker file, which results in .exit.text
first appearance to be in the discard section.

It's not that simple though - if you read the quote from the linker manual,
the implication is that the linker would be entirely free to discard an
input section as a priority if it appears in a discard section anywhere
in the linker script.  There's nothing to say future linkers won't do
this.  It would still be conformant to the linker manual.

> Another is to declare that it is a bug to use BUG in an exit section.
> I was thinking about that at the time, but decided it was probably too
> radical. There are only a small number of references in the kernel I
> think (again from memory - this was back in April I think). Not
> trivial to enforce, and the error you get is not exactly informative.

When a BUG() is inside an inline function which is used in an exit path,
it becomes non-trivial to eliminate.  That means there will be hidden
BUG() instances and we really can't ask people to avoid inline functions.
