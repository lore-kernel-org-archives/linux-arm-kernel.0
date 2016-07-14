From: jpoimboe@redhat.com (Josh Poimboeuf)
Date: Thu, 14 Jul 2016 00:48:42 -0500
Subject: [PATCH v2 01/11] mm: Implement stack frame object validation
In-Reply-To: <CAGXu5jLPZiRJx8n3_7GW2bufiuUgE9=c6dQcNxDRPHMU72sD9g@mail.gmail.com>
References: <1468446964-22213-1-git-send-email-keescook@chromium.org>
 <1468446964-22213-2-git-send-email-keescook@chromium.org>
 <CALCETrVDJDjdoh7yvOPd=_5twQnzQRhe8G2KLaRw-NnA1Uf__g@mail.gmail.com>
 <CAGXu5jLPZiRJx8n3_7GW2bufiuUgE9=c6dQcNxDRPHMU72sD9g@mail.gmail.com>
Message-ID: <20160714054842.6zal5rqawpgew26r@treble>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2016 at 03:04:26PM -0700, Kees Cook wrote:
> On Wed, Jul 13, 2016 at 3:01 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> > On Wed, Jul 13, 2016 at 2:55 PM, Kees Cook <keescook@chromium.org> wrote:
> >> This creates per-architecture function arch_within_stack_frames() that
> >> should validate if a given object is contained by a kernel stack frame.
> >> Initial implementation is on x86.
> >>
> >> This is based on code from PaX.
> >>
> >
> > This, along with Josh's livepatch work, are two examples of unwinders
> > that matter for correctness instead of just debugging.  ISTM this
> > should just use Josh's code directly once it's been written.
> 
> Do you have URL for Josh's code? I'd love to see what happening there.

The code is actually going to be 100% different next time around, but
FWIW, here's the last attempt:

  https://lkml.kernel.org/r/4d34d452bf8f85c7d6d5f93db1d3eeb4cba335c7.1461875890.git.jpoimboe at redhat.com

In the meantime I've realized the need to rewrite the x86 core stack
walking code to something much more manageable so we don't need all
these unwinders everywhere.  I'll probably post the patches in the next
week or so.  I'll add you to the CC list.

With the new interface I think you'll be able to do something like:

	struct unwind_state;

	unwind_start(&state, current, NULL, NULL);
	unwind_next_frame(&state);
	oldframe = unwind_get_stack_pointer(&state);

	unwind_next_frame(&state);
	frame = unwind_get_stack_pointer(&state);

	do {
		if (obj + len <= frame)
			return blah;
		oldframe = frame;
		frame = unwind_get_stack_pointer(&state);

	} while (unwind_next_frame(&state);

And then@the end there'll be some (still TBD) way to query whether it
reached the last syscall pt_regs frame, or if it instead encountered a
bogus frame pointer along the way and had to bail early.

-- 
Josh
