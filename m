From: mikebrady@eircom.net (Mike Brady)
Date: Sun, 28 Oct 2018 14:26:12 +0000
Subject: [alsa-devel] [PATCH v2] staging: bcm2835-audio: interpolate audio
 delay
In-Reply-To: <s5hftwuo4t0.wl-tiwai@suse.de>
References: <20181022191708.GA4659@ubuntu>
 <a703f8a2-e85a-bc5b-750a-cc43ef252ba5@gmail.com>
 <EA85FEC9-B1C7-4548-88F5-F0E7BC12158E@eircom.net>
 <046aea96-e0d3-60f4-c61a-c26bb1b5c193@gmail.com>
 <B9A84822-3780-4E01-96AD-FD3B42C44B45@eircom.net>
 <9884c4f5-2343-e3a4-8d8b-dd2db404ef27@gmail.com>
 <s5hftwuo4t0.wl-tiwai@suse.de>
Message-ID: <126FA055-050B-4AAC-9392-CA8CCA821768@eircom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On 25 Oct 2018, at 08:37, Takashi Iwai <tiwai@suse.de> wrote:
> 
> On Thu, 25 Oct 2018 00:02:34 +0200,
> Kirill Marinushkin wrote:
>> 
>>>> When you play sound - the pointer increments.
>>> 
>>> Unfortunately, when you play sound, the pointer does not actually increment, for up to about 10 milliseconds. I know of no way to actually access the true ?live? position of the frame that is being played at any instant; hence the desire to estimate it.
>>> 
>> 
>> Your vision of situation in the opposite from my vision. What you see as a
>> symptom - I see as a root cause. As I see, you should fix the
>> pointer-not-incrementing. Why do you think that it's okay that the pointer is
>> not updating during sound play? Why do you insist that there is a delay? I don't
>> understand why we are so stuck here.
> 
> Well, in the API POV, it's nothing wrong to keep hwptr sticking while
> updating only delay value.  It implies that the hardware chip doesn't
> provide the hwptr update.
> 
> Though, usually the delay value is provided also from the hardware,
> e.g. reading the link position or such.  It's a typical case like
> USB-audio, where the hwptr gets updated and the delay indicates the
> actual position *behind* hwptr.  That works because hwptr shows the
> position in the ring buffer at which you can access the data.  And it
> doesn't mean that hwptr is the actually playing position, but it can
> be ahead of the current position, when many samples are queued on
> FIFO.  The delay is provided to correct the position back to the
> actual point.
> 
> But, this also doesn't mean that the delay shouldn't be used for the
> purpose like this patchset, either.  OTOH, providing a finer hwptr
> value would be likely more apps-friendly; there must be many programs
> that don't evaluate the delay value properly.
> 
> So, I suppose that hwptr update might be a better option if the code
> won't become too complex.  Let's see.

Indeed. It will take me a few days to look into this?

Regards
Mike

> One another thing I'd like to point out is that the value given in the
> patch is nothing but an estimated position, optimistically calculated
> via the system timer.  Mike and I had already discussion in another
> thread, and another possible option would be to provide the proper
> timestamp-vs-hwptr pair, instead of updating the timestamp always at
> the status read.
> 
> Maybe it's worth to have a module option to suppress this optimistic
> hwptr update behavior, in case something went wrong with clocks?
> 
> 
> thanks,
> 
> Takashi
