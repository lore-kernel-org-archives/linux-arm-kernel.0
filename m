From: Peter.Smith@arm.com (Peter Smith)
Date: Tue, 20 Nov 2018 11:20:02 +0000
Subject: compiler code model for the kernel
In-Reply-To: <CAKwvOdkeA28avR-GKUABE+4+2n6xaWcOXB=FGfVpkXq5DmN0mQ@mail.gmail.com>
References: <CAKv+Gu8LchCWB-b+cDmStwrNf5qDs6ZMQ4drv2HMk-8OyjbzNQ@mail.gmail.com>,
 <CAKwvOdkeA28avR-GKUABE+4+2n6xaWcOXB=FGfVpkXq5DmN0mQ@mail.gmail.com>
Message-ID: <AM0PR08MB3538CEF9CBAB3C49BAABD455F8D90@AM0PR08MB3538.eurprd08.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


________________________________________
From: Nick Desaulniers <ndesaulniers@google.com>
Sent: 19 November 2018 23:54
To: Ard Biesheuvel
Cc: Will Deacon; Catalin Marinas; Ramana Radhakrishnan; Linux ARM; Mark Rutland; Arnd Bergmann; Marc Zyngier; Peter Smith; Kristof Beyls; Stephen Hines
Subject: Re: compiler code model for the kernel

+ some more folks to take a look

On Mon, Nov 19, 2018 at 9:42 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
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
> - symbol references are emitted as ADRP/ADD pairs
> -  no absolute references in generated code like jump tables etc (like
> -fpic/-fpie) [*]
> - no shared library semantics (no GOT indirections to support symbol
> preemption, or to reduce the CoW footprint and/or avoid text
> relocations)
> - resulting objects can be linked in -pie mode by ld.bfd
>
> Another thing that came up is that we currently rely on the stack
> pointer never to assume a value that is not 16-byte aligned, even
> transiently.
>
> Other things I've missed?
>
> [*] This is only strictly required in parts of the code that may
> execute at a different offset than the linked offset, even after
> processing dynamic relocations at boot time (e.g., KVM hyp code
> running in a different exception level) but avoiding those altogether
> is reasonable. Note that GCC does the right thing for us here already,
> but Clang current;y needs -fno-jump-tables to build the KVM hyp code.

Not got a lot to add at the moment. Some observations from the clang/llvm side.

Clang already has -mcmodel=kernel for fuchsia targets so there is some prior art. My understanding is that it uses the small code-model with some small tweaks. There will probably need to be some renaming in the back-end to distinguish between fuchsia kernel code model and linux kernel code model.

I think that the assumptions above should be describable without too much difficulty. ADRP/ADD is covered by the small code model. I think the existing -fpie where every global has hidden visibility and hence cannot be found in a shared object will produce code with no GOT indirections.

My limited understanding of the frame lowering code suggests that clang maintains a minimum 16-byte alignment of the stack pointer at all times. It would need to be looked over by an expert to make sure though.

Peter
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
