From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 2 Dec 2014 17:39:21 +0800
Subject: Build LSK 3.14 kernel with android-toolchain
In-Reply-To: <20141202090450.GD2411@dragon>
References: <CAAQ0ZWRQ05GiCOqV2Q6g2B6n+XN-qs9o6MKOFXiK2wKrW0nvog@mail.gmail.com>
 <2052560.M0NHOo7Rnz@wuerfel> <20141202090450.GD2411@dragon>
Message-ID: <20141202173921.314cc869@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn,

On Tue, 2 Dec 2014 01:04:54 -0800
Shawn Guo <shawn.guo@linaro.org> wrote:

> + LAKML and more people.
> 
> On Mon, Dec 01, 2014 at 05:38:38PM +0100, Arnd Bergmann wrote:
> > On Monday 01 December 2014 16:32:21 Shawn Guo wrote:
> > > Is it a valid or supported use case to build LSK 3.14 kernel with
> > > android-toolchain?  I can build a LSK 3.14 kernel with Linux toolchain
> > > gcc-linaro-arm-none-eabi-4.9-2014.09, which boots fine on my board.
> > > When I build the same kernel with
> > > android-toolchain-eabi-4.9-2014.09-x86, the kernel can be built out
> > > successfully, but it fails to boot on the board at very early stage
> > > with only uncompressing message shown up like below.
> > > 
> > > Uncompressing Linux... done, booting the kernel.
> > > 
> > > And it's not a LSK 3.14 specific problem, I tried to build mainline
> > > 3.10, 3.14 and 3.18-rc4 with the android-toolchain, and they all
> > > failed to boot.
> > > 
> > > I need some help to understand if it's a valid use case at all, before
> > > I try to looking into the problem.
> > 
> > I would expect it to work, it's probably a good idea to find out
> > why it doesn't. For all I know 'arm-none-eabi' is actually /not/
> > supported for building the kernel, since that doesn't use the Linux
> > Linux variant of eabi, while 'arm-*-linux-gnueabi' or
> > 'arm-*-linux-gnueabihf' is the default for Linux these days and
> > 'arm-*-linux-android' should be compatible with that.
> 
> Okay.  Thanks for the info.  It seems that I should download
> gcc-linaro-arm-linux-gnueabihf-4.9-2014.09 for comparison testing then.
> Actually, in the very first testing I used arm-linux-gnueabi-gcc 4.7.3
> shipped with Ubuntu 14.04.
> 
> > What is the
> > exact target triplet you use in those two cases?
> 
> They are arm-none-eabi and arm-linux-androideabi.  And I also replaced
> the first toolchain with arm-linux-gnueabi one, and got the same result.
> 
> > 
> > A few things you could try:
> > 
> > - boot it in qemu using the vexpress or virt platform code, see if
> >   the symptom is the same. If it is, attach gdb to the qemu gdbstub
> >   to look at the contents of the _log_buf.
> > 
> > - Maybe debug_ll crashes, try disabling that
> > 
> > - Maybe debug_ll is disabled already, try enabling it to see if you
> >   get more output.
> 
> I tracked it a little bit with debug_ll routine printch() and found it
> dies at the first pr_info() call in arch/arm/kernel/setup.c:
> 
> 	pr_info("Booting Linux on physical CPU 0x%x\n", mpidr);
> 
> And I spent some time to find out that the issue was introduced by
> commit dad5451a322b (ARM: 7605/1: vmlinux.lds: Move .notes section
> next to the rodata) since v3.8 release.  Reverting the commit helps me
> to get a booting kernel that is built by arm-linux-androideabi
> toolchain.  But I do not have the knowledge to understand what is
> happening.
> 

>From my experience in last several years

1. the arm-linux-androideabi- toolchain sets some options by default, PIC for
example, even -mno-android can't disable all the side effects per my test.

2. the arm-linux-eandroideabi- toolchain use gold for linker by default. Maybe
gold can't understand vmlinux.lds correctly?

Thanks,
Jisheng
