From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 15 May 2012 11:15:31 -0700
Subject: [PATCH] clk: Constify struct clk_init_data
In-Reply-To: <4FB2875C.6030402@codeaurora.org>
References: <1337004763-21250-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20120514215304.GB3075@gmail.com> <4FB1AF14.3050507@codeaurora.org>
 <20120515070058.GK30400@pengutronix.de> <4FB2875C.6030402@codeaurora.org>
Message-ID: <4FB29D43.2040300@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2012 09:42 AM, Saravana Kannan wrote:
> On 05/15/2012 12:00 AM, Sascha Hauer wrote:
>> On Mon, May 14, 2012 at 06:19:16PM -0700, Saravana Kannan wrote:
>>> On 05/14/2012 02:53 PM, Turquette, Mike wrote:
>>>> On Mon, May 14, 2012 at 7:12 AM, Mark
>>>> Brown<broonie@opensource.wolfsonmicro.com> wrote:
>>>>> Allow drivers to declare their clk_init_data const, the framework
>>>>> really
>>>>> shouldn't be modifying the data.
>>>>>
>>>>> Signed-off-by: Mark Brown<broonie@opensource.wolfsonmicro.com>
>>>>
>>>> +interested parties
>>>>
>>>>>
>>>>> diff --git a/include/linux/clk-provider.h
>>>>> b/include/linux/clk-provider.h
>>>>> index c1c23b9..fc43ea6 100644
>>>>> --- a/include/linux/clk-provider.h
>>>>> +++ b/include/linux/clk-provider.h
>>>>> @@ -143,7 +143,7 @@ struct clk_init_data {
>>>>> */
>>>>> struct clk_hw {
>>>>> struct clk *clk;
>>>>> - struct clk_init_data *init;
>>>>> + const struct clk_init_data *init;
>>>
>>> Oh, wait. This won't work for the case where the clock registration
>>> is completely dynamic. Say, created from device tree or thru some
>>> PCI/USB device probe, etc. That's why I didn't add it before.
>>
>> Why not? In this case clk_init_data is also only used in clk_register.
>> Given that Mark has posted the patch I assume it actually works.
>>
>> Sascha
>>
>
> It's used in __clk_register() though. Which I added as a "as close as
> clk_register() but allows static init" function.
>

Sorry about my rushed responses earlier. I don't think the const will 
work even when purely using clk_register().

Say I use device tree (you can extend this to HW probing/detection) to 
know that there is a fixed factor clock. Now, if I want to dynamically 
create and register it, I will have to allocate struct clk_fixed_factor 
and struct clk_init_data. Then populate the fields of those structs and 
finally point clk_fixed_factor.hw.init to the allocated clk_init_data. 
Then call clk_register on clk_fixed_factor.hw. I'm not sure the 
assigning of the init field above will be possible if we mark it as const.

Really though, not marking it as const shouldn't really have a huge 
impact. What matters is that the common clock framework shouldn't try to 
use it after clk_register() and we can do that by following what Russell 
suggested (set hw.init to NULL at the end of clk_register).

Does that make sense?

Thanks,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
