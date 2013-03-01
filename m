From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 01 Mar 2013 13:49:01 -0700
Subject: [PATCH 2/5] clk: notifier handler for dynamic voltage scaling
In-Reply-To: <1362130891.19498.12.camel@bilhuang-vm1>
References: <1362026969-11457-1-git-send-email-mturquette@linaro.org>
 <1362026969-11457-3-git-send-email-mturquette@linaro.org>
 <1362130891.19498.12.camel@bilhuang-vm1>
Message-ID: <5131143D.2060904@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/2013 02:41 AM, Bill Huang wrote:
> On Thu, 2013-02-28 at 12:49 +0800, Mike Turquette wrote:
>> Dynamic voltage and frequency scaling (dvfs) is a common power saving
>> technique in many of today's modern processors.  This patch introduces a
>> common clk rate-change notifier handler which scales voltage
>> appropriately whenever clk_set_rate is called on an affected clock.
> 
> I really think clk_enable and clk_disable should also be triggering
> notifier call and DVFS should act accordingly since there are cases
> drivers won't set clock rate but instead disable its clock directly, do
> you agree?
>>
>> There are three prerequisites to using this feature:
>>
>> 1) the affected clocks must be using the common clk framework
>> 2) voltage must be scaled using the regulator framework
>> 3) clock frequency and regulator voltage values must be paired via the
>> OPP library
> 
> Just a note, Tegra Core won't meet prerequisite #3 since each regulator
> voltage values is associated with clocks driving those many sub-HW
> blocks in it.

Perhaps that "just" means extending the dvfs.c code here to iterate over
each clock consumer (rather than each clock provider), and having each
set a minimum voltage (rather than a specific voltage), and having the
regulator core apply the maximum of those minimum constraints?

Or something like that anyway.
