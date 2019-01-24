Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC38CC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:31:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15FF3217D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dGSUO4tI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I7C/deVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15FF3217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=fMB1rGNLURnmfYX7kdWwCpmzWFkXceMzHrZYp3dwfl4=; b=dGS
	UO4tIBi7NGbyCfBIQGE2iPACDnnPAuioBTfS8BY2e1kYH0WHAZKZBJ5MM9Qhi8g6hHf4HE0XOf5YN
	V9fpze6K38ECtVNTk/8d3gniSIf0GmNfEgBnNo6Nc+FJdGQbKtDGGCj6KA6v4qtxUVAczXWBorpmL
	XDFYwOUvq6W/xEjcJUZThtbDrVU380orNoUpTDwvH+qB9Pwiq6drK4GEBxRbZRfkS2qAGt/i2sqzQ
	VQGu2+pcRO8nX3dzJUoP6kt+iPKsTNRfUJmdzdDAqKxrHucBmIoufFKLyZgi1Zs/8M+9HpdBRIjpf
	+acFTOnI8Io8oNYu2FsZCaVGqExSeVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmcI5-0003uP-Dt; Thu, 24 Jan 2019 10:31:21 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmcHh-0003Le-2t
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 10:31:10 +0000
Received: by mail-pl1-x642.google.com with SMTP id w4so2701324plz.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 02:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=RzIa7Ya/dSIO3n1iYtqdfXVMM91MiymgGXYIi64xyNY=;
 b=I7C/deVIzFgn6F7k62FDBomCn8+J+BNIUIOMFkyhIu6IdPqOCDhLnm+WrQDDW2WV0N
 VOF7mW3JBCsD6oDkc2wZ/BQYwTKWz/GZamvRlNMsKUXKhiNi/FjVq/KxA5DJCWWbrIF2
 KF9qd8axHN/eDqq4Ao45eGfPNaVcon/a2tjuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=RzIa7Ya/dSIO3n1iYtqdfXVMM91MiymgGXYIi64xyNY=;
 b=ni25lB1rgmx2BPIJzMhat9BB4WU2+OE4LFOCqIhJ5vaRcIWAtvWKT+UD+GqbcDoXeG
 WkoKQzaoI3DVGNruv7DdmvLCxawDS+vbf9NUgSYd6kGigqbHFMK/OulgOiC2h/+T20f9
 4uPnrdFdCAY2wXbyxDswl7WkJfRIzipayr2bRtZH1vqd+jwZJvhC2H1Z5g06CJ6htXdz
 qeS5ZNoI+83wRBAk7Z2qKFrVCREPNroUYUQszsyHUK8TKYsnmi0sNKFTkVZrPdPEyz0E
 d4+OgjZcA64DgZTOW+YktixUZ2QHZPhQ1AdaHxn/HrXev/kjpVqF8aeXbU5gA2i2fboZ
 WkcA==
X-Gm-Message-State: AJcUukd19/onROHAHZisMegIOJfQnKuqnL/G/rx0TQTHD1mVIeL6sLN+
 g55MMGmhNZNQNZZsdQICJF28JA==
X-Google-Smtp-Source: ALg8bN5hDSfbwpAMwhtfCYZ/h5HdnvglxzKrXKASafamYV84X2W0BgdZ8OwK0QNadTmpT2o2J+eA9A==
X-Received: by 2002:a17:902:bf44:: with SMTP id u4mr6079802pls.5.1548325855786; 
 Thu, 24 Jan 2019 02:30:55 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id x27sm33945205pfe.178.2019.01.24.02.30.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 02:30:54 -0800 (PST)
