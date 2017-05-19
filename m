From: davidm@egauge.net (David Mosberger)
Date: Fri, 19 May 2017 13:42:01 -0600
Subject: crash after receiving SIGCHLD during system call
In-Reply-To: <20170517230236.GK22219@n2100.armlinux.org.uk>
References: <CALnQHM3wjH1CWwUUJX7KhGOOhoW-0r22nyBWmBUJYCUFe-JEtw@mail.gmail.com>
 <20170517170940.GJ22219@n2100.armlinux.org.uk>
 <CALnQHM0tUDkjbX+oBW5pEeuBWUoX2eOmA9Qrc9V2-RsnDV3d6Q@mail.gmail.com>
 <20170517230236.GK22219@n2100.armlinux.org.uk>
Message-ID: <CALnQHM2XfoBrwXrO==MUd_np+WqZ0KX3cfV8Uub=z-Jzp5A-9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just to close on this thread: the reason for the crashes came from the
kernel not having Thumb enabled.  The user-level code wasn't supposed
to use Thumb, but it turns out that glibc-2.24 will use Thumb
instructions in the strlen(), strcmp(), and memcmp() functions even
when you don't ask for it (i.e., there is no CONFIG_THUMB or some such
enabled anywhere).

So, what happened was that user-level used Thumb and occasionally an
interrupt would happen in the middle of the Thumb code.  Now, if the
kernel ended up needing to send a signal (SIGCHLD in my case), it
would set up the signal frame but NOT clear the Thumb-mode bit (since
Thumb-support wasn't enabled).  Thus, when resuming user-level
execution, the CPU would try to execute the signal handler in Thumb
mode, which would then lead to the crash.

Mystery solved.

The code-size increase due to enabling Thumb support in the kernel and
since there is no way to stop user-level from using Thumb, it's really
necessary to always enable Thumb support in the kernel.

I do think it'd be a good idea to have a BUG_ON() for this case (i.e.,
attempting to deliver signal with Thumb-mode bit on, but Thumb-support
disabled), but that's up to the arm kernel maintainers, of course.

  --david
