From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 1 Mar 2018 10:31:02 +0000
Subject: Clang build of arm64 kernel fails
In-Reply-To: <d601e0ca-dd91-3dd4-c610-dd2ae49aa1b6@arm.com>
References: <CAAeHK+wRcZ1o53CEpeOQ-J5AayVAd8nm-ASj8HsTy1vOzHQAqQ@mail.gmail.com>
 <d601e0ca-dd91-3dd4-c610-dd2ae49aa1b6@arm.com>
Message-ID: <20180301103100.GE32331@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 09:45:24AM +0000, Robin Murphy wrote:
> Hi Andrey,
> 
> On 28/02/18 19:32, Andrey Konovalov wrote:
> >Hi Marc!
> >
> >I've tried to pull in new upstream commits and the kernel build
> >started failing for me with the following errors (see below).
> >
> >It seems that the reason is your commit "arm64: Add
> >ARM_SMCCC_ARCH_WORKAROUND_1 BP hardening support". It seems that Clang
> >doesn't like 32 bits registers being used in 64 bits build.
> 
> I'd say this is really a bug in Clang. Architecturally, the register in
> AArch64 state is still named "r0"; "x0"/"w0" are assembler operands which
> additionally encode the size of the corresponding *access* to r0.
> 
> I note that GCC's documentation on register variables[1] does just say "the
> name of the register", which implies this code is not incorrect. Given that
> Clang already likes to infer the operand size from the argument type in
> actual inline asms, it seems funny that its register allocator should care
> in this non-instruction context.

+1

rN is perfectly reasonable here and has always been supported by GCC for
AArch64 AFAIK.

(IMHO rN is preferable, because this separates the register allocation
specification from how that register is used to encode the data type --
GCC has no choice about the latter, but using "w"/"x" gives the
misleading impression of control over this.)

> >Would you mind sending a fix?
> 
> That said, I guess it's a bug we might have to work around anyway. Oh well.

It would be preferable to see evidence of the llvm community committing
to fix this before we consider merging a bodge into Linux for it.

Although this one issue is easy-ish to work around, we're on a slippery
slope towards allowing the LLVM and GCC inline assemblers to diverge if
we don't push back on worthless incompatibilities.

Cheers
---Dave
