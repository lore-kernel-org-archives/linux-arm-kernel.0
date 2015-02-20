From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Feb 2015 09:40:35 +0000
Subject: Announce: rmk's nightly builder gets ARM64 support
In-Reply-To: <CAKv+Gu_5fOinMVYbk99unmEDSqCF3Z7QdXiQTw0VrrWW16Oc6w@mail.gmail.com>
References: <20150219171220.GA8656@n2100.arm.linux.org.uk>
 <20150219183444.GB8656@n2100.arm.linux.org.uk>
 <20150220092003.GB31692@arm.com>
 <CAKv+Gu_5fOinMVYbk99unmEDSqCF3Z7QdXiQTw0VrrWW16Oc6w@mail.gmail.com>
Message-ID: <20150220094035.GE8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 09:24:39AM +0000, Ard Biesheuvel wrote:
> On 20 February 2015 at 09:20, Will Deacon <will.deacon@arm.com> wrote:
> > [adding Ard]
> >
> > On Thu, Feb 19, 2015 at 06:34:44PM +0000, Russell King - ARM Linux wrote:
> >> On Thu, Feb 19, 2015 at 05:12:20PM +0000, Russell King - ARM Linux wrote:
> >> > Today, I have added ARM64 support to my automated nightly kernel builder.
> >> > Initially, this will result in ARM64 builds being tested with allnoconfig
> >> > and defconfig, and I shall add allmodconfig and allyesconfig to this in
> >> > the coming days.
> >> >
> >> > Once that is done and stable, I will investigate adding an ARM Juno
> >> > platform to my boot farm so we can run the results of the builder.
> >> >
> >> > Other recent changes have been a disk upgrade, so the builder now has
> >> > plenty of disk space to run the allmodconfig and allyesconfig, which
> >> > used to fail (or be skipped) when the disk space was low.
> >> >
> >> > I've also added a new ARM target for building the defconfig without a
> >> > seed.
> >> >
> >> > As ever, all results are in the usual place, at:
> >> >
> >> > http://www.arm.linux.org.uk/developer/build/
> >>
> >> It seems that there's either something wrong with the kernel, or
> >> there's a problem with binutils.
> >>
> >> /tmp/cc1B9ysz.s:99: Error: selected processor does not support `aese v0.16b,v1.16b'
> >> /tmp/cc1B9ysz.s:207: Error: selected processor does not support `aesimc v1.16b,v0.16b'
> >> /tmp/cc1B9ysz.s:255: Error: selected processor does not support `aese v0.16b,v1.16b'
> >> /tmp/cc1B9ysz.s:389: Error: selected processor does not support `aesd v0.16b,v2.16b'
> >> /tmp/cc1B9ysz.s:389: Error: selected processor does not support `aesimc v0.16b,v0.16b'
> >> /tmp/cc1B9ysz.s:389: Error: selected processor does not support `aesd v0.16b,v3.16b'
> >> /tmp/cc1B9ysz.s:389: Error: selected processor does not support `aesimc v0.16b,v0.16b'
> >> /tmp/cc1B9ysz.s:389: Error: selected processor does not support `aesd v0.16b,v1.16b'
> >> /tmp/cc1B9ysz.s:389: Error: selected processor does not support `aesimc v0.16b,v0.16b'
> >> /tmp/cc1B9ysz.s:389: Error: selected processor does not support `aesd v0.16b,v2.16b'
> >> /tmp/cc1B9ysz.s:455: Error: selected processor does not support `aese v0.16b,v2.16b'
> >> /tmp/cc1B9ysz.s:455: Error: selected processor does not support `aesmc v0.16b,v0.16b'
> >> /tmp/cc1B9ysz.s:455: Error: selected processor does not support `aese v0.16b,v3.16b'
> >> /tmp/cc1B9ysz.s:455: Error: selected processor does not support `aesmc v0.16b,v0.16b'
> >> /tmp/cc1B9ysz.s:455: Error: selected processor does not support `aese v0.16b,v1.16b'
> >> /tmp/cc1B9ysz.s:455: Error: selected processor does not support `aesmc v0.16b,v0.16b'
> >> /tmp/cc1B9ysz.s:455: Error: selected processor does not support `aese v0.16b,v2.16b'
> >> make[2]: *** [arch/arm64/crypto/aes-ce-cipher.o] Error 1
> >>
> >> I've tried both the mainline git version, and the sourceware.org
> >> binutils-gdb.git version, both result in the same errors.
> >
> > It sounds like GCC isn't propagating the march flags down to the assembler,
> > since we take care in arch/arm64/crypto/Makefile to pass the '+crypto'
> > option for these files.
> >
> 
> Yes, this looks like a GCC problem, not binutils, since there are
> other .S files in the same folder that contain crypto instructions
> that build fine. This particular one is a .c file with AES
> instructions in inline asm() (and we pass -march=armv8-a+crypto)

Maybe we need to get jk's blog post updated - it's currently on of
the top hits in google, so this is probably going to trip up a lot of
people if they follow the instructions there.

http://jk.ozlabs.org/docs/arm64-toolchain/

So it sounds like possibly the binutils part of those instructions is
fine, it's the gcc part which isn't.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
