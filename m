From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 17 Apr 2012 12:55:25 +0530
Subject: [Query] Common Clock Framework: How to handle clks enabled by
 default
In-Reply-To: <CAAQ0ZWT_xJAp4H_k_Mr24Fcj5tKAhpev4nr8gpK3-3zpM_MobA@mail.gmail.com>
References: <4F8D0BF9.7080802@st.com>
 <CAAQ0ZWT_xJAp4H_k_Mr24Fcj5tKAhpev4nr8gpK3-3zpM_MobA@mail.gmail.com>
Message-ID: <4F8D1AE5.9000509@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/17/2012 12:43 PM, Shawn Guo wrote:
> On 17 April 2012 14:21, Viresh Kumar <viresh.kumar@st.com> wrote:
>> Hi,
>>
>> How are we handling clocks which are enabled by bootloaders and are
>> required to be enabled, like, pll, cpu, ahb?
>>
> Call clk_prepare_enable on the clocks in platform clock init function.

Probably that is what i need.

>> Following is example clk hierarchy:
>> osc(root)->pll->cpu->ahb->dma
>>
>> Issue1: Now, when we do clk_enable() for dma, all these already enabled clocks
>> are re-enabled.
> 
> What's the problem with doing that?  Your hardware does not cope with
> setting/clearing a bit that already set/cleared.  Even if that is the
> case, you can easily handle that in your .enable/.disable ops.

No issues with my hardware atleast, but seems to be logically incorrect.

If we could have scanned hardware at boot time, to see which are enabled
by bootloader and updated clk_prepare/enable count for them in clk framework,
picture would have been much clearer.

We can disable clks (enabled by bootloader), that lacks a specific flag in
their flags field during this scan.

>> Issue2: On clk_disable() all are disabled and system hangs :(
>>
> It should not.  It means you have other clocks in the hierarchy not
> manged well.  The parent of the clock will not be gated by calling
> clk_disable, if there are other sibling clocks are enabled.

Yes. This happens at boot time, where clk_enable for none of the siblings
is called.

>> There is one option CLK_IGNORE_UNUSED, which is used only for disabling
>> unused clocks. So that is not helpful here.
>>
>> One way i could think of is not to give clk_gate support for these clocks,
>> so that they can never be disabled. Is this the preferred way?
>>
> It only makes sense on those completely internal clocks which will
> never need managing.

Hmm.

-- 
viresh
