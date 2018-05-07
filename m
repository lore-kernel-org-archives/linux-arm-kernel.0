From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  7 May 2018 15:56:59 +0200
Subject: [PATCH 0/8] ARM: dts: renesas: Add PMU device nodes
Message-ID: <1525701427-12914-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series enables support for the ARM Performance Monitor Units
in Cortex-A7, Cortex-A9, and Cortex-A15 CPU cores on Renesas RZ/A1,
R-Car Gen2, and RZ/G1 SoCs.  This allows for better performance analysis
using the "perf" tool.

Sample output of "perf stat echo" on r8a7791/koelsch:

  - Before:

     Performance counter stats for 'echo':

	      2,636300      task-clock (msec)         #    0,265 CPUs utilized
		     8      context-switches          #    0,003 M/sec
		     0      cpu-migrations            #    0,000 K/sec
		    43      page-faults               #    0,016 M/sec
       <not supported>      cycles
       <not supported>      stalled-cycles-frontend
       <not supported>      stalled-cycles-backend
       <not supported>      instructions
       <not supported>      branches
       <not supported>      branch-misses

	   0,009960300 seconds time elapsed

  - After:

     Performance counter stats for 'echo':

	      2,455400      task-clock (msec)         #    0,273 CPUs utilized
		     3      context-switches          #    0,001 M/sec
		     0      cpu-migrations            #    0,000 K/sec
		    45      page-faults               #    0,018 M/sec
	     3.556.784      cycles                    #    1,449 GHz
       <not supported>      stalled-cycles-frontend
       <not supported>      stalled-cycles-backend
	     1.350.480      instructions              #    0,38  insns per cycle
	       335.542      branches                  #  136,655 M/sec
		18.075      branch-misses             #    5,39% of all branches

	   0,008987900 seconds time elapsed

Still missing:
  - R-Mobile APE6 (no PMU interrupt documented),
  - R-Car M1A and H1 (the PMU interrupt seems to be routed to the legacy
    SH INTC only?),
  - RZ/G1C (SMP support not yet upstream).

This has been tested on r8a7791/koelsch, and boot-tested on
r7s72100/genmai, r8a7790/lager, r8a7792/blanche, and r8a7794/silk.

Thanks!

Geert Uytterhoeven (8):
  ARM: dts: r7s72100: Add PMU device node
  ARM: dts: r8a7790: Add PMU device nodes
  ARM: dts: r8a7791: Add PMU device node
  ARM: dts: r8a7792: Add PMU device node
  ARM: dts: r8a7793: Add PMU device node
  ARM: dts: r8a7794: Add PMU device node
  ARM: dts: r8a7743: Add PMU device node
  ARM: dts: r8a7745: Add PMU device node

 arch/arm/boot/dts/r7s72100.dtsi |  5 +++++
 arch/arm/boot/dts/r8a7743.dtsi  |  7 +++++++
 arch/arm/boot/dts/r8a7745.dtsi  |  7 +++++++
 arch/arm/boot/dts/r8a7790.dtsi  | 18 ++++++++++++++++++
 arch/arm/boot/dts/r8a7791.dtsi  |  7 +++++++
 arch/arm/boot/dts/r8a7792.dtsi  |  7 +++++++
 arch/arm/boot/dts/r8a7793.dtsi  |  7 +++++++
 arch/arm/boot/dts/r8a7794.dtsi  |  7 +++++++
 8 files changed, 65 insertions(+)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
