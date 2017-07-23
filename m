From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun, 23 Jul 2017 09:33:40 -0700
Subject: [PATCH v4 4/7] ARM: meson: Add SMP bringup code for Meson8 and
 Meson8b
In-Reply-To: <20170722191946.22938-5-martin.blumenstingl@googlemail.com>
References: <20170722191946.22938-1-martin.blumenstingl@googlemail.com>
 <20170722191946.22938-5-martin.blumenstingl@googlemail.com>
Message-ID: <7B0CB90C-DFC3-4ECD-B342-A26BEEE52852@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On July 22, 2017 12:19:43 PM PDT, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>This adds the necessary SMP-operations and startup code to use the
>additional cores on the Amlogic Meson8/Meson8m2 (both are using the
>same
>sequence) and Meson8b (using a slightly difference sequence) SoCs.
>
>Signed-off-by: Carlo Caione <carlo@endlessm.com>
>[add Meson8/Meson8m2 support and allow taking CPU cores offline as
>well]
>Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>---

>+static void meson_smp_begin_secondary_boot(unsigned int cpu)
>+{
>+	/*
>+	 * Set the entry point before powering on the CPU through the SCU.
>This
>+	 * is needed if the CPU is in "warm" state (= after rebooting the
>+	 * system without power-cycling, or when taking the CPU offline and
>+	 * then taking it online again.
>+	 */
>+	writel(virt_to_phys(secondary_startup),
>+	       sram_base + MESON_SMP_SRAM_CPU_CTRL_ADDR_REG(cpu));

Please use __pa_symbol() since secondary startup is a kernel image symbol.

>+
>+	/*
>+	 * SCU Power on CPU (needs to be done before starting the CPU,
>+	 * otherwise the secondary CPU will not start).
>+	 */
>+	scu_cpu_power_enable(scu_base, cpu);
>+}
>+
>+static int meson_smp_finalize_secondary_boot(unsigned int cpu)
>+{
>+	unsigned long timeout;
>+
>+	timeout = jiffies + (10 * HZ);
>+	while (readl(sram_base + MESON_SMP_SRAM_CPU_CTRL_ADDR_REG(cpu))) {
>+		if (!time_before(jiffies, timeout)) {
>+			pr_err("Timeout while waiting for CPU%d status\n",
>+			       cpu);
>+			return -ETIMEDOUT;
>+		}
>+	}
>+
>+	writel(virt_to_phys(secondary_startup),
>+	       sram_base + MESON_SMP_SRAM_CPU_CTRL_ADDR_REG(cpu));

Same here.

Thanks!

-- 
Florian
