From: cd2436@columbia.edu (Christoffer Dall)
Date: Wed, 14 Apr 2010 17:29:07 +0200
Subject: cache problems with mmap'ed data structure in KVM
Message-ID: <q2p7d08b87d1004140829m9fc9bc6vab970f7c2e45aa0c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When booting a guest on an arm1136 physical cpu using my KVM
implementation (https://wiki.ncl.cs.columbia.edu/wiki/index.php/AndroidVirt:MainPage),
I get some distorted output in QEMU, which performs device emulation
for the kernel and thereby emulates a pl011 serial device.

QEMU shares a data structure with the kernel by mmap'ing a file
descriptor like this:
  env->kvm_run = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
MAP_SHARED, env->kvm_fd, 0);

The problem arises when the kernel writes to this data structure using
the kernel virtual addresses. The data does not seem to be
synchronized to the user space application reads.

I'm guessing that I need to initiate a cache writeback on the kernel
side and a re-read on the user space side, but I'm unsure what the
right way to go about it is.

Any help will be greatly (!) appreciated.

Thank you,
Christoffer Dall
