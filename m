From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 9 Jul 2018 09:52:57 +0100
Subject: [PATCH v2 6/6] KVM: arm/arm64: vgic: Allow configuration of
 interrupt groups
In-Reply-To: <7f875ead-d3cb-1fec-bc84-56e64526e6a7@arm.com>
References: <1530697100-22419-1-git-send-email-christoffer.dall@arm.com>
 <1530697100-22419-7-git-send-email-christoffer.dall@arm.com>
 <7f875ead-d3cb-1fec-bc84-56e64526e6a7@arm.com>
Message-ID: <CAFEAcA9HxPcZp3_EChj7_9B7M1u40Jp4kzpmZ4c2__ZA1owOiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 July 2018 at 09:42, Marc Zyngier <marc.zyngier@arm.com> wrote:
> I don't really get why QEMU doesn't try to restore GICD_IIDR, while it
> is definitely trying to restore RO sysregs (and that's how we detect
> incompatibilities).

Accident of design, mostly. From QEMU's point of view, GICD_IIDR
is part of the GIC device, which we save and restore as a separate
thing from the CPU. The GIC device was written in what for QEMU
is a more 'traditional' style, where QEMU assumes it knows all the
registers that might have state and saves and restores them all
(and doesn't bother to do anything with constant registers).
The CPU sysregs are done in a completely different style[*], where
we let the kernel be the source of truth for what sysregs exist;
as a side effect of that we end up trying to save and restore
constant sysregs, since QEMU doesn't know they're constant.

[*] there's an argument that in retrospect this was a mistake;
still, it is what we have and trying to upend it now would be
a huge pain.

thanks
-- PMM
