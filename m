From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Sep 2012 14:08:21 +0100
Subject: [PATCH 05/15] ARM: Expose PMNC bitfields for KVM use
In-Reply-To: <20120915153502.21241.13218.stgit@ubuntu>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153502.21241.13218.stgit@ubuntu>
Message-ID: <20120918130821.GN32204@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 15, 2012 at 04:35:02PM +0100, Christoffer Dall wrote:
> From: Rusty Russell <rusty.russell@linaro.org>
> 
> We want some of these for use in KVM, so pull them out of
> arch/arm/kernel/perf_event_v7.c into their own asm/perf_bits.h.
> 
> Signed-off-by: Rusty Russell <rusty.russell@linaro.org>
> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
> ---
>  arch/arm/include/asm/perf_bits.h |   56 ++++++++++++++++++++++++++++++++++++++
>  arch/arm/kernel/perf_event_v7.c  |   51 +----------------------------------
>  2 files changed, 57 insertions(+), 50 deletions(-)
>  create mode 100644 arch/arm/include/asm/perf_bits.h

I don't like this I'm afraid. These bit definitions, although useful for
kvm, are only applicable to ARMv7 PMUs. Perf does a reasonable job of
separating the low-level CPU-specific code and adding the v7 definitions
into their own global header feels like a step backwards. I also want to
move a load of this into drivers/ at some point and this won't help with
that effort.

Is KVM just using this for world switch? If so, why does it care about the
bit definitions (and what do you do for things like debug regs)? Is there
anything I could add to perf that you could call instead?

Will
