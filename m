From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 15 Jun 2016 12:44:39 +0100
Subject: [PATCH v2] arm64: allow building with kcov coverage on ARM64
In-Reply-To: <20160615092509.GA3984@leverpostej>
References: <1465923441-107596-1-git-send-email-glider@google.com>
 <20160614175543.GA2468@leverpostej>
 <CAG_fn=X521a9uD1bthDZ-swO9hrfq=jE2C_LUvzkn6C_q5dBvA@mail.gmail.com>
 <20160615092509.GA3984@leverpostej>
Message-ID: <20160615114438.GC3984@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 10:25:10AM +0100, Mark Rutland wrote:
> On Tue, Jun 14, 2016 at 08:16:08PM +0200, Alexander Potapenko wrote:
> > On Tue, Jun 14, 2016 at 7:55 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > > I built and booted (via EFI) a kernel with this feature enabled (also
> > > with the boot/Makefile change removed). I haven't tested the feature
> > > itself as such, as I'm not sure how to do that.
> > You can test it by running the test program from Documentation/kcov.txt.
> 
> Ah, I hadn't spotted that. If I get the chance I'll try to give that a
> go.

I just had a go (with this applied atop of v4.7-rc3), and I get:

root at ribbensteg:/home/nanook# ./kcov 
mmap: No such device

The device exists (it was able to open the fd, evidently):

root at ribbensteg:/home/nanook# ls -al /sys/kernel/debug/kcov 
-rw------- 1 root root 0 Jan  1  1970 /sys/kernel/debug/kcov

Strace show me:

openat(AT_FDCWD, "/sys/kernel/debug/kcov", O_RDWR) = 3
ioctl(3, CHIOMOVE or CM_IOCGATR, 0x10000) = 0
mmap(NULL, 524288, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = -1 ENODEV (No such device)

It doesn't look like the error paths in kcov_mmap are hitting.

Any ideas?

Thanks,
Mark.
