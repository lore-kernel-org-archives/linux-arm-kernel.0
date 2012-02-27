From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Feb 2012 13:04:53 +0000
Subject: elf_set_personality()
In-Reply-To: <20120227123612.GD12917@tbergstrom-lnx.Nvidia.com>
References: <20120227123612.GD12917@tbergstrom-lnx.Nvidia.com>
Message-ID: <20120227130453.GV22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 02:36:12PM +0200, Peter De Schrijver wrote:
> Commit ID 5e143436d04465c937c1a242808a99c46393af3e
> (fix personality flag propagation across an exec) makes a child process
> inherit a number of personality flags from its parent. This includes the
> READ_IMPLIES_EXEC flag.

So, READ_IMPLIES_EXEC will only be leaked if it's already set.

> Unfortunately this causes problems when debugging
> android applications using gdbserver. It appears that gdbserver on android
> has an executable stack. This causes the kernel to set the READ_IMPLIES_EXEC
> flag on the gdbserver process.

Ok.

> So the child android process will also get this flag.

And that means that attempting to mmap() stuff will also get executable
protections in addition.

> As soon as the android tries to mmap a readonly android shmem segment
> (using the ashmem driver), ashmem will return EPERM, because the segment has
> been exposed as readonly without exec permissions and the kernel will modify
> any readonly mmap request into read and execute.

This sounds like a problem.  If you have two applications trying to use
the ashmem driver, one without READ_IMPLIES_EXEC and one with
READ_IMPLIES_EXEC, then it seems that ashmem will prevent the
READ_IMPLIES_EXEC one from using such regions.  That sounds like a
(different) bug to me.

> Why does the READ_IMPLIES_EXEC flag need to be propagated? Would it be
> acceptable to not propagate it to child processes?

It shouldn't propagate.  But I think it's uncovered a separate problem
in the ashmem driver.
