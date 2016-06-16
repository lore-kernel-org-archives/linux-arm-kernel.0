From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 16 Jun 2016 16:44:12 +0100
Subject: [PATCH v2] arm64: allow building with kcov coverage on ARM64
In-Reply-To: <CAG_fn=X=LSEN2FS0rapgW1PEEqkDLcSXLdxeKa=5ya9g0GJ23A@mail.gmail.com>
References: <1465923441-107596-1-git-send-email-glider@google.com>
 <20160614175543.GA2468@leverpostej>
 <CAG_fn=X521a9uD1bthDZ-swO9hrfq=jE2C_LUvzkn6C_q5dBvA@mail.gmail.com>
 <20160615092509.GA3984@leverpostej>
 <20160615114438.GC3984@leverpostej>
 <CAG_fn=U7-fUnw1GLwBbmqGTxnOWf4QcTjTyP4mGAORfEuWt3Eg@mail.gmail.com>
 <20160615142550.GA7971@leverpostej> <576283B9.9050900@arm.com>
 <CAG_fn=X=LSEN2FS0rapgW1PEEqkDLcSXLdxeKa=5ya9g0GJ23A@mail.gmail.com>
Message-ID: <20160616154412.GC31477@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2016 at 05:20:03PM +0200, Alexander Potapenko wrote:
> On Thu, Jun 16, 2016 at 12:47 PM, James Morse <james.morse@arm.com> wrote:
> > On 15/06/16 15:25, Mark Rutland wrote:
> >> On Wed, Jun 15, 2016 at 01:53:03PM +0200, Alexander Potapenko wrote:
> >>> On Wed, Jun 15, 2016 at 1:44 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> >>>> On Wed, Jun 15, 2016 at 10:25:10AM +0100, Mark Rutland wrote:
> >>>>> On Tue, Jun 14, 2016 at 08:16:08PM +0200, Alexander Potapenko wrote:
> >>>>>> On Tue, Jun 14, 2016 at 7:55 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> >>>>>>> I built and booted (via EFI) a kernel with this feature enabled (also
> >>>>>>> with the boot/Makefile change removed). I haven't tested the feature
> >>>>>>> itself as such, as I'm not sure how to do that.
> >>>>>> You can test it by running the test program from Documentation/kcov.txt.
> >>>>>
> >>>>> Ah, I hadn't spotted that. If I get the chance I'll try to give that a
> >>>>> go.
> >>>>
> >>>> I just had a go (with this applied atop of v4.7-rc3), and I get:
> >>>>
> >>>> root at ribbensteg:/home/nanook# ./kcov
> >>>> mmap: No such device
> >>>>
> >>>> The device exists (it was able to open the fd, evidently):
> >>>>
> >>>> root at ribbensteg:/home/nanook# ls -al /sys/kernel/debug/kcov
> >>>> -rw------- 1 root root 0 Jan  1  1970 /sys/kernel/debug/kcov
> >>>>
> >>>> Strace show me:
> >>>>
> >>>> openat(AT_FDCWD, "/sys/kernel/debug/kcov", O_RDWR) = 3
> >>>> ioctl(3, CHIOMOVE or CM_IOCGATR, 0x10000) = 0
> >>>> mmap(NULL, 524288, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = -1 ENODEV (No such device)
> >>>>
> >>>> It doesn't look like the error paths in kcov_mmap are hitting.
> >>>>
> >>>> Any ideas?
> >>> According to Dmitry (thanks, Dmitry!) this has regressed recently, but
> >>> there's a pending patch that should probably fix the problem:
> >>> http://lkml.iu.edu/hypermail/linux/kernel/1605.2/04379.html
> >>
> >> Thanks for the pointer! With that applied, the program runs.
> >>
> >> However, it looks like I missed a warning from the kernel build system,
> >> and my toolchain doesn't actually support -fsanitize-coverage=trace-pc,
> >> so I'm not going to be able to test that further.
> >
> > I dusted off a compiler that supports this, and ran the sample program under
> > Documentation with the above unproxify patch.
> >
> > Tested-by: James Morse <james.morse@arm.com>
> I think it's time to ask now :)
> If I receive "Tested-by" or "Acked-by" responses, do I need to send
> out a patch adding them, or should I rely on the maintainer taking the
> patch to the tree?
> The first option reduces the amount of work done by the maintainer,
> while the second one reduces the traffic in the list.
> Sorry, I couldn't find the answer in the manuals.

It's up to the maintainer, so it varies. The best thing to do is to ask
the maintainer what they'd prefer.

>From my experience, Catalin is usually happy to add tags, so I suspect
he'd be happy to do so for this patch (assuming he's happy to pick it
up). I'll leave it for him to say either way.

Thanks,
Mark.
