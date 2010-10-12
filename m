From: elenbert@gmail.com (Oleg Kutkov)
Date: Tue, 12 Oct 2010 17:50:53 +0300
Subject: Own syscall implementation
In-Reply-To: <AANLkTikKyYfABS0SJUrxEckoW7XakUq1Ln8puv5vus5s@mail.gmail.com>
References: <AANLkTinkx11iDEh2HAagdaER9yShQKmh1oSbMgRHMyyo@mail.gmail.com>
	<20101011125438.GE27153@n2100.arm.linux.org.uk>
	<AANLkTikKyYfABS0SJUrxEckoW7XakUq1Ln8puv5vus5s@mail.gmail.com>
Message-ID: <AANLkTimRg-noVZimRZfYFPVuhBdu21oO8Jp9qVp7mp89@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I understood my errors. Everything is good now.
Anyway, thank you!

2010/10/11 Oleg Kutkov <elenbert@gmail.com>:
> Thank you for answer.
> Sorry, now i made some changes due to actual kernel version
>
> 2010/10/11 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>> That's fine, except that there's no bounds checking for the value of
>> 'call', which if it were negative or a large positive number would
>> overflow the nargs array. ?You're also not propagating the error back.
>>
>
> asmlinkage long sys_mycall(int call, unsigned long __user *args);
>
> SYSCALL_DEFINE2(mycall, int, call, unsigned long __user *, args)
> {
> ?unsigned long a[6];
> ?int err;
>
> ?if (call < 1 || call > SYS_ACCEPT4) {
> ? ? ? return -EINVAL;
> ?}
>
> ?if (err = copy_from_user(a, args, nargs[call])) {
> ? ? ?return -EFAULT;
> ?}
>
> ?switch (call) {
> ? ? case 0: /*some work*/ break;
> ? ? case 1: /*some work*/ break;
> ? ? default: break;
> ?}
>
> ?return err;
> }
>
>> You don't say what kernel version.
>
> My kernel version is 2.6.29
>
>> As 312 is already taken (we're now up to 369), and you're using .long, I
>> can only assume this is quite an old kernel... ?Modern kernels use CALL()
>> in calls.S to ensure that the number of syscalls are properly counted.
>
> call.S:
>
> CALL(sys_mycall)
>
>> So it's really not a good idea to create new syscalls for production code.
>> It's usually safer to write something like a char device driver and use
>> the read/write/ioctl methods instead.
>
> I understood. I just want to understand "how it works"
>
>> Have you checked the value of 'call' and nargs[call] ? ?Note that
>> copy_from_user() takes the number of _bytes_ to copy, not the number
>> of arguments.
>>
>
> Yes, i checked "call", as i show in code before. nargs i found in
> net/socket.c and it defined as:
> #define AL(x) ((x) * sizeof(unsigned long))
> static const unsigned char nargs[19]={
> ? ? ? ?AL(0),AL(3),AL(3),AL(3),AL(2),AL(3),
> ? ? ? ?AL(3),AL(3),AL(4),AL(4),AL(4),AL(6),
> ? ? ? ?AL(6),AL(2),AL(5),AL(5),AL(3),AL(3),
> ? ? ? ?AL(4)
> };
>
> I looking on SYSCALL_DEFINE2(socketcall, int, call, unsigned long
> __user *, args) and here is: if (copy_from_user(a, args,
> nargs[call])).
> I used that just as an example that i found..
>
