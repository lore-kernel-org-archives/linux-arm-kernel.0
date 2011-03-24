From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 24 Mar 2011 14:18:26 +0000
Subject: RFC: ARM: Support for VFP/NEON registers in coredumps
Message-ID: <20110324141826.GA3810@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Considering how to add the VFP/NEON register state to Coredumps,
there's no single obvious solution, so I'd like to put this out
for people's comments.

Currently, the coredump consists of several notes, the interesting
ones currently being:

 * NT_PRSTATUS - general process status, including the integer registers
 * NT_FPREGSET - the FPA registers (only present if FPA is in use)

These notes are duplicated per thread when a multithreaded process
dumps core.

There are few options I see:

 a) Dump the VFP/NEON state in NT_FPREGSET.
    This could be appended to, or in place of the legacy FPA regs,
    with flags in a header or (struct elf_prstatus).pr_fpvalid
    to describe what was dumped.  Old gdb etc. may read the
    resulting information as random FPA register contents;
    this could perhaps be avoided by always dumping a dummy
    FPA regs structure at the start of this note, though this
    seems wasteful.

    Possibly, gdb may explode if the NT_FPREGSET note is larger
    then expected.  I've not investigated this.

 b) Dump the VFP/NEON regs in a note of type NT_PRXFPREG.
    This avoids defining a new note type; however, this note type
    is really for x86 -- so overloading it in this way may just
    be nonsensical / confusing.

 c) Create a new note type specially for this, and dump the
    VFP/NEON regs in there.  This is closest to the model followed
    by ptrace, where PTRACE_GETREGS, PTRACE_GETFPREGS and
    PTRAGE_GETVFPREGS are all distinct.


Going for (c) seems sanest to me, and also means that old gdb
will just ignore the new data; this is probably what we want.

Comments are welcome.

Cheers
---Dave
