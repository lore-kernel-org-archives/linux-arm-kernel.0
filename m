From: robherring2@gmail.com (Rob Herring)
Date: Wed, 13 Mar 2013 10:39:41 -0500
Subject: [PATCH v3 03/11] clocksource: sp804: add device tree support
In-Reply-To: <1363188595.3100.101.camel@hornet>
References: <1363151142-32162-1-git-send-email-haojian.zhuang@linaro.org>
 <1363151142-32162-4-git-send-email-haojian.zhuang@linaro.org>
 <1363172730.3100.17.camel@hornet>	<51408A71.9090501@gmail.com>
 <1363185757.3100.66.camel@hornet>	<51409276.8050601@gmail.com>
 <1363186548.3100.75.camel@hornet>
 <CAD6h2NTP+X6RVr23Y-XLrQMqHptH974oYooTX=Y6F_Q4hyrmNA@mail.gmail.com>
 <1363188238.3100.95.camel@hornet>
 <CAD6h2NR+SC4cN5cBzHUNBfDQ1=x8Rbn3C4AizNyy562iMjyU6A@mail.gmail.com>
 <1363188595.3100.101.camel@hornet>
Message-ID: <51409DBD.5080209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2013 10:29 AM, Pawel Moll wrote:
> On Wed, 2013-03-13 at 15:25 +0000, Haojian Zhuang wrote:
>> On 13 March 2013 23:23, Pawel Moll <pawel.moll@arm.com> wrote:
>>> On Wed, 2013-03-13 at 14:17 +0000, Rob Herring wrote:
>>>> How about:
>>>>
>>>> 1 irq - TIMINT1
>>>> 2 irqs w/ same source # - TIMINTC
>>>> 2 irqs w/ different source # - TIMINT1 and TIMINT2
>>>
>>> On Wed, 2013-03-13 at 15:11 +0000, Haojian Zhuang wrote:
>>>> What's the scenario that we must use TIMINTC? TIMINT1 & TIMINT2 are
>>>> already enough on these two TIMERs. If we really needn't TIMINTC, we
>>>> need to support it. Since it's over-designed.
>>>>
>>>> If TIMINT1 & TIMINT2 aren't routed, and only TIMINTC is routed. It's another
>>>> case. We can consider it as replacement of TIMINT1.
>>>
>>> Just a thought... How to describe a SP804 with only TIMINT2 wired up?
>>>
>>> Pawe?
>>>
>>>
>> There's no difference on TIMINTC is only used to replace TIMINT1 or TIMINT2.
>> We only need to tell sp804 driver which timer is using irq, and the irq number.
> 
> If I understand you well:
> 
> * Both TIMINT1 and TIMINT2 wired up - TIMINTC doesn't matter
> 
> 	interrupts = <1>, <2>;
> 
> * TIMINT1 wired up, TIMINT2 not wired up
> 
> 	interrupts = <1>;
> 
> * Only TIMINTC wired up - treat it as TIMINT1
> 
> 	interrupts = <1>;
> 
> So far so good. My question is, how do you describe the following:
> 
> * _Only_ TIMINT2 wired up, TIMINT1 and TIMINTC _not_ wired up
> 
> 	interrupts = ???

I previously described that to add a property in that case. That makes
INT1 and INT2 only handling asymetric though. An alternative would be an
optional property "arm,sp804-has-irq = <#>" in the case of only INT1 or
INT2 connected. The combined irq would be a single irq without the
"arm,sp804-has-irq" property and both connected would be 2 irqs.

Rob
