From: Ramana.Radhakrishnan@arm.com (Ramana Radhakrishnan)
Date: Tue, 20 Nov 2018 13:25:00 +0000
Subject: compiler code model for the kernel
In-Reply-To: <CAKv+Gu8LchCWB-b+cDmStwrNf5qDs6ZMQ4drv2HMk-8OyjbzNQ@mail.gmail.com>
References: <CAKv+Gu8LchCWB-b+cDmStwrNf5qDs6ZMQ4drv2HMk-8OyjbzNQ@mail.gmail.com>
Message-ID: <979349c7-e6f1-9a2a-f38a-9631b4a35fce@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

CC'ing Richard E and James Greenhalgh as well on this thread.


On 19/11/2018 17:41, Ard Biesheuvel wrote:
> Hello all,
>
> Some of us (on cc) have discussed this a bit on various occasions, so
> perhaps it's time to sit down and do something about it :-)
>
> The Clang work that Nick is involved in has made explicit some
> assumptions that we are currently making in the kernel with respect to
> the behavior of GCC, and it would be good to formalise this so we can
> keep relying on it in the future, and to clarify to other compiler
> developers what is needed.
>
> GCC for x86 has a -mcmodel=kernel parameter, so perhaps we should
> introduce the same for AArch64. Under this model, we should be able to
> make the following assumptions:

I would prefer this is -mcmodel=kernel-small so that it's explicit that
this is like the small memory model.

On AArch64 this is what GCC calls the small absolute model in code i.e.
really all global data accesses from code are really PC relative and
thus position independent. The problem is data initializers but I
understand you are able to deal with it by producing relative
relocations by using hidden attributes.

Thus I wonder if we should go as far as implying -fvisibility=hidden in
the compiler for all global data. Is that what you do today ?

In-fact the patch stack I am carrying for the sp_el0 based canary toyed
with the idea of adding such a flag and only putting out the symbol name
for the offset as I really dont' see anyone but the kernel using that
kind of code generation.

> - symbol references are emitted as ADRP/ADD pairs

Ok.

> -  no absolute references in generated code like jump tables etc (like
> -fpic/-fpie) [*]

Ok. -fPIC/pie with default hidden visibility just achieves the same
thing with -mcmodel=small ?

> - no shared library semantics (no GOT indirections to support symbol
> preemption, or to reduce the CoW footprint and/or avoid text
> relocations)

Ok.

> - resulting objects can be linked in -pie mode by ld.bfd

Ok, but never producing a GOT. Further you probably want to have checks
on the final binary once a build is completed to ensure this ?

>
> Another thing that came up is that we currently rely on the stack
> pointer never to assume a value that is not 16-byte aligned, even
> transiently.

I think we've discussed that to great detail as far as GCC is concerned.
  I would prefer it is documented in the kernel documentation as a
requirement for this standard.


TL;DR

http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/611445.html


regards
Ramana

>
> Other things I've missed?
>
> [*] This is only strictly required in parts of the code that may
> execute at a different offset than the linked offset, even after
> processing dynamic relocations at boot time (e.g., KVM hyp code
> running in a different exception level) but avoiding those altogether
> is reasonable. Note that GCC does the right thing for us here already,
> but Clang current;y needs -fno-jump-tables to build the KVM hyp code.
>

IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
