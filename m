From: bjorn@kryo.se (Bjorn Andersson)
Date: Tue, 28 Oct 2014 08:41:50 -0700
Subject: [PATCH] genirq: Introduce irq_read_line()
In-Reply-To: <874musjyfi.fsf@why.wild-wind.fr.eu.org>
References: <1408479811-26088-1-git-send-email-bjorn.andersson@sonymobile.com>
 <CAJAp7OgGPZZuCgC8iUiW2jrEVubK=KCATxd6eazdT1x1sSrffg@mail.gmail.com>
 <alpine.DEB.2.11.1410211120430.5308@nanos>
 <544628BF.8010809@arm.com>
 <CAJAp7OjpN-+S=OH1BW6Fcme9mp4qj8AsSNC3_41fhfpYzX-Shg@mail.gmail.com>
 <544A936D.5040409@arm.com>
 <CAJAp7OjQ8qRspy_ocUnp+es+HPiR1jULhKK6g4DBXXZcOsABug@mail.gmail.com>
 <874musjyfi.fsf@why.wild-wind.fr.eu.org>
Message-ID: <CAJAp7OiXpksp_CPdpLYd2kwGXRNx2q+cq1a_hjc9fEBrcwXTiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 25, 2014 at 2:22 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Sat, Oct 25 2014 at 12:12:55 am BST, Bjorn Andersson <bjorn@kryo.se> wrote:
>> On Fri, Oct 24, 2014 at 10:59 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> I just pushed out a branch:
>>> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
>>> irq/irqchip_state
>>>
>>> Please let me know if that's useful for you.
>>>
>>
>> I think that my irq_read_line() would be equivalent of
>> irq_get_irqchip_state(IRQCHIP_STATE_PENDING), i.e. the state of the
>> interrupt ignoring masking. And the rest would be EINVAL.
>> So I think this would work out just fine for us!
>
> Excellent.
>

Hi Marc,

We gave this some more thought and read up on what "pending" and
"active" means according to the ARM GIC - PENDING is not what we want
:(

In the Qualcomm pmic we have two interrupt status registers
"interrupt" and "real-time". I think the "interrupt" status register
would be the one related to your defined constants. However what we
need to access in our use cases are the "real-time" status register,
which basically is a representation of the input to the interrupt
logic.

As far as I can see the GIC does not offer anything like that, but I
hope we could add another constant to your enum list and utilise your
api for this.

I'm not entirely sure what we should call it though,
IRQCHIP_STATE_LEVEL seems somewhat conflicting with level trigger and
the Qualcomm name IRQCHIP_STATE_REALTIME isn't very self describing.
Maybe IRQCHIP_STATE_LINE_LEVEL?

Regards,
Bjorn
