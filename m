From: David.Laight@ACULAB.COM (David Laight)
Date: Mon, 25 Jul 2016 09:27:31 +0000
Subject: [PATCH v3 02/11] mm: Hardened usercopy
In-Reply-To: <20160722174551.jddle6mf7zlq6xmb@treble>
References: <1468619065-3222-1-git-send-email-keescook@chromium.org>
 <1468619065-3222-3-git-send-email-keescook@chromium.org>
 <5790711f.2350420a.b4287.2cc0SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAGXu5jLCu1Vv0uugKZrsjSEsoABgXJSOJ8GkKmrHbvj9jkC2YA@mail.gmail.com>
 <20160722174551.jddle6mf7zlq6xmb@treble>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D5F502102@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Josh Poimboeuf
> Sent: 22 July 2016 18:46
..
> > >> +/*
> > >> + * Checks if a given pointer and length is contained by the current
> > >> + * stack frame (if possible).
> > >> + *
> > >> + *   0: not at all on the stack
> > >> + *   1: fully within a valid stack frame
> > >> + *   2: fully on the stack (when can't do frame-checking)
> > >> + *   -1: error condition (invalid stack position or bad stack frame)
> > >> + */
> > >> +static noinline int check_stack_object(const void *obj, unsigned long len)
> > >> +{
> > >> +     const void * const stack = task_stack_page(current);
> > >> +     const void * const stackend = stack + THREAD_SIZE;
> > >
> > > That allows access to the entire stack, including the struct thread_info,
> > > is that what we want - it seems dangerous? Or did I miss a check
> > > somewhere else?
> >
> > That seems like a nice improvement to make, yeah.
> >
> > > We have end_of_stack() which computes the end of the stack taking
> > > thread_info into account (end being the opposite of your end above).
> >
> > Amusingly, the object_is_on_stack() check in sched.h doesn't take
> > thread_info into account either. :P Regardless, I think using
> > end_of_stack() may not be best. To tighten the check, I think we could
> > add this after checking that the object is on the stack:
> >
> > #ifdef CONFIG_STACK_GROWSUP
> >         stackend -= sizeof(struct thread_info);
> > #else
> >         stack += sizeof(struct thread_info);
> > #endif
> >
> > e.g. then if the pointer was in the thread_info, the second test would
> > fail, triggering the protection.
> 
> FWIW, this won't work right on x86 after Andy's
> CONFIG_THREAD_INFO_IN_TASK patches get merged.

What ends up in the 'thread_info' area?
If it contains the fp save area then programs like gdb may end up requesting
copy_in/out directly from that area.

Interestingly the avx registers don't need saving on a normal system call
entry (they are all caller-saved) so the kernel stack can safely overwrite
that area.
Syscall entry probably ought to execute the 'zero all avx registers' instruction.
They do need saving on interrupt entry - but the stack used will be less.

	David