Date: Thu, 24 Jan 2019 16:00:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [BUG] cpufreq/armada-37xx: Parent clock issues after boot
Message-ID: <20190124103052.dvkg43uwieejoupo@vireshk-i7>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ncjxlayd3dawhhsc"
Content-Disposition: inline
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_023057_651932_869B4043 
X-CRM114-Status: GOOD (  23.67  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, rjw@rjwysocki.net,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--ncjxlayd3dawhhsc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Gregory,

Ilias has an espressobin board and he reported performance regression
while playing with cpufreq governors.

I have tried to track it down in the last couple of days with Ilias
testing the kernel with my suggestions. We strongly believe that there
is something wrong with parent clock selection in the clk driver.

Simple way to reproduce the issue:

- configure kernel with performance and powersave governors, make
  performance governor default and boot the kernel.

- Run "sysbench --test=cpu run" and note down performance numbers.
- Do following to force a freq change by kernel:
  echo powersave > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
  echo performance > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor

- Run sysbench again and you will see 20% drop in performance.

The problem happens as soon as the kernel changes the frequency for
the very first time. Probably because that's when we change the
clk-parent for the very first time.

Few more things I noticed:

- During boot when the kernel adds the CPU clk to clk-framework, we
  read the registers from the non-DVFS set as DVFS wasn't enabled yet.
  So both parent and clock rate are read from there.

- But cpufreq starts working with the other set of registers which are
  available only after DVFS is enabled.

- We call clk_get_parent() followed by clk_set_parent() in
  armada37xx_cpufreq_dvfs_setup(). I am not sure what you wanted to do
  here as these two statements may not have any affect as you pass the
  return value of clk_get_parent() to clk_set_parent(). Because the
  clk framework will match the new parent with cached value of old
  one, it wouldn't change anything at all at hardware level. Over
  that, this all is done before enabling DVFS specific bits, which
  will make us play with non-DVFS registers and we don't want that,
  isn't it ?

- We checked the divider values right from the registers before moving
  to powersave and after moving back to performance. We are at
  load_level 0, which means parent clock gets passed as is. So the
  divider should be fine, only thing left is parent clock.

I am attaching two files here, one of them is the debug patch I wrote
to test this and the second one shows those debug prints during
different phase of testing.

Thanks in advance for helping out.

-- 
viresh

--ncjxlayd3dawhhsc
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-armada-debug-prints.patch"

From 9cd83f9c1713126aef291d05f973d10e9df5f7eb Mon Sep 17 00:00:00 2001
Message-Id: <9cd83f9c1713126aef291d05f973d10e9df5f7eb.1548325580.git.viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 23 Jan 2019 15:18:19 +0530
Subject: [PATCH] armada-debug-prints

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clk/mvebu/armada-37xx-periph.c | 30 ++++++++++++++++++++++----
 drivers/cpufreq/armada-37xx-cpufreq.c  |  8 +++++++
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index 1f1cff428d78..31f2f2cca6a5 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -393,6 +393,7 @@ static unsigned int armada_3700_pm_dvfs_get_cpu_div(struct regmap *base)
 	armada_3700_pm_dvfs_update_regs(load_level, &reg, &offset);
 
 	regmap_read(base, reg, &div);
+	pr_info("CLKDEBUG: %s: %d: %x: %x: %d\n", __func__, __LINE__, reg, offset, load_level);
 
 	return (div >> offset) & ARMADA_37XX_NB_TBG_DIV_MASK;
 }
