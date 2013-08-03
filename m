From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 3 Aug 2013 01:03:21 +0100
Subject: [ARM ATTEND] catching up on exploit mitigations
In-Reply-To: <CAGXu5jKv9Vt+Hu0mFYaxggLLDZ46U3KR9MKegUoHH8StXCkBtQ@mail.gmail.com>
References: <CAGXu5jKv9Vt+Hu0mFYaxggLLDZ46U3KR9MKegUoHH8StXCkBtQ@mail.gmail.com>
Message-ID: <20130803000321.GR23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 12:05:40PM -0700, Kees Cook wrote:
> - vector table protections (needs to be protected like the x86_64
> vsyscall table, RO, etc)

(Dropped some mailing lists to reduce the visibility of this as its
soo close to the patches being merged...)

On the subject of this, those who are following what's going on at the
blackhat conference will be aware that there was a presentation
yesterday on this very subject.

Now that the presentation has been done, and the fixes are now merged
into Linus' tree, I can now talk about this.

There seems to be some confusion about the vector page - there are some
people who claim that the vector page is writable from userspace.  They
are simply wrong - no mainline kernel has ever had wriable vectors from
userspace.  That would be one hell of a big security hole.

However, there is a concern that the vector page reveals too much
information to userspace about the kernel, possibly giving away the
location of the syscall table, and whether the exposed code in that
page could be used to assist exploits of user applications - effectively
making ASLR useless.

This has been mitigated as much as reasonably possible; the signal
return code is now in a page which is placed randomly into the user
address space - and the signal handlers are placed randomly within
that page, and the page poisoned with a faulting instruction on both
ARM and Thumb.

The vector page is also poisoned in a similar manner; any attempt to
execute non-intentional code in that page will result in a SIGILL.

The code fragments which are jumped to by the instruction at the vector
location is now moved to a following page, which is inaccessible to
userspace.  All userspace can see there now is a set of branches to
the following page, not the branches into the kernel image.

The kuser helpers are an all together much bigger problem, because
they're part of our userspace ABI.  Don't go thinking that modern
builds don't call them, because they do, even when the builds are
optimised for ARMv7, as I can demonstrate with Ubuntu 12.04.1 ARMHF.
The get_tls helper still sees quite an amount of calls to it.

However, the option is given to the guy configuring the kernel to
disable these and make the vector page inaccessible to userspace.
When the page is made inaccessible to userspace, it becomes read-only
on the kernel side too.  The down side of this is the user ABI breakage,
so it can only be done _if_ you're sure that you have absolutely no
users of that stuff and none of your 3rd party stuff does either (iow,
think Android apps).

Some other solutions were considered, such as trapping faults to the
page and emulating the code that was there; given the amount of use
this stuff gets, I believe that would have a noticable performance
impact.  I also considered making the vectors page inaccessible to
userspace based on a kernel command line parameter - that's something
we can add if people want that.

As this issue in itself does not lead to the kernel being exploitable,
I view this as a fairly minor security issue; these patches are just
hardening the system against possible abuse, just like ASLR
theoretically makes it harder.
