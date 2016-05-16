From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 16 May 2016 10:53:56 +0200
Subject: [RFC PATCH 2/7] ALSA: ac97: add an ac97 bus
In-Reply-To: <s5hoa867e6v.wl-tiwai@suse.de> (Takashi Iwai's message of "Mon,
 16 May 2016 07:40:56 +0200")
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
 <1462050939-27940-3-git-send-email-robert.jarzmik@free.fr>
 <s5hk2j38tmf.wl-tiwai@suse.de> <87twi1hssl.fsf@belgarion.home>
 <s5hy47c7jvd.wl-tiwai@suse.de> <87mvnrhux4.fsf@belgarion.home>
 <s5hoa867e6v.wl-tiwai@suse.de>
Message-ID: <87inyeidsr.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Takashi Iwai <tiwai@suse.de> writes:

> On Sun, 15 May 2016 23:29:27 +0200,
> Robert Jarzmik wrote:
>> 
>> Takashi Iwai <tiwai@suse.de> writes:
>> 
>> > On Sat, 14 May 2016 11:50:50 +0200,
>> >
>> > No, my concern is that it's creating a dummy codec object temporarily
>> > on the stack just by copying some fields and calling the ops with it.
>> > (And actually the current code may work wrongly because lack of
>> >  zero-clear of the object.)
>> Ah yes, I remember now, the on-stack generated device, indeed ugly.
>> 
>> > IMO, a cleaner way would be to define the ops passed with both
>> > controller and codec objects as arguments, and pass NULL codec here.
>> It's rather unusual to need both the device and its controller in bus
>> operations. I must admit I have no better idea so far, so I'll try that just to
>> see how it looks like, and let's see next ...
>
> Thinking of this again, I wonder now why we need to pass the codec
> object at all.  It's the read/write ops via ac97, so we just need the
> ac97_controller object and the address slot of the accessed codec?
So far it would work. The only objection I would see is if in the future the bus
operation needs a specialization which is ac97 codec dependent, such as a flag
or a mask in ac97_codec_device structure.

Even if I'd like to not have these in bus operations, the struct snd_ac97 had a
need for a 'caps', 'ext_id', ... fields for example. Yet these could be
contained in the ac97_codec_device structure and not exposed to bus operations.

Another worry is the pattern (as an example) in atmel_ac97c_write() in
sound/atmel/ac97.c, where the codec structure is used to get the controller
through a container_of() type call. Yet passing the controller to bus operations
takes care of this one.

>From a "purely API" point of view the couple (ac97_controller, ac97_slot_id) is
what will route an ac97 bus operation, be that a read/write/reset/..., the
remaining question is will it cover the cases we've not thought of ?

Cheers.

-- 
Robert
