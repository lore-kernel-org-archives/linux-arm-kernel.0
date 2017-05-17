From: davidm@egauge.net (David Mosberger)
Date: Wed, 17 May 2017 10:04:32 -0600
Subject: crash after receiving SIGCHLD during system call
Message-ID: <CALnQHM3wjH1CWwUUJX7KhGOOhoW-0r22nyBWmBUJYCUFe-JEtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have been seeing occasional random crashes of lighttpd for a few
months now.  I was hoping it was
just a temporary glitch, but the problem has persisted across many
different kernel versions
(currently at 4.9.28) and BUILDROOT versions (currently at 2017.02.2).
The issue sounds a lot like this bug report:

 http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/241421.html

We use BUILDROOT with glibc v2.24 on a Cortex A5 processor (with hard-float).

At this point, I'm mostly wondering whether we're the only ones seeing
this problem.

strace indicates that lighttpd always crashes after receiving SIGCHLD
(i.e., no further system calls until the
SIGSEGV or SIGILL hits).

I added some instrumentation code to the SIGCHLD handler of lighttpd
v1.4.45 and I have seen crashes after the SIGCHLD handler
interrupted __libc_fork() and close().  The one constant so far is
that the pc register in the signal handler machine-context
(mcontext_t)
points to the instruction after the "svc 0" instruction.

Anyone have seen anything similar?

  --david
