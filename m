From: k.marinushkin@gmail.com (Kirill Marinushkin)
Date: Thu, 25 Oct 2018 00:02:34 +0200
Subject: [alsa-devel] [PATCH v2] staging: bcm2835-audio: interpolate audio
 delay
In-Reply-To: <B9A84822-3780-4E01-96AD-FD3B42C44B45@eircom.net>
References: <20181022191708.GA4659@ubuntu>
 <a703f8a2-e85a-bc5b-750a-cc43ef252ba5@gmail.com>
 <EA85FEC9-B1C7-4548-88F5-F0E7BC12158E@eircom.net>
 <046aea96-e0d3-60f4-c61a-c26bb1b5c193@gmail.com>
 <B9A84822-3780-4E01-96AD-FD3B42C44B45@eircom.net>
Message-ID: <9884c4f5-2343-e3a4-8d8b-dd2db404ef27@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mike,

We are not on the same page. What you hear is not what I tell you.
Either you don't understand what happens in your commit, or I don't understand
what happens in the driver.

Hopefully somebody in the community can comment here.

On 10/24/18 21:54, Mike Brady wrote:
>>>> You modify the function, which is called `snd_bcm2835_pcm_pointer`. Here you are
>>>> supposed to increase `alsa_stream->pos` with the proper offset. Instead, you
>>>> imitate a delay, but in fact the delay is not increased.
>>>>
>>>> So, the proper solution should be to fix the reported pointer.
>>>
>>> I think there is a difficulty with this. The ?pos? pointer looks to have to be modulo the buffer size. This causes a problem, as I see it, in that if the calculated (pos + interpolated delay in bytes) is longer than the buffer size
>>
>>
>> There is no "interpolated delay". The concept of "interpolated delay" is
>> incorrect.
> 
> Yes, my language here is wrong. What I mean is the estimated number of frames output since the pointer was last updated ? let?s call it the `interpolated frame count`.
> 

That's not what I mean. From my perspective, the problem is not in language, but
in the concept which you introduce here.

>> When you play sound - the pointer increments.
> 
> Unfortunately, when you play sound, the pointer does not actually increment, for up to about 10 milliseconds. I know of no way to actually access the true ?live? position of the frame that is being played at any instant; hence the desire to estimate it.
> 

Your vision of situation in the opposite from my vision. What you see as a
symptom - I see as a root cause. As I see, you should fix the
pointer-not-incrementing. Why do you think that it's okay that the pointer is
not updating during sound play? Why do you insist that there is a delay? I don't
understand why we are so stuck here.

> What actually seems to be happening is that when `bcm2835_playback_fifo` is called, the pointer is updated, but as frames are individually output to the DAC, this pointer does not increment. It is not updated until the next time `bcm2835_playback_fifo` is called.
> 
>> But in this commit you increment the delay, as if sound doesn't play.
> 
> It is true that the patch does make use of the  snd_pcm_runtime structure?s ?delay" field (aka "runtime->delay? here). That field is defined for: ?/* extra delay; typically FIFO size */?. Clearly it is not being used for that here ? it is being used simply because it is part of the calculation done in snd_pcm_calc_delay(), as you point out. At present, it looks like that field isn?t being used ?? it?s set to zero ?? and not modified anywhere else in the driver, AFAICS. If it was necessary, it would be a simple matter to preserve whatever value it was given.
> 

That's not what I am talking about. Somehow we don't understand each other.

>>>> As a result,
>>>> userspace will recieve the correct delay, instead of these crazy 10 ms.
>>>
>>> Just to point out that with the proposed patch, it appears that the correct delay is being reported, (apart, possibly, from any delay originally set in the snd_pcm_delay field, as mentioned above).
>>
>>
>> Then I would like to point out the alsa-lib function `snd_pcm_avail()` - it will return the wrong value.
> 
> It is already the case that snd_pcm_avail() does not return the true delay. The ALSA documentation states: "The value returned by that call [i.e. the snd_pcm_avail*() functions] is not directly related to the delay?? 
> 

Do you mean, that you are submitting the patch into the upstream kernel without
reading the code?

snd_pcm_avail() is calculated based on:

* hw_ptr
* buffer_size
* appl_ptr
* boundary

If you fix hw_ptr - it will fix both snd_pcm_delay() and snd_pcm_avail().
Instead, you invent the "interpolated delay", which in fact only compensates the
wrong hw_ptr instead of fixing it.

Best Regards,
Kirill
