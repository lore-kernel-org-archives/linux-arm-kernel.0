From: khilman@ti.com (Kevin Hilman)
Date: Tue, 03 Apr 2012 16:14:19 -0700
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <20120403160706.GP17741@mudshark.cambridge.arm.com> (Will
 Deacon's message of "Tue, 3 Apr 2012 17:07:06 +0100")
References: <CACVXFVMH9WZDqs-mVjxL=1FY12uHyQAJMTCQuU5ru1wQT+YnZg@mail.gmail.com>
 <CAMQu2gzW706YbOzHa4Am0=X17T0G3zBhOmWUd8eC6GY9F6OBog@mail.gmail.com>
 <CACVXFVPb-McJj1oi284RW37Pe08cAXSw-jteFwfNVPpCJx5EaQ@mail.gmail.com>
 <CAMQu2gwvgPfZv_LnB6GnYs=Wt+wj9GFPEDYiDK6C8TiTag3gTg@mail.gmail.com>
 <20120403092524.GD17741@mudshark.cambridge.arm.com>
 <CAMQu2gxE2STYxUGinzstX6W8jyofH829A__NQBjwLqZd9cqy=w@mail.gmail.com>
 <20120403094749.GH17741@mudshark.cambridge.arm.com>
 <CAMQu2gyFirtVTWpMu4G_qG5sq33J-_s_o2JhVAdrUf7P3qJ3AA@mail.gmail.com>
 <20120403123444.GL17741@mudshark.cambridge.arm.com>
 <878vicsxef.fsf@ti.com>
 <20120403160706.GP17741@mudshark.cambridge.arm.com>
Message-ID: <87ehs4pfw4.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon <will.deacon@arm.com> writes:

[...]

> Right. Can you confirm whether the PMU/CTI interrupts fire for you please?
> Just run perf top and look at /proc/interrupts while it's running. You
> should see a couple of arm-pmu entries in there and hopefully numbers > 0.

Ah, I see now (I'm a perf newbie.)

Indeed, like you, I have to change the EMU clock domain to SWSUP[1] in
order to see any interrupts and see anything in perf top.  This isn't
really a mergeable workaround, so I'll look into this a little closer
with Santosh to see what we can do once we fully understand the HW
problem.

Kevin

[1]
diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
index 9299ac2..41d2260 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -390,7 +390,7 @@ static struct clockdomain emu_sys_44xx_clkdm = {
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.cm_inst	  = OMAP4430_PRM_EMU_CM_INST,
 	.clkdm_offs	  = OMAP4430_PRM_EMU_CM_EMU_CDOFFS,
-	.flags		  = CLKDM_CAN_HWSUP,
+	.flags		  = CLKDM_CAN_SWSUP,
 };
