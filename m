From: afzal@ti.com (Mohammed, Afzal)
Date: Mon, 17 Sep 2012 08:39:54 +0000
Subject: [PATCH v6 10/10] ARM: OMAP2+: tusb6010: generic timing calculation
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9E3624@DBDE01.ent.ti.com>
References: <cover.1345524670.git.afzal@ti.com>
 <bc000ac53bb1b3ae1a951bbcf372caf6336d2a19.1345524670.git.afzal@ti.com>
 <20120824194630.GU11011@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9BA589@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9DC11D@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9DEC85@DBDE01.ent.ti.com>
 <20120906204354.GJ1303@atomide.com>
 <20120911184606.GN23092@atomide.com>,
 <C8443D0743D26F4388EA172BF4E2A7A93E9E253B@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9E3624@DBDE01.ent.ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9E4DFE@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Fri, Sep 14, 2012 at 15:50:02, Mohammed, Afzal wrote:
> * Mohammed, Afzal: Wednesday, September 12, 2012 3:20 PM

> > But some of the tusb async values is less by one. I need
> > to get it right.
> 
> Reason has been identified. It was due to rounding error,
> no changes are required in the expressions. Moving
> completely to picoseconds resolves the issue.
> 
> Can you please try with the attached patch ?

Can you please try with patch attached in previous message
of this thread and check whether it makes n800 gpmc
peripherals work properly

Changes as in above mentioned patch has been pasted below again.

Regards
Afzal

---8<------------------------


diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index d8e5b08..e9d57db 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -289,11 +289,11 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 	if (time == 0)
 		ticks = 0;
 	else
