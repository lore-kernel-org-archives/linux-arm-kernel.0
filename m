From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 28 Aug 2009 20:53:26 +0200
Subject: How to work out the cause of a DMA Bus Error (QCI PXA320)?
In-Reply-To: <Pine.LNX.4.64.0908272347140.4808@axis700.grange> (Guennadi
	Liakhovetski's message of "Thu\,
	27 Aug 2009 23\:53\:56 +0200 \(CEST\)")
References: <20090827182308.19411cv37br99zvw@webmail.tu-cottbus.de>
	<Pine.LNX.4.64.0908272347140.4808@axis700.grange>
Message-ID: <87iqg7ixcp.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guennadi Liakhovetski <g.liakhovetski@gmx.de> writes:

> On Thu, 27 Aug 2009, Judith Baumgarten wrote:
>
>> Hi,
>> 
>> I'm still working on the pxa_camera driver for PXA320.
>
> Is this a new driver or an extension to pxa270?
Good question :)

>> At the moment I can
>> capture some frames (RAW mode), but then I get a DMA Bus Error. Has anyone an
>> idea how to deal with that error or work out the specific cause?
>> The manual says, that if an error occures the channel is stopped until it's
>> reprogrammed and the corresponding RUN bit is set, but there are no RUN bits
>> in QCI DMA. So I don't see a chance to start it again...
>
> I think we also had some DMA issues on pxa270, but we fixed them latest 
> with these patches:
>
> "V4L/DVB (11322): pxa_camera: Fix overrun condition on last buffer"
> "V4L/DVB (11321): pxa_camera: Redesign DMA handling"
>
> if you're writing a new driver, have a look t pxa270 and at those patches 
> specifically.

You know, that little beast of PXA320 has a _dedicated_ 4-channel DMA controller
(with dedicated registers CIDADR, CIDSADR, ...). Maybe the rules we followed
for pxa270 are not all true anymore.

I would suggest to Judith to scan with care PXA3xx manual, volume III, chapter
3.4.5. To help debugging, you could add sysfs entries for CI* registers in
3.5.28.

Ah, and you're right, there is no "RUN" bit in CICMDx. I suspect, after a 30s
reading of the specification, that reloading CIDADR with a correct value will
trigger the DMA transfer (QCI DMA FIFO threshold -> DMA request line assert ->
DMA transfer).

Cheers.

--
Robert
