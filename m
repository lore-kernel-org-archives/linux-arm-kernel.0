From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Sat, 14 Jul 2012 12:39:11 +0200
Subject: Loading handle_arch_irq with a PC relative load
In-Reply-To: <alpine.LFD.2.02.1207131604470.14068@xanadu.home>
References: <50007197.8030403@xenomai.org>
 <alpine.LFD.2.02.1207131536260.14068@xanadu.home>
 <50007C33.4000105@xenomai.org>
 <alpine.LFD.2.02.1207131604470.14068@xanadu.home>
Message-ID: <50014C4F.8070002@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13/2012 10:09 PM, Nicolas Pitre wrote:
> On Fri, 13 Jul 2012, Gilles Chanteperdrix wrote:
> 
>> On 07/13/2012 09:40 PM, Nicolas Pitre wrote:
>>> On Fri, 13 Jul 2012, Gilles Chanteperdrix wrote:
>>>
>>>>
>>>> I do not know if it is really useful, but it seems it would be possible 
>>>> to reduce the number of memory accesses to just one in the irq_handler 
>>>> macro in the case where CONFIG_MULTI_IRQ_HANDLER is enabled, by using a 
>>>> PC relative load, with something like the following patch:
>>>
>>> To be strict with ccode sections, you can't do this.  The 
>>> handle_arch_irq symbol identifies a variable and with your patch you're 
>>> moving it from the .data section to the .text section.  The .text 
>>> section is meant to be read only, and this is even more true when using 
>>> a XIP kernel where .text is in ROM, or if we could make the access 
>>> protection of the kernel ro.
>>
>> I understand that but, XIP kernel aside, the handle_arch_irq variable is
>> set only once very early during the boot process, so, almost read-only.
>> Is not Linux using self-modifying code in some cases anyway (booting an
>> SMP kernel on an UP processor for instance).
> 
> There are limits to which such tricks should be applied.  In the SMP on 
> UP case this is a matter of making the kernel boot at all which is a 
> rather strong reason.
> 
> Do you have performance numbers like interrupt latency that show this 
> patch being worth it?  Without concrete justifications I don't think we 
> should go down that path.

So, I ran a few tests on at91rm9200, where I expected the differences to
be most visible.

First I enabled CONFIG_MULTI_IRQ_HANDLER and wrote the irq decoding
handler in plain C. This increases the irq latency of 1.2us (measured
with the average irq latency on an idle system).

I rewrote this irq decoding handler in assembly, using the macros in
entry-macro.S. This decreases the irq latency of 600ns.

Then I try the trick at the beginning of this thread, and... could not
measure any difference, so, you were right.

Anyway, given that on at91rm9200 worst case irq latencies are in the
80us range, all these optimizations are pointless.

-- 
                                                                Gilles.
