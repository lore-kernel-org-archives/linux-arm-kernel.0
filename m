From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 27 Feb 2012 14:36:12 +0200
Subject: elf_set_personality()
Message-ID: <20120227123612.GD12917@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Commit ID 5e143436d04465c937c1a242808a99c46393af3e
(fix personality flag propagation across an exec) makes a child process
inherit a number of personality flags from its parent. This includes the
READ_IMPLIES_EXEC flag. Unfortunately this causes problems when debugging
android applications using gdbserver. It appears that gdbserver on android
has an executable stack. This causes the kernel to set the READ_IMPLIES_EXEC
flag on the gdbserver process. So the child android process will also get this
flag. As soon as the android tries to mmap a readonly android shmem segment
(using the ashmem driver), ashmem will return EPERM, because the segment has
been exposed as readonly without exec permissions and the kernel will modify
any readonly mmap request into read and execute.

Why does the READ_IMPLIES_EXEC flag need to be propagated? Would it be
acceptable to not propagate it to child processes?

Thanks,

Peter.
