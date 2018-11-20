From: will.deacon@arm.com (Will Deacon)
Date: Tue, 20 Nov 2018 13:23:32 +0000
Subject: compiler code model for the kernel
In-Reply-To: <CAKv+Gu8LchCWB-b+cDmStwrNf5qDs6ZMQ4drv2HMk-8OyjbzNQ@mail.gmail.com>
References: <CAKv+Gu8LchCWB-b+cDmStwrNf5qDs6ZMQ4drv2HMk-8OyjbzNQ@mail.gmail.com>
Message-ID: <20181120132331.GB25884@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2018 at 09:41:54AM -0800, Ard Biesheuvel wrote:
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

It would be great if we could disable idiom recognition by the compiler as
part of this option, since this ends up with us failing to inline code
because the compiler ends up wanting to use vector registers but can't, so
replaces the idiom with a call to a libgcc function which we're forced to
implement out-of-line.

https://bugzilla.kernel.org/show_bug.cgi?id=200671

Another desirable feature would be having a way to force the assembler
to accept arbitrary instructions, rather than have to use .arch_extension
all over the place.

Will
