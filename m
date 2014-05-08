From: archit@ti.com (Archit Taneja)
Date: Thu, 8 May 2014 11:18:12 +0530
Subject: [PATCH] ARM: OMAP5: DSS hwmod data
In-Reply-To: <alpine.DEB.2.02.1405080432570.23579@utopia.booyaka.com>
References: <1394619996-3525-1-git-send-email-tomi.valkeinen@ti.com>
 <alpine.DEB.2.02.1405080432570.23579@utopia.booyaka.com>
Message-ID: <536B1A9C.7050006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Thursday 08 May 2014 10:07 AM, Paul Walmsley wrote:
> Hi,
>
> On Wed, 12 Mar 2014, Tomi Valkeinen wrote:
>
>> This patch adds hwmod data for omap5 display subsystem. I have tested this on
>> omap5-uevm with a DSI panel. I cannot test omap5-uevm's hdmi output yet, as the
>> mainline is missing omap5 HDMI driver.
>>
>> I do see this when booting:
>>
>>    omap_hwmod: dss_dispc: cannot be enabled for reset (3)
>>    omap_hwmod: dss_dsi1: cannot be enabled for reset (3)
>>    omap_hwmod: dss_dsi2: cannot be enabled for reset (3)
>>    omap_hwmod: dss_hdmi: cannot be enabled for reset (3)
>>    omap_hwmod: dss_rfbi: cannot be enabled for reset (3)
>>
>> But at least DSI works just fine.
>
> Am looking at this for v3.16.  But I think someone needs to take a look at
> those warnings and figure out why they are happening.

We associate DSS clock domain's MODULEMODE bits only with the dss_core 
hwmod. The rest of the dss hwmods don't touch MODULEMODE.

Therefore, these hwmods cannot be enabled independently, and reset.

We don't face this issue in the omapdss driver since the platform 
devices corresponding to these hwmods have their parent as the platform 
device corresponding to 'dss_core'. This parent child-relation ensures 
that 'dss_core' is enabled when the a child calls a pm_runtime_get function.

The problem is that we have multiple hwmods which use the same 
MODULEMODE bit. There is no use-counting done when it comes to 
enabling/disabling modulemode. If there was such a thing, we could have 
provided MODULEMODE flags even for the children hwmods.

>
> Is the soc_ops.wait_target_ready() call failing in omap_hwmod.c:_enable()
> ?

Yes, that's the one that fails.

We have the same DSS in OMAP4, but we don't see the issue there. That's 
because we have modeled the MODULEMODE bits as a fake interface clock. 
That lets us enable hwmods independently, but it messes up DSS PM as it 
breaks some rules related to the sequence in which the opt-clocks and 
MODULEMODE bits need to be disabled.

We would want to change OMAP4 to work the way as above too, with the 
cost of having these prints above.

Archit
