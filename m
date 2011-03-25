From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 25 Mar 2011 13:30:21 +0000
Subject: RFC: ARM: Support for VFP/NEON registers in coredumps
In-Reply-To: <OF13B038E5.B9DFA4EA-ONC125785E.0047A984-C125785E.004871A1@de.ibm.com>
References: <20110324141826.GA3810@arm.com>
	<OF1A9833E7.A620B0FF-ONC125785D.004F4BC3-C125785D.0052255A@de.ibm.com>
	<AANLkTin+X7BNBE9ZuDQhHVeNQqeNPjqj16pZDLTag_n+@mail.gmail.com>
	<OFAB8D9B91.5F6DE70D-ONC125785D.0059E446-C125785D.005B916C@de.ibm.com>
	<AANLkTinzxmULwhgXHbAUw0zveYXYj8zxRgZkoPYdOPhc@mail.gmail.com>
	<OF17449AB0.36DF06DD-ONC125785D.00635CD3-C125785D.0063E8BB@de.ibm.com>
	<AANLkTi=VtCy9MrY5+wGYfh9+otWy87WmFZkmGN-PqMPo@mail.gmail.com>
	<OF13B038E5.B9DFA4EA-ONC125785E.0047A984-C125785E.004871A1@de.ibm.com>
Message-ID: <AANLkTi=zrf-_S3fFFb69SXPvGhZawwEY94kt74CVC8-n@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 25, 2011 at 1:11 PM, Ulrich Weigand
<Ulrich.Weigand@de.ibm.com> wrote:
> Dave Martin <dave.martin@linaro.org> wrote:
>> > So to summarize: the kernel will write additional note sections as if
>> > generated via user_regset_view, containing the PTRACE_GETVFPREGS data.
>> >
>> > Note name: "LINUX"
>>
>> Why "LINUX" and not "CORE"? ?I don't understand the distinction... are
>> the "CORE" notes common to all platforms / all ELF implementations?
>
> Because that's what user_regset_view would do; all notes except the
> standard ones (NT_PRPSINFO, NT_PRSTATUS, NT_PRFPREG, NT_AUXV) have a
> note name of "LINUX". ? I'm not completely sure about the rationale,
> but presumably it is indeed because the standard notes are more or less
> common across multiple platforms.

OK -- I'm happy to go along with this.  It's easy to change if someone
doesn't like it, though I expect it will be accepted as-is.

>
>> > Note type: t.b.d. [*]
>> >
>> > [*] Looking at elf.h a logical name/value might be:
>> >
>> > #define NT_ARM_VFP ? ? ? ? ? ?0x400 ? ? ? ? ? ? /* ARM VFP/NEON
> registers */
>> >
>> >
>> > GDB support along those lines ought to be straightforward.
>>
>> It's been suggested that the new note should include a version/flags
>> field alongside the ptrace-like register dump, so that if the format
>> turns out to be inadequate / broken, it can be extended in a
>> compatible way.
>>
>> However, nothing else in the coredump or the ptrace interface seems to
>> have such versioning implementation. ?Ptrace gets extended by adding
>> more and more ptrace call types instead. ?Adding version fields, while
>> sensible, seems inconsistent with the current implementation.
>>
>> What's your view on adding a flags field to the VFP state dump?
>
> Again, if we want to use (or mimic) the user_regset_view mechanism,
> there is no choice in any of this; the content of the note will be
> exactly identical to the content of the ptrace buffer. ?Since this
> is the way everybody else is using, I think we'd have to have really
> good arguments for deviating from it; I'm not sure I see those.
>
> The usual way to deal with changes to the register set is to define
> *new* regset structures, which then translates to new ptrace commands
> and new core files notes, which are used instead of or in addition to
> the old ones ...

I was indeed thinking that it might be a good idea to take this
opportunity to migrate to using regsets; though for simplicity, I'll
probably avoid this for the first iteration.

Will this have any impact on the ptrace interface?

Cheers
---Dave
