From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 20 Feb 2015 12:02:53 +0530
Subject: [PATCH] clockevents: Add (missing) default case for switch blocks
Message-ID: <6291e308ab77a480c6b1732e16108c5fe6f66afa.1424412815.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many clockevent drivers are using a switch block for handling modes in their
->set_mode() callback. Some of these do not have a 'default' case and adding a
new mode in the 'enum clock_event_mode', starts giving following warnings for
these platforms about unhandled modes (e.g. XXX).

	warning: enumeration value ?XXX? not handled in switch [-Wswitch]

This patch adds default cases for them.

In order to keep things simple, add following to the switch blocks:

	default:
		break;

This can lead to different behavior for individual cases.

1) Some of the drivers don't have any special stuff in their ->set_mode()
   callback before or after the switch blocks. And so this default case would
   simply return for them without any updates to the clockevent device.

2) But in some cases, the clockevent device is disabled/stopped as soon as we
   enter the ->set_mode() callback and is enabled within the switch block or
   after it. And the clockevent device *may* stay disabled for default case.

The rationale behind only adding a 'break' was that the default case *will
never* be hit during execution of code. All new modes (beyond RESUME) are
handled with mode specific ->set_mode_*() callbacks and ->set_mode() is never
called for them. And all modes before and including RESUME are already
explicitly handled by the clockevent drivers.

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Rebased over: tip/master, due to recently added rockchip driver.
	8e3210338295 Merge branch 'x86/urgent'

 arch/arm/mach-at91/at91rm9200_time.c            | 2 ++
 arch/arm/mach-davinci/time.c                    | 2 ++
 arch/arm/mach-footbridge/dc21285-timer.c        | 2 ++
 arch/arm/mach-imx/epit.c                        | 2 ++
 arch/arm/mach-imx/time.c                        | 2 ++
 arch/arm/mach-lpc32xx/timer.c                   | 2 ++
 arch/arm/mach-mmp/time.c                        | 2 ++
 arch/arm/mach-omap1/time.c                      | 2 ++
 arch/arm/mach-omap1/timer32k.c                  | 2 ++
 arch/arm/mach-omap2/timer.c                     | 2 ++
 arch/arm/mach-sa1100/time.c                     | 2 ++
 arch/arm/mach-w90x900/time.c                    | 2 ++
 arch/blackfin/kernel/time-ts.c                  | 4 ++++
 arch/c6x/platforms/timer64.c                    | 2 ++
 arch/m68k/coldfire/pit.c                        | 2 ++
 arch/microblaze/kernel/timer.c                  | 2 ++
 arch/mips/kernel/cevt-bcm1480.c                 | 2 ++
 arch/mips/kernel/cevt-sb1250.c                  | 2 ++
 arch/mips/kernel/cevt-txx9.c                    | 2 ++
 arch/mips/loongson/common/cs5536/cs5536_mfgpt.c | 2 ++
 arch/mips/loongson/loongson-3/hpet.c            | 2 ++
 arch/mips/sni/time.c                            | 2 ++
 arch/nios2/kernel/time.c                        | 2 ++
 arch/openrisc/kernel/time.c                     | 2 ++
 arch/sparc/kernel/time_64.c                     | 2 ++
 arch/um/kernel/time.c                           | 2 ++
 arch/unicore32/kernel/time.c                    | 2 ++
 arch/x86/kernel/apic/apic.c                     | 2 ++
 arch/x86/kernel/hpet.c                          | 2 ++
 arch/x86/lguest/boot.c                          | 2 ++
 arch/x86/platform/uv/uv_time.c                  | 2 ++
 arch/x86/xen/time.c                             | 4 ++++
 drivers/clocksource/cadence_ttc_timer.c         | 2 ++
 drivers/clocksource/dw_apb_timer.c              | 2 ++
 drivers/clocksource/exynos_mct.c                | 4 ++++
 drivers/clocksource/i8253.c                     | 2 ++
 drivers/clocksource/metag_generic.c             | 2 ++
 drivers/clocksource/mxs_timer.c                 | 2 ++
 drivers/clocksource/nomadik-mtu.c               | 2 ++
 drivers/clocksource/pxa_timer.c                 | 2 ++
 drivers/clocksource/qcom-timer.c                | 2 ++
 drivers/clocksource/rockchip_timer.c            | 2 ++
 drivers/clocksource/samsung_pwm_timer.c         | 2 ++
 drivers/clocksource/tegra20_timer.c             | 2 ++
 drivers/clocksource/time-efm32.c                | 2 ++
 drivers/clocksource/timer-atmel-pit.c           | 2 ++
 drivers/clocksource/timer-prima2.c              | 2 ++
 drivers/clocksource/timer-u300.c                | 2 ++
 drivers/clocksource/vt8500_timer.c              | 2 ++
 49 files changed, 104 insertions(+)

diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/arch/arm/mach-at91/at91rm9200_time.c
index 51761f8927b7..053ae0e3c3cb 100644
--- a/arch/arm/mach-at91/at91rm9200_time.c
+++ b/arch/arm/mach-at91/at91rm9200_time.c
@@ -138,6 +138,8 @@ clkevt32k_mode(enum clock_event_mode mode, struct clock_event_device *dev)
 	case CLOCK_EVT_MODE_RESUME:
 		irqmask = 0;
 		break;
+	default:
+		break;
 	}
 	at91_st_write(AT91_ST_IER, irqmask);
 }
diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index 160c9602f490..59347b8e8228 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -326,6 +326,8 @@ static void davinci_set_mode(enum clock_event_mode mode,
 		break;
 	case CLOCK_EVT_MODE_RESUME:
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/arch/arm/mach-footbridge/dc21285-timer.c b/arch/arm/mach-footbridge/dc21285-timer.c
index bf7aa7d298e7..445965c216cd 100644
--- a/arch/arm/mach-footbridge/dc21285-timer.c
+++ b/arch/arm/mach-footbridge/dc21285-timer.c
@@ -74,6 +74,8 @@ static void ckevt_dc21285_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_SHUTDOWN:
 		*CSR_TIMER1_CNTL = 0;
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/arch/arm/mach-imx/epit.c b/arch/arm/mach-imx/epit.c
index 074b1a81ba76..76b78f0ea739 100644
--- a/arch/arm/mach-imx/epit.c
+++ b/arch/arm/mach-imx/epit.c
@@ -152,6 +152,8 @@ static void epit_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_RESUME:
 		/* Left event sources disabled, no more interrupts appear */
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index 15d18e198303..58c0423ef5f7 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -245,6 +245,8 @@ static void mxc_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_RESUME:
 		/* Left event sources disabled, no more interrupts appear */
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/arch/arm/mach-lpc32xx/timer.c b/arch/arm/mach-lpc32xx/timer.c
index 4e5837299c04..027a6c5c77b6 100644
--- a/arch/arm/mach-lpc32xx/timer.c
+++ b/arch/arm/mach-lpc32xx/timer.c
@@ -64,6 +64,8 @@ static void lpc32xx_clkevt_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_UNUSED:
 	case CLOCK_EVT_MODE_RESUME:
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 2756351dbb35..f38519135e00 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -140,6 +140,8 @@ static void timer_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_RESUME:
 	case CLOCK_EVT_MODE_PERIODIC:
 		break;
+	default:
+		break;
 	}
 	local_irq_restore(flags);
 }
diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index a7588cfd0286..53242cc6c3fd 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -139,6 +139,8 @@ static void omap_mpu_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	case CLOCK_EVT_MODE_RESUME:
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
index 107e7ab3edba..c21188c5b502 100644
--- a/arch/arm/mach-omap1/timer32k.c
+++ b/arch/arm/mach-omap1/timer32k.c
@@ -134,6 +134,8 @@ static void omap_32k_timer_set_mode(enum clock_event_mode mode,
 		break;
 	case CLOCK_EVT_MODE_RESUME:
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 7d45c84c69ba..15ea6af11933 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -126,6 +126,8 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	case CLOCK_EVT_MODE_RESUME:
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/arch/arm/mach-sa1100/time.c b/arch/arm/mach-sa1100/time.c
index 1dea6cfafb31..e44c5b77169c 100644
--- a/arch/arm/mach-sa1100/time.c
+++ b/arch/arm/mach-sa1100/time.c
@@ -70,6 +70,8 @@ sa1100_osmr0_set_mode(enum clock_event_mode mode, struct clock_event_device *c)
 	case CLOCK_EVT_MODE_RESUME:
 	case CLOCK_EVT_MODE_PERIODIC:
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/arch/arm/mach-w90x900/time.c b/arch/arm/mach-w90x900/time.c
index 9230d3725599..5b9d9171bb95 100644
--- a/arch/arm/mach-w90x900/time.c
+++ b/arch/arm/mach-w90x900/time.c
@@ -70,6 +70,8 @@ static void nuc900_clockevent_setmode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	case CLOCK_EVT_MODE_RESUME:
 		break;
+	default:
+		break;
 	}
 
 	__raw_writel(val, REG_TCSR0);
diff --git a/arch/blackfin/kernel/time-ts.c b/arch/blackfin/kernel/time-ts.c
index cb0a4845339e..fcb082c8993d 100644
--- a/arch/blackfin/kernel/time-ts.c
+++ b/arch/blackfin/kernel/time-ts.c
@@ -173,6 +173,8 @@ static void bfin_gptmr0_set_mode(enum clock_event_mode mode,
 		break;
 	case CLOCK_EVT_MODE_RESUME:
 		break;
+	default:
+		break;
 	}
 }
 
@@ -279,6 +281,8 @@ static void bfin_coretmr_set_mode(enum clock_event_mode mode,
 		break;
 	case CLOCK_EVT_MODE_RESUME:
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/arch/c6x/platforms/timer64.c b/arch/c6x/platforms/timer64.c
index 3c73d74a4674..027c45417106 100644
--- a/arch/c6x/platforms/timer64.c
+++ b/arch/c6x/platforms/timer64.c
@@ -146,6 +146,8 @@ static void set_clock_mode(enum clock_event_mode mode,
 		break;
 	case CLOCK_EVT_MODE_RESUME:
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/arch/m68k/coldfire/pit.c b/arch/m68k/coldfire/pit.c
index 493b3111d4c1..373dc3c62b35 100644
--- a/arch/m68k/coldfire/pit.c
+++ b/arch/m68k/coldfire/pit.c
@@ -72,6 +72,8 @@ static void init_cf_pit_timer(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_RESUME:
 		/* Nothing to do here */
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/arch/microblaze/kernel/timer.c b/arch/microblaze/kernel/timer.c
index dd96f0e4bfa2..7eb95b73c7bf 100644
--- a/arch/microblaze/kernel/timer.c
+++ b/arch/microblaze/kernel/timer.c
@@ -142,6 +142,8 @@ static void xilinx_timer_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_RESUME:
 		pr_info("%s: resume\n", __func__);
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/arch/mips/kernel/cevt-bcm1480.c b/arch/mips/kernel/cevt-bcm1480.c
index 7976457184b1..a08cd30c1d76 100644
--- a/arch/mips/kernel/cevt-bcm1480.c
+++ b/arch/mips/kernel/cevt-bcm1480.c
@@ -66,6 +66,8 @@ static void sibyte_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_UNUSED:	/* shuddup gcc */
 	case CLOCK_EVT_MODE_RESUME:
 		;
+	default:
+		break;
 	}
 }
 
diff --git a/arch/mips/kernel/cevt-sb1250.c b/arch/mips/kernel/cevt-sb1250.c
index 5ea6d6b1de15..fdb7eed6dfd3 100644
--- a/arch/mips/kernel/cevt-sb1250.c
+++ b/arch/mips/kernel/cevt-sb1250.c
@@ -64,6 +64,8 @@ static void sibyte_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_UNUSED:	/* shuddup gcc */
 	case CLOCK_EVT_MODE_RESUME:
 		;
+	default:
+		break;
 	}
 }
 
