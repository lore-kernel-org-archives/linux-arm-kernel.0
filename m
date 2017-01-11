From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 11 Jan 2017 15:34:47 +0000
Subject: [PATCH] arm64: assembler: make adr_l work in modules under KASLR
In-Reply-To: <CAKv+Gu9DxMzSTVRPdeSaJQNqe5RGjS_qzVzBU1SpGs5EZvCE1Q@mail.gmail.com>
References: <1484146493-18460-1-git-send-email-ard.biesheuvel@linaro.org>
 <20170111151822.GC26344@leverpostej>
 <CAKv+Gu9DxMzSTVRPdeSaJQNqe5RGjS_qzVzBU1SpGs5EZvCE1Q@mail.gmail.com>
Message-ID: <20170111153447.GD26344@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 03:25:09PM +0000, Ard Biesheuvel wrote:
> On 11 January 2017 at 15:18, Mark Rutland <mark.rutland@arm.com> wrote:
> > Hi Ard,
> >
> > On Wed, Jan 11, 2017 at 02:54:53PM +0000, Ard Biesheuvel wrote:
> >> When CONFIG_RANDOMIZE_MODULE_REGION_FULL=y, the offset between loaded
> >> modules and the core kernel may exceed 4 GB, putting symbols exported
> >> by the core kernel out of the reach of the ordinary adrp/add instruction
> >> pairs used to generate relative symbol references. So make the adr_l
> >> macro emit a movz/movk sequence instead when executing in module context.
> >
> > AFAICT, we only use adr_l in a few assembly files that shouldn't matter
> > to modules:
> >
> > * arch/arm64/kernel/head.S
> > * arch/arm64/kernel/sleep.S
> > * arch/arm64/kvm/hyp-init.S
> > * arch/arm64/kvm/hyp/hyp-entry.S
> >
> > ... so I don't follow why we need this.
> >
> > Have I missed something? Or do you intend to use this in module code in
> > future?
> 
> Yes. E.g., the scalar AES cipher that I am proposing for v4.11 reuses
> the lookup tables from crypto/aes_generic.c, which may be built into
> the core kernel, while the code itself may be built as a module.

Ah, ok.

> But in general, if the macro is available to modules, I would like to
> make sure that it does not result in code that builds fine but may
> fail in some cases only at runtime, especially given the fact that
> there is also a Cortex-A53 erratum regarding adrp instructions, for
> which reason we build modules with -mcmodel=large (which amounts to
> the same thing as the patch above)
> 
> > It seems somewhat surprising to me to have adr_l expand to something
> > that doesn't use adr/adrp, but that's not necessarily a problem.
> 
> I did realise that, but I don't think it is a problem tbh.

In this case it should be fine, certainly.

There are cases like the early boot code and hyp code where it's
critical that we use adr. It's also possible that we might build
(modular) drivers which want some idmapped code, where we want adr, so
it seems unfortunate that this depends on howthe code is built.

So, maybe it's better to have a mov_sym helper for this case, to be
explicit about what we want? That can use either adr* or mov*, or the
latter consistently.

Thanks,
Mark.
