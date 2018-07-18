From: andreyknvl@google.com (Andrey Konovalov)
Date: Wed, 18 Jul 2018 19:16:25 +0200
Subject: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
In-Reply-To: <20180703173608.GF27243@arm.com>
References: <cover.1530018818.git.andreyknvl@google.com>
 <20180628105057.GA26019@e103592.cambridge.arm.com>
 <CAAeHK+w0T43+h3xqU4a-qutxd-qiEhsvk0eaZpmAn-T0hpaLZQ@mail.gmail.com>
 <20180629110709.GA17859@arm.com>
 <CAAeHK+wHd8B2nhat-Z2Y2=s4NVobPG7vjr2CynjFhqPTwQRepQ@mail.gmail.com>
 <20180703173608.GF27243@arm.com>
Message-ID: <CAAeHK+wTcH+2hgm_BTkLLdn1GkjBtkhQ=vPWZCncJ6KenqgKpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 2, 2018 at 10:30 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> OK, anecdotal experience works for me.  But this is all stuff that
> should have been in the changelog from day zero, please.  It describes
> the reason for the patchset's existence!

I will add all those points to the cover letter in v5.

On Tue, Jul 3, 2018 at 7:36 PM, Will Deacon <will.deacon@arm.com> wrote:
> Hmm, but elsewhere in this thread, Evgenii is motivating the need for this
> patch set precisely because the lower overhead means it's suitable for
> "near-production" use. So I don't think writing this off as a debugging
> feature is the right approach, and we instead need to put effort into
> analysing the impact of address tags on the kernel as a whole. Playing
> whack-a-mole with subtle tag issues sounds like the worst possible outcome
> for the long-term.

I don't see a way to find cases where pointer tags would matter
statically, so I've implemented the dynamic approach that I mentioned
above. I've instrumented all pointer comparisons/subtractions in an
LLVM compiler pass and used a kernel module that would print a bug
report whenever two pointers with different tags are being
compared/subtracted (ignoring comparisons with NULL pointers and with
pointers obtained by casting an error code to a pointer type). Then I
tried booting the kernel in QEMU and on an Odroid C2 board and I ran
syzkaller overnight.

This yielded the following results.

======

The two places that look interesting are:

is_vmalloc_addr in include/linux/mm.h (already mentioned by Catalin)
is_kernel_rodata in mm/util.c

Here we compare a pointer with some fixed untagged values to make sure
that the pointer lies in a particular part of the kernel address
space. Since KWHASAN doesn't add tags to pointers that belong to
rodata or vmalloc regions, this should work as is. To make sure I've
added debug checks to those two functions that check that the result
doesn't change whether we operate on pointers with or without
untagging.

======

A few other cases that don't look that interesting:

Comparing pointers to achieve unique sorting order of pointee objects
(e.g. sorting locks addresses before performing a double lock):

tty_ldisc_lock_pair_timeout in drivers/tty/tty_ldisc.c
pipe_double_lock in fs/pipe.c
unix_state_double_lock in net/unix/af_unix.c
lock_two_nondirectories in fs/inode.c
mutex_lock_double in kernel/events/core.c

ep_cmp_ffd in fs/eventpoll.c
fsnotify_compare_groups fs/notify/mark.c

Nothing needs to be done here, since the tags embedded into pointers
don't change, so the sorting order would still be unique.

Check that a pointer belongs to some particular allocation:

is_sibling_entry lib/radix-tree.c
object_is_on_stack in include/linux/sched/task_stack.h

Nothing needs to be here either, since two pointers can only belong to
the same allocation if they have the same tag.

======

Will, Catalin, WDYT?