diff --git a/arch/mips/kernel/cevt-txx9.c b/arch/mips/kernel/cevt-txx9.c
index 2ae08462e46e..7f468a3c9a93 100644
--- a/arch/mips/kernel/cevt-txx9.c
+++ b/arch/mips/kernel/cevt-txx9.c
@@ -105,6 +105,8 @@ static void txx9tmr_set_mode(enum clock_event_mode mode,
 		__raw_writel(TIMER_CCD, &tmrptr->ccdr);
 		__raw_writel(0, &tmrptr->itmr);
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/arch/mips/loongson/common/cs5536/cs5536_mfgpt.c b/arch/mips/loongson/common/cs5536/cs5536_mfgpt.c
index 12c75db23420..ec4a800b36dd 100644
--- a/arch/mips/loongson/common/cs5536/cs5536_mfgpt.c
+++ b/arch/mips/loongson/common/cs5536/cs5536_mfgpt.c
@@ -77,6 +77,8 @@ static void init_mfgpt_timer(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_RESUME:
 		/* Nothing to do here */
 		break;
+	default:
+		break;
 	}
 	raw_spin_unlock(&mfgpt_lock);
 }
diff --git a/arch/mips/loongson/loongson-3/hpet.c b/arch/mips/loongson/loongson-3/hpet.c
index e898d68668a9..7833f5d5757f 100644
--- a/arch/mips/loongson/loongson-3/hpet.c
+++ b/arch/mips/loongson/loongson-3/hpet.c
@@ -125,6 +125,8 @@ static void hpet_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_RESUME:
 		hpet_enable_legacy_int();
 		break;
+	default:
+		break;
 	}
 	spin_unlock(&hpet_lock);
 }
