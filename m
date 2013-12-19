From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 19 Dec 2013 12:44:43 -0700
Subject: [PATCH 2/4] clk: tegra: add EMC clock driver
In-Reply-To: <20131219100557.GE17188@tbergstrom-lnx.Nvidia.com>
References: <1387272400-4689-1-git-send-email-josephl@nvidia.com>
 <1387272400-4689-3-git-send-email-josephl@nvidia.com>
 <52B0D6FA.2060101@wwwdotorg.org>
 <1387359758.2576.38.camel@jlo-ubuntu-64.nvidia.com>
 <52B1E950.1040001@wwwdotorg.org>
 <20131219100557.GE17188@tbergstrom-lnx.Nvidia.com>
Message-ID: <52B34CAB.5060705@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2013 03:05 AM, Peter De Schrijver wrote:
>>> I guess using the clk_notifier may be OK for the 1st case.
>>
>> In both cases, isn't the overall operation something like:
>>
>> a) Do some work before changing the EMC clock
>> b) Change the EMC clock
>> c) Do some work after changing the EMC clock
>>
> 
> There is hw interaction between the EMC controller and the CAR module.
> Writing to the EMC clock source register in CAR will trigger a state machine
> in the EMC controller to handle the change of memory clock. The details
> of the state machine and how it needs to be setup are different for
> each Tegra variant. This means we need to be sure of the exact sequence
> of CAR and EMC register accesses for this to work. In theory this could
> be done with pre and post rate change notifiers, but I'm afraid this would
> be quite fragile.

Isn't the state machine setup something that the EMC driver does through
EMC registers (or perhaps also using flow controller registers?). If all
the clock driver does for this clock is program the requested rate,
which triggers the HW state machine, then I think we can isolate
everything else into the EMC driver.

In such a case, we don't need to use pre-/post-rate change notifiers at
all; just have the EMC driver call into the clock driver at the
appropriate step in the process where the clock registers should be written.

> 
>> Admittedly, the exact definition of "some work" is different for your
>> cases (1) and (2) above, but the overall structure is the same. As such,
>> can't the EMC scaling driver do (a), then do (b) i.e. call
>> clk_set_rate(), then do (c)? Or, in your case (2), do we need to do
> 
> We would need to be very sure clk_set_rate() doesn't access any other register
> besides the EMC clock source register before returning to the EMC scaling
> driver.

Well, we can certainly make that happen. We're writing the code behind
clk_set_rate() for the EMC clock after all...

But I'm not sure why that is a requirement. If it is, we're pretty
screwed, because surely there's nothing stopping some other driver
that's running on a different CPU from coming along and changing some
completely unrelated clock, which will then touch "some other register".
