From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 24 Jul 2014 18:48:36 -0400
Subject: next build: 629 warnings 1 failures (next/next-20140723)
In-Reply-To: <20140724132448.GB13371@arm.com>
References: <53cf8323.e4b6440a.7d37.4f75@mx.google.com>
 <CAOesGMhT9n7nVbCay5cU74pv2qrbqMooZLoY923Lk6SzXk5z+A@mail.gmail.com>
 <20140724085037.GB1994@arm.com> <20140724104318.GA13371@arm.com>
 <20140724132448.GB13371@arm.com>
Message-ID: <20140724224836.GY23220@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 02:24:48PM +0100, Catalin Marinas wrote:
> On Thu, Jul 24, 2014 at 11:43:18AM +0100, Catalin Marinas wrote:
> > On Thu, Jul 24, 2014 at 09:50:37AM +0100, Will Deacon wrote:
> > > On Thu, Jul 24, 2014 at 12:27:30AM +0100, Olof Johansson wrote:
> > > > I'm building with a vanilla gcc 4.8.2 / binutils 2.23.2. That
> > > > shouldn't be broken like this, so those changes should be fixed (or
> > > > minimal toolchain expecations need to be documented -- but there
> > > > really is no good reason to require 4.9.0/2.24).
> > > 
> > > These all come from the GICv3 driver, so it's not going to be a lot of fun
> > > fixing them. You'd have to introduce a macro for generating the system-reg
> > > accesses (for both C and asm), then switch the GIC driver and the arch code
> > > over to using that.
> > 
> > We may need to document that enabling GICv3 requires a newer toolchain.
> > 
> > Otherwise, my years old macros ;) (adapted here and untested):
> [...]
> > But I'll let Marc comment when he gets back from holiday (I'm pretty
> > sure he will enjoy it ;))
> 
> Saving Marc some time:
> 
> ------------8<--------------------------------
> 
> From 3acb8b49aeba9f48153a2d719dec05d0b862e285 Mon Sep 17 00:00:00 2001
> From: Catalin Marinas <catalin.marinas@arm.com>
> Date: Thu, 24 Jul 2014 14:14:42 +0100
> Subject: [PATCH] arm64: gicv3: Allow GICv3 compilation with older binutils
> 
> GICv3 introduces new system registers accessible with the full msr/mrs
> syntax (e.g. mrs x0, Sx_op0_op1_CRm_CRn_op2). However, only recent
> binutils understand the new syntax. This patch introduces msr_s/mrs_s
> assembly macros which generate the equivalent instructions above and
> converts the existing GICv3 code (both drivers/irqchip/ and
> arch/arm64/kernel/).
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Reported-by: Olof Johansson <olof@lixom.net>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/sysreg.h    | 60 ++++++++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/head.S           |  6 ++--
>  drivers/irqchip/irq-gic-v3.c       | 16 +++++-----
>  include/linux/irqchip/arm-gic-v3.h | 42 +++++++++++++-------------
>  4 files changed, 93 insertions(+), 31 deletions(-)
>  create mode 100644 arch/arm64/include/asm/sysreg.h

I'm going to assume this goes on top of Marc's series, and that you'll
take it through arm64:

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
