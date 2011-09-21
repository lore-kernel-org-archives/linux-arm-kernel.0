From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 20 Sep 2011 22:14:59 -0600
Subject: [PATCH 0/3] GIC OF bindings
In-Reply-To: <20110920.224910.1996429830782124690.davem@davemloft.net>
References: <1316550244-3655-1-git-send-email-robherring2@gmail.com>
	<20110920.224910.1996429830782124690.davem@davemloft.net>
Message-ID: <CACxGe6t7Mdr+w+aGFPM2-FEAQaYHuG8Za9dybLgMo-5-whLyNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2011 at 8:49 PM, David Miller <davem@davemloft.net> wrote:
> From: Rob Herring <robherring2@gmail.com>
> Date: Tue, 20 Sep 2011 15:24:01 -0500
>
>> Hopefully, this is the final or near final version of GIC binding support.
>>
>> Changes from the previous version:
>> - SPIs and PPIs are numbered starting at 0. Now the gic has it's own irq
>> ? domain translate function instead of the simple domain one.
>> - interrupt cell format has changed based on Grant's proposal.
>> - Dropped "ARM: gic: allow irq_start to be 0". Instead, the first 16 irqs
>> ? are skipped and the domain irq_base adjusted accordingly.
>> - Added a fix to of_irq_find_parent when the parent == child.
>> - Renamed intc_desc.parent to intc_desc.interrupt_parent.
>> - Implemented Grant's algorithm for walking the list of interrupt
>> ? controllers. Added a return value to interrupt init functions, so they
>> ? don't get added to the parent list on a init failure.
>>
>> The changes are significant enough that I did not include previous
>> acked/reviewed/tested-by's.
>
> Just out of curiosity where does this "interrupt-parent" property
> come from?
>
> On platforms I am familiar with, the parent path is walked to the root
> and we stop at device nodes that have "interrupt-map" and
> "interrupt-map-mask" properties.
>
> The map and mask are applied to the "reg" property of the device in
> question to see which map entry matches, if a match is found the map
> entry contains the translated interrupt.
>
> And this process continues over and over all the way to the root to get
> the system interrupt that processor actually deals with.
>
> The mechanism shown here seems overly simplistic and not able to handle
> the cases handled by existing OF property schemes in use for several
> years on real systems.

interrupt-parent has been implemented for years on powerpc.  I don't
know if it was ever an Open Firmware thing, but it is in ePAPR [1],
and ARM isn't doing anything novel in that regard.

[1] section 2.4, page 30,
https://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.1.pdf

It is true that is cannot handle all situations, but for those
interrupt-map is still available.

g.
