From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 19 Oct 2016 11:59:11 +0200
Subject: [PATCH 2/5] ARM: dts: Add Integrator/AP cpus node and operating points
In-Reply-To: <1476871154-32243-1-git-send-email-linus.walleij@linaro.org>
References: <1476871154-32243-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1476871154-32243-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the cpus node to the Integrator/AP device tree so
that we have a proper placeholder to put in the DT-defined
operating points for the generic DT/OPP cpufreq driver,
along with the proper operating points.

The old Integrator cpufreq driver would resolve the max
frequency to 71MHz, and the min frequency to 12 MHz, but
the clock driver can actually handle any frequency inbetween
so I picked a few select frequencies as OPPs. The cpufreq
framework doesn't seem to deal with sliding frequency scales,
only fixed points so 7 OPPs is better than 2 atleast.

We define a CPU node since this is required for cpufreq-dt,
however we do not define any compatible string for the CPU
since this architecture has pluggable CPU modules and we
do not know which one will be used. If necessary, the CPU
compatible can be filled in by the boot loader, but for
just cpufreq-dt it is not required.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/integratorap.dts | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/integratorap.dts b/arch/arm/boot/dts/integratorap.dts
index 6f16d09dc5a4..e8b249f92fb3 100644
--- a/arch/arm/boot/dts/integratorap.dts
+++ b/arch/arm/boot/dts/integratorap.dts
@@ -10,6 +10,41 @@
 	compatible = "arm,integrator-ap";
 	dma-ranges = <0x80000000 0x0 0x80000000>;
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			/*
+			 * Since the board has pluggable CPU modules, we
+			 * cannot define a proper compatible here. Let the
+			 * boot loader fill in the apropriate compatible
+			 * string if necessary.
+			 */
+			/* compatible = "arm,arm926ej-s"; */
+			reg = <0>;
+			/*
+			 * The documentation in ARM DUI 0138E page 3-12 states
+			 * that the maximum frequency for this clock is 200 MHz
+			 * but painful trial-and-error has proved to me that it
+			 * is actually just hanging the system above 71 MHz.
+			 * Sad but true.
+			 */
+					 /* kHz     uV   */
+			operating-points = <71000  0
+					    66000  0
+					    60000  0
+					    48000  0
+					    36000  0
+					    24000  0
+					    12000  0>;
+			clocks = <&cmosc>;
+			clock-names = "cpu";
+			clock-latency = <1000000>; /* 1 ms */
+		};
+	};
+
 	aliases {
 		arm,timer-primary = &timer2;
 		arm,timer-secondary = &timer1;
-- 
2.7.4
