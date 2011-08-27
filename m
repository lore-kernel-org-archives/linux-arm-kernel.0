From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 27 Aug 2011 12:17:47 -0300
Subject: [PATCH 1/5] ARM: mx5: Allow CCM definitions to work on MX51 and
	MX53
In-Reply-To: <20110827111943.GK31404@pengutronix.de>
References: <1314386521-29351-1-git-send-email-fabio.estevam@freescale.com>
	<20110827111943.GK31404@pengutronix.de>
Message-ID: <CAOMZO5DcLj+bVchVrk9+K+xvzjD7sZpvMjmM0W0-o_qbzFnd5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 27, 2011 at 8:19 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Fri, Aug 26, 2011 at 04:21:57PM -0300, Fabio Estevam wrote:
>> Allow CCM (Clock Control Module) definitions to work on MX51 and MX53
>> by checking the cpu type in run-time and using the appropriate register bases.
>
> They already work on i.MX51 and i.MX53. They have different physical
> addresses, but have (more or less accidently...) the same virtual
> address.

Without this patch I get a kernel crash on MX53 at
arch/arm/mach-mx5/system.c , when trying to read
the following registers CCM registers:

void mx5_cpu_lp_set(enum mxc_cpu_pwr_mode mode)
{
	u32 plat_lpc, arm_srpgcr, ccm_clpcr;
	u32 empgc0, empgc1;
	int stop_mode = 0;

	/* always allow platform to issue a deep sleep mode request */
	plat_lpc = __raw_readl(MXC_CORTEXA8_PLAT_LPC) &
	    ~(MXC_CORTEXA8_PLAT_LPC_DSM);
	ccm_clpcr = __raw_readl(MXC_CCM_CLPCR) & ~(MXC_CCM_CLPCR_LPM_MASK);
	arm_srpgcr = __raw_readl(MXC_SRPG_ARM_SRPGCR) & ~(MXC_SRPGCR_PCR);
	empgc0 = __raw_readl(MXC_SRPG_EMPGC0_SRPGCR) & ~(MXC_SRPGCR_PCR);
	empgc1 = __raw_readl(MXC_SRPG_EMPGC1_SRPGCR) & ~(MXC_SRPGCR_PCR);

Regards,

Fabio Estevam
