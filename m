From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Nov 2017 18:06:39 +0000
Subject: [PATCH 00/18] arm64: Unmap the kernel whilst running in
 userspace (KAISER)
In-Reply-To: <CAKv+Gu8YB_qXgWEbd0ZZ6UycxNLXxTZCno87vJ9HH7d6+dKeLQ@mail.gmail.com>
References: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
 <CAKv+Gu8YB_qXgWEbd0ZZ6UycxNLXxTZCno87vJ9HH7d6+dKeLQ@mail.gmail.com>
Message-ID: <20171120180639.GN32488@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

Cheers for having a look.

On Sat, Nov 18, 2017 at 03:25:06PM +0000, Ard Biesheuvel wrote:
> On 17 November 2017 at 18:21, Will Deacon <will.deacon@arm.com> wrote:
> > This patch series implements something along the lines of KAISER for arm64:
> 
> Very nice! I am quite pleased, because this makes KASLR much more
> useful than it is now.

Agreed. I might actually start enabling now ;)

> My main question is why we need a separate trampoline vector table: it
> seems to me that with some minor surgery (as proposed below), we can
> make the kernel_ventry macro instantiations tolerant for being loaded
> somewhere in the fixmap (which I think is a better place for this than
> at the base of the VMALLOC space), removing the need to change
> vbar_el1 back and forth. The only downside is that exceptions taken
> from EL1 will also use absolute addressing, but I don't think that is
> a huge price to pay.

I think there are two aspects to this:

1. Moving the vectors to the fixmap
2. Avoiding the vbar toggle

I think (1) is a good idea, so I'll hack that up for v2. The vbar toggle
isn't as obvious: avoiding it adds some overhead to EL1 irq entry because
we're writing tpidrro_el0 as well as loading from the literal pool. I think
that it also makes the code more difficult to reason about because we'd have
to make sure we don't try to use the fixmap mapping before it's actually
mapped, which I think would mean we'd need a set of early vectors that we
then switch away from in a CPU hotplug notifier or something.

I'll see if I can measure the cost of the current vbar switching to get
an idea of the potential performance available.

Will
