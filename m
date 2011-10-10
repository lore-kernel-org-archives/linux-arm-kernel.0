From: jon.medhurst@linaro.org (Jon Medhurst (Tixy))
Date: Mon, 10 Oct 2011 08:40:54 +0100
Subject: [PATCH] ARM: kprobes: work around build errors
In-Reply-To: <1318230339.2238.51.camel@computer2>
References: <2056947.a9vGLIKRYk@wuerfel> <1318230339.2238.51.camel@computer2>
Message-ID: <1318232454.2936.18.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-10-10 at 08:05 +0100, Tixy wrote:
> On Sat, 2011-10-08 at 17:07 +0200, Arnd Bergmann wrote:
> > The errors for the thumb variant are using the same tool
> > chain, but obviously in v7 thumb2 mode. The error I got
> > is
> > 
> > /tmp/cczp95OW.s:18721: Error: offset out of range
> > 
> > Reducing the amount of padding in the "TEST_BF_X("bpl.w 2f",0x1000)"
> > test case resolves this, and I experimentally found 0xe20 to be the
> > maximum value in this location, but that is different if I change the
> > surrounding code. This one is much harder to reproduce and I can
> > provide the configuration file I used if that helps.
> 
> The padding value of 0x1000 was deliberately chosen as it forces a
> different instruction encoding to be used. This encoding was introduced
> in ARMv6T2 so the test case should instead be made conditional on
> __LINUX_ARM_ARCH__ >= 7.

This last bit about adding __LINUX_ARM_ARCH__ >= 7 is obviously rubbish
as the Thumb tests are only ever compiled for v7 CPUs and that is what
you were doing. It seams that the problem may instead lie with the
toolchain or could it be a config issue where Thumb kernels are built
for v6 instruction set?

I believe the Thumb test tests were built OK in Linaro's 11.09 release
and the code compiles when I build for a BeagleBoard with gcc version
"4.5.2 (Ubuntu/Linaro 4.5.2-8ubuntu3)".

-- 
Tixy
