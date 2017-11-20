From: cdall@linaro.org (Christoffer Dall)
Date: Mon, 20 Nov 2017 09:53:19 +0100
Subject: [PATCH v4 00/21] SError rework + RAS&IESB for firmware first
 support
In-Reply-To: <CAFEAcA_yRT7829=reU=vnAiHWy-9oP1G84v0w_ST8C3VxpskNA@mail.gmail.com>
References: <20171019145807.23251-1-james.morse@arm.com>
 <5A049B20.6000501@arm.com> <20171113112946.GK14144@cbox>
 <CAFEAcA_yRT7829=reU=vnAiHWy-9oP1G84v0w_ST8C3VxpskNA@mail.gmail.com>
Message-ID: <20171120085319.GC28855@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 13, 2017 at 01:05:19PM +0000, Peter Maydell wrote:
> On 13 November 2017 at 11:29, Christoffer Dall <cdall@linaro.org> wrote:
> > I'm thinking this is analogous to migrating a VM that uses an irqchip in
> > userspace and has set the IRQ or FIQ lines using KVM_IRQ_LINE.  My
> > feeling is that this is also not supported today.
> 
> Oops, yes, we completely forgot about migration when we added
> that feature... I think you're right that we won't get that right.

So I think it might actually work for the timer, because we migrate the
timer state, and I think QEMU migrates the timer-to-GIC line state, and
if we're licky the IRQ line from the userspace GIC to the KVM VCPU would
get updated after restore.

But in general, KVM_IRQ_LINE values don't get migrated, and I think
that's a problem we've probably had from the initial implementation, and
not introduced with userspace timers support.

IIRC, QEMU is really happy to continously call KVM_IRQ_LINE with the
same value (which could potentially be further optimized), and that
currently may hide this problem.

Still, it's something we should look at and ensure is correct,
especially when adding a new similar state that needs migration.

Thanks,
-Christoffer
