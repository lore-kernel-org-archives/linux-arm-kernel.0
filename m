From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 06 Mar 2015 14:40:46 -0700
Subject: [PATCH 02/10] mailbox: Enable BCM2835 mailbox support
In-Reply-To: <54FA0E2B.30300@wwwdotorg.org>
References: <1425329684-23968-1-git-send-email-eric@anholt.net>
 <1425329684-23968-3-git-send-email-eric@anholt.net>
 <54F675F1.60205@wwwdotorg.org> <87a8zs8vzo.fsf@eliezer.anholt.net>
 <54F932FD.5040207@wwwdotorg.org> <87bnk5lwvt.fsf@eliezer.anholt.net>
 <54FA0E2B.30300@wwwdotorg.org>
Message-ID: <54FA1EDE.1060900@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2015 01:29 PM, Stephen Warren wrote:
> On 03/06/2015 01:00 PM, Eric Anholt wrote:
>> Stephen Warren <swarren@wwwdotorg.org> writes:
>>
>>> On 03/04/2015 11:20 AM, Eric Anholt wrote:
>>>> Stephen Warren <swarren@wwwdotorg.org> writes:
>>>>
>>>>> On 03/02/2015 01:54 PM, Eric Anholt wrote:
>>>>>> From: Lubomir Rintel <lkundrak@v3.sk>
>>>>>>
>>>>>> Implement BCM2835 mailbox support as a device registered with
>>>>>> the general purpose mailbox framework. Implementation based on
>>>>>> commits by Lubomir Rintel [1], Suman Anna and Jassi Brar [2] on
>>>>>> which to base the implementation.
>>>>>
>>>>>> diff --git a/drivers/mailbox/bcm2835-mailbox.c
>>>>>> b/drivers/mailbox/bcm2835-mailbox.c
>>>
>>>>>> +static irqreturn_t bcm2835_mbox_irq(int irq, void *dev_id) +{
>>>>>> +    struct bcm2835_mbox *mbox = (struct bcm2835_mbox *) dev_id; +
>>>>>> struct device *dev = mbox->dev; + +    while (!(readl(mbox->regs +
>>>>>> MAIL0_STA) & ARM_MS_EMPTY)) { +        u32 msg = readl(mbox->regs +
>>>>>> MAIL0_RD); +        unsigned int chan = MBOX_CHAN(msg); + +        if
>>>>>> (!mbox->channel[chan].started) { +            dev_err(dev, "Reply on
>>>>>> stopped channel %d\n", chan); +            continue; +        } +
>>>>>> dev_dbg(dev, "Reply 0x%08X\n", msg); +
>>>>>> mbox_chan_received_data(mbox->channel[chan].link, +
>>>>>> (void *)
>>>>>> MBOX_DATA28(msg)); +    } +    rmb(); /* Finished last mailbox read.
>>>>>> */
>>>>>
>>>>> I know the PDF mentioned in the comment earlier in the patch says
>>>>> to put in barriers between accesses to different peripherals,
>>>>> which this seems compliant with, but I don't see quite what this
>>>>> barrier achieves. I think the PDF is talking generalities, not
>>>>> imposing a rule that must be blindly followed. Besides, if
>>>>> there's a context-switch you can't actually implement the rules
>>>>> the PDF suggests. What read operation is this barrier attempting
>>>>> to ensure happens after reading all mailbox messages and any
>>>>> associated DRAM buffer?
>>>>
>>>> Looking at this bit of code in particular:
>>>>
>>>> "As interrupts can appear anywhere in the code so you should
>>>> safeguard those. If an interrupt routine reads from a peripheral
>>>> the routine should start with a memory read barrier. If an
>>>> interrupt routine writes to a peripheral the routine should end
>>>> with a memory write barrier."
>>>
>>> I can see that doing that would be safe, but I don't think following
>>> those rules is actually necessary in the general case. Following those
>>> rules would cause lots of unnecessary barriers in code.
>>>
>>> Barriers shouldn't be used arbitrarily at the start/end of ISRs, but
>>> rather at specific chosen locations in the code that actually need to
>>> enforce some kind of memory ordering.
>>
>> According to the architecture docs, if you don't RMB at the start of
>> your ISR, then the following timeline could get the wrong values:
>
> Which architecture doc and section/... specifically?

Ah, this is BCM2835-ARM-Peripherals.pdf still. I found the footnote you 
mentioned.

>> some other device driver               our isr
>> ------------------------               -------
>> rmb()
>> read from device
>>                                         read from device
>>                                         examine value read
>>                                         exit isr
>> examine value raed.
>>
>> The ISR could get the device driver's value.  This is made explicit in
>> footnote 2 on page 7.
>
> Are you saying that the "read from device" in the right -hand "our isr"
> column could end up returning the value actually read during "read from
> device" in the left-hand "some other device driver" column, or vice-versa?
>
> That doesn't make any sense.
>
> Barriers are about ensuring that accesses happen (are visible or
> complete) in the desired order, not about ensuring that the results of
> two unrelated reads don't get swapped.

Ah. I've been thinking about the typical uses of barriers to ensure 
ordering of transactions on a standards-compliant ARM CPU.

It was pointed out on IRC that perhaps the barriers are to work around a 
CPU/SoC bug. In which case, if the CPU/bus really can swap results, then 
I can see how barriers might be required and how they might solve the 
problem. If this is the real reason, it sounds truly massively scary.

I think this deserves a complete description in each driver file and in 
the commit description for any commit that introduces these barriers. 
Otherwise someone else will just want to rip them out.

I'm also concerned that we need to add barriers in many more places than 
just that start/end of ISRs. For example, what if the ISR for the 
mailbox ends up calling back into some other driver that goes and 
touches a different HW module. Now we need to put barriers either at the 
start/end of that callback function, or immediately before/after we call 
that callback function. This has potential to need barriers in a whole 
bunch of places one wouldn't expect.

I sure hope this was fixed on bcm2836, or that the ordering issue 
appears separately within each CPU core and there's no interaction 
between multiple CPU cores. Otherwise, two separate pieces of code 
running on two separate CPU cores are going to have trouble when they 
start touching different peripherals.