-		ticks = gpmc_ns_to_ticks(time);
+		ticks = gpmc_ps_to_ticks(time);
 	nr_bits = end_bit - st_bit + 1;
 	if (ticks >= 1 << nr_bits) {
 #ifdef DEBUG
-		printk(KERN_INFO "GPMC CS%d: %-10s* %3d ns, %3d ticks >= %d\n",
+		pr_info("GPMC CS%d: %-10s* %3d ps, %3d ticks >= %d\n",
 				cs, name, time, ticks, 1 << nr_bits);
 #endif
 		return -1;
@@ -302,10 +302,9 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 	mask = (1 << nr_bits) - 1;
 	l = gpmc_cs_read_reg(cs, reg);
 #ifdef DEBUG
-	printk(KERN_INFO
-		"GPMC CS%d: %-10s: %3d ticks, %3lu ns (was %3i ticks) %3d ns\n",
-	       cs, name, ticks, gpmc_get_fclk_period() * ticks / 1000,
-			(l >> st_bit) & mask, time);
+	pr_info("GPMC CS%d: %-10s: %3d ticks, %3lu ps (was %3i ticks) %3d ps\n",
+		cs, name, ticks, gpmc_get_fclk_period() * ticks,
+		(l >> st_bit) & mask, time);
 #endif
 	l &= ~(mask << st_bit);
 	l |= ticks << st_bit;
@@ -385,8 +384,8 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 	l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
 	if (l & (GPMC_CONFIG1_READTYPE_SYNC | GPMC_CONFIG1_WRITETYPE_SYNC)) {
 #ifdef DEBUG
-		printk(KERN_INFO "GPMC CS%d CLK period is %lu ns (div %d)\n",
-				cs, (div * gpmc_get_fclk_period()) / 1000, div);
+		pr_info("GPMC CS%d CLK period is %lu ps (div %d)\n",
+				cs, div * gpmc_get_fclk_period(), div);
 #endif
 		l &= ~0x03;
 		l |= (div - 1);
@@ -922,46 +921,42 @@ static int gpmc_calc_sync_read_timings(struct gpmc_timings *gpmc_t,
 		 * indirectly necessitates requirement of t_avdp_r & t_avdp_w
 		 * instead of having a single t_avdp
 		 */
-		temp = max_t(u32, temp,	gpmc_t->clk_activation * 1000 +
-							dev_t->t_avdh);
-		temp = max_t(u32,
-			(gpmc_t->adv_on + gpmc_ticks_to_ns(1)) * 1000, temp);
+		temp = max_t(u32, temp,	gpmc_t->clk_activation + dev_t->t_avdh);
+		temp = max_t(u32, gpmc_t->adv_on + gpmc_ticks_to_ps(1), temp);
 	}
-	gpmc_t->adv_rd_off = gpmc_round_ps_to_ticks(temp) / 1000;
+	gpmc_t->adv_rd_off = gpmc_round_ps_to_ticks(temp);
 
 	/* oe_on */
 	temp = dev_t->t_oeasu; /* remove this ? */
 	if (mux) {
-		temp = max_t(u32, temp,
-			gpmc_t->clk_activation * 1000 + dev_t->t_ach);
-		temp = max_t(u32, temp, (gpmc_t->adv_rd_off +
-				gpmc_ticks_to_ns(dev_t->cyc_aavdh_oe)) * 1000);
+		temp = max_t(u32, temp,	gpmc_t->clk_activation + dev_t->t_ach);
+		temp = max_t(u32, temp, gpmc_t->adv_rd_off +
+				gpmc_ticks_to_ps(dev_t->cyc_aavdh_oe));
 	}
-	gpmc_t->oe_on = gpmc_round_ps_to_ticks(temp) / 1000;
+	gpmc_t->oe_on = gpmc_round_ps_to_ticks(temp);
 
 	/* access */
 	/* any scope for improvement ?, by combining oe_on & clk_activation,
 	 * need to check whether access = clk_activation + round to sync clk ?
 	 */
 	temp = max_t(u32, dev_t->t_iaa,	dev_t->cyc_iaa * gpmc_t->sync_clk);
-	temp += gpmc_t->clk_activation * 1000;
+	temp += gpmc_t->clk_activation;
 	if (dev_t->cyc_oe)
-		temp = max_t(u32, temp, (gpmc_t->oe_on +
-				gpmc_ticks_to_ns(dev_t->cyc_oe)) * 1000);
-	gpmc_t->access = gpmc_round_ps_to_ticks(temp) / 1000;
+		temp = max_t(u32, temp, gpmc_t->oe_on +
+				gpmc_ticks_to_ps(dev_t->cyc_oe));
+	gpmc_t->access = gpmc_round_ps_to_ticks(temp);
 
-	gpmc_t->oe_off = gpmc_t->access + gpmc_ticks_to_ns(1);
+	gpmc_t->oe_off = gpmc_t->access + gpmc_ticks_to_ps(1);
 	gpmc_t->cs_rd_off = gpmc_t->oe_off;
 
 	/* rd_cycle */
 	temp = max_t(u32, dev_t->t_cez_r, dev_t->t_oez);
 	temp = gpmc_round_ps_to_sync_clk(temp, gpmc_t->sync_clk) +
-							gpmc_t->access * 1000;
+							gpmc_t->access;
 	/* barter t_ce_rdyz with t_cez_r ? */
 	if (dev_t->t_ce_rdyz)
-		temp = max_t(u32, temp,
-				gpmc_t->cs_rd_off * 1000 + dev_t->t_ce_rdyz);
-	gpmc_t->rd_cycle = gpmc_round_ps_to_ticks(temp) / 1000;
+		temp = max_t(u32, temp,	gpmc_t->cs_rd_off + dev_t->t_ce_rdyz);
+	gpmc_t->rd_cycle = gpmc_round_ps_to_ticks(temp);
 
 	return 0;
 }
@@ -976,29 +971,28 @@ static int gpmc_calc_sync_write_timings(struct gpmc_timings *gpmc_t,
 	temp = dev_t->t_avdp_w;
 	if (mux) {
 		temp = max_t(u32, temp,
-			gpmc_t->clk_activation * 1000 + dev_t->t_avdh);
-		temp = max_t(u32,
-			(gpmc_t->adv_on + gpmc_ticks_to_ns(1)) * 1000, temp);
+			gpmc_t->clk_activation + dev_t->t_avdh);
+		temp = max_t(u32, gpmc_t->adv_on + gpmc_ticks_to_ps(1), temp);
 	}
-	gpmc_t->adv_wr_off = gpmc_round_ps_to_ticks(temp) / 1000;
+	gpmc_t->adv_wr_off = gpmc_round_ps_to_ticks(temp);
 
 	/* wr_data_mux_bus */
 	temp = max_t(u32, dev_t->t_weasu,
-			gpmc_t->clk_activation * 1000 + dev_t->t_rdyo);
+			gpmc_t->clk_activation + dev_t->t_rdyo);
 	/* shouldn't mux be kept as a whole for wr_data_mux_bus ?,
 	 * and in that case remember to handle we_on properly
 	 */
 	if (mux) {
 		temp = max_t(u32, temp,
-			gpmc_t->adv_wr_off * 1000 + dev_t->t_aavdh);
-		temp = max_t(u32, temp, (gpmc_t->adv_wr_off +
-				gpmc_ticks_to_ns(dev_t->cyc_aavdh_we)) * 1000);
+			gpmc_t->adv_wr_off + dev_t->t_aavdh);
+		temp = max_t(u32, temp, gpmc_t->adv_wr_off +
+				gpmc_ticks_to_ps(dev_t->cyc_aavdh_we));
 	}
