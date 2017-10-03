From: jpoimboe@redhat.com (Josh Poimboeuf)
Date: Mon, 2 Oct 2017 20:17:17 -0500
Subject: 4879b7ae05 ("Merge tag 'dmaengine-4.12-rc1' of .."): WARNING:
 kernel stack regs at bd92bc2e in 01-cpu-hotplug:3811 has bad 'bp' value
 000001be
In-Reply-To: <CA+55aFwo4U3vHFtKyCrGaumcfCMszfS48QSxNfEC3pD5wLxQnA@mail.gmail.com>
References: <59d177a7.vsiddgOxdHRIlRvy%fengguang.wu@intel.com>
 <CA+55aFz_ijfUxyk2kdLhfzfS1z0_uRBw6eQb9UxFvh=5zOzzaw@mail.gmail.com>
 <20171002212654.rsm4uj3hfioddldd@treble>
 <CA+55aFwo4U3vHFtKyCrGaumcfCMszfS48QSxNfEC3pD5wLxQnA@mail.gmail.com>
Message-ID: <20171003011717.gl6sbyoykb3lzhed@treble>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 02, 2017 at 02:58:08PM -0700, Linus Torvalds wrote:
> On Mon, Oct 2, 2017 at 2:26 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > The bisect is pointing to a commit which is almost 5 months old, so this
> > is pre-ORC.  Kallsyms *is* enabled, but the unwinder dump isn't smart
> > enough to realize it's dumping misaligned stack addresses:
> 
> Ahh, I didn't pick up on that "esp isn't aligned" part.
> 
> That said, if %esp gets unaligned at some point, it's not clear
> exactly when we should align it. An unaligned stack pointer will
> continue to _work_ just potentially perform fairly badly.

True, but unaligned stacks seem to be very rare, and I don't remember
ever seeing one with frame pointers enabled.  I think the call return
addresses will always be aligned, so I think it makes sense to align the
starting address before dumping.

> But more likely, we picked the wrong frame value to begin with.

Agreed.

> For example, maybe that decode_frame_pointer() logic really should
> check not that the low bit in bp is set, but instead check that it's a
> valid "unsigned long *" that has the low bit set.
> 
> IOW, the difference would be that instead of checking
> 
>         if (!(regs & 0x1))
>                 return NULL;
> 
> if would check
> 
>         if ((regs & (sizeof(unsigned long)-1)) != 1)
>                 return NULL;

Yeah, that would be an improvement.

> but also maybe add logic to simply not trust a next frame pointer that
> isn't appropriately aligned.

Also a good idea.

> So I think adding PTR_ALIGN() there in the unwind dumper might be a
> bit late. By that time it has already accepted what looks like a
> garbage frame. No?

Yeah, maybe.  I guess it really depends on what exactly the root cause
is.  It got a bad frame pointer somehow, but maybe not *too* bad because
it still ended up in the task stack somehow.  It's not clear how that
happened, but it's possible the task stack had some clues about what led
up to it.

I'll implement your suggestions in addition to the patch to align sp in
the dump code.  Having all of them together would hopefully enable the
unwinder to detect a bad condition as early as possible and also do a
better job at dumping it.

-- 
Josh
