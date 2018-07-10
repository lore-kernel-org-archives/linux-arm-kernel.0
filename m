From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 10 Jul 2018 16:38:26 +0100
Subject: [PATCH v2 6/6] KVM: arm/arm64: vgic: Allow configuration of
 interrupt groups
In-Reply-To: <20180710152727.GA8890@u002843.usa.arm.com>
References: <1530697100-22419-1-git-send-email-christoffer.dall@arm.com>
 <1530697100-22419-7-git-send-email-christoffer.dall@arm.com>
 <7f875ead-d3cb-1fec-bc84-56e64526e6a7@arm.com>
 <20180709224836.GA26579@u002843.usa.arm.com>
 <f07199bf-9e31-25ad-72d9-27192c27fccd@redhat.com>
 <20180710103223.GE2656@work-vm>
 <20180710152727.GA8890@u002843.usa.arm.com>
Message-ID: <CAFEAcA9rKb=c3XFN-9a2xjrr3q=AVQ7hA2_dEsG_JGhYuuAn8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 July 2018 at 16:27, Christoffer Dall <christoffer.dall@arm.com> wrote:
> Unless someone objects, I'll try to come up with a v3 that asks
> userspace to confirm it wants writable groups.  Ideally I'd like for
> this to happen automatically if userspace writes an IIDR with revision 2
> and above, but that may result in either
>
>   (1) imposing ordering on the restore sequence from userspace;
>       userspace must write IIDR before IGROUPR if it wants non-default
>       groups,
>   (2) terrible sequence of locking and resetting everything if IIDR
>       hasn't been written before time of first executing a VCPU, or
>   (3) an additional bookkeeping flag in the critical path for GICv2
>       which ignores the group unless userspace wrote IIDR.
>
> Out of the three, I think (3) is the least desirable because it
> precludes the guest from programming its own groups.  I'll have a look
> at how (2) looks, because it hides everything, and finally we can fall
> back to (1) and document it clearly.

There are already some ordering restrictions on the restore
sequence for the GICv3, I think (eg there's a comment in QEMU
about having to restore GICR_PROPBASER/PENDBASER before GICR_CTLR),
so (1) isn't the end of the world...

thanks
-- PMM
