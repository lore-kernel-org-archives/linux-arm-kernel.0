From: judith.baumgarten@tu-cottbus.de (Judith Baumgarten)
Date: Mon, 31 Aug 2009 18:30:42 +0200
Subject: How to work out the cause of a DMA Bus Error (QCI PXA320)?
In-Reply-To: <87iqg7ixcp.fsf@free.fr>
References: <20090827182308.19411cv37br99zvw@webmail.tu-cottbus.de>
	<Pine.LNX.4.64.0908272347140.4808@axis700.grange>
	<87iqg7ixcp.fsf@free.fr>
Message-ID: <20090831183042.26357169rn4rl5ma@webmail.tu-cottbus.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Zitat von Robert Jarzmik <robert.jarzmik@free.fr>:

> Guennadi Liakhovetski <g.liakhovetski@gmx.de> writes:
>
>> On Thu, 27 Aug 2009, Judith Baumgarten wrote:
>>
>>> Hi,
>>>
>>> I'm still working on the pxa_camera driver for PXA320.
>>
>> Is this a new driver or an extension to pxa270?
> Good question :)
It's an extension to the existing one (kernel 2.6.28.7).

>>> At the moment I can
>>> capture some frames (RAW mode), but then I get a DMA Bus Error.  
>>> Has anyone an
>>> idea how to deal with that error or work out the specific cause?
>>> The manual says, that if an error occures the channel is stopped until it's
>>> reprogrammed and the corresponding RUN bit is set, but there are  
>>> no RUN bits
>>> in QCI DMA. So I don't see a chance to start it again...
>>
>> I think we also had some DMA issues on pxa270, but we fixed them latest
>> with these patches:
>>
>> "V4L/DVB (11322): pxa_camera: Fix overrun condition on last buffer"
>> "V4L/DVB (11321): pxa_camera: Redesign DMA handling"
>>
>> if you're writing a new driver, have a look t pxa270 and at those patches
>> specifically.
>
I implemented the most important things of that patches and it seems  
to solve some of the errors (The error occurs later).

> You know, that little beast of PXA320 has a _dedicated_ 4-channel  
> DMA controller
> (with dedicated registers CIDADR, CIDSADR, ...). Maybe the rules we followed
> for pxa270 are not all true anymore.
Yes I know. The rules are almost the same, except that I can't say,  
stop DMA at the end of the sglist with that DDADR_STOP bit.
>
> I would suggest to Judith to scan with care PXA3xx manual, volume  
> III, chapter
> 3.4.5. To help debugging, you could add sysfs entries for CI* registers in
> 3.5.28.
Could you explain how to create these entries in sysfs? They could be  
really helpfull, because it seems, that it's a timing problem. If I  
insert two or three printks it works for over 30 minutes (I stopped it  
then).

> Ah, and you're right, there is no "RUN" bit in CICMDx. I suspect, after a 30s
> reading of the specification, that reloading CIDADR with a correct value will
> trigger the DMA transfer (QCI DMA FIFO threshold -> DMA request line  
> assert ->
> DMA transfer).
Yes you are right. It starts again, if I load a new Descriptor but I  
always get fifo overruns then. I will try to implement the overflow  
handling of chapter 3.4.5.3 exactly. At the moment I didn't use the  
CICR0_DIS...

Thanks
Judith

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
