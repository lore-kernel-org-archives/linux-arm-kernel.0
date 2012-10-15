From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 15 Oct 2012 18:44:50 +0100
Subject: [PATCH 9/9] ARM: add uprobes support
In-Reply-To: <CAH+eYFC1fr0vpK2T4hz9LK=Nz5bzQBQ4O-o0f9tsnj-_D9ZEJg@mail.gmail.com>
References: <1350242593-17761-1-git-send-email-rabin@rab.in>
 <1350242593-17761-9-git-send-email-rabin@rab.in>
 <20121015111443.GA2006@linaro.org>
 <CAH+eYFC1fr0vpK2T4hz9LK=Nz5bzQBQ4O-o0f9tsnj-_D9ZEJg@mail.gmail.com>
Message-ID: <20121015174450.GB18614@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2012 at 01:44:55PM +0200, Rabin Vincent wrote:
> 2012/10/15 Dave Martin <dave.martin@linaro.org>:
> > On Sun, Oct 14, 2012 at 09:23:13PM +0200, Rabin Vincent wrote:
> >> Add basic uprobes support for ARM.
> >>
> >> perf probe --exec and SystemTap's userspace probing work.  The ARM
> >> kprobes test code has also been run in a userspace harness to test the
> >> uprobe instruction decoding.
> >
> > The assumption that the target code is ARM appears to be buried all over
> > the place.
> 
> Right, as stated:
> 
> >> Caveats:
> >>  - Thumb is not supported
> 
> > Certainly this code as currently written must depend on !THUMB2_KERNEL.
> 
> Why?  It currently works for ARM userspace even if the kernel is
> Thumb-2.

My bad, I misread what was happening in the Makefile changes.

My concern is about whether we can build the ARM and Thumb-2 kprobes
code into the same kernel.  If so, no problem, but I believe this is
not a tested configuration for kprobes itself.

If you've not already done so, it should be possible to test this
by adding CONFIG_THUMB2_KERNEL=y to your config, providing your
hardware is Thumb-2 capable.

> > However, there's an underlying problem here which we'd need to solve.
> > The kprobes code can take advantage of the fact that the kernel is all
> > ARM or (almost) all Thumb code.  So there is no support for kprobes
> > supporting ARM and Thumb at the same time.
> >
> > With userspace, we don't have this luxury.  With Debian armhf, Ubuntu
> > and Linaro building Thumb-2 userspaces, it may be an increasingly common
> > configuration independently of whether the kernel is built in Thumb-2
> > or not.
> >
> > Furthermode, there is no such thing as a pure Thumb-2 system in practice:
> > PLTs are always ARM, for example.  For uprobes to work well in userspace,
> > both should be supported together.
> 
> Right.  I don't think it's difficult to support both of them together,
> my thought was just to have userspace tell us if they want to probe a
> Thumb instruction via the usual 0th-bit set convention, and then take it
> from there.  I didn't do the Thumb handling currently because I didn't
> really look into modifying the kprobes Thumb instruction decoding and
> the IT handling for uprobes.

Having looked at the code a little more closely, it looks more closely
aligned with this goal than I thought at first.

I agree with your suggestion to require the caller to specify explicitly
whether they want to insert an ARM or Thumb probe (indeed, I think
there's no other way to do it, since guessing the target instruction
set can't be done reliably).  The code for setting a probe can then
switch trivially on that low bit.

Additional undef_hooks would be needed for the Thumb case, but this
looks relatively straightforward, as you say.


General question which I'm not sure I understand yet: is is possible
to combine uprobes/kprobes decode more completely?  It's not obvious
to me whether the uprobes-specific decoding only relates to features
which architecturally execute differently in user mode versus
privileged mode.  Some explanation somewhere could be helpful.

Cheers
---Dave
