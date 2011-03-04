From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 4 Mar 2011 11:57:56 +0100
Subject: [PATCH] OMAP2/3: VENC hwmod: add OCPIF_SWSUP_IDLE flag to
	interface
In-Reply-To: <alpine.DEB.2.00.1103032300480.10981@utopia.booyaka.com>
References: <alpine.DEB.2.00.1103032300480.10981@utopia.booyaka.com>
Message-ID: <4D70C5B4.3080401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Tomi

Hi Paul,

On 3/4/2011 7:02 AM, Paul Walmsley wrote:
>
> According to the hwmod interface data, the DSS submodule "VENC" uses a
> clock, "dss_54m_fck"/"dss_tv_fck", which the PRCM cannot autoidle.  By
> default, the hwmod code assumes that interface clocks can be autoidled
> by the PRCM.  When the interface clock can't be autoidled by the PRCM,
> those interfaces must be marked with the OCPIF_SWSUP_IDLE flag.
> Otherwise, the "interface clock" will always have a non-zero use
> count, and the device won't enter idle.  This problem was observed on
> N8x0.
>
> Fix the immediate problem by marking the VENC interface with the
> OCPIF_SWSUP_IDLE flag.  But it's not clear that
> "dss_54m_fck"/"dss_tv_fck" is really the correct interface clock for
> VENC.  It may be that the VENC interface should use a
> hardware-autoidling interface clock.  This is the situation on OMAP4,
> which uses "l3_div_ck" as the VENC interface clock, which can be
> autoidled by the PRCM.  Clarification from TI is needed.

Yep, this is clearly wrong, all DSS modules are using the same 
interconnect port from the L4, thus they should all use the dss_ick as 
interface clock and not the functional clock dss_tv_fck.

There is something strange with that module because the main_clk is 
attached to dss1_alwon_fck instead of dss_tv_fck.

I'm quite sure that both are needed to make that module work and that's 
why it was added as an interface clock.
In theory, one of them should be an optional clock like on OMAP4.


Sumit,

Could you explain the rational behind the usage of dss_tv_fck as an iclk 
and dss1_alwon_fck as a fclk?

Thanks,
Benoit
