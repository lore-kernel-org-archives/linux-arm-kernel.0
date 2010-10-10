From: san.mlists@gmail.com (Santhosh N)
Date: Sun, 10 Oct 2010 19:55:19 +0530
Subject: PXA270 audio problem
In-Reply-To: <201009241335.38801.marek.vasut@gmail.com>
References: <AANLkTi=_AANevVpthOKuRfkkvU9mKMWsmpHc+XohoUwg@mail.gmail.com>
	<AANLkTimRPZijUXcecbBSexuthttJ76-NYVbs0cc3iyZm@mail.gmail.com>
	<AANLkTikerg6JUt8Kv5M9N1UbHaQE6seeiSYdSVOoNghb@mail.gmail.com>
	<201009241335.38801.marek.vasut@gmail.com>
Message-ID: <AANLkTinUQhiC2JCvmrcN4QLPFdVzypuqO_w2ZswLV7+h@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The problem persists in the linux kernel 2.6.35.7 as well. If I
repeatedly play a set of mp3 files continuously the audio stops after
some time with the following error:
ALSA sound/core/pcm_native.c:1512: playback drain error i(DMA or IRQ trouble?)
The DMA interrupts stop occuring. But the DMA interrupts does occur
for audio record in this state and the touch screen works.

One thing I have noticed is if I remove and insert back the
snd_pxa2xx_ac97 module, audio playback starts again. But the touch
screen stops working from there on. I need to reboot the machine.

I tried exploring the DMA operation for audio playback. I noticed that
on reaching the no audio playback state the REQPEND bit of DCSR
register stops getting set after the DDADR is loaded with the address.
I have attached the files having dumps at various stages of audio
playback. The change in DMA register settings can be noticed in the
line having "START DMA->".

I am now exploring the AC97 communication part. Some times I doubt if
it is a bug in the processor. But still no proper justification yet.

Warm regards,
Santhosh N