@@ -469,12 +470,22 @@ static unsigned long clk_pm_cpu_recalc_rate(struct clk_hw *hw,
 {
 	struct clk_pm_cpu *pm_cpu = to_clk_pm_cpu(hw);
 	unsigned int div;
+	unsigned long rate;
 
-	if (armada_3700_pm_dvfs_is_enabled(pm_cpu->nb_pm_base))
+	pr_info("CLKDEBUG: %s: %d: %lu: %p\n", __func__, __LINE__, parent_rate, hw);
+
+	if (armada_3700_pm_dvfs_is_enabled(pm_cpu->nb_pm_base)) {
+		pr_info("CLKDEBUG: %s: %d\n", __func__, __LINE__);
 		div = armada_3700_pm_dvfs_get_cpu_div(pm_cpu->nb_pm_base);
-	else
+	} else {
+		pr_info("CLKDEBUG: %s: %d\n", __func__, __LINE__);
 		div = get_div(pm_cpu->reg_div, pm_cpu->shift_div);
-	return DIV_ROUND_UP_ULL((u64)parent_rate, div);
+	}
+
+	rate = DIV_ROUND_UP_ULL((u64)parent_rate, div);
+
+	pr_info("CLKDEBUG: %s: %d: %lu: %u\n", __func__, __LINE__, rate, div);
+	return rate;
 }
 
 static long clk_pm_cpu_round_rate(struct clk_hw *hw, unsigned long rate,
@@ -533,6 +544,8 @@ static void clk_pm_cpu_set_rate_wa(unsigned long rate, struct regmap *base)
 	if (rate != 1200 * 1000 * 1000)
 		return;
 
+	pr_info("CLKDEBUG: %s: %d\n", __func__, __LINE__);
+
 	regmap_read(base, ARMADA_37XX_NB_CPU_LOAD, &cur_level);
 	cur_level &= ARMADA_37XX_NB_CPU_LOAD_MASK;
 	if (cur_level <= ARMADA_37XX_DVFS_LOAD_1)
@@ -552,10 +565,14 @@ static int clk_pm_cpu_set_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned int div = parent_rate / rate;
 	unsigned int load_level;
 
+	pr_info("CLKDEBUG: %s: %d\n", __func__, __LINE__);
+
 	/* only available when DVFS is enabled */
 	if (!armada_3700_pm_dvfs_is_enabled(base))
 		return -EINVAL;
 
+	pr_info("CLKDEBUG: %s: %d\n", __func__, __LINE__);
+
 	for (load_level = 0; load_level < LOAD_LEVEL_NR; load_level++) {
 		unsigned int reg, mask, val,
 			offset = ARMADA_37XX_NB_TBG_DIV_OFF;
@@ -563,10 +580,13 @@ static int clk_pm_cpu_set_rate(struct clk_hw *hw, unsigned long rate,
 		armada_3700_pm_dvfs_update_regs(load_level, &reg, &offset);
 
 		regmap_read(base, reg, &val);
+		pr_info("CLKDEBUG: %s: %d: %x: %x: %x\n", __func__, __LINE__, reg, offset, val);
 		val >>= offset;
 		val &= ARMADA_37XX_NB_TBG_DIV_MASK;
 
 		if (val == div) {
+			pr_info("CLKDEBUG: %s: %d: %u\n", __func__, __LINE__, div);
+
 			/*
 			 * We found a load level matching the target
 			 * divider, switch to this load level and
@@ -578,6 +598,7 @@ static int clk_pm_cpu_set_rate(struct clk_hw *hw, unsigned long rate,
 			clk_pm_cpu_set_rate_wa(rate, base);
 
 			regmap_update_bits(base, reg, mask, load_level);
+			pr_info("CLKDEBUG: %s: %d: %x: %x: %d\n", __func__, __LINE__, reg, offset, load_level);
 
 			return rate;
 		}
@@ -676,7 +697,8 @@ static int armada_3700_add_composite_clk(const struct clk_periph_data *data,
 	*hw = clk_hw_register_composite(dev, data->name, data->parent_names,
 					data->num_parents, mux_hw,
 					mux_ops, rate_hw, rate_ops,
-					gate_hw, gate_ops, CLK_IGNORE_UNUSED);
+					gate_hw, gate_ops, CLK_IGNORE_UNUSED |
+					CLK_GET_RATE_NOCACHE);
 
 	return PTR_ERR_OR_ZERO(*hw);
 }
diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index 75491fc841a6..17031f833777 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -159,6 +159,7 @@ static void __init armada37xx_cpufreq_dvfs_setup(struct regmap *base,
 		mask <<= offset;
 
 		regmap_update_bits(base, reg, mask, val);
+		pr_info("CLKDEBUG: %s: %d: %x: %x: %x\n", __func__, __LINE__, reg, offset, val);
 	}
 
 	/*
@@ -399,6 +400,8 @@ static int __init armada37xx_cpufreq_driver_init(void)
 		return PTR_ERR(clk);
 	}
 
+	pr_info("CLKDEBUG: %s: %d\n", __func__, __LINE__);
+
 	/* Get nominal (current) CPU frequency */
 	cur_frequency = clk_get_rate(clk);
 	if (!cur_frequency) {
@@ -445,6 +448,11 @@ static int __init armada37xx_cpufreq_driver_init(void)
 	pdata.suspend = armada37xx_cpufreq_suspend;
 	pdata.resume = armada37xx_cpufreq_resume;
 
+	ret = clk_set_rate(clk, 500000000);
+	pr_info("CLKDEBUG: %s: %d: %d\n", __func__, __LINE__, ret);
+	ret = clk_set_rate(clk, 1000000000);
+	pr_info("CLKDEBUG: %s: %d: %d\n", __func__, __LINE__, ret);
+
 	pdev = platform_device_register_data(NULL, "cpufreq-dt", -1, &pdata,
 					     sizeof(pdata));
 	ret = PTR_ERR_OR_ZERO(pdev);
-- 
2.20.1.321.g9e740568ce00


--ncjxlayd3dawhhsc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="logs.txt"

> - reboot board
> dmesg -c | grep CLKDEBUG
[    3.958289] CLKDEBUG: clk_pm_cpu_recalc_rate: 475: 1000000000: (____ptrval____)
[    3.965957] CLKDEBUG: clk_pm_cpu_recalc_rate: 481
[    3.970773] CLKDEBUG: clk_pm_cpu_recalc_rate: 487: 1000000000: 1
[   14.915365] CLKDEBUG: armada37xx_cpufreq_driver_init: 403
[   14.920587] CLKDEBUG: clk_pm_cpu_recalc_rate: 475: 1000000000: (____ptrval____)
[   14.928093] CLKDEBUG: clk_pm_cpu_recalc_rate: 481
[   14.932960] CLKDEBUG: clk_pm_cpu_recalc_rate: 487: 1000000000: 1
[   14.939156] CLKDEBUG: armada37xx_cpufreq_dvfs_setup: 162: 18: 10: 28000000
[   14.946218] CLKDEBUG: armada37xx_cpufreq_dvfs_setup: 162: 18: 0: 4840
[   14.952896] CLKDEBUG: armada37xx_cpufreq_dvfs_setup: 162: 1c: 10: 88800000
[   14.959911] CLKDEBUG: armada37xx_cpufreq_dvfs_setup: 162: 1c: 0: a8c0
[   14.967159] CLKDEBUG: armada37xx_cpufreq_driver_init: 452: -22
[   14.972548] CLKDEBUG: armada37xx_cpufreq_driver_init: 454: 0
[   14.979653] CLKDEBUG: clk_pm_cpu_recalc_rate: 475: 1000000000: (____ptrval____)
[   14.985876] CLKDEBUG: clk_pm_cpu_recalc_rate: 478
[   14.990695] CLKDEBUG: armada_3700_pm_dvfs_get_cpu_div: 396: 18: 1d: 0
[   14.997370] CLKDEBUG: clk_pm_cpu_recalc_rate: 487: 1000000000: 1
[   15.003588] CLKDEBUG: clk_pm_cpu_recalc_rate: 475: 1000000000: (____ptrval____)
[   15.011066] CLKDEBUG: clk_pm_cpu_recalc_rate: 478
[   15.015910] CLKDEBUG: armada_3700_pm_dvfs_get_cpu_div: 396: 18: 1d: 0
[   15.022530] CLKDEBUG: clk_pm_cpu_recalc_rate: 487: 1000000000: 1

> sysbench --test=cpu run
WARNING: the --test option is deprecated. You can pass a script name or path on the command line without any options.
sysbench 1.0.11 (using system LuaJIT 2.1.0-beta3)

Running the test with following options:
Number of threads: 1
Initializing random number generator from current time


Prime numbers limit: 10000

Initializing worker threads...

Threads started!

CPU speed:
    events per second:   497.21

General statistics:
    total time:                          10.0018s
    total number of events:              4977

Latency (ms):
         min:                                  2.00
         avg:                                  2.01
         max:                                  2.16
         95th percentile:                      2.03
         sum:                               9995.15

Threads fairness:
    events (avg/stddev):           4977.0000/0.00
    execution time (avg/stddev):   9.9951/0.00

> echo 500000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
> dmesg -c | grep CLKDEBUG
[  322.493188] CLKDEBUG: clk_pm_cpu_recalc_rate: 475: 1000000000: 00000000821db03d
[  322.493202] CLKDEBUG: clk_pm_cpu_recalc_rate: 478
[  322.493215] CLKDEBUG: armada_3700_pm_dvfs_get_cpu_div: 396: 18: 1d: 0
[  322.493223] CLKDEBUG: clk_pm_cpu_recalc_rate: 487: 1000000000: 1
[  322.493266] CLKDEBUG: clk_pm_cpu_set_rate: 568
[  322.493275] CLKDEBUG: clk_pm_cpu_set_rate: 574
[  322.493285] CLKDEBUG: clk_pm_cpu_set_rate: 583: 18: 1d: 28004840
[  322.493295] CLKDEBUG: clk_pm_cpu_set_rate: 583: 18: d: 28004840
[  322.493302] CLKDEBUG: clk_pm_cpu_set_rate: 588: 2
[  322.493320] CLKDEBUG: clk_pm_cpu_set_rate: 601: 30: d: 1
[  322.493340] CLKDEBUG: clk_pm_cpu_recalc_rate: 475: 1000000000: 00000000821db03d
[  322.493362] CLKDEBUG: clk_pm_cpu_recalc_rate: 478
[  322.493391] CLKDEBUG: armada_3700_pm_dvfs_get_cpu_div: 396: 18: d: 1
[  322.493410] CLKDEBUG: clk_pm_cpu_recalc_rate: 487: 500000000: 2
> sysbench --test=cpu run
WARNING: the --test option is deprecated. You can pass a script name or path on the command line without any options.
sysbench 1.0.11 (using system LuaJIT 2.1.0-beta3)

Running the test with following options:
Number of threads: 1
Initializing random number generator from current time


Prime numbers limit: 10000

Initializing worker threads...

Threads started!

CPU speed:
    events per second:   196.71

General statistics:
    total time:                          10.0034s
    total number of events:              1971

Latency (ms):
         min:                                  5.05
         avg:                                  5.07
         max:                                  5.78
         95th percentile:                      5.09
         sum:                               9993.70

Threads fairness:
    events (avg/stddev):           1971.0000/0.00
    execution time (avg/stddev):   9.9937/0.00

> echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
> dmesg -c | grep CLKDEBUG
[  394.670483] CLKDEBUG: clk_pm_cpu_recalc_rate: 475: 1000000000: 00000000821db03d
[  394.670514] CLKDEBUG: clk_pm_cpu_recalc_rate: 478
[  394.670545] CLKDEBUG: armada_3700_pm_dvfs_get_cpu_div: 396: 18: d: 1
[  394.670564] CLKDEBUG: clk_pm_cpu_recalc_rate: 487: 500000000: 2
[  394.670618] CLKDEBUG: clk_pm_cpu_set_rate: 568
[  394.670639] CLKDEBUG: clk_pm_cpu_set_rate: 574
[  394.670664] CLKDEBUG: clk_pm_cpu_set_rate: 583: 18: 1d: 28004840
[  394.670682] CLKDEBUG: clk_pm_cpu_set_rate: 588: 1
[  394.670712] CLKDEBUG: clk_pm_cpu_set_rate: 601: 30: 1d: 0
[  394.670733] CLKDEBUG: clk_pm_cpu_recalc_rate: 475: 1000000000: 00000000821db03d
[  394.670746] CLKDEBUG: clk_pm_cpu_recalc_rate: 478
[  394.670760] CLKDEBUG: armada_3700_pm_dvfs_get_cpu_div: 396: 18: 1d: 0
[  394.670769] CLKDEBUG: clk_pm_cpu_recalc_rate: 487: 1000000000: 1
> sysbench --test=cpu run
apalos@dockerslave ~ $ sysbench --test=cpu run
WARNING: the --test option is deprecated. You can pass a script name or path on the command line without any options.
sysbench 1.0.11 (using system LuaJIT 2.1.0-beta3)

Running the test with following options:
Number of threads: 1
Initializing random number generator from current time


Prime numbers limit: 10000

Initializing worker threads...

Threads started!

CPU speed:
    events per second:   395.73

General statistics:
    total time:                          10.0025s
    total number of events:              3962

Latency (ms):
         min:                                  2.51
         avg:                                  2.52
         max:                                  2.73
         95th percentile:                      2.52
         sum:                               9995.59

Threads fairness:
    events (avg/stddev):           3962.0000/0.00
    execution time (avg/stddev):   9.9956/0.00

> grep . /sys/devices/system/cpu/cpufreq/policy0/*
> 
/sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0 1
grep: /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq: Permission denied
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:1000000
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:200000
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:4294967295
/sys/devices/system/cpu/cpufreq/policy0/related_cpus:0 1
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies:200000 250000 500000 1000000 
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:performance schedutil 
/sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:1000000
/sys/devices/system/cpu/cpufreq/policy0/scaling_driver:cpufreq-dt
/sys/devices/system/cpu/cpufreq/policy0/scaling_governor:performance
/sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:1000000
/sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:200000
/sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>

--ncjxlayd3dawhhsc
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--ncjxlayd3dawhhsc--