diff --git a/arch/mips/sni/time.c b/arch/mips/sni/time.c
index cf8ec568b9df..97e1678c4956 100644
--- a/arch/mips/sni/time.c
+++ b/arch/mips/sni/time.c
@@ -40,6 +40,8 @@ static void a20r_set_mode(enum clock_event_mode mode,
 		break;
 	case CLOCK_EVT_MODE_RESUME:
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/arch/nios2/kernel/time.c b/arch/nios2/kernel/time.c
index 7f4547418ee1..1c5103cf1729 100644
--- a/arch/nios2/kernel/time.c
+++ b/arch/nios2/kernel/time.c
@@ -181,6 +181,8 @@ static void nios2_timer_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_RESUME:
 		nios2_timer_start(timer);
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/arch/openrisc/kernel/time.c b/arch/openrisc/kernel/time.c
index 7c52e9494a8d..ca82d2daf16e 100644
--- a/arch/openrisc/kernel/time.c
+++ b/arch/openrisc/kernel/time.c
@@ -68,6 +68,8 @@ static void openrisc_timer_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_RESUME:
 		pr_debug(KERN_INFO "%s: resume\n", __func__);
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index edbbeb157d46..850ea2c476d7 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -704,6 +704,8 @@ static void sparc64_timer_setup(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_UNUSED:
 		WARN_ON(1);
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 117568d4f64a..8e0a5b4cce4f 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -38,6 +38,8 @@ static void itimer_set_mode(enum clock_event_mode mode,
 
 	case CLOCK_EVT_MODE_RESUME:
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/arch/unicore32/kernel/time.c b/arch/unicore32/kernel/time.c
index d3824b2ff644..179d7547edc5 100644
--- a/arch/unicore32/kernel/time.c
+++ b/arch/unicore32/kernel/time.c
@@ -60,6 +60,8 @@ puv3_osmr0_set_mode(enum clock_event_mode mode, struct clock_event_device *c)
 	case CLOCK_EVT_MODE_RESUME:
 	case CLOCK_EVT_MODE_PERIODIC:
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index b665d241efad..e7141d8f108b 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -493,6 +493,8 @@ static void lapic_timer_setup(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_RESUME:
 		/* Nothing to do here */
 		break;
+	default:
+		break;
 	}
 
 	local_irq_restore(flags);
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 319bcb9372fe..8c10da669d63 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -364,6 +364,8 @@ static void hpet_set_mode(enum clock_event_mode mode,
 		}
 		hpet_print_config();
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/arch/x86/lguest/boot.c b/arch/x86/lguest/boot.c
index c1c1544b8485..95b9705240ab 100644
--- a/arch/x86/lguest/boot.c
+++ b/arch/x86/lguest/boot.c
@@ -978,6 +978,8 @@ static void lguest_clockevent_set_mode(enum clock_event_mode mode,
 		BUG();
 	case CLOCK_EVT_MODE_RESUME:
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_time.c
index a244237f3cfa..6612046adfe2 100644
--- a/arch/x86/platform/uv/uv_time.c
+++ b/arch/x86/platform/uv/uv_time.c
@@ -338,6 +338,8 @@ static void uv_rtc_timer_setup(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_SHUTDOWN:
 		uv_rtc_unset_timer(ced_cpu, 1);
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 69087341d9ae..02e6d6f688a0 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -291,6 +291,8 @@ static void xen_timerop_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_SHUTDOWN:
 		HYPERVISOR_set_timer_op(0);  /* cancel timeout */
 		break;
+	default:
+		break;
 	}
 }
 
@@ -349,6 +351,8 @@ static void xen_vcpuop_set_mode(enum clock_event_mode mode,
 		break;
 	case CLOCK_EVT_MODE_RESUME:
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/drivers/clocksource/cadence_ttc_timer.c b/drivers/clocksource/cadence_ttc_timer.c
index 510c8a1d37b3..f93d1d8b8a9a 100644
--- a/drivers/clocksource/cadence_ttc_timer.c
+++ b/drivers/clocksource/cadence_ttc_timer.c
@@ -224,6 +224,8 @@ static void ttc_set_mode(enum clock_event_mode mode,
 		writel_relaxed(ctrl_reg,
 				timer->base_addr + TTC_CNT_CNTRL_OFFSET);
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/drivers/clocksource/dw_apb_timer.c b/drivers/clocksource/dw_apb_timer.c
index f3656a6b0382..ddfd00325e43 100644
--- a/drivers/clocksource/dw_apb_timer.c
+++ b/drivers/clocksource/dw_apb_timer.c
@@ -173,6 +173,8 @@ static void apbt_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_RESUME:
 		apbt_enable_int(&dw_ced->timer);
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 83564c9cfdbe..e604e1c5eb12 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -306,6 +306,8 @@ static void exynos4_comp_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	case CLOCK_EVT_MODE_RESUME:
 		break;
+	default:
+		break;
 	}
 }
 
@@ -410,6 +412,8 @@ static inline void exynos4_tick_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	case CLOCK_EVT_MODE_RESUME:
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
index 14ee3efcc404..d06c1df00e1e 100644
--- a/drivers/clocksource/i8253.c
+++ b/drivers/clocksource/i8253.c
@@ -136,6 +136,8 @@ static void init_pit_timer(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_RESUME:
 		/* Nothing to do here */
 		break;
+	default:
+		break;
 	}
 	raw_spin_unlock(&i8253_lock);
 }
diff --git a/drivers/clocksource/metag_generic.c b/drivers/clocksource/metag_generic.c
index b7384b853e5a..834dc25676b8 100644
--- a/drivers/clocksource/metag_generic.c
+++ b/drivers/clocksource/metag_generic.c
@@ -72,6 +72,8 @@ static void metag_timer_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_UNUSED:
 		WARN_ON(1);
 		break;
+	default:
+		break;
 	};
 }
 
