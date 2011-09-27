From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 27 Sep 2011 16:27:32 +0530
Subject: [RFC PATCH 3/3] ARM: mm: add l2x0 suspend/resume support
In-Reply-To: <20110927102835.GA18572@e102568-lin.cambridge.arm.com>
References: <1317047561-11020-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1317047561-11020-4-git-send-email-lorenzo.pieralisi@arm.com>
	<20110926150645.GN22455@n2100.arm.linux.org.uk>
	<20110926171452.GC11647@e102568-lin.cambridge.arm.com>
	<4E815F42.6010102@ti.com>
	<20110927102835.GA18572@e102568-lin.cambridge.arm.com>
Message-ID: <4E81AC1C.4090405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 September 2011 03:58 PM, Lorenzo Pieralisi wrote:
> Santosh,
> 
> On Tue, Sep 27, 2011 at 06:29:38AM +0100, Santosh Shilimkar wrote:
>> Lorenzo,
>>
>> On Monday 26 September 2011 10:44 PM, Lorenzo Pieralisi wrote:
>>> On Mon, Sep 26, 2011 at 04:06:45PM +0100, Russell King - ARM Linux wrote:
>>>> On Mon, Sep 26, 2011 at 03:32:41PM +0100, Lorenzo Pieralisi wrote:
>>>>> Context is saved once for all at boot time, along with the L2 physical address
>>>>> and cache type.
>>>>
>>>> Why is this assembly code?  As Barry's previous patch shows, it's
>>>> entirely possible to save all the state required at init time from
>>>> the existing C code without needing any additional functions.
>>>>
>>>
>> I too didn't like this approach.
>>
>> The platforms which needs to take care of security needs to take
>> care of the L2 on their own and this code doesn't help them.
>>
>> Other platform which wants to use the L2 code, looks like are
>> fine to use the C-version which saves registers in init and restores
>> it in resume path whenever needed. The patch which was posted
>> on that was good enough. Regarding turning OFF MMU is really
>> not necessary unless and until some hardware's are buggy. In that
>> case, instead of adding that un-necessary code in generic code,
>> it's better to patch only that buggy SOC code.
>>
> 
> I summed up the reasons for this patch to exist in the cover letter 
> and I mentioned that some bits can be merged IF needed:
> 
> http://www.spinics.net/lists/arm-kernel/msg141989.html
> 
I read that.

> Having said that:
> 
> - This patch does not switch the MMU off
I noticed that. That comment was miss-placed.

> - This patch does not cover security, and I mentioned that
I never said it is covering security.
"The platforms which needs to take care of security needs to take
care of the L2 on their own and this code doesn't help them."

> - Russell referred to saving registers not restoring them, for a reason
I raised this point on very first patch for L2. My point here was all
the L2 registers cab be saved in init function and C-file.

> - If the resume hook is written in C you cannot call it when the MMU is
>   off, which we need if L2 is retained. Unless you think OMAP is the
>   only platform supporting L2 RAM retention, but there are people who might
>   disagree.
> 
Again I never said that. I guess MX support it as well. But I don't know
whether they have secure limitations as well. If not then probably
this asm resume function can help.

> And if you think it is not worth merging since most SoCs will run in
> non-secure mode, then that's a very valid point, but it is true for both
> patch series, not just for this one.
> 
I agree. From various discussion so far, apart MX, nobody complained
about C-version of the code. Hence the comment. If there are more
platforms which needs it, then the asm version would be useful and
should be preferred over C-version.

Regards
Santosh
