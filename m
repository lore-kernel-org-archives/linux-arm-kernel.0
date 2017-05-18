From: davidm@egauge.net (David Mosberger)
Date: Thu, 18 May 2017 09:28:00 -0600
Subject: crash after receiving SIGCHLD during system call
In-Reply-To: <CALnQHM1WpXmvkK8eCqd8G=6Ny-O=PD=nSaa1kwQBAB6dNwa1Hg@mail.gmail.com>
References: <CALnQHM3wjH1CWwUUJX7KhGOOhoW-0r22nyBWmBUJYCUFe-JEtw@mail.gmail.com>
 <20170517170940.GJ22219@n2100.armlinux.org.uk>
 <CALnQHM0tUDkjbX+oBW5pEeuBWUoX2eOmA9Qrc9V2-RsnDV3d6Q@mail.gmail.com>
 <20170517230236.GK22219@n2100.armlinux.org.uk>
 <CALnQHM2ocw5ETbwsRF_c43tweHruunOjsfaBOT5Qxgt2K6Ww1g@mail.gmail.com>
 <CALnQHM1WpXmvkK8eCqd8G=6Ny-O=PD=nSaa1kwQBAB6dNwa1Hg@mail.gmail.com>
Message-ID: <CALnQHM23aTPcmWy0p6=ffdZUX1jb7H-mKmZJ6L7GyvXWikhPAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 17, 2017 at 11:34 PM, David Mosberger <davidm@egauge.net> wrote:

> I also confirmed that at the end of sys_rt_sigreturn(), the T bit in
> regs->ARM_cpsr is NEVER set.

Similarly, regs->ARM_lr does not have bit 0 set (expect when it's
obviously used as a scratch registers, with values of 0x1 or 0x10d).

To me, it looks like bit 0 of a return address gets corrupted
(possibly a register state corruption or an on-stack corruption).
That would in turn cause the "bx rl" instruction to turn on Thumb mode
and things go south from there.  It's interesting that only one bit
get corrupted since the address overall looks plausible.

  --david
