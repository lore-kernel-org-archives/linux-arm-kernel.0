From: tom.cooksey@arm.com (Tom Cooksey)
Date: Wed, 14 Aug 2013 15:59:57 +0100
Subject: [RFC 1/1] drm/pl111: Initial drm/kms driver for pl111
In-Reply-To: <CAF6AEGvOLwon=8jJGY6oTZ_E8+bH9RC1kHrbb+XuBCyEXEDO2Q@mail.gmail.com>
References: <1374772648-19151-1-git-send-email-tom.cooksey@arm.com>	<1374772648-19151-2-git-send-email-tom.cooksey@arm.com>	<CAF6AEGvGG1-4k-3_YHQ2ES6JEb-V-Xuicc8gfw9rPWze5JUEDg@mail.gmail.com>	<20130807164651.GY22035@phenom.ffwll.local>	<520515b0.88b70e0a.3ecd.1004SMTPIN_ADDED_BROKEN@mx.google.com>	<CAF6AEGu68ntQDSueQJmAM1KSsSA86j98GDEf8wOPbZKjECw99Q@mail.gmail.com>	<20130809165706.GC31670@phenom.ffwll.local>	<520a4435.070a0e0a.4fce.ffff9731SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAF6AEGvOLwon=8jJGY6oTZ_E8+bH9RC1kHrbb+XuBCyEXEDO2Q@mail.gmail.com>
Message-ID: <000901ce98fe$f1a2b350$d4e819f0$@cooksey@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> > > > So in the above, after X receives the second DRI2SwapBuffers,
> >> > > > it doesn't need to get scheduled again for the next frame to 
> >> > > > be both rendered by the GPU and issued to the display for 
> >> > > > scanout.
> >> > > 
> >> > > well, this is really only an issue if you are so loaded that you
> >> > > don't get a chance to schedule for ~16ms.. which is pretty long
> >> > > time.
> >>
> >> Yes - it really is 16ms (minus interrupt/workqueue latency) isn't
> >> it? Hmmm, that does sound very long. Will try out some experiments 
> >> and see.
> >
> > We're looking at moving the flip queue into the DDX driver, however
> > it's not as straight-forward as I thought. With the current design,
> > all rate-limiting happens on the client side. So even if you only
> 
> > have double buffering, using KDS you can queue up as many 
> > asynchronous GPU-render/scan-out pairs as you want. It's up to EGL 
> > in the client application to figure out there's a lot of frames in-
> > flight and so should probably block the application's render thread 
> > in eglSwapBuffers to let the GPU and/or display catch up a bit.
> >
> > If we only allow a single outstanding page-flip job in DRM, there'd
> 
> > be a race if we returned a buffer to the client which had an 
> > outstanding page-flip queued up in the DDX: The client could issue 
> 
> > a render job to the buffer just as the DDX processed the page-flip 
> > from the queue, making the scan-out block until the GPU rendered 
> > the next frame. It would also mean the previous frame would have 
> > been lost as it never got scanned out before the GPU rendered the 
> > next-next frame to it.
>
> You wouldn't unconditionally send the swap-done event to the client
> when the queue is "full".  (Well, for omap and msm, the queue depth is
> 1, for triple buffer.. I think usually you don't want to do more than
> triple buffer.)  The client would never get a buffer that wasn't
> already done being scanned out, so there shouldn't be a race.
> 
> Basically, in DDX, when you get a ScheduleSwap, there are two cases:
> 1) you are still waiting for previous page-flip event from kernel, in
> which case you queue the swap and don't immediately send the event
> back to the client.  When the previous page flip completes, you
> schedule the new one and then send back the event to the client.
> 2) you are not waiting for a previous page-flip, in which case you
> schedule the new page-flip and send the event to the client.
> 
> (I hope that is clear.. I suppose maybe a picture here would help, 
> but sadly I don't have anything handy)

So your solution depends on the client-side EGL using page flip events
to figure out when to block the application thread when CPU is running
ahead of the GPU/display. We (currently) use the number of uncompleted
frames sent to the GPU to block the application thread. So there is a
race if we move the flip queue into the DDX and did nothing else.
However, I'm not proposing we do nothing else. :-)

Our proposal was to instead use waiting on the reply of the
DRI2GetBuffers request to block the application thread when the client
is submitting frames faster than the display can display them.
I've not really looked into using the DRI2BufferSwapComplete in our
EGL implementation - it always felt like we'd be at risk of the
application somehow stealing the event and causing us to dead-lock.
But - that may well be a completely irrational fear. :-) Anyway, I'll
take a look, thanks for the pointer!


Cheers,

Tom
