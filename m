From: ramana.radhakrishnan@arm.com (Ramana Radhakrishnan)
Date: Mon, 14 Aug 2017 10:55:48 +0100
Subject: New assembler warnings with binutils 2.29
In-Reply-To: <20170814085901.evwj3rrxo74wcgak@armageddon.cambridge.arm.com>
References: <d101c48b-c47b-be60-4b40-de4f845e4965@redhat.com>
 <20170811092213.mdmzqtm2lp6ltlxt@armageddon.cambridge.arm.com>
 <CAKv+Gu8EQq+azTjMNDpE=TzEd_6b-VdQqUYbCc1=qGuYTU4Srg@mail.gmail.com>
 <20170814085901.evwj3rrxo74wcgak@armageddon.cambridge.arm.com>
Message-ID: <cab26e7e-a052-c78c-5ee7-fe11de1185bd@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 09:59:02AM +0100, Catalin Marinas wrote:
> On Fri, Aug 11, 2017 at 10:26:06AM +0100, Ard Biesheuvel wrote:
> > On 11 August 2017 at 10:22, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Thu, Aug 10, 2017 at 01:13:22PM -0700, Laura Abbott wrote:
> > >> Fedora rawhide recently upgraded to binutils 2.29 and this seems
> > >> to produce new warnings:
> > >>
> > >> ./arch/arm64/include/asm/assembler.h: Assembler messages:
> > >> ./arch/arm64/include/asm/assembler.h:125: Warning: ignoring attempt to redefine built-in register 'lr'
> > >>
> > >> This is
> > >>
> > >> /*
> > >>  * Register aliases.
> > >>  */
> > >> lr      .req    x30             // link register
> > >
> > > Strange, does gas now think 'lr' is a general purpose register (aliased
> > > to x30)? It never was and IIRC the toolchain people many years ago
> > > refused to add it, hence the alias above in the kernel. I wonder if they
> > > added 'fp' as well...

I don't remember the reasons why it was refused in the past. Asking 
around I can't seem to find anyone who remembers why either and it would 
be much quicker to fix the problem in binutils than any of this 
archeology :)

> > >
> > > We could remove the alias and replace all 'lr' instances with 'x30'
> > > throughout the kernel (no too many) or we add some #ifdef around the
> > > above based on the binutils version.
> > 
> > This is annoying. Replacing lr with x30 achieves the opposite of the
> > intent of the binutils change. And using #ifdefs is inaccurate,
> > because you can't really test the binutils version only the GCC
> > version, and those are not tightly coupled.
> > 
> > Can you .unreq it?
> 
> Not really, with an older binutils I get:
> 
> arch/arm64/include/asm/assembler.h:125: Error: unknown register alias 'lr'
> 
> I personally consider this a binutils bug. After 6+ years (probably not
> all public) of building the kernel just fine, all of a sudden certain
> strings became reserved in gas. Three options:

IIRC the ABI states that LR is an alias for X30, FP is an alias for X29,
IP0 an alias for X16 and IP1 an alias for X17.

The warning is unfortunate - looking at the implementation of the
.req directive in gas it's something controlled in the aarch64 backend
and thus we could change gas to make LR (and friends) an internal alias 
thus removing the warning.

Any attempts to realias these to the correct meaning as per the AAPCS 
continues to work from my limited testing of a prototype patch so far.

I'll do a test run and post it on the lists and point you guys to it 
(probably now after lunch as I have a couple of meetings to run to) so 
that you could also test it and let us know if there are any issues.


regards
Ramana