-	gpmc_t->wr_data_mux_bus = gpmc_round_ps_to_ticks(temp) / 1000;
+	gpmc_t->wr_data_mux_bus = gpmc_round_ps_to_ticks(temp);
 
 	/* we_on */
 	if (gpmc_capability & GPMC_HAS_WR_DATA_MUX_BUS)
-		gpmc_t->we_on = gpmc_round_ps_to_ticks(dev_t->t_weasu) / 1000;
+		gpmc_t->we_on = gpmc_round_ps_to_ticks(dev_t->t_weasu);
 	else
 		gpmc_t->we_on = gpmc_t->wr_data_mux_bus;
 
@@ -1007,24 +1001,24 @@ static int gpmc_calc_sync_write_timings(struct gpmc_timings *gpmc_t,
 	gpmc_t->wr_access = gpmc_t->access;
 
 	/* we_off */
-	temp = gpmc_t->we_on * 1000 + dev_t->t_wpl;
+	temp = gpmc_t->we_on + dev_t->t_wpl;
 	temp = max_t(u32, temp,
-			(gpmc_t->wr_access + gpmc_ticks_to_ns(1)) * 1000);
+			gpmc_t->wr_access + gpmc_ticks_to_ps(1));
 	temp = max_t(u32, temp,
-		(gpmc_t->we_on + gpmc_ticks_to_ns(dev_t->cyc_wpl)) * 1000);
-	gpmc_t->we_off = gpmc_round_ps_to_ticks(temp) / 1000;
+		gpmc_t->we_on + gpmc_ticks_to_ps(dev_t->cyc_wpl));
+	gpmc_t->we_off = gpmc_round_ps_to_ticks(temp);
 
-	gpmc_t->cs_wr_off = gpmc_round_ps_to_ticks(gpmc_t->we_off * 1000 +
-							dev_t->t_wph) / 1000;
+	gpmc_t->cs_wr_off = gpmc_round_ps_to_ticks(gpmc_t->we_off +
+							dev_t->t_wph);
 
 	/* wr_cycle */
 	temp = gpmc_round_ps_to_sync_clk(dev_t->t_cez_w, gpmc_t->sync_clk);
-	temp += gpmc_t->wr_access * 1000;
+	temp += gpmc_t->wr_access;
 	/* barter t_ce_rdyz with t_cez_w ? */
 	if (dev_t->t_ce_rdyz)
 		temp = max_t(u32, temp,
-				 gpmc_t->cs_wr_off * 1000 + dev_t->t_ce_rdyz);
-	gpmc_t->wr_cycle = gpmc_round_ps_to_ticks(temp) / 1000;
+				 gpmc_t->cs_wr_off + dev_t->t_ce_rdyz);
+	gpmc_t->wr_cycle = gpmc_round_ps_to_ticks(temp);
 
 	return 0;
 }
@@ -1038,35 +1032,33 @@ static int gpmc_calc_async_read_timings(struct gpmc_timings *gpmc_t,
 	/* adv_rd_off */
 	temp = dev_t->t_avdp_r;
 	if (mux)
-		temp = max_t(u32,
-			(gpmc_t->adv_on + gpmc_ticks_to_ns(1)) * 1000, temp);
-	gpmc_t->adv_rd_off = gpmc_round_ps_to_ticks(temp) / 1000;
+		temp = max_t(u32, gpmc_t->adv_on + gpmc_ticks_to_ps(1), temp);
+	gpmc_t->adv_rd_off = gpmc_round_ps_to_ticks(temp);
 
 	/* oe_on */
 	temp = dev_t->t_oeasu;
 	if (mux)
 		temp = max_t(u32, temp,
-			gpmc_t->adv_rd_off * 1000 + dev_t->t_aavdh);
-	gpmc_t->oe_on = gpmc_round_ps_to_ticks(temp) / 1000;
+			gpmc_t->adv_rd_off + dev_t->t_aavdh);
+	gpmc_t->oe_on = gpmc_round_ps_to_ticks(temp);
 
 	/* access */
 	temp = max_t(u32, dev_t->t_iaa, /* remove t_iaa in async ? */
-				gpmc_t->oe_on * 1000 + dev_t->t_oe);
+				gpmc_t->oe_on + dev_t->t_oe);
 	temp = max_t(u32, temp,
-				gpmc_t->cs_on * 1000 + dev_t->t_ce);
+				gpmc_t->cs_on + dev_t->t_ce);
 	temp = max_t(u32, temp,
-				gpmc_t->adv_on * 1000 + dev_t->t_aa);
-	gpmc_t->access = gpmc_round_ps_to_ticks(temp) / 1000;
+				gpmc_t->adv_on + dev_t->t_aa);
+	gpmc_t->access = gpmc_round_ps_to_ticks(temp);
 
