From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 27 Nov 2014 11:57:15 +0100
Subject: [PATCH/RFC 0/4] ARM: shmobile: Correct masks for GIC PPI interrupts
Message-ID: <1417085839-22836-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi all,

This patch series corrects the masks in the second interrupt cells for
Private Peripheral Interrupts in dtsi files for the shmobile family of
SoCs.

It's my understanding this mask should reflect the actual number of CPU
cores the interrupt is wired too.
Is that correct?

  - Hence it should be "GIC_CPU_MASK_SIMPLE(2)" on dual-core CPUs, like
    r8a7791 and r8a7794 (the first two patches),
  - Should it be "GIC_CPU_MASK_SIMPLE(8)" on big.LITTLE configurations
    with four Cortex-A15 cores and four Cortex-A7 cores?
    Or should the interrupts be delivered to the four Cortex-A15 cores
    only by default?
    The last two RFC-patches implement the former for r8a7790 and
    r8a73a4.

Note that incorrect masks for GIC PPI interrupts are not limited to
shmobile. Presumably the interrupt specifiers got copied around a lot,
cfr. the proliferation of "GIC_CPU_MASK_SIMPLE(4)" (and the older
hardcoded "0xf0x" variant) in various dtsi files, not always limited to
quad-core CPUs.

This was tested on r8a7791/koelsch, which uses the arch timer interrupt.

Thanks for your feedback!

Geert Uytterhoeven (4):
  ARM: shmobile: r8a7791: Correct mask for GIC PPI interrupts
  ARM: shmobile: r8a7794: Correct mask for GIC PPI interrupts
  [RFC] ARM: shmobile: r8a7790: Correct mask for GIC PPI interrupts
  [RFC] ARM: shmobile: r8a73a4: Correct mask for GIC PPI interrupts

 arch/arm/boot/dts/r8a73a4.dtsi | 10 +++++-----
 arch/arm/boot/dts/r8a7790.dtsi | 10 +++++-----
 arch/arm/boot/dts/r8a7791.dtsi | 10 +++++-----
 arch/arm/boot/dts/r8a7794.dtsi | 10 +++++-----
 4 files changed, 20 insertions(+), 20 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
