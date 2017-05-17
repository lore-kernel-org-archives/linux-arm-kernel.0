From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 May 2017 18:09:40 +0100
Subject: crash after receiving SIGCHLD during system call
In-Reply-To: <CALnQHM3wjH1CWwUUJX7KhGOOhoW-0r22nyBWmBUJYCUFe-JEtw@mail.gmail.com>
References: <CALnQHM3wjH1CWwUUJX7KhGOOhoW-0r22nyBWmBUJYCUFe-JEtw@mail.gmail.com>
Message-ID: <20170517170940.GJ22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 17, 2017 at 10:04:32AM -0600, David Mosberger wrote:
> I added some instrumentation code to the SIGCHLD handler of lighttpd
> v1.4.45 and I have seen crashes after the SIGCHLD handler
> interrupted __libc_fork() and close().  The one constant so far is
> that the pc register in the signal handler machine-context
> (mcontext_t) points to the instruction after the "svc 0" instruction.

I don't think there's much to be read into that as signal delivery to
a process always occurs on the thread's exit path from kernel mode to
user mode.

This happens after:

- completion of an interrupt handler
- completion of a kernel syscall
- completion of a page fault

What would help is to enable CONFIG_DEBUG_USER and pass 'user_debug=31'
to the kernel.  It should be more verbose about the cause of the fault
from the kernel point of view.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
