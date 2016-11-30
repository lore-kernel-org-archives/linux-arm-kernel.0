From: kilobyte@angband.pl (Adam Borowski)
Date: Wed, 30 Nov 2016 07:52:53 +0100
Subject: [RFC3 nowrap: PATCH v7 00/18] ILP32 for ARM64
In-Reply-To: <20161130050209.GB18796@yury-N73SV>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <20161130050209.GB18796@yury-N73SV>
Message-ID: <20161130065253.GA21237@angband.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2016 at 10:32:09AM +0530, Yury Norov wrote:
> On Fri, Oct 21, 2016 at 11:32:59PM +0300, Yury Norov wrote:
> > This series enables aarch64 with ilp32 mode, and as supporting work,
> > introduces ARCH_32BIT_OFF_T configuration option that is enabled for
> > existing 32-bit architectures but disabled for new arches (so 64-bit
> > off_t is is used by new userspace).
> 
> Hi all,
> 
> Steve Ellcey submitted glibc patches for ILP32:
> https://www.sourceware.org/ml/libc-alpha/2016-11/msg01071.html
> It implicitly assumes that kernel clears top halves of registers for
> all syscalls in assembly entry. That patches are going to be taken.
> It it happens, we will have no choice on kernel side how to clear top
> halves anymore.

Since a while ago, there's a package "arch-test" in Debian that empirically
enumerates architectures executable by the running kernel (and loaded
binfmts), by trying small test programs for each.  The list of architectures
it knows does include arm64ilp32.

For most archs the test is just {write(1, "ok\n"); _exit(0);} unless there's
some difference from baseline that should be checked for, like dmb (ARMv7)
on armhf or mtvsrd (POWER8) on ppc64el.  I could scribble in the top half of
a register to test the delousing, but it's not like alternate versions of
the ABI are expected in the wild...


There's another issue: name.  A stalled request to add it to dpkg's cputable
(https://bugs.debian.org/824742) uses "arm64ilp32" and "arm64ilp32be" which
are unwieldy.  Even the discussion uses "ilp32" -- probably too generic. 
https://wiki.linaro.org/Platform/arm64-ilp32 mentions both.  I've heard
"a32" somewhere.  I have no stake here (I'm on the CC list as a x32 not arm
porter...), but if you want to choose a color for this bikeshed, the time
is now.


Meow!
-- 
The bill declaring Jesus as the King of Poland fails to specify whether
the addition is at the top or end of the list of kings.  What should the
historians do?
