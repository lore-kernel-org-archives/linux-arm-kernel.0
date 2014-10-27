From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 27 Oct 2014 14:57:27 -0700
Subject: [PATCH] genirq: Introduce irq_read_line()
In-Reply-To: <alpine.DEB.2.11.1410251033270.5308@nanos>
References: <1408479811-26088-1-git-send-email-bjorn.andersson@sonymobile.com>
 <CAJAp7OgGPZZuCgC8iUiW2jrEVubK=KCATxd6eazdT1x1sSrffg@mail.gmail.com>
 <alpine.DEB.2.11.1410211120430.5308@nanos> <544628BF.8010809@arm.com>
 <CAJAp7OjpN-+S=OH1BW6Fcme9mp4qj8AsSNC3_41fhfpYzX-Shg@mail.gmail.com>
 <544A936D.5040409@arm.com> <544AABB8.10302@codeaurora.org>
 <alpine.DEB.2.11.1410251033270.5308@nanos>
Message-ID: <544EBFC7.70603@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2014 01:34 AM, Thomas Gleixner wrote:
> On Fri, 24 Oct 2014, Stephen Boyd wrote:
>
>> On 10/24/2014 10:59 AM, Marc Zyngier wrote:
>>> Hi Bjorn,
>>>
>>> On 24/10/14 18:31, Bjorn Andersson wrote:
>>>> Stephen Boyd talked about the need to be able to mask/unmask interrupts from
>>>> client code in the Qualcomm platform as well - most likely to block wakeup
>>>> sources(?)
>>> What's wrong with irq_disable?
>> The problem is irq_disable() is lazy and doesn't actually disable the
>> interrupt.
> Nothing prevents you from adding your own irq_disable() callback for
> those interrupts. Just the default is lazy.
>
>

Ok, if we did that it would be global for the entire arm gic right? I see:

void irq_disable(struct irq_desc *desc)
{
        irq_state_set_disabled(desc);
        if (desc->irq_data.chip->irq_disable) {
                desc->irq_data.chip->irq_disable(&desc->irq_data);
                irq_state_set_masked(desc);
        }
}       

so we would need to add some return value to irq_disable() so that we
could tell if this particular interrupt needs to be disabled or not or
we would need to set a different chip for this particular interrupt with
the irq_disable callback set? Plus any scheme would need to be SoC
specific somehow and be setup early when the gic is probed. Maybe we can
encode this information in the DT specifier somehow to indicate that we
want disable_irq() to actually mask the irq? This is all under the
assumption that we can't just force every gic interrupt to mask on disable.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
