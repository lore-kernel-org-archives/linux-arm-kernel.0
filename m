From: t.stanislaws@samsung.com (Tomasz Stanislawski)
Date: Wed, 18 Jun 2014 12:11:54 +0200
Subject: [PATCH 1/4] clk: propagate parent change up one level
In-Reply-To: <536176DD.5020507@gmail.com>
References: <1396623201-26000-1-git-send-email-t.stanislaws@samsung.com>
 <1396623201-26000-2-git-send-email-t.stanislaws@samsung.com>
 <5344198B.2030604@samsung.com> <536176DD.5020507@gmail.com>
Message-ID: <53A165EA.9000806@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,
Do you have any comments about this patch?
The patch is needed to provide a clean fix for recently
broken support for HDMI on Exynos4210 SoC in mainline.

Regards,
Tomasz Stanislawski


On 05/01/2014 12:19 AM, Tomasz Figa wrote:
> Mike,
> 
> On 08.04.2014 17:45, Tomasz Figa wrote:
>> Hi,
>>
>> On 04.04.2014 16:53, Tomasz Stanislawski wrote:
>>> This patch adds support for propagation of setup of clock's parent one
>>> level
>>> up.
>>>
>>> This feature is helpful when a driver changes topology of its clocks
>>> using
>>> clk_set_parent().  The problem occurs when on one platform/SoC
>>> driver's clock
>>> is located at MUX output but on the other platform/SoC there is a
>>> gated proxy
>>> clock between the MUX and driver's clock.  In such a case, driver's
>>> code has to
>>> be modified to use one clock for enabling and the other clock for
>>> setup of a
>>> parent.
>>>
>>> The code updates are avoided by propagating setup of a parent up one
>>> level.
>>>
>>> Additionally, this patch adds CLK_SET_PARENT_PARENT (sorry for naming)
>>> flag to
>>> inform clk-core that clk_set_parent() should be propagated.
>>>
>>> Signed-off-by: Tomasz Stanislawski <t.stanislaws@samsung.com>
>>> ---
>>>   drivers/clk/clk.c            |    6 ++++++
>>>   include/linux/clk-provider.h |    1 +
>>>   2 files changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>>> index dff0373..53bbfda 100644
>>> --- a/drivers/clk/clk.c
>>> +++ b/drivers/clk/clk.c
>>> @@ -1737,6 +1737,12 @@ int clk_set_parent(struct clk *clk, struct clk
>>> *parent)
>>>
>>>       /* try finding the new parent index */
>>>       if (parent) {
>>> +        if ((clk->flags & CLK_SET_PARENT_PARENT)
>>> +            && clk->num_parents == 1) {
>>> +            ret = clk_set_parent(clk->parent, parent);
>>> +            goto out;
>>> +        }
>>> +
>>>           p_index = clk_fetch_parent_index(clk, parent);
>>>           p_rate = parent->rate;
>>>           if (p_index < 0) {
>>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
>>> index 5119174..daa0b03 100644
>>> --- a/include/linux/clk-provider.h
>>> +++ b/include/linux/clk-provider.h
>>> @@ -30,6 +30,7 @@
>>>   #define CLK_GET_RATE_NOCACHE    BIT(6) /* do not use the cached clk
>>> rate */
>>>   #define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate
>>> change */
>>>   #define CLK_GET_ACCURACY_NOCACHE BIT(8) /* do not use the cached clk
>>> accuracy */
>>> +#define CLK_SET_PARENT_PARENT    BIT(9) /* propagate parent change up
>>> one level */
>>>
>>>   struct clk_hw;
>>>   struct dentry;
>>>
>>
>> This would be very useful, at least on Exynos platforms, with
>> mux-div-gate clock paths. PARENT_PARENT sounds a bit funny, though.
>>
>> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> 
> Your opinion on this would be greatly appreciated.
> 
> Best regards,
> Tomasz
