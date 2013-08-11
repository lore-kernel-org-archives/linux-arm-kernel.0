From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 11 Aug 2013 22:05:04 +0200
Subject: [PATCH 00/20] ARM: pxa: move core and drivers to dmaengine
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
 <87zjsqzdg8.fsf@free.fr> <52061C53.4050905@gmail.com>
Message-ID: <874nawyowf.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack <zonque@gmail.com> writes:
> Hi Robert,

We might reduce the thread broadcast, I don't think these many people care about
pxa camera specifics, and its DMA constraints.


>> All that is described in there :
>>   Documentation/video4linux/pxa_camera.txt
>
> Yes, I've seen that, and while the documentation about all that is
> excellent, I lack an explanation why things are so complicated for this
> application, and why a simple cyclic DMA approach does not suffice here.
> I'm sure there's a reason though.
Well, I think there is a good one.
The current video4linux flow, for video capture, is :
 1) userland prepares buffers (ie. dma transfers are prepared, one sg list for
 each "image" or "frame")
 2) userland queues buffers (no hardware operation)
 3) userland starts the capture
 4) userland poll for each frame end
   a) When a frame is finished, userland unqueues it
      => no overwrite of this frame is possible anymore
   b) Userland treats is (might be sent to storage, or compressed, ...)
   c) Userland requeues it (while other frame is being DMAed)

Moreover, it should be assumed that waiting for a "end of DMA transfer" before
requeuing the next one (ie. "cold queuing" instead of "hot queueing") will imply
the miss of the next frame start, and one frame will be missed.

With a cyclic DMA, if I understand dmaengine correctly, step 4a. is not
posssible (ie. if userland is slow enough, the frame will be overwritten without
userland knowing it, and while userland is handling it).

> There might be need to teach the dmaengine core more functionality, but
> in order to do that, we first need to understand the exact requirements.
The first one that comes to my mind is :
 - enable to submit a transfer to a running channel, the same one that served a
 previous transfer :
   => this will guarantee ordering of DMA transfers
   => this will guarantee no DMA stops if 2 or more buffers are queued
   => this will try to chain this transfer to the last one queued on the channel
   => if by bad luck the "miss window is hit", ie. the DMA finishes while the
   chaining was being done, restart the DMA on its stop

>> Another point I'd like to know, is what is the performance penalty in using
>> dmaengine, and do you have any figures ?
> The DMA transfers themselves certainly perform equally well, and the
> framework is just a thin layer. Where would you expect performance penalty?

Well, last time I had a look (in [1]), I think I remember having a 3% penalty
on SD card transfers (pxamci driver, mioa701 board, transcend 16Go SD card). 

It's been a while and my memory is a bit fuzzy about it. The loss I had at the
time was in queuing/unqueuing the DMA requests IIRC.

>> Lastly, they was debug information to debug descriptors chaining, channel
>> statuses, requestors. I didn't see where these had gone, could you point me to
>> the right file ?
>
> Such a debug interface is not part of the mmp-pdma implementation at
> this point, and the core doesn't have a generic debugfs feature either.
> If you need that, we'd have to add it back.
Well, I use that. It's not vital for DMA to work of course, but it's very nice
to have when you mess with DMA transfers :)

> FWIW, I attached my work-in-progress patch for this driver which just
> does some basic dmaengine preparations. Be aware that this does not even
> compile, it's really just a snapshot.
OK, cool. Once the dmaengine stuff is clearer in my mind, and if "hot
submitting" is already possible in dmaengine, it shouldn't be that hard to
convert.

Cheers.

-- 
Robert

[1]
http://archive.arm.linux.org.uk/lurker/message/20090517.194809.b18c79c8.en.html
