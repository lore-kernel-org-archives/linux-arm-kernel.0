From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 9 Apr 2014 07:30:16 +0200
Subject: Big endian working?
In-Reply-To: <CAA3XUr3gR-R1X6+CxP-Z0fv7kiSzENtm0NsYd539BNVWKCgdNw@mail.gmail.com>
References: <20140408095446.0520dd28@skate> <5343BDEE.4010005@linaro.org>
 <12950765.TpxjkTx5NP@wuerfel>
 <alpine.LFD.2.11.1404082339291.1571@knanqh.ubzr>
 <CAA3XUr3gR-R1X6+CxP-Z0fv7kiSzENtm0NsYd539BNVWKCgdNw@mail.gmail.com>
Message-ID: <20140409073016.72060cd3@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Victor Kamensky,

On Tue, 8 Apr 2014 21:46:05 -0700, Victor Kamensky wrote:

> > If I remember correctly, those are for booting a BE kernel on hardware
> > that initializes in LE mode and expects a LE kernel.  Since the zImage
> > header values are defined to be words, those must be swapped so they
> > read as LE even if the kernel is BE.  Of course the kernel is then
> > responsible for switching the endian mode when entered.
> 
> My understanding is that CPU_BE8_BOOT_LE was needed only for
> atags boot case. Since now practically nobody uses atags, but rather
> fdt those patches were not pushed into main stream.

Well it would still be nice to have ATAGs support, as a few people are
still using old, non fdt-capable bootloaders.

> Please look at
> git://git.baserock.org/delta/linux baserock/311-rc7/be/atags-v2
> 
> Thomas, does your Armada XP uboot still uses atags? I would think
> not.

The bootloader is not doing FDT based booting, but in my BE kernel, I
have:

# CONFIG_ATAGS is not set
# CONFIG_ARM_ATAG_DTB_COMPAT is not set

So the kernel completely ignores the ATAGs.

> I can confirm that in main line TC2 works in BE mode without any
> changes. In linaro kernel tree we have Arandle and Pandaboard with
> additional, drivers only changes, and they work OK. However I don't
> think we are testing zImage, in all cases I use it, it is uImage.
> 
> Maybe Nico's zImage change was under atags umbrella by mistake and
> it really addresses general zImage issue. In this case we need to add
> this commit to main line. However, I don't think we need to carry
> CPU_BE8_BOOT_LE option forward, why we just use
> CONFIG_CPU_BIG_ENDIAN instead. Note in all cases when BE
> image used loader is always in LE mode. Never seen case
> otherwise.
> 
> As toolchain concerned any recent 4.7 and 4.8 should work. Note
> toolchain should may not be configured as BE by default. LE toolchain
> should compile BE kernel just fine.

Right, in the end, the BE kernel was working completely fine for me,
without any patches. The problem was due to a mistake made between the
load address and entry point address encoded into the uImage header vs.
the real address at which I was loading the uImage in memory. This was
leading the first 0x40 bytes of the kernel code to be skipped,
therefore skipping the "setend be" instructions.

The most amazing thing being that with a LE kernel, even if you skip
the first 0x40 bytes of the kernel code, it still boots completely
successfully! This is the reason why it took me so long to debug: if a
LE kernel is booting, and the same BE kernel with the same
configuration doesn't boot, surely it shouldn't be related to how/where
I load the kernel. But it was!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
