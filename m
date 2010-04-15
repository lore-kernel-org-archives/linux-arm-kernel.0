From: hollis@penguinppc.org (Hollis Blanchard)
Date: Thu, 15 Apr 2010 12:19:03 -0700
Subject: [Android-virt] cache problems with mmap'ed data structure in KVM
In-Reply-To: <q2p7d08b87d1004140829m9fc9bc6vab970f7c2e45aa0c@mail.gmail.com>
References: <q2p7d08b87d1004140829m9fc9bc6vab970f7c2e45aa0c@mail.gmail.com>
Message-ID: <v2nfb412d761004151219va46cd840v5b2b67f022536b70@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 14, 2010 at 8:29 AM, Christoffer Dall <cd2436@columbia.edu> wrote:
> When booting a guest on an arm1136 physical cpu using my KVM
> implementation (https://wiki.ncl.cs.columbia.edu/wiki/index.php/AndroidVirt:MainPage),
> I get some distorted output in QEMU, which performs device emulation
> for the kernel and thereby emulates a pl011 serial device.
>
> QEMU shares a data structure with the kernel by mmap'ing a file
> descriptor like this:
> ?env->kvm_run = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
> MAP_SHARED, env->kvm_fd, 0);
>
> The problem arises when the kernel writes to this data structure using
> the kernel virtual addresses. The data does not seem to be
> synchronized to the user space application reads.

It sounds like you've already figured out the VIVT caching problems.

> I'm guessing that I need to initiate a cache writeback on the kernel
> side and a re-read on the user space side, but I'm unsure what the
> right way to go about it is.

The simplest might be to map this structure uncached on both sides
(kernel and user).

As an alternative, you might be able to use flush_user_range() and
flush_kern_dcache_area() (see arch/arm/include/asm/cacheflush.h). That
wouldn't really work with host SMP, but then again with host SMP you
probably will have different cache design that will avoid the problem
to begin with.

-Hollis
