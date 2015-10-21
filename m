From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 21 Oct 2015 10:38:12 +0200
Subject: [PATCH 0/5] drivers/tty: make more bool drivers explicitly
 non-modular
In-Reply-To: <20151021002007.GA4588@windriver.com>
References: <1445206878-12455-1-git-send-email-paul.gortmaker@windriver.com>
 <20151020151052.GI3421@piout.net>
 <20151021002007.GA4588@windriver.com>
Message-ID: <20151021083812.GL3421@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/10/2015 at 20:20:07 -0400, Paul Gortmaker wrote :
> [Re: [PATCH 0/5] drivers/tty: make more bool drivers explicitly non-modular] On 20/10/2015 (Tue 17:10) Alexandre Belloni wrote:
> 
> > On 18/10/2015 at 18:21:13 -0400, Paul Gortmaker wrote :
> > > The one common thread here for all the patches is that we also
> > > scrap the .remove functions which would only be used for module
> > > unload (impossible) and driver unbind.  For the drivers here, there
> > > doesn't seem to be a sensible unbind use case (vs. e.g. a multiport
> > > PCI ethernet driver where one port is unbound and passed through to
> > > a kvm guest or similar).  Hence we just explicitly disallow any
> > > driver unbind operations to help prevent root from doing something
> > > illogical to the machine that they could have done previously.
> > > 
> > > We've already done this for drivers/tty/serial/mpsc.c previously.
> > > 
> > > Build tested for allmodconfig on ARM64 and powerpc for tty/tty-testing.
> > > 
> > 
> > So, how does this actually build test atmel_serial?
> 
> Not sure why this should be a surprise;  I build test it exactly like this:
> 

CONFIG_SERIAL_ATMEL is not selected by allmodconfig on arm64 or powerpc
so this is not explaining how you build tested atmel_serial.

> paul at builder-02:~/git/linux-head$ echo $ARCH
> arm64
> paul at builder-02:~/git/linux-head$ echo $CROSS_COMPILE 
> aarch64-linux-gnu-
> paul at builder-02:~/git/linux-head$ make O=../arm-build/  drivers/tty/serial/atmel_serial.o
> make[1]: Entering directory '/home/paul/git/arm-build'
> arch/arm64/Makefile:25: LSE atomics not supported by binutils
>   CHK     include/config/kernel.release
>   Using /home/paul/git/linux-head as source for kernel
>   GEN     ./Makefile
>   CHK     include/generated/uapi/linux/version.h
>   CHK     include/generated/utsrelease.h
> 
> [...]
> 
>   HOSTCC  scripts/sign-file
>   HOSTCC  scripts/extract-cert
>   CC      drivers/tty/serial/atmel_serial.o
> make[1]: Leaving directory '/home/paul/git/arm-build'
> paul at builder-02:~/git/linux-head$ 
> 
> It did build; no warning/error.  Would you call it an invalid build test?
> 

What you describe is a different test. I end up with 4 warnings when
doing that on my machine.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
