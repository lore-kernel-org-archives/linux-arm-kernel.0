From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Wed, 9 Sep 2009 16:54:20 +0400
Subject: Collie/Simpad hacks in head-sa1100.S break booting on other machines
Message-ID: <20090909125420.GA13915@rainbow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

When trying to boot kernel with both CONFIG_SA1100_COLLIE and
CONFIG_SA1100_H3600 compiled in on iPaq h3600, I suddenly have been
bitten by this hack in arch/arm/boot/compressed/head-sa1100.S:

#ifdef CONFIG_SA1100_COLLIE
                mov     r7, #MACH_TYPE_COLLIE
#endif

Yes, it's silently sets machine ID to MACH_TYPE_COLLIE on _any_ SA1100 machine
if CONFIG_SA1100_COLLIE is set. And there's also similar hack (or broken
bootloader workaround, if you like) for Simpad.

I don't know if these hacks are needed anymore (for Collie with stock
bootloader probably yes, for Simpad I don't know as I don't have this
hardware), but I think something should be done at least to prevent
selecting other machines if CONFIG_SA1100_COLLIE or CONFIG_SA1100_SIMPAD
selected. Please find not very elegant, but working patch in attahment.
It just adds "depends on !SA1100_COLLIE && !SA1100_SIMPAD" to every other
machine. Sadly, I'm not an expert in kconfig - maybe there's a better way
to do that?

-- 
Best regards,
Dmitry "MAD" Artamonow
