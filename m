From: luto@amacapital.net (Andy Lutomirski)
Date: Tue, 5 Nov 2013 14:36:56 -0800
Subject: ARM audit, seccomp, etc are broken wrt OABI syscalls
Message-ID: <CALCETrUt7Ojh5Yy4KYgBPj_wBr=fzKKJ=OOgGP9BtXoKrr9QnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[cc: some ARM people]

After a bit of an adventure, I got QEMU working.  (Linux 3.12's smc91x
driver and qemu 1.6 don't get along.  It would be great if some
kernel.org page described a standard way to boot a modern Linux image
on a modern QEMU version, but I digress.)

The current state of affairs is unhealthy.  I wrote a program
(attached) that does 'svc $0x90002f' (silly GNU syntax for "Issue the
getgid syscall in OABI").  The registers I program are:

r0: 1
r1: 2
r2: 3
r3: 4
r4: 5
r5: 6

(i.e. the arguments are 1,2,3,4,5,6, although getgid ignores them)

r7: 1

(r7 is the EABI syscall register.  On a kernel without OABI support,
the immediate svc argument is ignored and syscall 1, i.e. _exit, will
be invoked).

Seccomp sees the registers as I set them (unsurprisingly) and it sees
nr == 0x2f.  It passes those values on to a SIGSYS handler, if one
exists.  This is, IMO, bad.  The OABI and EABI argument passing
conventions are *not* the same, and seccomp filters that check syscall
argument values may be spoofable by using OABI calls.

I suspect that audit, perf, ftrace, and maybe even ptrace are broken
as well for exactly the same reason.

I would argue that there are two reasonable fixes:

1. Set a different audit arch for OABI syscalls (e.g.
AUDIT_ARCH_ARMOABI).  That is, treat OABI syscall entries the same way
that x86_64 treats int 80.

2. Leave the 0x900000 bits set in the syscall nr.  That way OABI
syscalls would look like a different set of syscalls on the same
architecture.  That is, treat OABI syscall entries kind of like x86_64
treats x32 syscalls.  (There's probably no reason to accept 0x900000 +
N as an r7 value to cause 'svc 0' to invoke OABI syscall N, though.)

3. Unconditionally kill any process that makes an OABI syscall with
seccomp enabled (because there should be no such programs).  Eww.

Options 1 and 2 are both break ABI, but I doubt that anythink cares.
OABI is, AFAICT, mostly dead.  That being said, even if nothing
legitimate uses OABI, exploits against seccomp-using programs can
certainly use OABI, so I think that this needs to be fixed somehow.

Thoughts?  I think I prefer option 1.  I don't really want to make the
change because my ARM assembly skills are lacking.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: seccomp_oabi.c
Type: text/x-csrc
Size: 2375 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131105/5e363192/attachment.bin>
