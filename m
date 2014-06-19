From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 19 Jun 2014 14:12:01 +0100
Subject: [PATCH v4 11/13] serial: asc: Adopt readl_/writel_relaxed()
In-Reply-To: <53A2D135.4020700@linaro.org>
References: <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
 <1403174303-25456-1-git-send-email-daniel.thompson@linaro.org>
 <1403174303-25456-12-git-send-email-daniel.thompson@linaro.org>
 <53A2C9A3.9090507@linaro.org> <53A2CD8D.1050106@linaro.org>
 <53A2D135.4020700@linaro.org>
Message-ID: <53A2E1A1.3010705@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/06/14 13:01, Srinivas Kandagatla wrote:
>>> Why are we concern about x86 for this driver?
>>> As per my understanding this IP is only seen on ARM and SH based CPUs so
>>> why cant we just use relaxed versions, why ifdefs?
>>> I think, this would involve fixing the kconfig and make it depend on SH
>>> and ARM based platforms only.
>>
>> You mean just drop the COMPILE_TEST?
>>
>> In generally I like as much code as possible to compile on x86. Its
>> worthwhile protection against the excessive/accidental ARMisms which
>> could easily impact less common architectures (such as SH).
> 
> That's fair. Does this mean that we are going do similar changes to
> other ST drivers too?

I didn't give any thought at all to other ST drivers. I don't see why a
*general* preference (of mine or anyone else) would override what is
right for any particular driver.

I don't think "both manage ST peripherals" means drivers have much in
common.


>>> On the other hand, This patch looks more generic and applicable to most
>>> of the drivers. Am not sure which way is the right one.
>>
>> I'm particularly keen on doing the right thing where readl_relaxed() is
>> concerned because this function has a compiler barrier on ARM but not on
>> x86.
>>
> My only concern is code duplication all across ST drivers.

I really struggle to understand this. Why would anyone copy code out of
the asc driver into the network driver (or any other ST driver)?


>> Since having asc_in/asc_out made it easy to portably make these changes
>> I decided is was better to be redundantly exemplary than conceal secret
>> portability issues.
> Your change would fit in nicely with as asc_in/out are wrappers and fix
> st-asc but this would be just for asc driver.
> What about other drivers which fall in same category?
> 
> So I think we should just drop COMPILE_TEST and possibly make it
> specific to ARM and SH or ARM only.

I'm slightly uneasy about this primarily because all the rationale above
describes a concern about drivers other than the one I seek to change.
They ought to be outside the scope of this change.

Nevertheless, since I said I don't feel that strongly about it, as you
wish...

I'll change this in v5.
