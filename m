From: rabin@rab.in (Rabin Vincent)
Date: Sun, 21 Oct 2012 20:59:08 +0200
Subject: [PATCH 9/9] ARM: add uprobes support
In-Reply-To: <20121015174450.GB18614@linaro.org>
References: <1350242593-17761-1-git-send-email-rabin@rab.in>
 <1350242593-17761-9-git-send-email-rabin@rab.in>
 <20121015111443.GA2006@linaro.org>
 <CAH+eYFC1fr0vpK2T4hz9LK=Nz5bzQBQ4O-o0f9tsnj-_D9ZEJg@mail.gmail.com>
 <20121015174450.GB18614@linaro.org>
Message-ID: <20121021185908.GD4840@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2012 at 06:44:50PM +0100, Dave Martin wrote:
> On Mon, Oct 15, 2012 at 01:44:55PM +0200, Rabin Vincent wrote:
> > Why?  It currently works for ARM userspace even if the kernel is
> > Thumb-2.
> 
> My bad, I misread what was happening in the Makefile changes.
> 
> My concern is about whether we can build the ARM and Thumb-2 kprobes
> code into the same kernel.  If so, no problem, but I believe this is
> not a tested configuration for kprobes itself.
> 
> If you've not already done so, it should be possible to test this
> by adding CONFIG_THUMB2_KERNEL=y to your config, providing your
> hardware is Thumb-2 capable.

I've tested this before.  With a Thumb-2 kernel, both the kprobes test
(Thumb) and the uprobes test (ARM) run fine.

> General question which I'm not sure I understand yet: is is possible
> to combine uprobes/kprobes decode more completely?  It's not obvious
> to me whether the uprobes-specific decoding only relates to features
> which architecturally execute differently in user mode versus
> privileged mode.  Some explanation somewhere could be helpful.

What we change is not the decoding itself but the handling of the
instructions:

  (1) Load and stores are executed from the xol area by user space so
  the instructions need to be rewritten when they touch the PC.  Kprobes
  code rewrites the instructions directly and executes them or in some
  cases simulates them.

  (2) All other non-simulated instructions are also executed from the
  XOL area in userspace.  Because of this, the ALU instructions which
  use the PC also need to be rewritten to not use the PC.  Perhaps we
  can actually get rid of this and just execute these instruction from
  kernel space like it is done for uprobes.

  So the uprobes code is uses the decoding tables just to know if the
  instruction is using the PC or not, but if we make the ALU
  instructions execute from kernel space we could actually use the
  emulate_*() functions like kprobes does.
