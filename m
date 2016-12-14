From: schwab@suse.de (Andreas Schwab)
Date: Wed, 14 Dec 2016 15:34:54 +0100
Subject: jemalloc testsuite stalls in memset
Message-ID: <mvmmvfy37g1.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When running the jemalloc-4.4.0 testsuite on aarch64 with glibc 2.24 the
test/unit/junk test hangs in memset:

(gdb) r
Starting program: /tmp/jemalloc/jemalloc-4.4.0/test/unit/junk
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
test_junk_small: pass
test_junk_large: pass
^C
Program received signal SIGINT, Interrupt.
memset () at ../sysdeps/aarch64/memset.S:91
91              str     q0, [dstin]
(gdb) x/i $pc
=> 0xffffb7ddf54c <memset+140>: str     q0, [x0]

x0 is pointing to the start of this mmap'd block:

      0xffffb7400000     0xffffb7600000   0x200000        0x0

Any attempt to contine execution or step over the insn still causes the
process to hang here.  Only after accessing the memory through the
debugger the test successfully continues to completion.

The kernel has been configured with transparent hugepages.

CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y

This issue has been bisected to commit
b8d3c4c3009d42869dc03a1da0efc2aa687d0ab4 ("mm/huge_memory.c: don't split
THP page when MADV_FREE syscall is called").

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
