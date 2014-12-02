From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 2 Dec 2014 20:04:32 +0800
Subject: Build LSK 3.14 kernel with android-toolchain
In-Reply-To: <2048273.C5mPR68Ukg@wuerfel>
References: <CAAQ0ZWRQ05GiCOqV2Q6g2B6n+XN-qs9o6MKOFXiK2wKrW0nvog@mail.gmail.com>
 <20141202090450.GD2411@dragon> <20141202173921.314cc869@xhacker>
 <2048273.C5mPR68Ukg@wuerfel>
Message-ID: <20141202120430.GE2411@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 02, 2014 at 11:24:03AM +0100, Arnd Bergmann wrote:
> > > I tracked it a little bit with debug_ll routine printch() and found it
> > > dies at the first pr_info() call in arch/arm/kernel/setup.c:
> > > 
> > >       pr_info("Booting Linux on physical CPU 0x%x\n", mpidr);
> > > 
> > > And I spent some time to find out that the issue was introduced by
> > > commit dad5451a322b (ARM: 7605/1: vmlinux.lds: Move .notes section
> > > next to the rodata) since v3.8 release.  Reverting the commit helps me
> > > to get a booting kernel that is built by arm-linux-androideabi
> > > toolchain.  But I do not have the knowledge to understand what is
> > > happening.
> > > 
> > 
> > From my experience in last several years
> > 
> > 1. the arm-linux-androideabi- toolchain sets some options by default, PIC for
> > example, even -mno-android can't disable all the side effects per my test.
> 
> Yes, that's definitely possible. Any idea how the android folks build their
> kernel?
> 
> > 2. the arm-linux-eandroideabi- toolchain use gold for linker by default. Maybe
> > gold can't understand vmlinux.lds correctly?
> 
> That would be very easy to test, just set LD=${CROSS_COMPILE}ld.bfd on the
> command line and rebuild. In my testing, I've encountered a number of different
> bugs in both ld.bfd and ld.gold that prevent you from building the kernel.

Yes, either reverting commit dad5451a322b (ARM: 7605/1: vmlinux.lds:
Move .notes section next to the rodata) or building kernel with
LD=${CROSS_COMPILE}ld.bfd get me a working kernel.

Shawn
