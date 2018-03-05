From: will.deacon@arm.com (Will Deacon)
Date: Mon, 5 Mar 2018 17:42:50 +0000
Subject: [RFC PATCH v3 2/3] arm64/kernel: don't ban ADRP to work around
 Cortex-A53 erratum #843419
In-Reply-To: <CAKv+Gu91CfVq4nBsLhNRRkGN-0PevGeUPSRqLMf5hTWp9qa6vA@mail.gmail.com>
References: <20180214113645.16793-1-ard.biesheuvel@linaro.org>
 <20180214113645.16793-3-ard.biesheuvel@linaro.org>
 <20180305171831.GB12869@arm.com>
 <CAKv+Gu9cHHJN2JrxSeQCHihq0DNz1ZS5xeB4DAHEh5okufRpGw@mail.gmail.com>
 <20180305173428.GA13385@arm.com>
 <CAKv+Gu91CfVq4nBsLhNRRkGN-0PevGeUPSRqLMf5hTWp9qa6vA@mail.gmail.com>
Message-ID: <20180305174250.GD13385@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2018 at 05:41:17PM +0000, Ard Biesheuvel wrote:
> On 5 March 2018 at 17:34, Will Deacon <will.deacon@arm.com> wrote:
> > On Mon, Mar 05, 2018 at 05:26:35PM +0000, Ard Biesheuvel wrote:
> >> On 5 March 2018 at 17:18, Will Deacon <will.deacon@arm.com> wrote:
> >> > On Wed, Feb 14, 2018 at 11:36:44AM +0000, Ard Biesheuvel wrote:
> >> >> Working around Cortex-A53 erratum #843419 involves special handling of
> >> >> ADRP instructions that end up in the last two instruction slots of a
> >> >> 4k page, or whose output register gets overwritten without having been
> >> >> read. (Note that the latter instruction sequence is never emitted by
> >> >> a properly functioning compiler)
> >> >
> >> > Does the workaround currently implemented in the linker also make this
> >> > same assumption? If not, I'm a little wary that we're making an assumption
> >> > about compiler behaviour with no way to detect whether its been violated or
> >> > not.
> >> >
> >>
> >> I can check, but I don't see how a compiler would ever choose 'adrp'
> >> when it emits what amounts to a nop instruction.
> >
> > Agreed, but it wouldn't be the first time we've seen compilers do weird
> > things.
> >
> 
> I just checked ld.bfd: it only checks for sequence 1, which is the one
> that affects ADRP instructions at offsets 0xfff8/0xfffc modulo 4 KB.
> It actually checks more elaborately whether the sequence is in fact
> vulnerable rather than assuming any ADRP instruction at such an offset
> may be vulnerable, but in my testing of the current patches, I only
> get a handful of them anyway of which the majority are resolved by
> patching ADRP->ADR.
> 
> Sequence 2 is described as follows in the docs:
> 
> """
> Sequence 2:
> 1) An ADRP instruction, which writes to a register Rn.
> 2) Another instruction which writes to Rn.
> o This cannot be a branch or an ADRP.
> o This cannot read Rn.
> 3)
> 4)
> Another instruction.
> o This cannot be a branch.
> o This cannot write Rn.
> o This may optionally read Rn.
> A load or store instruction from the "Load/store register (unsigned
> immediate)" encoding class, using Rn as the
> base address register.
> """
> 
> and ld.bfd does not check for it at all.

In which case, the code you're proposing for modules is just as good as
what we're doing for the kernel text itself. Might be worth mentioning that
somewhere, but I think it's fine.

Thanks for looking,

Will
