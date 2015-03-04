From: keescook@chromium.org (Kees Cook)
Date: Wed,  4 Mar 2015 13:10:44 -0800
Subject: [PATCH v4 0/10] split ET_DYN ASLR from mmap ASLR
Message-ID: <1425503454-7531-1-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To address the "offset2lib" ASLR weakness[1], this separates ET_DYN
ASLR from mmap ASLR, as already done on s390. The architectures
that are already randomizing mmap (arm, arm64, mips, powerpc, s390,
and x86), have their various forms of arch_mmap_rnd() made available
via the new CONFIG_ARCH_HAS_ELF_RANDOMIZE. For these architectures,
arch_randomize_brk() is collapsed as well.

This is an alternative to the solutions in:
https://lkml.org/lkml/2015/2/23/442

I've been able to test x86 and arm, and the buildbot (so far) seems
happy with building the rest.

Thanks!

-Kees

[1] http://cybersecurity.upv.es/attacks/offset2lib/offset2lib.html

v4:
- added Ack on powerpc (mpe)
- fixed mmap_base argument convention to be the same on all archs
- corrected paste-o in mips variable names (buildbot)
- clarified ET_DYN vs mmap ASLR regions in 9/10 (mpe)
v3:
- split change on a per-arch basis for easier review
- moved PF_RANDOMIZE check out of per-arch code (ingo)
v2:
- verbosified the commit logs, especially 4/5 (akpm)