-	gpmc_t->oe_off = gpmc_t->access + gpmc_ticks_to_ns(1);
+	gpmc_t->oe_off = gpmc_t->access + gpmc_ticks_to_ps(1);
 	gpmc_t->cs_rd_off = gpmc_t->oe_off;
 
 	/* rd_cycle */
 	temp = max_t(u32, dev_t->t_rd_cycle,
-			gpmc_t->cs_rd_off * 1000 + dev_t->t_cez_r);
-	temp = max_t(u32, temp,
-			gpmc_t->oe_off * 1000 + dev_t->t_oez);
-	gpmc_t->rd_cycle = gpmc_round_ps_to_ticks(temp) / 1000;
+			gpmc_t->cs_rd_off + dev_t->t_cez_r);
+	temp = max_t(u32, temp, gpmc_t->oe_off + dev_t->t_oez);
+	gpmc_t->rd_cycle = gpmc_round_ps_to_ticks(temp);
 
 	return 0;
 }
@@ -1080,37 +1072,35 @@ static int gpmc_calc_async_write_timings(struct gpmc_timings *gpmc_t,
 	/* adv_wr_off */
 	temp = dev_t->t_avdp_w;
 	if (mux)
-		temp = max_t(u32,
-			(gpmc_t->adv_on + gpmc_ticks_to_ns(1)) * 1000, temp);
-	gpmc_t->adv_wr_off = gpmc_round_ps_to_ticks(temp) / 1000;
+		temp = max_t(u32, gpmc_t->adv_on + gpmc_ticks_to_ps(1), temp);
+	gpmc_t->adv_wr_off = gpmc_round_ps_to_ticks(temp);
 
 	/* wr_data_mux_bus */
 	temp = dev_t->t_weasu;
 	if (mux) {
-		temp = max_t(u32, temp,
-			gpmc_t->adv_wr_off * 1000 + dev_t->t_aavdh);
-		temp = max_t(u32, temp, (gpmc_t->adv_wr_off +
-				gpmc_ticks_to_ns(dev_t->cyc_aavdh_we)) * 1000);
+		temp = max_t(u32, temp,	gpmc_t->adv_wr_off + dev_t->t_aavdh);
+		temp = max_t(u32, temp, gpmc_t->adv_wr_off +
+				gpmc_ticks_to_ps(dev_t->cyc_aavdh_we));
 	}
-	gpmc_t->wr_data_mux_bus = gpmc_round_ps_to_ticks(temp) / 1000;
+	gpmc_t->wr_data_mux_bus = gpmc_round_ps_to_ticks(temp);
 
 	/* we_on */
 	if (gpmc_capability & GPMC_HAS_WR_DATA_MUX_BUS)
-		gpmc_t->we_on = gpmc_round_ps_to_ticks(dev_t->t_weasu) / 1000;
+		gpmc_t->we_on = gpmc_round_ps_to_ticks(dev_t->t_weasu);
 	else
 		gpmc_t->we_on = gpmc_t->wr_data_mux_bus;
 
 	/* we_off */
-	temp = gpmc_t->we_on * 1000 + dev_t->t_wpl;
-	gpmc_t->we_off = gpmc_round_ps_to_ticks(temp) / 1000;
+	temp = gpmc_t->we_on + dev_t->t_wpl;
+	gpmc_t->we_off = gpmc_round_ps_to_ticks(temp);
 
-	gpmc_t->cs_wr_off = gpmc_round_ps_to_ticks((gpmc_t->we_off * 1000 +
-				dev_t->t_wph)) / 1000;
+	gpmc_t->cs_wr_off = gpmc_round_ps_to_ticks(gpmc_t->we_off +
+							dev_t->t_wph);
 
 	/* wr_cycle */
 	temp = max_t(u32, dev_t->t_wr_cycle,
-				gpmc_t->cs_wr_off * 1000 + dev_t->t_cez_w);
-	gpmc_t->wr_cycle = gpmc_round_ps_to_ticks(temp) / 1000;
+				gpmc_t->cs_wr_off + dev_t->t_cez_w);
+	gpmc_t->wr_cycle = gpmc_round_ps_to_ticks(temp);
 
 	return 0;
 }
