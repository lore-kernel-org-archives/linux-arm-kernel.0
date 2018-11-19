From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 19 Nov 2018 09:41:54 -0800
Subject: compiler code model for the kernel
Message-ID: <CAKv+Gu8LchCWB-b+cDmStwrNf5qDs6ZMQ4drv2HMk-8OyjbzNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

Some of us (on cc) have discussed this a bit on various occasions, so
perhaps it's time to sit down and do something about it :-)

The Clang work that Nick is involved in has made explicit some
assumptions that we are currently making in the kernel with respect to
the behavior of GCC, and it would be good to formalise this so we can
keep relying on it in the future, and to clarify to other compiler
developers what is needed.

GCC for x86 has a -mcmodel=kernel parameter, so perhaps we should
introduce the same for AArch64. Under this model, we should be able to
make the following assumptions:
- symbol references are emitted as ADRP/ADD pairs
-  no absolute references in generated code like jump tables etc (like
-fpic/-fpie) [*]
- no shared library semantics (no GOT indirections to support symbol
preemption, or to reduce the CoW footprint and/or avoid text
relocations)
- resulting objects can be linked in -pie mode by ld.bfd

Another thing that came up is that we currently rely on the stack
pointer never to assume a value that is not 16-byte aligned, even
transiently.

Other things I've missed?

[*] This is only strictly required in parts of the code that may
execute at a different offset than the linked offset, even after
processing dynamic relocations at boot time (e.g., KVM hyp code
running in a different exception level) but avoiding those altogether
is reasonable. Note that GCC does the right thing for us here already,
but Clang current;y needs -fno-jump-tables to build the KVM hyp code.
