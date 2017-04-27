From: gregkh@linuxfoundation.org (gregkh)
Date: Thu, 27 Apr 2017 16:04:55 +0200
Subject: stable/linux-3.18.y build: 204 builds: 5 failed, 199 passed, 35
 errors, 212 warnings (v3.18.49)
In-Reply-To: <CAK8P3a0QN_8PPGaMYA8GZG6axseRLcJq=--1NgfOAPaEGgiAjg@mail.gmail.com>
References: <58f8ea00.84621c0a.da7d6.1c19@mx.google.com>
 <CAK8P3a3QsSMtc7AWjVjtM+tW8ARt1Ygw53=CSjgbG6Pvpq0QvQ@mail.gmail.com>
 <20170427103348.GA9881@kroah.com>
 <CAK8P3a0QN_8PPGaMYA8GZG6axseRLcJq=--1NgfOAPaEGgiAjg@mail.gmail.com>
Message-ID: <20170427140455.GA1919@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 27, 2017 at 01:40:22PM +0200, Arnd Bergmann wrote:
> On Thu, Apr 27, 2017 at 12:33 PM, gregkh <gregkh@linuxfoundation.org> wrote:
> > On Fri, Apr 21, 2017 at 04:27:14PM +0200, Arnd Bergmann wrote:
> >> On Thu, Apr 20, 2017 at 7:04 PM, kernelci.org bot <bot@kernelci.org> wrote:
> >> > stable/linux-3.18.y build: 204 builds: 5 failed, 199 passed, 35 errors, 212 warnings (v3.18.49)
> >>
> >> I've gone through all these now and found a fix. In three cases, there is no
> >> fix yet since the respective drivers got removed before the warning was
> >> noticed. Do we have a policy for how to deal with those? Should I just
> >> send patches to address the warnings for 3.18?
> >
> > I've wondered about this, and yeah, I would like to see the number drop
> > to 0 if at all possible (the scsi driver will not change), so i'll be
> > glad to take patches for the code that is no longer in upstream.
> 
> Ok, I'll have a go at this after the build report.
> 
> >> > drivers/scsi/advansys.c:71:2: warning: #warning this driver is still not
> >> > properly converted to the DMA API [-Wcpp]
> >>
> >> The driver was properly converted in v4.2 and the warning removed, but the
> >> conversion would be outside of stable-kernel-rules.
> >
> > Yeah, this one is going to have to stay as-is :(
> 
> How about just shutting up the #warning then, based on the argument that
> the warning isn't helping anyone fix it, and all the other drivers that had not
> been converted at the time don't come with a #warning?

Yes, I'll take a patch for that, especially as the driver is now fixed
in newer kernels.

> >> aebac99384f7 ("MIPS: kernel: entry.S: Set correct ISA level for mips_ihb")
> >
> > That was in 3.18.14, what kernel are you looking at here???
> 
> For most of the changes, I tried looking at 'git log v3.18..stable/linux-4.4.y'
> and immediately found the obvious fix. If that didn't help, I tried a few other
> things, but I usually did not look in 3.18.y to see if it was already there
> if I found something at first that looked obviously right.
> 
> This is another case where I confused the patch that introduced the
> warning with the one that fixed it. This one requires a another patch that
> got merged into 3.20:
> 
> be5136988e25 ("MIPS: asm: compiler: Add new macros to set ISA and arch
> asm annotations")

There was no "3.20", it was "4.0" :)

Thanks, I've applied this now.

> >> > cerfcube_defconfig (arm) ? PASS, 0 errors, 2 warnings, 0 section mismatches
> >> >
> >> > Warnings:
> >> > fs/nfsd/nfs4state.c:3781:3: warning: 'old_deny_bmap' may be used
> >> > uninitialized in this function [-Wmaybe-uninitialized]
> >>
> >> 5368e1a6 ("nfsd: work around a gcc-5.1 warning")
> 
> It's a copy-paste mistake, missing the first digits of the commit ID,
> I found the correct one now:
> 
> 6ac75368e1a6 nfsd: work around a gcc-5.1 warning

Now applied.

> > That commit id isn't in Linus's tree, where did you get it from?
> >> > defconfig+CONFIG_LKDTM=y (mips) ? PASS, 0 errors, 3 warnings, 0 section
> >> > mismatches
> >> >
> >> > Warnings:
> >> > include/asm-generic/div64.h:43:28: warning: comparison of distinct pointer
> >> > types lacks a cast
> >> > include/asm-generic/div64.h:43:28: warning: comparison of distinct pointer
> >> > types lacks a cast
> >>
> >> 2ae83bf93882 ("[CIFS] Fix setting time before epoch (negative time values)")
> >
> > That was in 3.17, are you sure you are looking at 3.18 like the subject
> > says???
> 
> Another similar mistake on my end, 2ae83bf93882 introduced the problem,
> the fix we need was
> 
> 97c7134ae22f ("Fix signed/unsigned pointer warning")

Looks good, also now applied, thanks.

greg k-h
