From: will.deacon@arm.com (Will Deacon)
Date: Thu, 2 Feb 2017 18:18:00 +0000
Subject: [PATCH 03/10] arm64: KVM: Save/restore the host SPE state when
 entering/leaving a VM
In-Reply-To: <3064a7a5-6661-fc22-c5e4-2478e8457035@arm.com>
References: <1485540470-11469-1-git-send-email-will.deacon@arm.com>
 <1485540470-11469-4-git-send-email-will.deacon@arm.com>
 <3064a7a5-6661-fc22-c5e4-2478e8457035@arm.com>
Message-ID: <20170202181800.GM13839@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 04:29:50PM +0000, Marc Zyngier wrote:
> On 27/01/17 18:07, Will Deacon wrote:
> > The SPE buffer is virtually addressed, using the page tables of the CPU
> > MMU. Unusually, this means that the EL0/1 page table may be live whilst
> > we're executing at EL2 on non-VHE configurations. When VHE is in use,
> > we can use the same property to profile the guest behind its back.
> > 
> > This patch adds the relevant disabling and flushing code to KVM so that
> > the host can make use of SPE without corrupting guest memory, and any
> > attempts by a guest to use SPE will result in a trap.
> > 
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Alex Benn?e <alex.bennee@linaro.org>
> > Cc: Christoffer Dall <christoffer.dall@linaro.org>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/include/asm/kvm_arm.h  |  3 ++
> >  arch/arm64/include/asm/kvm_host.h |  7 ++++-
> >  arch/arm64/kvm/debug.c            |  6 ++++
> >  arch/arm64/kvm/hyp/debug-sr.c     | 66 +++++++++++++++++++++++++++++++++++++--
> >  arch/arm64/kvm/hyp/switch.c       | 17 +++++++++-
> >  5 files changed, 95 insertions(+), 4 deletions(-)

[...]

> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks! Given that this patch depends on an earlier one in the series
(already queued via arm64) and the rest of the series depends on this
patch, do you mind if I take this via arm64 for 4.11? It applies cleanly
against current -next.

Will
