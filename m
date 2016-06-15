From: dvyukov@google.com (Dmitry Vyukov)
Date: Wed, 15 Jun 2016 16:36:18 +0200
Subject: [PATCH v2] arm64: allow building with kcov coverage on ARM64
In-Reply-To: <20160615142550.GA7971@leverpostej>
References: <1465923441-107596-1-git-send-email-glider@google.com>
 <20160614175543.GA2468@leverpostej>
 <CAG_fn=X521a9uD1bthDZ-swO9hrfq=jE2C_LUvzkn6C_q5dBvA@mail.gmail.com>
 <20160615092509.GA3984@leverpostej> <20160615114438.GC3984@leverpostej>
 <CAG_fn=U7-fUnw1GLwBbmqGTxnOWf4QcTjTyP4mGAORfEuWt3Eg@mail.gmail.com>
 <20160615142550.GA7971@leverpostej>
Message-ID: <CACT4Y+bqx9LyMxvnD-f6vs3MuTxQJkuPMirz4vfDe8NpfoTUHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 4:25 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> >> > > I built and booted (via EFI) a kernel with this feature enabled (also
>> >> > > with the boot/Makefile change removed). I haven't tested the feature
>> >> > > itself as such, as I'm not sure how to do that.
>> >> > You can test it by running the test program from Documentation/kcov.txt.
>> >>
>> >> Ah, I hadn't spotted that. If I get the chance I'll try to give that a
>> >> go.
>> >
>> > I just had a go (with this applied atop of v4.7-rc3), and I get:
>> >
>> > root at ribbensteg:/home/nanook# ./kcov
>> > mmap: No such device
>> >
>> > The device exists (it was able to open the fd, evidently):
>> >
>> > root at ribbensteg:/home/nanook# ls -al /sys/kernel/debug/kcov
>> > -rw------- 1 root root 0 Jan  1  1970 /sys/kernel/debug/kcov
>> >
>> > Strace show me:
>> >
>> > openat(AT_FDCWD, "/sys/kernel/debug/kcov", O_RDWR) = 3
>> > ioctl(3, CHIOMOVE or CM_IOCGATR, 0x10000) = 0
>> > mmap(NULL, 524288, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = -1 ENODEV (No such device)
>> >
>> > It doesn't look like the error paths in kcov_mmap are hitting.
>> >
>> > Any ideas?
>> According to Dmitry (thanks, Dmitry!) this has regressed recently, but
>> there's a pending patch that should probably fix the problem:
>> http://lkml.iu.edu/hypermail/linux/kernel/1605.2/04379.html
>
> Thanks for the pointer! With that applied, the program runs.
>
> However, it looks like I missed a warning from the kernel build system,
> and my toolchain doesn't actually support -fsanitize-coverage=trace-pc,
> so I'm not going to be able to test that further.
>
> It would be great if we could deliberately not register the debugfs file
> when there was no compiler support for the feature, for those like me
> who miss the build time warning. We do something like that for the LSE
> atomics on arm64.

Hi Mark,

It's a common problem and it would be great to detect this.
But I think it's better to return ENOTSUP from open rather than not
registering the file at all. This way higher level tools will be able
to more easily diagnose the issue and properly report to user. A
missing file looks like not mounted debugfs (which another common
issue).

I am not sure how to do it.
Compiler does not provide any define for this option. And I am not
familiar enough with kernel makefiles. Would it be possible to add a
define to CLAGS in the makefile along with printing the warning?
