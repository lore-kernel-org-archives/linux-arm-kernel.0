From: tom.cooksey@arm.com (Tom Cooksey)
Date: Fri, 9 Aug 2013 18:31:34 +0100
Subject: [RFC 1/1] drm/pl111: Initial drm/kms driver for pl111
In-Reply-To: <20130809165706.GC31670@phenom.ffwll.local>
References: <1374772648-19151-1-git-send-email-tom.cooksey@arm.com>
 <1374772648-19151-2-git-send-email-tom.cooksey@arm.com>
 <CAF6AEGvGG1-4k-3_YHQ2ES6JEb-V-Xuicc8gfw9rPWze5JUEDg@mail.gmail.com>
 <20130807164651.GY22035@phenom.ffwll.local>
 <520515b0.88b70e0a.3ecd.1004SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAF6AEGu68ntQDSueQJmAM1KSsSA86j98GDEf8wOPbZKjECw99Q@mail.gmail.com>
 <20130809165706.GC31670@phenom.ffwll.local>
Message-ID: <000701ce9526$4bb43440$e31c9cc0$@cooksey@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > So in the above, after X receives the second DRI2SwapBuffers, it
> > > doesn't need to get scheduled again for the next frame to be both
> > > rendered by the GPU and issued to the display for scanout.
> >
> > well, this is really only an issue if you are so loaded that you
> > don't get a chance to schedule for ~16ms.. which is pretty long time.

Yes - it really is 16ms (minus interrupt/workqueue latency) isn't it?
Hmmm, that does sound very long. Will try out some experiments and see.


> > If you are triple buffering, it should not end up in the critical 
> > path (since the gpu already has the 3rd buffer to start on the next
> > frame). And, well, if you do it all in the kernel you probably need
> > to toss things over to a workqueue anyways.
> 
> Just a quick comment on the kernel flip queue issue.
> 
> 16 ms scheduling latency sounds awful but totally doable with a less
> than stellar ddx driver going into limbo land and so preventing your
> single threaded X from doing more useful stuff. Is this really the 
> linux scheduler being stupid?

Ahahhaaa!! Yes!!! Really good point. We generally don't have 2D HW and
so rely on pixman to perform all 2D operations which does indeed tie
up that thread for fairly long periods of time.

We've had internal discussions about introducing a thread (gulp) in
the DDX to off-load drawing operations to. I think we were all a bit
scared by that idea though.


BTW: I wasn't suggesting it was the linux scheduler being stupid, just
that there is sometimes lots of contention over the CPU cores and X
is just one thread among many wanting to run.


> At least my impression was that the hw/kernel flip queue is to save
> power so that you can queue up a few frames and everything goes to
> sleep for half a second or so (at 24fps or whatever movie your
> showing). Needing to schedule 5 frames ahead with pageflips under
> load is just guaranteed to result in really horrible interactivity
> and so awful user experience

Agreed. There's always a tradeoff between tolerance to variable frame
rendering time/system latency (lot of buffers) and UI latency (few
buffers). 

As a side note, video playback is one use-case for explicit sync
objects which implicit/buffer-based sync doesn't handle: Queue up lots
of video frames for display, but mark those "display buffer" 
operations as depending on explicit sync objects which get signalled 
by the audio clock. Not sure Android actually does that yet though. 
Anyway, off topic.


Cheers,

Tom
