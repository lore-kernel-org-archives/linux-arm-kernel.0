From: architt@codeaurora.org (Archit Taneja)
Date: Mon, 29 Jan 2018 09:44:21 +0530
Subject: [PATCH] drm/bridge/synopsys: dsi: use adjusted_mode in mode_set
In-Reply-To: <5f9d5de7-4597-b9e9-64fe-666230b12bce@st.com>
References: <20180125155504.8611-1-philippe.cornu@st.com>
 <CA+ASDXOLYaL1zT-K0FvVTFGQ2BA12eHkrZw_mau50aUBdy=vhA@mail.gmail.com>
 <5f9d5de7-4597-b9e9-64fe-666230b12bce@st.com>
Message-ID: <075514d0-ff00-606e-4616-e2db4fb75d0d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/26/2018 03:24 PM, Philippe CORNU wrote:
> Hi Brian,
> And a big thanks for your Tested-by
> 
> On 01/25/2018 11:47 PM, Brian Norris wrote:
>> On Thu, Jan 25, 2018 at 7:55 AM, Philippe Cornu <philippe.cornu@st.com> wrote:
>>> The "adjusted_mode" clock value (ie the real pixel clock) is more
>>> accurate than "mode" clock value (ie the panel/bridge requested
>>> clock value). It offers a better preciseness for timing
>>> computations and allows to reduce the extra dsi bandwidth in
>>> burst mode (from ~20% to ~10-12%, hw platform dependant).
>>>
>>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>>> ---
>>> Note: This patch replaces "drm/bridge/synopsys: dsi: add optional pixel clock"
>>
>> These two appear to be the same for my cases, but at least nothing breaks:
>>
> 
> In drivers/gpu/drm/rockchip/rockchip_drm_vop.c function
> vop_crtc_mode_fixup(), the adjusted_mode->clock (ie. vop px clk output =
> dw dsi px clk input) is updated according to rockchip hw pll/dividers...
> 
> So you "may" have a different value in adjusted_mode->clock compare to
> mode->clock. Maybe there is no difference for the panel you are using
> because its px clock matches perfectly with rockchip hw pll/dividers...
> or has been set to match with ;-)
> 
> I did a similar patch (see [1]) and it works "fine" on stm, the only
> difference with the rockchip vop is that clk_round_rate() returns odd
> values on stm so I used set/get_rate instead.
> 
> So now, both rockchip & stm crtc have an "adjusted_mode->clock" so it
> makes sense to use it in dw dsi :)

Could you get the patch [1] queued on drm-misc-next? I can queue this patch
after it.

Thanks,
Archit

> 
> Philippe :-)
> 
> [1] https://patchwork.freedesktop.org/patch/200720/
> "[PATCH] drm/stm: ltdc: use crtc_mode_fixup to update adjusted_mode clock"
> 
> 
>> Tested-by: Brian Norris <briannorris@chromium.org>
>>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
