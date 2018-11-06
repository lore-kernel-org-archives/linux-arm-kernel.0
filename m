From: mikebrady@eircom.net (Mike Brady)
Date: Tue, 6 Nov 2018 21:05:11 +0000
Subject: [alsa-devel] [PATCH v2] staging: bcm2835-audio: interpolate audio
 delay
In-Reply-To: <s5hsh0f1p30.wl-tiwai@suse.de>
References: <20181022191708.GA4659@ubuntu>
 <a703f8a2-e85a-bc5b-750a-cc43ef252ba5@gmail.com>
 <EA85FEC9-B1C7-4548-88F5-F0E7BC12158E@eircom.net>
 <046aea96-e0d3-60f4-c61a-c26bb1b5c193@gmail.com>
 <B9A84822-3780-4E01-96AD-FD3B42C44B45@eircom.net>
 <9884c4f5-2343-e3a4-8d8b-dd2db404ef27@gmail.com>
 <s5hftwuo4t0.wl-tiwai@suse.de>
 <126FA055-050B-4AAC-9392-CA8CCA821768@eircom.net>
 <C35AD288-063F-4197-A758-450CBB3B1184@eircom.net>
 <s5hsh0f1p30.wl-tiwai@suse.de>
Message-ID: <6AF69E32-029E-478F-9BFA-6262316364A9@eircom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 5 Nov 2018, at 16:11, Takashi Iwai <tiwai@suse.de> wrote:
> 
> On Mon, 05 Nov 2018 16:57:07 +0100,
> Mike Brady wrote:
>> 
>>> One another thing I'd like to point out is that the value given in the
>>> patch is nothing but an estimated position, optimistically calculated
>>> via the system timer.  Mike and I had already discussion in another
>>> thread, and another possible option would be to provide the proper
>>> timestamp-vs-hwptr pair, instead of updating the timestamp always at
>>> the status read.
>> 
>> Agreed ? that would give the caller the information needed to do the
>> interpolation for themselves if desired.
> 
> And now I wonder whether the problem is still present with the latest
> code.  There was a (kind of) regression in this regard when we
> introduced the fine-grained hardware timestamping, but it should have
> been addressed by the commit 20e3f985bb875fea4f86b04eba4b6cc29bfd6b71
>    ALSA: pcm: update tstamp only if audio_tstamp changed
> 
> Could you double-check whether the tstamp field gets still updated
> even if no hwptr (and delay) is changed?

Yes, this could be a bit problematic. The function update_audio_tstamp in pcm_lib.c could include the interpolated delay in the calculation of audio_tstamp, and hence
could trigger the update of tstamp.

Another issue, as I see it, is that the the audio_tstamp value would depend on whether, and when, a snd_pcm_delay() call (which recalculates the interpolation and puts it into the delay field) was made immediately prior to it. By zeroing the delay when a GPU interrupt occurs, you could be certain that the interpolated delay would be less than or equal to the true delay, but this doesn?t seem very satisfactory ? you have neither the timestamp of the last update nor the correctly interpolated timestamp. 

Sadly, therefore, I?m now of the view that this approach to interpolating the delay between GPU interrupts is not really viable. Would that be your view?

Regards
Mike

> thanks,
> 
> Takashi