@@ -1125,10 +1115,10 @@ static int gpmc_calc_sync_common_timings(struct gpmc_timings *gpmc_t,
 
 	gpmc_t->page_burst_access = gpmc_round_ps_to_sync_clk(
 					dev_t->t_bacc,
-					gpmc_t->sync_clk) / 1000;
+					gpmc_t->sync_clk);
 
 	temp = max_t(u32, dev_t->t_ces, dev_t->t_avds);
-	gpmc_t->clk_activation = gpmc_round_ps_to_ticks(temp) / 1000;
+	gpmc_t->clk_activation = gpmc_round_ps_to_ticks(temp);
 
 	if (gpmc_calc_divider(gpmc_t->sync_clk) != 1)
 		return 0;
@@ -1151,14 +1141,14 @@ static int gpmc_calc_common_timings(struct gpmc_timings *gpmc_t,
 	u32 temp;
 
 	/* cs_on */
-	gpmc_t->cs_on = gpmc_round_ns_to_ticks(dev_t->t_ceasu / 1000);
+	gpmc_t->cs_on = gpmc_round_ps_to_ticks(dev_t->t_ceasu);
 
 	/* adv_on */
 	temp = dev_t->t_avdasu;
 	if (dev_t->t_ce_avd)
 		temp = max_t(u32, temp,
-				gpmc_t->cs_on * 1000 + dev_t->t_ce_avd);
-	gpmc_t->adv_on = gpmc_round_ns_to_ticks(temp / 1000);
+				gpmc_t->cs_on + dev_t->t_ce_avd);
+	gpmc_t->adv_on = gpmc_round_ps_to_ticks(temp);
 
 	if (dev_t->sync_write || dev_t->sync_read)
 		gpmc_calc_sync_common_timings(gpmc_t, dev_t);
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index e59a932..f1d1d2e 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -116,38 +116,38 @@ struct gpmc_timings {
 	u32 sync_clk;
 
 	/* Chip-select signal timings corresponding to GPMC_CS_CONFIG2 */
-	u16 cs_on;		/* Assertion time */
-	u16 cs_rd_off;		/* Read deassertion time */
-	u16 cs_wr_off;		/* Write deassertion time */
+	u32 cs_on;		/* Assertion time */
+	u32 cs_rd_off;		/* Read deassertion time */
+	u32 cs_wr_off;		/* Write deassertion time */
 
 	/* ADV signal timings corresponding to GPMC_CONFIG3 */
-	u16 adv_on;		/* Assertion time */
-	u16 adv_rd_off;		/* Read deassertion time */
-	u16 adv_wr_off;		/* Write deassertion time */
+	u32 adv_on;		/* Assertion time */
+	u32 adv_rd_off;		/* Read deassertion time */
+	u32 adv_wr_off;		/* Write deassertion time */
 
 	/* WE signals timings corresponding to GPMC_CONFIG4 */
-	u16 we_on;		/* WE assertion time */
-	u16 we_off;		/* WE deassertion time */
+	u32 we_on;		/* WE assertion time */
+	u32 we_off;		/* WE deassertion time */
 
 	/* OE signals timings corresponding to GPMC_CONFIG4 */
-	u16 oe_on;		/* OE assertion time */
-	u16 oe_off;		/* OE deassertion time */
+	u32 oe_on;		/* OE assertion time */
+	u32 oe_off;		/* OE deassertion time */
 
 	/* Access time and cycle time timings corresponding to GPMC_CONFIG5 */
-	u16 page_burst_access;	/* Multiple access word delay */
-	u16 access;		/* Start-cycle to first data valid delay */
-	u16 rd_cycle;		/* Total read cycle time */
-	u16 wr_cycle;		/* Total write cycle time */
+	u32 page_burst_access;	/* Multiple access word delay */
+	u32 access;		/* Start-cycle to first data valid delay */
+	u32 rd_cycle;		/* Total read cycle time */
+	u32 wr_cycle;		/* Total write cycle time */
 
-	u16 bus_turnaround;
-	u16 cycle2cycle_delay;
+	u32 bus_turnaround;
+	u32 cycle2cycle_delay;
 
-	u16 wait_monitoring;
-	u16 clk_activation;
+	u32 wait_monitoring;
+	u32 clk_activation;
 
 	/* The following are only on OMAP3430 */
-	u16 wr_access;		/* WRACCESSTIME */
-	u16 wr_data_mux_bus;	/* WRDATAONADMUXBUS */
+	u32 wr_access;		/* WRACCESSTIME */
+	u32 wr_data_mux_bus;	/* WRDATAONADMUXBUS */
 
 	struct gpmc_bool_timings bool_timings;
 };
