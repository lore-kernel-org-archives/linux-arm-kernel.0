From: mikebrady@eircom.net (Mike Brady)
Date: Mon, 5 Nov 2018 15:57:07 +0000
Subject: [alsa-devel] [PATCH v2] staging: bcm2835-audio: interpolate audio
 delay
In-Reply-To: <126FA055-050B-4AAC-9392-CA8CCA821768@eircom.net>
References: <20181022191708.GA4659@ubuntu>
 <a703f8a2-e85a-bc5b-750a-cc43ef252ba5@gmail.com>
 <EA85FEC9-B1C7-4548-88F5-F0E7BC12158E@eircom.net>
 <046aea96-e0d3-60f4-c61a-c26bb1b5c193@gmail.com>
 <B9A84822-3780-4E01-96AD-FD3B42C44B45@eircom.net>
 <9884c4f5-2343-e3a4-8d8b-dd2db404ef27@gmail.com>
 <s5hftwuo4t0.wl-tiwai@suse.de>
 <126FA055-050B-4AAC-9392-CA8CCA821768@eircom.net>
Message-ID: <C35AD288-063F-4197-A758-450CBB3B1184@eircom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the comments and suggestions.

> On 25 Oct 2018, at 08:37, Takashi Iwai <tiwai@suse.de> wrote:
> 
> Well, in the API POV, it's nothing wrong to keep hwptr sticking while
> updating only delay value.  It implies that the hardware chip doesn't
> provide the hwptr update.

As I understand it, this driver stages settings, data and status information for the true audio driver which is part of VideoCore (VC). The driver communicates with the VC by sending messages. Responses come back in asynchronous callbacks. There doesn?t seem to be any other source of data or status.

When parameters such as frame format, rate and period size have been set up, the VC executes periodic callbacks to retrieve period-sized buffers of data. At 44,100 frames per second and with standard 444-frame periods, callbacks occur approximately every 10.07 milliseconds.

> Though, usually the delay value is provided also from the hardware,
> e.g. reading the link position or such.  It's a typical case like
> USB-audio, where the hwptr gets updated and the delay indicates the
> actual position *behind* hwptr.  That works because hwptr shows the
> position in the ring buffer at which you can access the data.  And it
> doesn't mean that hwptr is the actually playing position, but it can
> be ahead of the current position, when many samples are queued on
> FIFO.  The delay is provided to correct the position back to the
> actual point.

 The information that the alsa snd_pcm_delay() function depends on is updated during these callbacks. Thus, a user program monitoring the snc_pcm_delay() value closely will see sudden jumps in the value every 10 milliseconds or so ? a 10 millisecond jitter. 
> 
> But, this also doesn't mean that the delay shouldn't be used for the
> purpose like this patchset, either.  OTOH, providing a finer hwptr
> value would be likely more apps-friendly; there must be many programs
> that don't evaluate the delay value properly.

With interpolation, the number of frames that would have been output from the time of the last callback is subtracted from the delay to give a more accurate estimate of the actual delay at the time it is requested.

> So, I suppose that hwptr update might be a better option if the code
> won't become too complex.  Let's see.

Having looked at the code, there does not seem to be a good way to avoid interpolation. Later versions of the interface include a message type of VC_AUDIO_MSG_TYPE_LATENCY (see https://github.com/raspberrypi/firmware/blob/master/opt/vc/include/interface/vmcs_host/vc_vchi_audioserv_defs.h#L158) which seems to be a request to return the latency. However, the latency would be returned in an asynchronous callback (see function audio_vchi_callback in bcm2835-vchiq.c). One can wait for the result, but it seems that it could take up to 10 milliseconds (see function bcm2835_audio_send_msg_locked in bcm2835-vchiq.c). This is hardly tolerable, and to avoid it, one would have to store both the latency returned and the time the request was sent (or the time the reply was returned ? it?s not clear which would be correct) and interpolate from that to the time the delay is requested. In other words, from the point of view of avoiding interpolation, this is likely to be no better than the present suggestion. There wold also be a need to make the latency request periodically, adding to the overhead.

Without getting a good deal more information about the VC, which may not be available, I?m afraid I can?t see a way of getting a better fix on the instantaneous values of pointers such as the hw_ptr. BTW, I have not been able to find a source for the file vc_vchi_audioserv_defs.h, which looks like a Broadcom file and which appears to have two  versions. If anyone could point me to the source, I?d be grateful.

> One another thing I'd like to point out is that the value given in the
> patch is nothing but an estimated position, optimistically calculated
> via the system timer.  Mike and I had already discussion in another
> thread, and another possible option would be to provide the proper
> timestamp-vs-hwptr pair, instead of updating the timestamp always at
> the status read.

Agreed ? that would give the caller the information needed to do the interpolation for themselves if desired.

> Maybe it's worth to have a module option to suppress this optimistic
> hwptr update behavior, in case something went wrong with clocks?

Following this suggestion, I have updated the patch to include a module parameter ?enable_delay_interpolation?, and I will post that later for consideration.

Regards
Mike


> thanks,
> 
> Takashi

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel at alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
