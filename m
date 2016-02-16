From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 16 Feb 2016 10:50:02 -0800
Subject: [PATCH v2] arm64: add alignment fault hanling
In-Reply-To: <20160216170408.GL14509@arm.com>
References: <329817481.954581455597874663.JavaMail.weblogic@epmlwas08c>
 <20160216103104.GC14509@arm.com> <56C300AD.8070505@arm.com>
 <20160216122153.GD19413@e104818-lin.cambridge.arm.com>
 <20160216160055.GH14509@arm.com> <20160216170408.GL14509@arm.com>
Message-ID: <CA+55aFw-86k4gY46Et=e02HQQSxjUK2Jfz0SJz8tWtk5P8YZFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 9:04 AM, Will Deacon <will.deacon@arm.com> wrote:
> [replying to self and adding some x86 people]
>
> Background: Euntaik reports a problem where userspace has ended up with
> a memory page mapped adjacent to an MMIO page (e.g. from /dev/mem or a
> PCI memory bar from someplace in /sys). strncpy_from_user happens with
> the word-at-a-time implementation, and we end up reading into the MMIO
> page.
>
> Question: Does x86 guarantee that this faults? (Arjan reckoned no, but
> wasn't 100%).

x86 not only does *not* guarantee that that faults, but quite the
reverse: I'm pretty sure it would be considered an architectural bug
if it didn't silently "just work". IOW, the page-crossing unaligned
access will be split up as two accesses, and done as a regular cached
read for the normal RAM page part, and as an uncached IO read for the
MMIO page.

So if somebody passes us a string adjacent to a MMIO mapping, we'll
happily do the access on x86 and touch the MMIO space. No biggie, and
nobody sane actually does that. If you have the rights to do device
mappings, you should probably restrain from doing insane things. "With
great power comes great responsibility".

> Thinking more about this, we could spit out a guard page between every
> VMA, but it's likely to hamper any VMA merging.

More importantly, it wouldn't work for the general case. People often
pass in a specific virtual memory address to mmap because they *need*
adjacent mappings. One example of that case is doing a circular buffer
that is guaranteed to always be accessible linearly (and avoiding the
split case where it hits the end of the circular buffer) by mapping
the same buffer twice.

Of course, no actual real program will do that for mixing MMIO and
non-MMIO, and so we might obviously add code to always add a guard
page for the normal case when a specific address isn't asked for. So
as a heuristic to make sure it doesn't happen by mistake it possibly
makes sense.

You'd still want to make sure that you don't get a kernel oops if some
attacker tries to break ARM64 on purpose, obviously (although even
that is not necessarily a huge deal for somebody who already has
physical IO privileges). So I suspect that Eun Taik Lee's patch makes
perfect sense even if it's not necessarily the full solution in
itself.

                Linus
