From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Oct 2014 10:34:55 +0100
Subject: [PATCH] genirq: Introduce irq_read_line()
In-Reply-To: <alpine.DEB.2.11.1410211120430.5308@nanos>
References: <1408479811-26088-1-git-send-email-bjorn.andersson@sonymobile.com>
 <CAJAp7OgGPZZuCgC8iUiW2jrEVubK=KCATxd6eazdT1x1sSrffg@mail.gmail.com>
 <alpine.DEB.2.11.1410211120430.5308@nanos>
Message-ID: <544628BF.8010809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On 21/10/14 10:22, Thomas Gleixner wrote:
> On Thu, 4 Sep 2014, Bjorn Andersson wrote:
> 
>> On Tue, Aug 19, 2014 at 1:23 PM, Bjorn Andersson
>> <bjorn.andersson@sonymobile.com> wrote:
>>> Introduce the irq_read_line() function to allow device drivers to read
>>> the current logical state of an input when the hardware only exposes
>>> this through status bits in the interrupt controller.
>>>
>>> The new function is backed by a new callback function in the irq_chip -
>>> irq_read_line() - that can be implemented by irq_chips that owns such
>>> status bits.
>>>
>>> Based on rfc patch from April 2011 by Abhijeet.
>>>
>>> Cc: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
>>
>> ping?
> 
> Sorry, slipped through the cracks. I was talking about this to Marc
> last week and he needs it for yet another reason. He had some thoughts
> about the state representation, so I wait for him to comment.

Thanks for putting me in the loop. For the record, here's the RFC I
posted back in June:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/266328.html

and the patch implementing a similar concept:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/266331.html

Basic idea is that you can read (and possibly write back) various
low-level attributes (pending, masked, active) that an interrupt
controller may implement. Given your use case, we should loose the
checks on the interrupt being forwarded, as this makes little sense
outside of virtualization.

I'm planning to respin the series this week, as I have a number of
changes (there is hardly any need for the various states to be reported
atomically, for example), and a number of bugs have been found.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