On Fri, Sep 24, 2010 at 5:05 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Dne ?t 23. z??? 2010 09:24:51 Santhosh N napsal(a):
>> Hi,
>>
>> Following is the way I reach the no audio playback state.
>>
>> I have put a loop in a shell script and play a short mp3 file
>> repeatedly. The no audio playback state is reached sometimes very
>> quickly and sometimes after a while.
>
> Can you try more up-to-date kernel ? There were many changes in ucb1400 driver
> happening
>>
>> Regards,
>> Santhosh N
>>
>> On Thu, Sep 23, 2010 at 12:35 PM, Santhosh N <san.mlists@gmail.com> wrote:
>> > Hi,
>> >
>> > Following are the AC97 and DMA register dumps. I am printing out the
>> > DMA registers from the pxa2xx_pcm_trigger function.
>> >
>> > I have noticed that, the touchscreen and audio record continues to
>> > work after the problem. In the problem state, the DMA interrupts occur
>> > for audio record but not for playback.
>> >
>> > AC97:
>> > BeforeProblem ? ? ? ? ? ? ? ? ? AfterProblem
>> > 0:00 = 02a0 ? ? ? ? ? ? ? ? ? ? 0:00 = 02a0
>> > 0:02 = 0d0d ? ? ? ? ? ? ? ? ? ? 0:02 = 0d0d
>> > 0:04 = 0000 ? ? ? ? ? ? ? ? ? ? 0:04 = 0000
>> > 0:06 = 0000 ? ? ? ? ? ? ? ? ? ? 0:06 = 0000
>> > 0:08 = 0000 ? ? ? ? ? ? ? ? ? ? 0:08 = 0000
>> > 0:0a = 0000 ? ? ? ? ? ? ? ? ? ? 0:0a = 0000
>> > 0:0c = 0000 ? ? ? ? ? ? ? ? ? ? 0:0c = 0000
>> > 0:0e = 0000 ? ? ? ? ? ? ? ? ? ? 0:0e = 0000
>> > 0:10 = 0000 ? ? ? ? ? ? ? ? ? ? 0:10 = 0000
>> > 0:12 = 0000 ? ? ? ? ? ? ? ? ? ? 0:12 = 0000
>> > 0:14 = 0000 ? ? ? ? ? ? ? ? ? ? 0:14 = 0000
>> > 0:16 = 0000 ? ? ? ? ? ? ? ? ? ? 0:16 = 0000
>> > 0:18 = 0000 ? ? ? ? ? ? ? ? ? ? 0:18 = 0000
>> > 0:1a = 0000 ? ? ? ? ? ? ? ? ? ? 0:1a = 0000
>> > 0:1c = 0000 ? ? ? ? ? ? ? ? ? ? 0:1c = 0000
>> > 0:1e = 0000 ? ? ? ? ? ? ? ? ? ? 0:1e = 0000
>> > 0:20 = 0000 ? ? ? ? ? ? ? ? ? ? 0:20 = 0000
>> > 0:22 = 0000 ? ? ? ? ? ? ? ? ? ? 0:22 = 0000
>> > 0:24 = 0000 ? ? ? ? ? ? ? ? ? ? 0:24 = 0000
>> > 0:26 = 000b ? ? ? ? ? ? ? ? ? ? 0:26 = 000b
>> > 0:28 = 0001 ? ? ? ? ? ? ? ? ? ? 0:28 = 0001
>> > 0:2a = 0001 ? ? ? ? ? ? ? ? ? ? 0:2a = 0001
>> > 0:2c = 5622 ? ? ? ? ? ? ? ? ? ? 0:2c = 3e80
>> > 0:2e = 0000 ? ? ? ? ? ? ? ? ? ? 0:2e = 0000
>> > 0:30 = 0000 ? ? ? ? ? ? ? ? ? ? 0:30 = 0000
>> > 0:32 = bb80 ? ? ? ? ? ? ? ? ? ? 0:32 = bb80
>> > 0:34 = 0000 ? ? ? ? ? ? ? ? ? ? 0:34 = 0000
>> > 0:36 = 0000 ? ? ? ? ? ? ? ? ? ? 0:36 = 0000
>> > 0:38 = 0000 ? ? ? ? ? ? ? ? ? ? 0:38 = 0000
>> > 0:3a = 0000 ? ? ? ? ? ? ? ? ? ? 0:3a = 0000
>> > 0:3c = 0000 ? ? ? ? ? ? ? ? ? ? 0:3c = 0000
>> > 0:3e = 0000 ? ? ? ? ? ? ? ? ? ? 0:3e = 0000
>> > 0:40 = 0000 ? ? ? ? ? ? ? ? ? ? 0:40 = 0000
>> > 0:42 = 0000 ? ? ? ? ? ? ? ? ? ? 0:42 = 0000
>> > 0:44 = 0000 ? ? ? ? ? ? ? ? ? ? 0:44 = 0000
>> > 0:46 = 0000 ? ? ? ? ? ? ? ? ? ? 0:46 = 0000
>> > 0:48 = 0000 ? ? ? ? ? ? ? ? ? ? 0:48 = 0000
>> > 0:4a = 0000 ? ? ? ? ? ? ? ? ? ? 0:4a = 0000
>> > 0:4c = 0000 ? ? ? ? ? ? ? ? ? ? 0:4c = 0000
>> > 0:4e = 0000 ? ? ? ? ? ? ? ? ? ? 0:4e = 0000
>> > 0:50 = 0000 ? ? ? ? ? ? ? ? ? ? 0:50 = 0000
>> > 0:52 = 0000 ? ? ? ? ? ? ? ? ? ? 0:52 = 0000
>> > 0:54 = 0000 ? ? ? ? ? ? ? ? ? ? 0:54 = 0000
>> > 0:56 = 0000 ? ? ? ? ? ? ? ? ? ? 0:56 = 0000
>> > 0:58 = 0000 ? ? ? ? ? ? ? ? ? ? 0:58 = 0000
>> > 0:5a = 0000 ? ? ? ? ? ? ? ? ? ? 0:5a = 0000
>> > 0:5c = 0000 ? ? ? ? ? ? ? ? ? ? 0:5c = 0000
>> > 0:5e = 0000 ? ? ? ? ? ? ? ? ? ? 0:5e = 0000
>> > 0:60 = 0000 ? ? ? ? ? ? ? ? ? ? 0:60 = 0000
>> > 0:62 = 0000 ? ? ? ? ? ? ? ? ? ? 0:62 = 0000
>> > 0:64 = 0948 ? ? ? ? ? ? ? ? ? ? 0:64 = 0948
>> > 0:66 = 0000 ? ? ? ? ? ? ? ? ? ? 0:66 = 0000
>> > 0:68 = 824b ? ? ? ? ? ? ? ? ? ? 0:68 = 824b
>> > 0:6a = 0050 ? ? ? ? ? ? ? ? ? ? 0:6a = 0050
>> > 0:6c = 0030 ? ? ? ? ? ? ? ? ? ? 0:6c = 0030
>> > 0:6e = 2004 ? ? ? ? ? ? ? ? ? ? 0:6e = 2004
>> > 0:70 = 0000 ? ? ? ? ? ? ? ? ? ? 0:70 = 0000
>> > 0:72 = 0000 ? ? ? ? ? ? ? ? ? ? 0:72 = 0000
>> > 0:74 = 0000 ? ? ? ? ? ? ? ? ? ? 0:74 = 0000
>> > 0:76 = 0000 ? ? ? ? ? ? ? ? ? ? 0:76 = 0000
>> > 0:78 = 0000 ? ? ? ? ? ? ? ? ? ? 0:78 = 0000
>> > 0:7a = 0000 ? ? ? ? ? ? ? ? ? ? 0:7a = 0000
>> > 0:7c = 5053 ? ? ? ? ? ? ? ? ? ? 0:7c = 5053
>> > 0:7e = 4304 ? ? ? ? ? ? ? ? ? ? 0:7e = 4304
>> >
>> > Only diff in the above is in the 02C(Audio sample rate control) register.
>> >
>> > DMA:
>> > BeforeProblem
>> >
>> > ::: DMA Channel: 8, Trigger Start
>> >
>> > DDADR = 0xB714A010
>> > DSADR = 0xB7100040
>> > DTADR = 0x40500040
>> > DCMD ?= 0x9023CFC0
>> > DCSR ?= 0x80000000
>> >
>> > ::: DMA Channel: 8, Trigger Stop
>> >
>> > DDADR = 0xB714A0E0
>> > DSADR = 0xB710D000
>> > DTADR = 0x40500040
>> > DCMD ?= 0x9023D000
>> > DCSR ?= 0x00000008
>> >
>> >
>> > AfterProblem
>> >
>> > ::: DMA Channel: 8, Trigger Start
>> >
>> > DDADR = 0xB70B7010
>> > DSADR = 0xB7100000
>> > DTADR = 0x40500040
>> > DCMD ?= 0x9023D000
>> > DCSR ?= 0x80000000
>> > ALSA sound/core/pcm_native.c:1512: playback drain error (DMA or IRQ
>> > trouble?)
>> >
>> > ::: DMA Channel: 8, Trigger Stop
>> >
>> > DDADR = 0xB70B7010
>> > DSADR = 0xB7100000
>> > DTADR = 0x40500040
>> > DCMD ?= 0x9023D000
>> > DCSR ?= 0x00000008
>> >
>> > Each dump above is after playing a mp3 file using madplay.
>> >
>> > Regards,
>> > Santhosh N
>> >
>> > On Thu, Sep 23, 2010 at 11:38 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
>> >> On Thu, Sep 23, 2010 at 1:33 PM, Santhosh N <san.mlists@gmail.com> wrote:
>> >>> Dear All,
>> >>>
>> >>> I am running linux 2.6.26 kernel on a PXA270 board. A UCB1400 chip
>> >>> used for audio and touchscreen in that. I have been facing a problem
>> >>> with audio.
>> >>>
>> >>> The audio plays properly, but suddenly stops. I get the following
>> >>> message: ALSA sound/core/pcm_native.c:1513: playback drain error (DMA
>> >>> or IRQ trouble?)
>> >>>
>> >>> I have noticed that the DMA interrupts stop coming. Where as the AC97
>> >>> interrupts come properly.
>> >>>
>> >>> Any help in solving this will be grateful.
>> >>
>> >> Dumping the DMA registers and the AC97 controller registers would
>> >> be helpful.
>> >>
>> >>> Regards,
>> >>> Santhosh N
>> >>>
>> >>> _______________________________________________
>> >>> linux-arm-kernel mailing list
>> >>> linux-arm-kernel at lists.infradead.org
>> >>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
-------------- next part --------------
[18326.464323] Audio amplifier ... Powering on
[18326.465174] :::: pxa2xx_pcm_hw_params
[18326.465261] ::: 0 -> ddadr=B7175010 dsadr=B7140000 dtadr=40500040 dcmd=9023D000
[18326.465301] ::: 1 -> ddadr=B7175020 dsadr=B7141000 dtadr=40500040 dcmd=9023D000
[18326.465339] ::: 2 -> ddadr=B7175030 dsadr=B7142000 dtadr=40500040 dcmd=9023D000
[18326.465377] ::: 3 -> ddadr=B7175040 dsadr=B7143000 dtadr=40500040 dcmd=9023D000
[18326.465415] ::: 4 -> ddadr=B7175050 dsadr=B7144000 dtadr=40500040 dcmd=9023D000
[18326.465452] ::: 5 -> ddadr=B7175060 dsadr=B7145000 dtadr=40500040 dcmd=9023D000
[18326.465490] ::: 6 -> ddadr=B7175070 dsadr=B7146000 dtadr=40500040 dcmd=9023D000
[18326.465528] ::: 7 -> ddadr=B7175080 dsadr=B7147000 dtadr=40500040 dcmd=9023D000
[18326.465566] ::: 8 -> ddadr=B7175090 dsadr=B7148000 dtadr=40500040 dcmd=9023D000
[18326.465604] ::: 9 -> ddadr=B71750A0 dsadr=B7149000 dtadr=40500040 dcmd=9023D000
[18326.465641] ::: 10 -> ddadr=B71750B0 dsadr=B714A000 dtadr=40500040 dcmd=9023D000
[18326.465679] ::: 11 -> ddadr=B71750C0 dsadr=B714B000 dtadr=40500040 dcmd=9023D000
[18326.465717] ::: 12 -> ddadr=B71750D0 dsadr=B714C000 dtadr=40500040 dcmd=9023D000
[18326.465756] ::: 13 -> ddadr=B71750E0 dsadr=B714D000 dtadr=40500040 dcmd=9023D000
[18326.465794] ::: 14 -> ddadr=B71750F0 dsadr=B714E000 dtadr=40500040 dcmd=9023D000
[18326.465832] ::: 15 -> ddadr=B7175100 dsadr=B714F000 dtadr=40500040 dcmd=9023D000
[18326.465870] ::: 16 -> ddadr=B7175110 dsadr=B7150000 dtadr=40500040 dcmd=9023D000
[18326.465908] ::: 17 -> ddadr=B7175120 dsadr=B7151000 dtadr=40500040 dcmd=9023D000
[18326.465946] ::: 18 -> ddadr=B7175130 dsadr=B7152000 dtadr=40500040 dcmd=9023D000
[18326.465984] ::: 19 -> ddadr=B7175140 dsadr=B7153000 dtadr=40500040 dcmd=9023D000
[18326.466022] ::: 20 -> ddadr=B7175150 dsadr=B7154000 dtadr=40500040 dcmd=9023D000
[18326.466060] ::: 21 -> ddadr=B7175160 dsadr=B7155000 dtadr=40500040 dcmd=9023D000
[18326.466098] ::: 22 -> ddadr=B7175170 dsadr=B7156000 dtadr=40500040 dcmd=9023D000
[18326.466136] ::: 23 -> ddadr=B7175180 dsadr=B7157000 dtadr=40500040 dcmd=9023D000
[18326.466174] ::: 24 -> ddadr=B7175190 dsadr=B7158000 dtadr=40500040 dcmd=9023D000
[18326.466212] ::: 25 -> ddadr=B71751A0 dsadr=B7159000 dtadr=40500040 dcmd=9023D000
[18326.466250] ::: 26 -> ddadr=B71751B0 dsadr=B715A000 dtadr=40500040 dcmd=9023D000
[18326.466289] ::: 27 -> ddadr=B71751C0 dsadr=B715B000 dtadr=40500040 dcmd=9023D000
[18326.466327] ::: 28 -> ddadr=B71751D0 dsadr=B715C000 dtadr=40500040 dcmd=9023D000
[18326.466365] ::: 29 -> ddadr=B71751E0 dsadr=B715D000 dtadr=40500040 dcmd=9023D000
[18326.466403] ::: 30 -> ddadr=B71751F0 dsadr=B715E000 dtadr=40500040 dcmd=9023D000
[18326.466441] ::: 31 -> ddadr=B7175200 dsadr=B715F000 dtadr=40500040 dcmd=9023D000
[18326.466479] ::: 31 -> ddadr=B7175000 dsadr=B715F000 dtadr=40500040 dcmd=9023D000
[18326.466511] :::::::: b7175000 Total Descs: 31
[18326.485633] :::: pxa2xx_pcm_prepare
[18326.485730] :::: pxa2xx_ac97_pcm_prepare
[18326.485812] :::: pxa2xx_ac97_irq
[18326.485944] :::: pxa2xx_ac97_irq
[18326.486260] :::: pxa2xx_ac97_irq
[18326.487611] :::: pxa2xx_pcm_hw_params
[18326.487714] ::: 0 -> ddadr=B7175010 dsadr=B7140000 dtadr=40500040 dcmd=9023D000
[18326.487752] ::: 1 -> ddadr=B7175020 dsadr=B7141000 dtadr=40500040 dcmd=9023D000
[18326.487790] ::: 2 -> ddadr=B7175030 dsadr=B7142000 dtadr=40500040 dcmd=9023D000
[18326.487828] ::: 3 -> ddadr=B7175040 dsadr=B7143000 dtadr=40500040 dcmd=9023D000
[18326.487865] ::: 4 -> ddadr=B7175050 dsadr=B7144000 dtadr=40500040 dcmd=9023D000
[18326.487903] ::: 5 -> ddadr=B7175060 dsadr=B7145000 dtadr=40500040 dcmd=9023D000
[18326.487941] ::: 6 -> ddadr=B7175070 dsadr=B7146000 dtadr=40500040 dcmd=9023D000
[18326.487979] ::: 7 -> ddadr=B7175080 dsadr=B7147000 dtadr=40500040 dcmd=9023D000
[18326.488016] ::: 8 -> ddadr=B7175090 dsadr=B7148000 dtadr=40500040 dcmd=9023D000
[18326.488054] ::: 9 -> ddadr=B71750A0 dsadr=B7149000 dtadr=40500040 dcmd=9023D000
[18326.488092] ::: 10 -> ddadr=B71750B0 dsadr=B714A000 dtadr=40500040 dcmd=9023D000
[18326.488130] ::: 11 -> ddadr=B71750C0 dsadr=B714B000 dtadr=40500040 dcmd=9023D000
[18326.488168] ::: 12 -> ddadr=B71750D0 dsadr=B714C000 dtadr=40500040 dcmd=9023D000
[18326.488207] ::: 13 -> ddadr=B71750E0 dsadr=B714D000 dtadr=40500040 dcmd=9023D000
[18326.488244] ::: 14 -> ddadr=B71750F0 dsadr=B714E000 dtadr=40500040 dcmd=9023D000
[18326.488282] ::: 15 -> ddadr=B7175100 dsadr=B714F000 dtadr=40500040 dcmd=9023D000
[18326.488321] ::: 16 -> ddadr=B7175110 dsadr=B7150000 dtadr=40500040 dcmd=9023D000
[18326.488359] ::: 17 -> ddadr=B7175120 dsadr=B7151000 dtadr=40500040 dcmd=9023D000
[18326.488396] ::: 18 -> ddadr=B7175130 dsadr=B7152000 dtadr=40500040 dcmd=9023D000
[18326.488435] ::: 19 -> ddadr=B7175140 dsadr=B7153000 dtadr=40500040 dcmd=9023D000
[18326.488473] ::: 20 -> ddadr=B7175150 dsadr=B7154000 dtadr=40500040 dcmd=9023D000
[18326.488511] ::: 21 -> ddadr=B7175160 dsadr=B7155000 dtadr=40500040 dcmd=9023D000
[18326.488549] ::: 22 -> ddadr=B7175170 dsadr=B7156000 dtadr=40500040 dcmd=9023D000
[18326.488587] ::: 23 -> ddadr=B7175180 dsadr=B7157000 dtadr=40500040 dcmd=9023D000
[18326.488625] ::: 24 -> ddadr=B7175190 dsadr=B7158000 dtadr=40500040 dcmd=9023D000
[18326.488663] ::: 25 -> ddadr=B71751A0 dsadr=B7159000 dtadr=40500040 dcmd=9023D000
[18326.488701] ::: 26 -> ddadr=B71751B0 dsadr=B715A000 dtadr=40500040 dcmd=9023D000
[18326.488740] ::: 27 -> ddadr=B71751C0 dsadr=B715B000 dtadr=40500040 dcmd=9023D000
[18326.488777] ::: 28 -> ddadr=B71751D0 dsadr=B715C000 dtadr=40500040 dcmd=9023D000
[18326.488816] ::: 29 -> ddadr=B71751E0 dsadr=B715D000 dtadr=40500040 dcmd=9023D000
[18326.488854] ::: 30 -> ddadr=B71751F0 dsadr=B715E000 dtadr=40500040 dcmd=9023D000
[18326.488892] ::: 31 -> ddadr=B7175200 dsadr=B715F000 dtadr=40500040 dcmd=9023D000
[18326.488930] ::: 31 -> ddadr=B7175000 dsadr=B715F000 dtadr=40500040 dcmd=9023D000
[18326.488963] :::::::: b7175000 Total Descs: 31
[18326.490958] :::: pxa2xx_pcm_prepare
[18326.491054] :::: pxa2xx_ac97_pcm_prepare
[18326.491188] :::: pxa2xx_ac97_irq
[18326.491594] :::: pxa2xx_ac97_irq
[18326.492739] :::: pxa2xx_ac97_irq
[18326.493721] :::: pxa2xx_pcm_trigger 1
[18326.493756] ::: START DMA->  DDADR=B7175010 DCSR=80000100 DRCMR12=00000088
[18326.494214] :::: pxa2xx_pcm_pointer
[18326.494237] ::::: Aud mem(dsadr) = B7140060 Done = 24
[18326.494683] :::: pxa2xx_pcm_pointer
[18326.494705] ::::: Aud mem(dsadr) = B7140080 Done = 32
[18326.495147] :::: pxa2xx_pcm_pointer
[18326.495169] ::::: Aud mem(dsadr) = B71400C0 Done = 48
[18326.496497] :::: pxa2xx_pcm_pointer
[18326.496591] ::::: Aud mem(dsadr) = B7140140 Done = 80
[18326.497096] :::: pxa2xx_pcm_pointer
[18326.497118] ::::: Aud mem(dsadr) = B7140160 Done = 88
[18326.497560] :::: pxa2xx_pcm_pointer
[18326.497582] ::::: Aud mem(dsadr) = B7140180 Done = 96
[18326.498024] :::: pxa2xx_pcm_pointer
[18326.498046] ::::: Aud mem(dsadr) = B71401C0 Done = 112
[18326.499343] :::: pxa2xx_pcm_pointer
[18326.499438] ::::: Aud mem(dsadr) = B7140220 Done = 136
[18326.499944] :::: pxa2xx_pcm_pointer
[18326.499966] ::::: Aud mem(dsadr) = B7140260 Done = 152
[18326.500409] :::: pxa2xx_pcm_pointer
[18326.500431] ::::: Aud mem(dsadr) = B7140280 Done = 160
[18326.500874] :::: pxa2xx_pcm_pointer
[18326.500895] ::::: Aud mem(dsadr) = B71402A0 Done = 168
[18326.503096] :::: pxa2xx_pcm_pointer
[18326.503196] ::::: Aud mem(dsadr) = B7140380 Done = 224
[18326.503740] :::: pxa2xx_pcm_pointer
[18326.503762] ::::: Aud mem(dsadr) = B71403A0 Done = 232
[18326.504204] :::: pxa2xx_pcm_pointer
[18326.504226] ::::: Aud mem(dsadr) = B71403E0 Done = 248
[18326.504667] :::: pxa2xx_pcm_pointer
[18326.504689] ::::: Aud mem(dsadr) = B7140400 Done = 256
[18326.506005] :::: pxa2xx_pcm_pointer
[18326.506099] ::::: Aud mem(dsadr) = B7140480 Done = 288
[18326.506605] :::: pxa2xx_pcm_pointer
[18326.506627] ::::: Aud mem(dsadr) = B71404A0 Done = 296
[18326.507069] :::: pxa2xx_pcm_pointer
[18326.507091] ::::: Aud mem(dsadr) = B71404E0 Done = 312
[18326.507532] :::: pxa2xx_pcm_pointer
[18326.507554] ::::: Aud mem(dsadr) = B7140500 Done = 320
[18326.508844] :::: pxa2xx_pcm_pointer
[18326.508939] ::::: Aud mem(dsadr) = B7140580 Done = 352
[18326.509441] :::: pxa2xx_pcm_pointer
[18326.509463] ::::: Aud mem(dsadr) = B71405A0 Done = 360
[18326.509905] :::: pxa2xx_pcm_pointer
[18326.509927] ::::: Aud mem(dsadr) = B71405C0 Done = 368
[18326.510370] :::: pxa2xx_pcm_pointer
[18326.510392] ::::: Aud mem(dsadr) = B7140600 Done = 384
[18326.511787] :::: pxa2xx_pcm_pointer
[18326.511884] ::::: Aud mem(dsadr) = B7140680 Done = 416
[18326.539421] :::: pxa2xx_pcm_dma_irq
[18326.539522] :::: pxa2xx_pcm_pointer
[18326.539554] ::::: Aud mem(dsadr) = B7141000 Done = 1024
[18326.585856] :::: pxa2xx_pcm_dma_irq
[18326.585958] :::: pxa2xx_pcm_pointer
[18326.585990] ::::: Aud mem(dsadr) = B7142000 Done = 2048
[18326.632289] :::: pxa2xx_pcm_dma_irq
[18326.632388] :::: pxa2xx_pcm_pointer
[18326.632421] ::::: Aud mem(dsadr) = B7143000 Done = 3072
[18326.678747] :::: pxa2xx_pcm_dma_irq
[18326.678848] :::: pxa2xx_pcm_pointer
[18326.678879] ::::: Aud mem(dsadr) = B7144000 Done = 4096
[18326.725181] :::: pxa2xx_pcm_dma_irq
[18326.725283] :::: pxa2xx_pcm_pointer
[18326.725315] ::::: Aud mem(dsadr) = B7145000 Done = 5120
[18326.771615] :::: pxa2xx_pcm_dma_irq
[18326.771716] :::: pxa2xx_pcm_pointer
[18326.771748] ::::: Aud mem(dsadr) = B7146000 Done = 6144
[18326.818050] :::: pxa2xx_pcm_dma_irq
[18326.818152] :::: pxa2xx_pcm_pointer
[18326.818184] ::::: Aud mem(dsadr) = B7147000 Done = 7168
[18326.864483] :::: pxa2xx_pcm_dma_irq
[18326.864585] :::: pxa2xx_pcm_pointer
[18326.864617] ::::: Aud mem(dsadr) = B7148000 Done = 8192
[18326.910919] :::: pxa2xx_pcm_dma_irq
[18326.911019] :::: pxa2xx_pcm_pointer
[18326.911051] ::::: Aud mem(dsadr) = B7149000 Done = 9216
[18326.957351] :::: pxa2xx_pcm_dma_irq
[18326.957454] :::: pxa2xx_pcm_pointer
[18326.957486] ::::: Aud mem(dsadr) = B714A000 Done = 10240
[18327.003787] :::: pxa2xx_pcm_dma_irq
[18327.003883] :::: pxa2xx_pcm_pointer
[18327.003915] ::::: Aud mem(dsadr) = B714B000 Done = 11264
[18327.050241] :::: pxa2xx_pcm_dma_irq
[18327.050339] :::: pxa2xx_pcm_pointer
[18327.050370] ::::: Aud mem(dsadr) = B714C000 Done = 12288
[18327.096675] :::: pxa2xx_pcm_dma_irq
[18327.096771] :::: pxa2xx_pcm_pointer
[18327.096803] ::::: Aud mem(dsadr) = B714D000 Done = 13312
[18327.143110] :::: pxa2xx_pcm_dma_irq
[18327.143212] :::: pxa2xx_pcm_pointer
[18327.143244] ::::: Aud mem(dsadr) = B714E000 Done = 14336
[18327.189554] :::: pxa2xx_pcm_dma_irq
[18327.189652] :::: pxa2xx_pcm_pointer
[18327.189686] ::::: Aud mem(dsadr) = B714F000 Done = 15360
[18327.235980] :::: pxa2xx_pcm_dma_irq
[18327.236082] :::: pxa2xx_pcm_pointer
[18327.236114] ::::: Aud mem(dsadr) = B7150000 Done = 16384
[18327.282417] :::: pxa2xx_pcm_dma_irq
[18327.282519] :::: pxa2xx_pcm_pointer
[18327.282551] ::::: Aud mem(dsadr) = B7151000 Done = 17408
[18327.328848] :::: pxa2xx_pcm_dma_irq
[18327.328949] :::: pxa2xx_pcm_pointer
[18327.328982] ::::: Aud mem(dsadr) = B7152000 Done = 18432
[18327.375283] :::: pxa2xx_pcm_dma_irq
[18327.375385] :::: pxa2xx_pcm_pointer
[18327.375418] ::::: Aud mem(dsadr) = B7153000 Done = 19456
[18327.421717] :::: pxa2xx_pcm_dma_irq
[18327.421818] :::: pxa2xx_pcm_pointer
[18327.421851] ::::: Aud mem(dsadr) = B7154000 Done = 20480
[18327.468174] :::: pxa2xx_pcm_dma_irq
[18327.468276] :::: pxa2xx_pcm_pointer
[18327.468307] ::::: Aud mem(dsadr) = B7155000 Done = 21504
[18327.514606] :::: pxa2xx_pcm_dma_irq
[18327.514709] :::: pxa2xx_pcm_pointer
[18327.514741] ::::: Aud mem(dsadr) = B7156000 Done = 22528
[18327.561042] :::: pxa2xx_pcm_dma_irq
[18327.561143] :::: pxa2xx_pcm_pointer
[18327.561175] ::::: Aud mem(dsadr) = B7157000 Done = 23552
[18327.607475] :::: pxa2xx_pcm_dma_irq
[18327.607576] :::: pxa2xx_pcm_pointer
[18327.607608] ::::: Aud mem(dsadr) = B7158000 Done = 24576
[18327.653910] :::: pxa2xx_pcm_dma_irq
[18327.654012] :::: pxa2xx_pcm_pointer
[18327.654044] ::::: Aud mem(dsadr) = B7159000 Done = 25600
[18327.654106] :::: pxa2xx_pcm_trigger 0
[18327.656835] :::: pxa2xx_pcm_prepare
[18327.656929] :::: pxa2xx_ac97_pcm_prepare
[18327.657055] :::: pxa2xx_ac97_irq
[18327.657195] :::: pxa2xx_ac97_irq
[18327.657329] :::: pxa2xx_pcm_hw_free
[18327.657351] :::: pxa2xx_pcm_close
[18327.657374] :::: pxa2xx_ac97_pcm_shutdown
[18327.657393] Audio amplifier ... Powering Off
-------------- next part --------------
[22725.656695] Audio amplifier ... Powering on
[22725.657530] :::: pxa2xx_pcm_hw_params
[22725.657614] ::: 0 -> ddadr=B71DF010 dsadr=B7140000 dtadr=40500040 dcmd=9023D000
[22725.657656] ::: 1 -> ddadr=B71DF020 dsadr=B7141000 dtadr=40500040 dcmd=9023D000
[22725.657696] ::: 2 -> ddadr=B71DF030 dsadr=B7142000 dtadr=40500040 dcmd=9023D000
[22725.657733] ::: 3 -> ddadr=B71DF040 dsadr=B7143000 dtadr=40500040 dcmd=9023D000
[22725.657771] ::: 4 -> ddadr=B71DF050 dsadr=B7144000 dtadr=40500040 dcmd=9023D000
[22725.657809] ::: 5 -> ddadr=B71DF060 dsadr=B7145000 dtadr=40500040 dcmd=9023D000
[22725.657847] ::: 6 -> ddadr=B71DF070 dsadr=B7146000 dtadr=40500040 dcmd=9023D000
[22725.657885] ::: 7 -> ddadr=B71DF080 dsadr=B7147000 dtadr=40500040 dcmd=9023D000
[22725.657923] ::: 8 -> ddadr=B71DF090 dsadr=B7148000 dtadr=40500040 dcmd=9023D000
[22725.657961] ::: 9 -> ddadr=B71DF0A0 dsadr=B7149000 dtadr=40500040 dcmd=9023D000
[22725.657998] ::: 10 -> ddadr=B71DF0B0 dsadr=B714A000 dtadr=40500040 dcmd=9023D000
[22725.658037] ::: 11 -> ddadr=B71DF0C0 dsadr=B714B000 dtadr=40500040 dcmd=9023D000
[22725.658075] ::: 12 -> ddadr=B71DF0D0 dsadr=B714C000 dtadr=40500040 dcmd=9023D000
[22725.658112] ::: 13 -> ddadr=B71DF0E0 dsadr=B714D000 dtadr=40500040 dcmd=9023D000
[22725.658150] ::: 14 -> ddadr=B71DF0F0 dsadr=B714E000 dtadr=40500040 dcmd=9023D000
[22725.658189] ::: 15 -> ddadr=B71DF100 dsadr=B714F000 dtadr=40500040 dcmd=9023D000
[22725.658227] ::: 16 -> ddadr=B71DF110 dsadr=B7150000 dtadr=40500040 dcmd=9023D000
[22725.658265] ::: 17 -> ddadr=B71DF120 dsadr=B7151000 dtadr=40500040 dcmd=9023D000
[22725.658303] ::: 18 -> ddadr=B71DF130 dsadr=B7152000 dtadr=40500040 dcmd=9023D000
[22725.658341] ::: 19 -> ddadr=B71DF140 dsadr=B7153000 dtadr=40500040 dcmd=9023D000
[22725.658378] ::: 20 -> ddadr=B71DF150 dsadr=B7154000 dtadr=40500040 dcmd=9023D000
[22725.658417] ::: 21 -> ddadr=B71DF160 dsadr=B7155000 dtadr=40500040 dcmd=9023D000
[22725.658455] ::: 22 -> ddadr=B71DF170 dsadr=B7156000 dtadr=40500040 dcmd=9023D000
[22725.658493] ::: 23 -> ddadr=B71DF180 dsadr=B7157000 dtadr=40500040 dcmd=9023D000
[22725.658531] ::: 24 -> ddadr=B71DF190 dsadr=B7158000 dtadr=40500040 dcmd=9023D000
[22725.658569] ::: 25 -> ddadr=B71DF1A0 dsadr=B7159000 dtadr=40500040 dcmd=9023D000
[22725.658608] ::: 26 -> ddadr=B71DF1B0 dsadr=B715A000 dtadr=40500040 dcmd=9023D000
[22725.658645] ::: 27 -> ddadr=B71DF1C0 dsadr=B715B000 dtadr=40500040 dcmd=9023D000
[22725.658683] ::: 28 -> ddadr=B71DF1D0 dsadr=B715C000 dtadr=40500040 dcmd=9023D000
[22725.658722] ::: 29 -> ddadr=B71DF1E0 dsadr=B715D000 dtadr=40500040 dcmd=9023D000
[22725.658760] ::: 30 -> ddadr=B71DF1F0 dsadr=B715E000 dtadr=40500040 dcmd=9023D000
[22725.658798] ::: 31 -> ddadr=B71DF200 dsadr=B715F000 dtadr=40500040 dcmd=9023D000
[22725.658836] ::: 31 -> ddadr=B71DF000 dsadr=B715F000 dtadr=40500040 dcmd=9023D000
[22725.659645] :::::::: b71df000 Total Descs: 31
[22725.677877] :::: pxa2xx_pcm_prepare
[22725.677976] :::: pxa2xx_ac97_pcm_prepare
[22725.678049] :::: pxa2xx_ac97_irq
[22725.678180] :::: pxa2xx_ac97_irq
[22725.678501] :::: pxa2xx_ac97_irq
[22725.680553] :::: pxa2xx_pcm_hw_params
[22725.680656] ::: 0 -> ddadr=B71DF010 dsadr=B7140000 dtadr=40500040 dcmd=9023D000
[22725.680694] ::: 1 -> ddadr=B71DF020 dsadr=B7141000 dtadr=40500040 dcmd=9023D000
[22725.680732] ::: 2 -> ddadr=B71DF030 dsadr=B7142000 dtadr=40500040 dcmd=9023D000
[22725.680770] ::: 3 -> ddadr=B71DF040 dsadr=B7143000 dtadr=40500040 dcmd=9023D000
[22725.680808] ::: 4 -> ddadr=B71DF050 dsadr=B7144000 dtadr=40500040 dcmd=9023D000
[22725.680846] ::: 5 -> ddadr=B71DF060 dsadr=B7145000 dtadr=40500040 dcmd=9023D000
[22725.680884] ::: 6 -> ddadr=B71DF070 dsadr=B7146000 dtadr=40500040 dcmd=9023D000
[22725.680922] ::: 7 -> ddadr=B71DF080 dsadr=B7147000 dtadr=40500040 dcmd=9023D000
[22725.680960] ::: 8 -> ddadr=B71DF090 dsadr=B7148000 dtadr=40500040 dcmd=9023D000
[22725.680998] ::: 9 -> ddadr=B71DF0A0 dsadr=B7149000 dtadr=40500040 dcmd=9023D000
[22725.681036] ::: 10 -> ddadr=B71DF0B0 dsadr=B714A000 dtadr=40500040 dcmd=9023D000
[22725.681074] ::: 11 -> ddadr=B71DF0C0 dsadr=B714B000 dtadr=40500040 dcmd=9023D000
[22725.681112] ::: 12 -> ddadr=B71DF0D0 dsadr=B714C000 dtadr=40500040 dcmd=9023D000
[22725.681150] ::: 13 -> ddadr=B71DF0E0 dsadr=B714D000 dtadr=40500040 dcmd=9023D000
[22725.681188] ::: 14 -> ddadr=B71DF0F0 dsadr=B714E000 dtadr=40500040 dcmd=9023D000
[22725.681226] ::: 15 -> ddadr=B71DF100 dsadr=B714F000 dtadr=40500040 dcmd=9023D000
[22725.681264] ::: 16 -> ddadr=B71DF110 dsadr=B7150000 dtadr=40500040 dcmd=9023D000
[22725.681302] ::: 17 -> ddadr=B71DF120 dsadr=B7151000 dtadr=40500040 dcmd=9023D000
[22725.681340] ::: 18 -> ddadr=B71DF130 dsadr=B7152000 dtadr=40500040 dcmd=9023D000
[22725.681379] ::: 19 -> ddadr=B71DF140 dsadr=B7153000 dtadr=40500040 dcmd=9023D000
[22725.681416] ::: 20 -> ddadr=B71DF150 dsadr=B7154000 dtadr=40500040 dcmd=9023D000
[22725.681455] ::: 21 -> ddadr=B71DF160 dsadr=B7155000 dtadr=40500040 dcmd=9023D000
[22725.681493] ::: 22 -> ddadr=B71DF170 dsadr=B7156000 dtadr=40500040 dcmd=9023D000
[22725.681531] ::: 23 -> ddadr=B71DF180 dsadr=B7157000 dtadr=40500040 dcmd=9023D000
[22725.681569] ::: 24 -> ddadr=B71DF190 dsadr=B7158000 dtadr=40500040 dcmd=9023D000
[22725.681608] ::: 25 -> ddadr=B71DF1A0 dsadr=B7159000 dtadr=40500040 dcmd=9023D000
[22725.681646] ::: 26 -> ddadr=B71DF1B0 dsadr=B715A000 dtadr=40500040 dcmd=9023D000
[22725.681684] ::: 27 -> ddadr=B71DF1C0 dsadr=B715B000 dtadr=40500040 dcmd=9023D000
[22725.681722] ::: 28 -> ddadr=B71DF1D0 dsadr=B715C000 dtadr=40500040 dcmd=9023D000
[22725.681760] ::: 29 -> ddadr=B71DF1E0 dsadr=B715D000 dtadr=40500040 dcmd=9023D000
[22725.681797] ::: 30 -> ddadr=B71DF1F0 dsadr=B715E000 dtadr=40500040 dcmd=9023D000
[22725.681836] ::: 31 -> ddadr=B71DF200 dsadr=B715F000 dtadr=40500040 dcmd=9023D000
[22725.681874] ::: 31 -> ddadr=B71DF000 dsadr=B715F000 dtadr=40500040 dcmd=9023D000
[22725.681907] :::::::: b71df000 Total Descs: 31
[22725.683919] :::: pxa2xx_pcm_prepare
[22725.684015] :::: pxa2xx_ac97_pcm_prepare
[22725.684091] :::: pxa2xx_ac97_irq
[22725.684225] :::: pxa2xx_ac97_irq
[22725.684604] :::: pxa2xx_ac97_irq
[22725.685811] :::: pxa2xx_pcm_trigger 1
[22725.685894] ::: START DMA->  DDADR=B71DF010 DCSR=80000000 DRCMR12=00000088
[22725.686351] :::: pxa2xx_pcm_pointer
[22725.686374] ::::: Aud mem(dsadr) = B7140000 Done = 0
[22725.686824] :::: pxa2xx_pcm_pointer
[22725.686845] ::::: Aud mem(dsadr) = B7140000 Done = 0
[22725.687287] :::: pxa2xx_pcm_pointer
[22725.687308] ::::: Aud mem(dsadr) = B7140000 Done = 0
[22725.688664] :::: pxa2xx_pcm_pointer
[22725.688757] ::::: Aud mem(dsadr) = B7140000 Done = 0
[22725.690441] :::: pxa2xx_pcm_pointer
[22725.690537] ::::: Aud mem(dsadr) = B7140000 Done = 0
[22725.691027] :::: pxa2xx_pcm_pointer
[22725.691049] ::::: Aud mem(dsadr) = B7140000 Done = 0
[22725.691490] :::: pxa2xx_pcm_pointer
[22725.691511] ::::: Aud mem(dsadr) = B7140000 Done = 0
[22725.692811] :::: pxa2xx_pcm_pointer
[22725.692906] ::::: Aud mem(dsadr) = B7140000 Done = 0
[22725.693407] :::: pxa2xx_pcm_pointer
[22725.693429] ::::: Aud mem(dsadr) = B7140000 Done = 0
[22725.693871] :::: pxa2xx_pcm_pointer
[22725.693892] ::::: Aud mem(dsadr) = B7140000 Done = 0
[22725.694334] :::: pxa2xx_pcm_pointer
[22725.694356] ::::: Aud mem(dsadr) = B7140000 Done = 0
[22725.695650] :::: pxa2xx_pcm_pointer
[22725.695744] ::::: Aud mem(dsadr) = B7140000 Done = 0
[22725.696248] :::: pxa2xx_pcm_pointer
[22725.696270] ::::: Aud mem(dsadr) = B7140000 Done = 0
[22725.696712] :::: pxa2xx_pcm_pointer
[22725.696734] ::::: Aud mem(dsadr) = B7140000 Done = 0
[22725.697176] :::: pxa2xx_pcm_pointer
[22725.697197] ::::: Aud mem(dsadr) = B7140000 Done = 0
[22725.698491] :::: pxa2xx_pcm_pointer
[22725.698585] ::::: Aud mem(dsadr) = B7140000 Done = 0
[22725.700161] :::: pxa2xx_pcm_pointer
[22725.700258] ::::: Aud mem(dsadr) = B7140000 Done = 0
[22725.700808] :::: pxa2xx_pcm_pointer
[22725.700830] ::::: Aud mem(dsadr) = B7140000 Done = 0
[22725.701270] :::: pxa2xx_pcm_pointer
[22725.701292] ::::: Aud mem(dsadr) = B7140000 Done = 0
[22725.702608] :::: pxa2xx_pcm_pointer
[22725.702702] ::::: Aud mem(dsadr) = B7140000 Done = 0
[22725.703206] :::: pxa2xx_pcm_pointer
[22725.703227] ::::: Aud mem(dsadr) = B7140000 Done = 0
[22725.703669] :::: pxa2xx_pcm_pointer
[22725.703691] ::::: Aud mem(dsadr) = B7140000 Done = 0
[22725.704132] :::: pxa2xx_pcm_pointer
[22725.704154] ::::: Aud mem(dsadr) = B7140000 Done = 0
[22725.705555] :::: pxa2xx_pcm_pointer
[22725.705650] ::::: Aud mem(dsadr) = B7140000 Done = 0
[22726.699233] ALSA sound/core/pcm_native.c:1512: playback drain error (DMA or IRQ trouble?)
[22726.699314] :::: playback drain error (DMA or IRQ trouble?)
[22726.699367] :::: pxa2xx_pcm_trigger 0
[22726.703145] :::: pxa2xx_pcm_hw_free
[22726.703232] :::: pxa2xx_pcm_close
[22726.703258] :::: pxa2xx_ac97_pcm_shutdown
[22726.703278] Audio amplifier ... Powering Off
-------------- next part --------------
BeforeProblem                   AfterProblem
0:00 = 02a0                     0:00 = 02a0
0:02 = 0d0d                     0:02 = 0d0d
0:04 = 0000                     0:04 = 0000
0:06 = 0000                     0:06 = 0000
0:08 = 0000                     0:08 = 0000
0:0a = 0000                     0:0a = 0000
0:0c = 0000                     0:0c = 0000
0:0e = 0000                     0:0e = 0000
0:10 = 0000                     0:10 = 0000
0:12 = 0000                     0:12 = 0000
0:14 = 0000                     0:14 = 0000
0:16 = 0000                     0:16 = 0000
0:18 = 0000                     0:18 = 0000
0:1a = 0000                     0:1a = 0000
0:1c = 0000                     0:1c = 0000
0:1e = 0000                     0:1e = 0000
0:20 = 0000                     0:20 = 0000
0:22 = 0000                     0:22 = 0000
0:24 = 0000                     0:24 = 0000
0:26 = 000b                     0:26 = 000b
0:28 = 0001                     0:28 = 0001
0:2a = 0001                     0:2a = 0001
0:2c = 5622                     0:2c = 3e80
0:2e = 0000                     0:2e = 0000
0:30 = 0000                     0:30 = 0000
0:32 = bb80                     0:32 = bb80
0:34 = 0000                     0:34 = 0000
0:36 = 0000                     0:36 = 0000
0:38 = 0000                     0:38 = 0000
0:3a = 0000                     0:3a = 0000
0:3c = 0000                     0:3c = 0000
0:3e = 0000                     0:3e = 0000
0:40 = 0000                     0:40 = 0000
0:42 = 0000                     0:42 = 0000
0:44 = 0000                     0:44 = 0000
0:46 = 0000                     0:46 = 0000
0:48 = 0000                     0:48 = 0000
0:4a = 0000                     0:4a = 0000
0:4c = 0000                     0:4c = 0000
0:4e = 0000                     0:4e = 0000
0:50 = 0000                     0:50 = 0000
0:52 = 0000                     0:52 = 0000
0:54 = 0000                     0:54 = 0000
0:56 = 0000                     0:56 = 0000
0:58 = 0000                     0:58 = 0000
0:5a = 0000                     0:5a = 0000
0:5c = 0000                     0:5c = 0000
0:5e = 0000                     0:5e = 0000
0:60 = 0000                     0:60 = 0000
0:62 = 0000                     0:62 = 0000
0:64 = 0948                     0:64 = 0948
0:66 = 0000                     0:66 = 0000
0:68 = 824b                     0:68 = 824b
0:6a = 0050                     0:6a = 0050
0:6c = 0030                     0:6c = 0030
0:6e = 2004                     0:6e = 2004
0:70 = 0000                     0:70 = 0000
0:72 = 0000                     0:72 = 0000
0:74 = 0000                     0:74 = 0000
0:76 = 0000                     0:76 = 0000
0:78 = 0000                     0:78 = 0000
0:7a = 0000                     0:7a = 0000
0:7c = 5053                     0:7c = 5053
0:7e = 4304                     0:7e = 4304
