From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 28 Jun 2013 08:50:26 -0600
Subject: [PATCH v1 01/12] input: matrix-keypad: update devicetree binding
 doc
In-Reply-To: <20130628082422.GV24305@book.gsilab.sittig.org>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
 <1371838198-7327-2-git-send-email-gsi@denx.de>
 <51C4C63B.3030300@wwwdotorg.org>
 <20130622092319.GE24305@book.gsilab.sittig.org>
 <51C8C17A.1050700@wwwdotorg.org>
 <20130628082422.GV24305@book.gsilab.sittig.org>
Message-ID: <51CDA2B2.7090304@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2013 02:24 AM, Gerhard Sittig wrote:
> On Mon, Jun 24, 2013 at 16:00 -0600, Stephen Warren wrote:
>>
>> On 06/22/2013 03:23 AM, Gerhard Sittig wrote:
...
> So the direction to go is
> - move the Linux driver specific discussion to
>   Documentation/input/ including potential hardware setups and
>   the background on the driver's theory of operation
> - just concentrate on "adjustables" in the binding document,
>   merely listing the set and their units, while the motivation or
>   background either "is obvious" or can get looked up in the
>   driver's discussion
>
> Reducing the set of options is orthogonal to that.

Yup, sounds good.

> Breaking
> backwards compatibility by changing the default behaviour after
> introducing more generic approaches to the specific issue is an
> option that remains for future changes.

Breaking backwards-compatibility in the DT bindings would be
problematic. They're supposed to be an ABI, which if it evolves, does so
entirely in a backwards-compatible fashion.

This can usually be achieved by something like:

* If new DT properties present, enable new behaviour.
* If old DT properties present, or lack of new properties, enable old
behaviour.

This allows somebody to install a specific DT on a system, then continue
booting arbitrary new kernels on it without loss of functionality.

>>>> That one change is definitely wrong. Each entry in row-gpios and
>>>> col-gpios should include GPIO flags (in a format defined by the binding
>>>> for the DT node providing the GPIO). Those flags include an active-high
>>>> vs. active-low bit. In Linux, you can use of_get_gpio_flags() to
>>>> retrieve a standardized representation of the flags.
>>>
>>> See my introduction above.  This isn't a "change", it's just
>>> catching up in the documentation and adding what was omitted
>>> before.
>>
>> Oh dear, that's quite unfortunate. I see that even though that property
>> wasn't documented in the binding doc, arch/powerpc/boot/dts/ac14xx.dts
>> has still already used it, so we probably can't fix it. I suppose we
>> must simply document it, and ignore the shortcomings of that binding:-(
> 
> Don't worry about the 'AC14xx' board too long, its using the
> keypad matrix driver is new in mainline, and still can get
> adjusted without too much problems before more wide spread use.
> "Getting it right" is what I'm currently heading for, while
> nothing is set in stone yet.

Given the "ABI-ness" of DT, I'm not convinced we don't have to worry
about the AC14xx. I think we'll have to continue supporting that
property, even if there's a newer/better/more-flexible way of
representing the information too.
