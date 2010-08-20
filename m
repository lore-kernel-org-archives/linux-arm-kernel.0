From: Simon.Richter@hogyros.de (Simon Richter)
Date: Fri, 20 Aug 2010 14:41:28 +0200
Subject: ptrace(PTRACE_PEEKUSER, ..., PT_TEXT_ADDR, ...)
Message-ID: <20100820124118.GC6950@richter>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

when patching gdbserver to work on MMUless ARM systems I found that
there are two definitions for the magic values for PT_TEXT_ADDR (and the
related fields) in different Linux versions. uClinux 2.4 kernels use
values starting from 0xc4 (the same as the Coldfire port), while 2.6
based kernels use magic numbers starting from 0x10000, which were
introduced in 68b7f7153fa58df710924fbb79722717d2d16094 .

As has been pointed out by Andreas Schwab from SuSE, the code
responsible for returning the text segment address is never reached
because the lines immediately before the code added in the commit
already filter these out and return -EIO.

So apparently the new values have never really been in use (so I
wouldn't consider them part of the kernel interface), and the old values
now point to something else (because VFP registers were added to struct
user).

The "new" values are published in <asm/ptrace.h>, and according to a
quick search on koders.com, no one but gdb even mentions that name; gdb
only does so in gdbserver/linux-low.c, where the entire block that
retrieves the offsets is conditional, and as <sys/ptrace.h> does not
pull in <asm/ptrace.h> and gdbserver only includes the former, hence the
current mechanism is unused on ARM, and debugging on MMUless systems is
broken.

How should this be resolved?

Option 1 would be to exempt the magic values from the size check in
arch/arm/kernel/ptrace.c. That would probably introduce the least
breakage, should libc ever decide to include <asm/ptrace.h> from
<sys/ptrace.h> and someone else use the new libc headers with old kernel
headers.

Option 2 is to move the values to the user page. This way, the special
case in ptrace.c could go away, however it would make the values
writeable via ptrace(), which would probably be undesirable.

Additionally, we could introduce a warning if anyone uses 0xc4, 0xc8 or
0xcc as offsets without also reading at 0xc0 before; this way, people
using the "old" interface can be told to upgrade.

Opinions?

   Simon
