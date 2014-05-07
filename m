From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 7 May 2014 16:42:09 +0100
Subject: [PATCH 0/9] arm64: KVM: debug infrastructure support
In-Reply-To: <1399476054-21571-1-git-send-email-marc.zyngier@arm.com>
References: <1399476054-21571-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAFEAcA8XwVLevHhAZXPijoSk3Dw=BaoUT+qUNj3QkQZm2n5EPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 May 2014 16:20, Marc Zyngier <marc.zyngier@arm.com> wrote:
> This patch series adds debug support, a key feature missing from the
> KVM/arm64 port.
>
> The main idea is to keep track of whether the debug registers are
> "dirty" (changed by the guest) or not. In this case, perform the usual
> save/restore dance, for one run only. It means we only have a penalty
> if a guest is actually using the debug registers.
>
> The huge amount of registers is properly frightening, but CPUs
> actually only implement a subset of them. Also, there is a number of
> registers we don't bother emulating (things having to do with external
> debug and OSlock).

Presumably these registers now appear in the userspace
interface too, yes? Did you check that they all cope with
the "migration reads all register values on the source and then
writes them on the destination in arbitrary order" semantics without
further fiddling? (I have a note that says that at least
OSLAR_EL1/OSLSR_EL1 won't work that way, for instance.)

thanks
-- PMM
