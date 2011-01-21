From: skannan@codeaurora.org (Saravana Kannan)
Date: Fri, 21 Jan 2011 11:16:52 -0800
Subject: [PATCH] drivers: mmc: msm: remove clock disable in probe
In-Reply-To: <1295629086.19880.17.camel@m0nster>
References: <1295374473-27872-1-git-send-email-dwalker@codeaurora.org>	
	<AANLkTim-=40MM=TeH1XSQ-rio1ctwcZAs4qbf9SaxmdH@mail.gmail.com>	
	<4D38FC55.2030601@codeaurora.org>
	<1295629086.19880.17.camel@m0nster>
Message-ID: <4D39DBA4.2040107@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2011 08:58 AM, Daniel Walker wrote:
> On Thu, 2011-01-20 at 19:24 -0800, Saravana Kannan wrote:
>> On 01/19/2011 02:50 AM, Vitaly Wool wrote:
>>> Hi,
>>>
>>> On Tue, Jan 18, 2011 at 7:14 PM, Daniel Walker<dwalker@codeaurora.org>   wrote:
>>>> The probe function adds the MMC host which can start accepting request
>>>> immediately. There is an assumption here that no requests happen
>>>> immediatly, but it's not always the case. This assumption can causes
>>>> a BUG() when the clocks are disabled. The fix is to just remove the
>>>> clock disable in the probe function.
>>>>
>>>> Signed-off-by: Daniel Walker<dwalker@codeaurora.org>
>>>
>>> I can add acked-by and/or tested-by if needed.
>>>
>>> ~Vitaly
>>
>> Nack from me. The fix is incorrect. The clocks are alread refcounted in
>> the clock driver. There should be no need to "leave it on because
>> someone else might access it". Every code that needs the clock should
>> have a clk_enable/disable around it and it would all work fine.
>
> You appear to be wrong Saravana .. The clocks are off at that point,
> which means there's no need to disable them twice. If you look at the
> MMC code mmc_add_host() will disable the clocks.
>

Does the clock disable in the probe fail all the time or only sometimes?

mmc_add_host() does a lot of things, so it's hard to figure out how it 
eventually ends up disabling the clocks as you claim. The only execution 
path from add_host() that I can see disabling the clocks are the calls 
to host->ios(). But that function has an enable and disable inside it. 
So, that's already balanced.

To me this still looks like a clock enable/disable mismatch. My best 
*guess* would be that the deferred disable code in 
msmsdcc_disable_clocks() might be missing a corner case and causing a 
disable to happen more that it should.

I will look further into this if I have time, but at this point I'm 
still skeptical whether this is the right fix. The reason I went from 
"sure" to "skeptical" is due to the deferred clock delay code in the driver.

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
