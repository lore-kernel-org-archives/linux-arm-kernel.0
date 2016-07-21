From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Jul 2016 10:21:55 +0100
Subject: [RFC 3/3] kexec: extend kexec_file_load system call
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D5F4FE82B@AcuExch.aculab.com>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160712014201.11456-4-takahiro.akashi@linaro.org>
 <20160715130955.GC23514@redhat.com>
 <20160715131950.GB19840@leverpostej>
 <20160718023024.GB6310@dhcp-128-65.nay.redhat.com>
 <063D6719AE5E284EB5DD2968C1650D6D5F4FE82B@AcuExch.aculab.com>
Message-ID: <20160721092155.GM1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2016 at 11:41:35AM +0000, David Laight wrote:
> From: Dave Young
> > I do not think it is worth to add another syscall for extra fds.
> > We have open(2) as an example for different numbers of arguments
> > already.
> 
> Probably works 'by luck' and no one has actually thought about why.
> That ioctl() works is (probably) even more lucky.
> 
> There are ABI that use different calling conventions for varags functions
> (eg always stack all the arguments). I guess linux doesn't run on any of them.
> 
> ioctl() is a particular problem because the 'arg' might be an integer or a pointer.
> Fortunately all the 64bit ABI linux uses pass the arg parameter in a register
> (and don't use different registers for pointer and data arguments).
> 
> You could have two 'libc' functions that refer to the same system call entry.
> Certainly safer than a varargs function.

Don't forget that the syscall API is not a normal C function API - it's
special, because there's little point stacking arguments on the userspace
stack and then having the kernel function try and read them off the
kernelspace stack.

If an architecture does such a thing, then it needs special veneers to
handle that (reading off the userspace stack and placing them onto the
kernelspace stack, or the arch needs to define some other method of
handling the situation.)

So, really, the actual C APIs don't matter that much - what matters more
is the definition of a sane way to pass such arguments.  Given the
extensive historical nature of open() and ioctl(), it would be completely
silly not to create something which allows these calls to work.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
