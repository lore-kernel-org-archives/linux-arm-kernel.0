From: will.deacon@arm.com (Will Deacon)
Date: Wed, 8 Aug 2018 16:44:44 +0100
Subject: [RFC PATCH] arm64: lse: provide additional GPR to 'fetch' LL/SC
 fallback variants
In-Reply-To: <CAKv+Gu9b362=rSKX=RN3Kjb8V1D2UhmsZx7qYY5va1Whz5iGfg@mail.gmail.com>
References: <20180804095553.16358-1-ard.biesheuvel@linaro.org>
 <20180807165634.GA21809@arm.com>
 <CAKv+Gu9b362=rSKX=RN3Kjb8V1D2UhmsZx7qYY5va1Whz5iGfg@mail.gmail.com>
Message-ID: <20180808154443.GA31006@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 07, 2018 at 07:02:20PM +0200, Ard Biesheuvel wrote:
> On 7 August 2018 at 18:56, Will Deacon <will.deacon@arm.com> wrote:
> > On Sat, Aug 04, 2018 at 11:55:53AM +0200, Ard Biesheuvel wrote:
> >> When support for ARMv8.2 LSE atomics is compiled in, the original
> >> LL/SC implementations are demoted to fallbacks that are invoked
> >> via function calls on systems that do not implement the new instructions.
> >>
> >> Due to the fact that these function calls may occur from modules that
> >> are located further than 128 MB away from their targets in the core
> >> kernel, such calls may be indirected via PLT entries, which are permitted
> >> to clobber registers x16 and x17. Since we must assume that those
> >> registers do not retain their value across a function call to such a
> >> LL/SC fallback, and given that those function calls are hidden from the
> >> compiler entirely, we must assume that calling any of the LSE atomics
> >> routines clobbers x16 and x17 (and x30, for that matter).
> >>
> >> Fortunately, there is an upside: having two scratch register available
> >> permits the compiler to emit many of the LL/SC fallbacks without having
> >> to preserve/restore registers on the stack, which would penalise the
> >> users of the LL/SC fallbacks even more, given that they are already
> >> putting up with the function call overhead.
> >>
> >> However, the 'fetch' variants need an additional scratch register in
> >> order to execute without the need to preserve registers on the stack.
> >>
> >> So let's give those routines an additional scratch register 'x15' when
> >> emitted as a LL/SC fallback, and ensure that the register is marked as
> >> clobbered at the associated LSE call sites (but not anywhere else)
> >
> > Hmm, doesn't this mean that we'll needlessly spill/reload in the case that
> > we have LSE atomics in the CPU? I'd rather keep the LSE code as fast as
> > possible if ARM64_LSE_ATOMICS=y, and allow people to disable the config
> > option if they want to get the best performance for the LL/SC variants.
> >
> 
> It depends. We are trading a guaranteed spill on the LL/SC side for a
> potential spill on the LSE side for, and AArch64 has a lot more
> registers than most other architectures.
> 
> This is a thing that distro kernels will want to enable as well, and I
> feel the burden of having this flexibility is all put on the LL/SC
> users.

I actually think that putting the burden on LL/SC is a sensible default,
since all 8.1+ arm64 CPUs are going to have the atomics. Do you have any
benchmarks showing that this gives a significant hit on top of the cost
of moving these out of line?

Will
