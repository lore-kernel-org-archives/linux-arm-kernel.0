From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Oct 2010 13:54:38 +0100
Subject: Own syscall implementation
In-Reply-To: <AANLkTinkx11iDEh2HAagdaER9yShQKmh1oSbMgRHMyyo@mail.gmail.com>
References: <AANLkTinkx11iDEh2HAagdaER9yShQKmh1oSbMgRHMyyo@mail.gmail.com>
Message-ID: <20101011125438.GE27153@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 11, 2010 at 02:52:04PM +0300, Oleg Kutkov wrote:
> Hello.
> 
> My name is Oleg and i'm newbie in a arm-kernel.
> I doing experiments with kernel and trying to add my own syscall.
> What i'm done:
> 1. Added somewhere this code:
> 
> asmlinkage long sys_mycall(int call, unsigned long __user *args);
> 
> SYSCALL_DEFINE2(mycall, int, call, unsigned long __user *, args)
> {
>       unsigned long a[6];
> 
>    if (err = copy_from_user(a, args, nargs[call])) {
>        return -EFAULT;
>    }
> 
>        ///some cool work///
> }


That's fine, except that there's no bounds checking for the value of
'call', which if it were negative or a large positive number would
overflow the nargs array.  You're also not propagating the error back.

> 2. Added to calls.S my function (but i'm not really understand what this :( )
> 
> .long sys_mycall

You don't say what kernel version.

> 3. And finally define in unistd.h:
> 
> #define __NR_mycall                    (__NR_SYSCALL_BASE+312)

As 312 is already taken (we're now up to 369), and you're using .long, I
can only assume this is quite an old kernel...  Modern kernels use CALL()
in calls.S to ensure that the number of syscalls are properly counted.

Note that this is a problem to people adding random new syscalls - they'll
get in the way of future additions to the kernel, and in some cases, glibc
probes for support for syscalls by trying to call them.

So it's really not a good idea to create new syscalls for production code.
It's usually safer to write something like a char device driver and use
the read/write/ioctl methods instead.

> Everything is good, but when some one calls me from userspace - i
> receiving garbage in args and copy_from_user is failed to copy data...

Have you checked the value of 'call' and nargs[call] ?  Note that
copy_from_user() takes the number of _bytes_ to copy, not the number
of arguments.