diff --git a/drivers/clocksource/mxs_timer.c b/drivers/clocksource/mxs_timer.c
index 445b68a01dc5..afaf4e1f170b 100644
--- a/drivers/clocksource/mxs_timer.c
+++ b/drivers/clocksource/mxs_timer.c
@@ -190,6 +190,8 @@ static void mxs_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_RESUME:
 		/* Left event sources disabled, no more interrupts appear */
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/drivers/clocksource/nomadik-mtu.c b/drivers/clocksource/nomadik-mtu.c
index a709cfa49d85..0f75ac8cdddd 100644
--- a/drivers/clocksource/nomadik-mtu.c
+++ b/drivers/clocksource/nomadik-mtu.c
@@ -140,6 +140,8 @@ static void nmdk_clkevt_mode(enum clock_event_mode mode,
 		break;
 	case CLOCK_EVT_MODE_RESUME:
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/drivers/clocksource/pxa_timer.c b/drivers/clocksource/pxa_timer.c
index 941f3f344e08..cb6b0bb74825 100644
--- a/drivers/clocksource/pxa_timer.c
+++ b/drivers/clocksource/pxa_timer.c
@@ -107,6 +107,8 @@ pxa_osmr0_set_mode(enum clock_event_mode mode, struct clock_event_device *dev)
 	case CLOCK_EVT_MODE_RESUME:
 	case CLOCK_EVT_MODE_PERIODIC:
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/drivers/clocksource/qcom-timer.c b/drivers/clocksource/qcom-timer.c
index 098c542e5c53..9fadcde8eed7 100644
--- a/drivers/clocksource/qcom-timer.c
+++ b/drivers/clocksource/qcom-timer.c
@@ -95,6 +95,8 @@ static void msm_timer_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_UNUSED:
 	case CLOCK_EVT_MODE_SHUTDOWN:
 		break;
+	default:
+		break;
 	}
 	writel_relaxed(ctrl, event_base + TIMER_ENABLE);
 }
diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/rockchip_timer.c
index a35993bafb20..cf572f161d5c 100644
--- a/drivers/clocksource/rockchip_timer.c
+++ b/drivers/clocksource/rockchip_timer.c
@@ -98,6 +98,8 @@ static inline void rk_timer_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_SHUTDOWN:
 		rk_timer_disable(ce);
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index 5645cfc90c41..c4a34818011b 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -225,6 +225,8 @@ static void samsung_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	case CLOCK_EVT_MODE_RESUME:
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
index d2616ef16770..859ebe8728ce 100644
--- a/drivers/clocksource/tegra20_timer.c
+++ b/drivers/clocksource/tegra20_timer.c
@@ -90,6 +90,8 @@ static void tegra_timer_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	case CLOCK_EVT_MODE_RESUME:
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/drivers/clocksource/time-efm32.c b/drivers/clocksource/time-efm32.c
index bba62f9deefb..67c5f5e43352 100644
--- a/drivers/clocksource/time-efm32.c
+++ b/drivers/clocksource/time-efm32.c
@@ -81,6 +81,8 @@ static void efm32_clock_event_set_mode(enum clock_event_mode mode,
 
 	case CLOCK_EVT_MODE_RESUME:
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
index b5b4d4585c9a..2c5e026b9fc3 100644
--- a/drivers/clocksource/timer-atmel-pit.c
+++ b/drivers/clocksource/timer-atmel-pit.c
@@ -116,6 +116,8 @@ pit_clkevt_mode(enum clock_event_mode mode, struct clock_event_device *dev)
 		break;
 	case CLOCK_EVT_MODE_RESUME:
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/drivers/clocksource/timer-prima2.c b/drivers/clocksource/timer-prima2.c
index ce18d570e1cd..405400018e85 100644
--- a/drivers/clocksource/timer-prima2.c
+++ b/drivers/clocksource/timer-prima2.c
@@ -123,6 +123,8 @@ static void sirfsoc_timer_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_UNUSED:
 	case CLOCK_EVT_MODE_RESUME:
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/drivers/clocksource/timer-u300.c b/drivers/clocksource/timer-u300.c
index 5dcf756970e7..746f65ed13b0 100644
--- a/drivers/clocksource/timer-u300.c
+++ b/drivers/clocksource/timer-u300.c
@@ -265,6 +265,8 @@ static void u300_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_RESUME:
 		/* Ignore this call */
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/drivers/clocksource/vt8500_timer.c b/drivers/clocksource/vt8500_timer.c
index 1098ed3b9b89..ca982352a637 100644
--- a/drivers/clocksource/vt8500_timer.c
+++ b/drivers/clocksource/vt8500_timer.c
@@ -102,6 +102,8 @@ static void vt8500_timer_set_mode(enum clock_event_mode mode,
 			regbase + TIMER_CTRL_VAL);
 		writel(0, regbase + TIMER_IER_VAL);
 		break;
+	default:
+		break;
 	}
 }
 
-- 
2.3.0.rc0.44.ga94655d
