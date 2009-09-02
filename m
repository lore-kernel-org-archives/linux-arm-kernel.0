From: judith.baumgarten@tu-cottbus.de (Judith Baumgarten)
Date: Wed, 02 Sep 2009 19:04:25 +0200
Subject: How to work out the cause of a DMA Bus Error (QCI PXA320)?
In-Reply-To: <87r5uq7aa0.fsf@free.fr>
References: <20090827182308.19411cv37br99zvw@webmail.tu-cottbus.de>
	<Pine.LNX.4.64.0908272347140.4808@axis700.grange>
	<87iqg7ixcp.fsf@free.fr>
	<20090831183042.26357169rn4rl5ma@webmail.tu-cottbus.de>
	<87r5uq7aa0.fsf@free.fr>
Message-ID: <20090902190425.15125hddangb9ml5@webmail.tu-cottbus.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Zitat von Robert Jarzmik <robert.jarzmik@free.fr>:

>>> "V4L/DVB (11322): pxa_camera: Fix overrun condition on last buffer"
>>> "V4L/DVB (11321): pxa_camera: Redesign DMA handling"
>>>
>>> if you're writing a new driver, have a look t pxa270 and at those patches
>>> specifically.
>>>
>> I implemented the most important things of that patches and it  
>> seems  to solve
>> some of the errors (The error occurs later).
> Good. Guennadi won't be mad I broke the design :)
>
> May I suggest an old and dirty trick I used to debug the DMA on  
> pxa27x. I tried
> the smallest size of picture, and multiple of 16 in bytes. I think  
> it was 48x32
> pixels of RGB565 (ie. 48 * 32 * 2 bytes).
>
> As you can see, that size fits in one transfer (assuming it begins on a page
> start).
>
> Now you try that transfer, and if a BUSERR occurs, you freeze the  
> DMA, (comment
> out the DMA restarting). You check the DMA registers, find the  
> culprit, and all
> is good.
Ok, it still seems to be some kind of link_missed problem. I didn't  
find the culprit yet but the CICMD being 0 is an indicator I think. At  
the moment DMA and FIFOs are resetted and it works so far. But I could  
also load a new buffer.
The error occurs (mostly) when there are other hardware interrupts, so  
there is still some timing problem.

>> Could you explain how to create these entries in sysfs? They could  
>> be  really
>> helpfull, because it seems, that it's a timing problem. If I  insert two or
>> three printks it works for over 30 minutes (I stopped it  then).
>
> I could provide you this :
> http://git.kernel.org/?p=linux/kernel/git/ycmiao/pxa-linux-2.6.git;a=commitdiff;h=f957c87757a2e2dcf825ed66d5489f9848cf8d75;hp=4ed0ec58fbcc76925d22854fa5050c2748ae3270
>
> This is a bit egocentric, but I think that's the kind of stuff you're looking
> for. And if you work on in, I hope you'll expand that patch so add  
> the specific
> pxa3xx registers.
Due to the fact that this patch is for the system dma controller, that  
the pxa3xx doesn't use, I will have to integrate it to pxa_camera  
driver. Do you have an idea how to access the pcdev->lock out of such  
a function?

> Seems a timing issue ... maybe the time the descriptor is loaded, the fifo is
> overrun.
>
> I seem to remember a discussion with Guennadi about DMA startup. Guennadi
> thought it would be better to prepare DMA before QCI interrupt  
> signaling the end
> of frame (and the near to come beginning of the next one), I thought  
> DMA should
> be dealt with after the interrupt. Maybe you'll prove me wrong, who knows ...
I can only speak for pxa320, but at the moment it never minds. EOF and  
EOFX bits are always set at the same time so DMA can be prepared  
immediately after  the previous buffer was marked as done. But there  
seems to be still a bug in synchronisation of DMA and capturing,  
because the first (round about) 50 pixels are transferred to the last  
buffer, so that the image shifted left.

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
