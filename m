From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Sep 2013 21:47:43 +0100
Subject: About atags_proc buffer size
In-Reply-To: <5245E9C9.9030509@gmail.com>
References: <5245E9C9.9030509@gmail.com>
Message-ID: <20130927204743.GK12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 10:25:45PM +0200, Vojtech Bocek wrote:
> I want to ask something about atags_proc.c implementation. Currently,
> it uses a buffer to temporarily store atags. The buffer size is set to
> 1.5kb for some reason, but as far as I know, atag list's size is not
> limited in any way. I've got a device (HTC One) which uses about 12kb
> of tags, that means it panics during boot if CONFIG_ATAGS_PROC is
> enabled, because the buffer contains only part of the tag list without
> an end tag.

The tags are supposed to be a short-lived structure which gets used to
pass barest minimum of details to the kernel, and the data stored in
them almost certainly gets overwritten before the kernels memory
allocators are up and running.

So, we need to statically allocate some space to save these things -
it can't be done dynamically.

The problem is this: for the vast majority of platforms, they pass no
more than 1.5kB (lower case b is *bits* not *bytes*) to the kernel in
their tagged list.  Having a static allocation of 12k would be wasteful
for the majority of users.

> I don't know much about the way ARM boot process works, but I tried to
> store just the pointer to atag list, and it works fine (quick patch
> attached). Do atags get erased later in boot process on some platforms,
> is that the reason why buffer had to be used?

This may appear to work, but check it after you've been running for
some time and have exercised the memory systems.  You'll probably find
that your tags have vanished!
