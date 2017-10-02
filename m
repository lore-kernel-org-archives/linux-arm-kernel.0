From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 2 Oct 2017 12:24:33 +0100
Subject: undefined instruction d5380001
In-Reply-To: <CAJs94EZqdWJRTF+tLgGU=pcRoU5HvuV959Qq8nFB5yQ-sQyxzg@mail.gmail.com>
References: <CAJs94EZqdWJRTF+tLgGU=pcRoU5HvuV959Qq8nFB5yQ-sQyxzg@mail.gmail.com>
Message-ID: <20171002112433.GM3611@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 29, 2017 at 10:23:54PM +0300, Matwey V. Kornilov wrote:
> Hello,
> 
> I am running 4.13.3 on rockchip 3328 platform(aarch64) with glibc 2.26
> and see the following at booting:
> 
> [   11.152061] modprobe[93]: undefined instruction: pc=0000ffff8ca48ff4
> [   11.152707] Code: d503201f 8a180320 92750001 365ffc20 (d5380001)
> [   11.154347] modprobe[94]: undefined instruction: pc=0000ffff94243ff4
> [   11.154991] Code: d503201f 8a180320 92750001 365ffc20 (d5380001)
> [   11.157070] modprobe[97]: undefined instruction: pc=0000ffff839a0ff4
> [   11.157715] Code: d503201f 8a180320 92750001 365ffc20 (d5380001)
> [   11.159265] modprobe[98]: undefined instruction: pc=0000ffffb0591ff4
> [   11.159908] Code: d503201f 8a180320 92750001 365ffc20 (d5380001)
> 
> As far as I understand d5380001 should be emulated in cpufeature.c but
> it is not. What could be wrong here?

The whole sequence is

   0:   d503201f        nop
   4:   8a180320        and     x0, x25, x24
   8:   92750001        and     x1, x0, #0x800
   c:   365ffc20        tbz     w0, #11, 0xffffffffffffff90
  10:*  d5380001        mrs     x1, midr_el1            <-- trapping instruction

I'm _guessing_ this is the glibc startup code, or otherwise something
similar:

http://www.sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/aarch64/cpu-features.c;h=0275d11c7fa5cba02f3173db25a8a02993e92b7e;hb=1c9a5c270d8b66f30dcfaf1cb2d6cf39d3e18369#l46

The emulation is not guaranteed to work if HWCAP_CPUID (1 << 11) is not
set, but this code does seem to be checking correctly, and v4.13 should
unconditionally set this hwcap and emulate MRS.

So no, I don't know what's going wrong here.


What should happen here is that the do_undefinstr() in
arch/arm64/kernel/traps.c should call registered undef hooks until it
finds one that accepts the faulting instruction.

So, either the cpufeatures undef hook is not getting called, or it is
failing the instruction somewhere, possibly in
cpufeatures.c:emulate_id_reg() or emulate_sys_reg().


Can you add some trace to those functions to see what's happening?

Cc'ing Suzuki, who knows this code better than me and may have some
ideas.

Cheers
---Dave
