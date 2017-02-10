From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 10 Feb 2017 13:39:37 +0100
Subject: Aarch64 kernel with 32bit userspace question
In-Reply-To: <78db1867-9bd2-b1f6-ea3f-86aa08c199f5@denx.de>
References: <0057242a-2e16-3b59-1f81-9f4ccf64216d@denx.de>
 <20170209122509.GD27312@n2100.armlinux.org.uk>
 <78db1867-9bd2-b1f6-ea3f-86aa08c199f5@denx.de>
Message-ID: <6172994.uov8zcY07Z@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, February 9, 2017 9:38:41 PM CET Marek Vasut wrote:
> > 
> > The default kernel headers_install will want to place the headers into
> > <includepath>/asm along side <includepath>/asm-generic and
> > <includepath>/linux which is not what modern ARM distros want.
> 
> Thanks for all the help, it at least helped me get a better picture how
> the multilib stuff works on arm/aarch64 .
> 
> It turns out that OE is not yet able to generate multilib sdk, while it
> is able to generate multilib system image. Therefore, while I had two
> different compilers, only one sysroot was installed (aarch64 one) and
> both were pointing into it. The 32bit compiler used the wrong headers,
> so I ran into this issue.  I'll have to drill into the OE further to
> figure out the proper solution.

It seems the support for biarch headers was removed from the kernel
a few years before arm64 got merged: https://lkml.org/lkml/2008/6/30/467

You could still use "make headers_install_all" in place of
"make headers_install" in 
http://git.yoctoproject.org/cgit.cgi/poky/plain/meta/recipes-kernel/linux-libc-headers/linux-libc-headers.inc
but you still have to figure out how to find the right headers,
either by moving the two asm directories to /usr/{arm,aarch64}-linux-gnu/include/asm
or by doing the same trick that we had before the 2008 patch.

	Arnd
