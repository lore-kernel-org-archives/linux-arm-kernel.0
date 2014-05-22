From: cov@codeaurora.org (Christopher Covington)
Date: Thu, 22 May 2014 11:26:17 -0400
Subject: [PATCH RESEND 1/2] irqchip: Add generic gic-v1/gic-v2 compat
 strings.
In-Reply-To: <20140522090702.GA23478@leverpostej>
References: <1400680085-10430-1-git-send-email-Nikolay.Borisov@arm.com>
 <1400680085-10430-2-git-send-email-Nikolay.Borisov@arm.com>
 <CAL_JsqKpgWBQ6qFrDHt13wqRx1afPeapEz5z16enUyUX1fgUJg@mail.gmail.com>
 <20140522090702.GA23478@leverpostej>
Message-ID: <537E1719.4050102@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 05/22/2014 05:07 AM, Mark Rutland wrote:
> On Wed, May 21, 2014 at 10:27:33PM +0100, Rob Herring wrote:
>> On Wed, May 21, 2014 at 8:48 AM, Nikolay Borisov
>> <Nikolay.Borisov@arm.com> wrote:
>>> The current set of GIC compatible strings only contains specific
>>> implementations (e.g. arm,cortex-a9-gic) rather than revisions of the
>>> standard (e.g. arm,gic-v2), so each new implementation must either claim
>>> to be an extension of an existing implementation or have a new string
>>> added to the driver. This may be problematic when workarounds are
>>> required for bugs in particular implementations, as said workaround may
>>> end up targeting a wider set of implementations than intended.
>>>
>>> To prevent these issues, this patch adds compatible strings for the
>>> revisions of the GIC spec which all GIC implementations should be able
>>> to claim conformance to in addition to any particular implementation
>>> specific string, e.g.
>>
>> This just encourages not having specific properties which then also
>> prevents being able to add work-arounds later. SOCs using the a9 or
>> a15 string ONLY that are not an a9 or a15 are wrong. That's what we
>> should fix. Adding more generic strings is not going to help that. Do
>> you have a specific work-around you need to implement?
> 
> AFAIK, we don't have a specific workaround required anywhere that these
> strings would help with. It's just that generic GIC strings had been
> brought up repeatedly with no particular conclusion.
> 
> If we simply ensure that new DTS that feature a GIC have
> implementation-specific strings in addition to those we already support
> (e.g. "arm,cortex-a9-gic"), then I'm fine with that.
> 
>> Given that the GIC specs are obviously meaningless since we now have
>> GICv2 with 16 core support as well as the special exynos gics, I'm not
>> inclined to accept this.
> 
> Arguably neither are "true" GICv2, but your point stands.

I think the generic string (in addition to the specific one) is a good thing,
and I think it should be done for the PMU and any other specified/architected
hardware as well. If we don't allow for them, a shortcut would be to
masquerade hardware as something that's already supported. It seems like this
needs to be discouraged just as much as omitting the specific string.

The current behavior is that the driver will not run without a specific string
present. What if this were preserved (or replaced with a warning) even with
the addition of support for a generic string?

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
