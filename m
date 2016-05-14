From: tiwai@suse.de (Takashi Iwai)
Date: Sat, 14 May 2016 17:13:42 +0200
Subject: [RFC PATCH 2/7] ALSA: ac97: add an ac97 bus
In-Reply-To: <87twi1hssl.fsf@belgarion.home>
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
 <1462050939-27940-3-git-send-email-robert.jarzmik@free.fr>
 <s5hk2j38tmf.wl-tiwai@suse.de> <87twi1hssl.fsf@belgarion.home>
Message-ID: <s5hy47c7jvd.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 14 May 2016 11:50:50 +0200,
Robert Jarzmik wrote:
> >> +unsigned int ac97_bus_scan_one(struct ac97_controller *ac97,
> >> +				      int codec_num)
> >> +{
> >> +	struct ac97_codec_device codec;
> >> +	unsigned short vid1, vid2;
> >> +	int ret;
> >> +
> >> +	codec.dev = *ac97->dev;
> >> +	codec.num = codec_num;
> >> +	ret = ac97->ops->read(&codec, AC97_VENDOR_ID1);
> >> +	vid1 = (ret & 0xffff);
> >> +	if (ret < 0)
> >> +		return 0;
> >
> > Hmm.  This looks pretty hackish and dangerous.
> You mean returning 0 even if the read failed, right ?

No, my concern is that it's creating a dummy codec object temporarily
on the stack just by copying some fields and calling the ops with it.
(And actually the current code may work wrongly because lack of
 zero-clear of the object.)

IMO, a cleaner way would be to define the ops passed with both
controller and codec objects as arguments, and pass NULL codec here.


Takashi
