From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue, 20 Oct 2015 20:20:07 -0400
Subject: [PATCH 0/5] drivers/tty: make more bool drivers explicitly
 non-modular
In-Reply-To: <20151020151052.GI3421@piout.net>
References: <1445206878-12455-1-git-send-email-paul.gortmaker@windriver.com>
 <20151020151052.GI3421@piout.net>
Message-ID: <20151021002007.GA4588@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Re: [PATCH 0/5] drivers/tty: make more bool drivers explicitly non-modular] On 20/10/2015 (Tue 17:10) Alexandre Belloni wrote:

> On 18/10/2015 at 18:21:13 -0400, Paul Gortmaker wrote :
> > The one common thread here for all the patches is that we also
> > scrap the .remove functions which would only be used for module
> > unload (impossible) and driver unbind.  For the drivers here, there
> > doesn't seem to be a sensible unbind use case (vs. e.g. a multiport
> > PCI ethernet driver where one port is unbound and passed through to
> > a kvm guest or similar).  Hence we just explicitly disallow any
> > driver unbind operations to help prevent root from doing something
> > illogical to the machine that they could have done previously.
> > 
> > We've already done this for drivers/tty/serial/mpsc.c previously.
> > 
> > Build tested for allmodconfig on ARM64 and powerpc for tty/tty-testing.
> > 
> 
> So, how does this actually build test atmel_serial?

Not sure why this should be a surprise;  I build test it exactly like this:

paul at builder-02:~/git/linux-head$ echo $ARCH
arm64
paul at builder-02:~/git/linux-head$ echo $CROSS_COMPILE 
aarch64-linux-gnu-
paul at builder-02:~/git/linux-head$ make O=../arm-build/  drivers/tty/serial/atmel_serial.o
make[1]: Entering directory '/home/paul/git/arm-build'
arch/arm64/Makefile:25: LSE atomics not supported by binutils
  CHK     include/config/kernel.release
  Using /home/paul/git/linux-head as source for kernel
  GEN     ./Makefile
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h

[...]

  HOSTCC  scripts/sign-file
  HOSTCC  scripts/extract-cert
  CC      drivers/tty/serial/atmel_serial.o
make[1]: Leaving directory '/home/paul/git/arm-build'
paul at builder-02:~/git/linux-head$ 

It did build; no warning/error.  Would you call it an invalid build test?

> 
> A proper solution would be to actually make it a tristate and allow
> building as a module. I think it currently fails because of
> console_initcall() but that is certainly fixable.

Well, as per other threads on this topic, if people want to extend
the functionality to support tristate, then great.  But please do
not confuse that with existing functionality which is clearly non
modular in this case.

Thanks,
Paul.
--

> 
> 
> -- 
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
