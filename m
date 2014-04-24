From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 24 Apr 2014 09:37:03 +0200
Subject: [PATCH v6 0/6] ARM: vdso gettimeofday using generic timer
 architecture
In-Reply-To: <20140423215040.GC26756@n2100.arm.linux.org.uk>
References: <cover.1398213562.git.nathan_lynch@mentor.com>
 <20140423215040.GC26756@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu-jFAo8JKqz3XHx348pSUBWaDy48RryKwgsxdM15jeAVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 April 2014 23:50, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Tue, Apr 22, 2014 at 07:48:51PM -0500, Nathan Lynch wrote:
>> - Build vdso.so with -lgcc: calls to __lshrdi3, __divsi3 sometimes
>>   emitted (especially with -Os).  Override certain libgcc functions to
>>   prevent undefined symbols.

After reading Russell's concerns below, I had a quick play with these
patches, and I noticed that the libgcc dependencies are actually only
present when compiling -Os. However, with normal optimization enabled
(which most people are using anyway), you don't need libgcc at all. So
why not override -O2 optimization for vdso.so, and be done with it?

WIth -Os:

Archive member included because of file (symbol)

/usr/lib/gcc-cross/arm-linux-gnueabihf/4.8/sf/libgcc.a(_divsi3.o)
                              arch/arm/kernel/vdso/vgettimeofday.o
(__aeabi_idiv)
/usr/lib/gcc-cross/arm-linux-gnueabihf/4.8/sf/libgcc.a(_lshrdi3.o)
                              arch/arm/kernel/vdso/vgettimeofday.o
(__aeabi_llsr)

Without CONFIG_OPTIMIZE_FOR_SIZE, no archive members are included at all.

-- 
Ard.



>
> This rather worries me.
>
> For a start, the toolchain I use for cross-building kernels (which I
> build myself from gnu.org source) never has a libgcc with it - that's
> because in order to build libgcc, I need a libc, and I don't want to
> have a full cross environment on my machine just to build the soddin
> compiler.
>
> So, I want to be able to build kernels without having a libgcc sitting
> around.
>
> Second point here is that we have multiple different versions of
> userspace crap with multiple different ABIs.  Think about armel vs
> armhf for starters.  There's at least *three* different ELF formats -
> OABI, EABI armel, EABI armhf.  Okay, we can forget about OABI, but
> what about the other two?  What about single zImage where you may
> want a single kernel image which can run on either flavour?
>
> It is not possible to build a single .so which is compatible with
> both - an armhf dynamic linker rejects armel outright, and vice versa.
>
> This, to me, sounds like one big fail... and as far as I'm aware, the
> kernel has no idea itself which flavour of userspace is running, so it
> has no idea which flavour of VDSO to offer (if it even had both.)
>
> --
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
