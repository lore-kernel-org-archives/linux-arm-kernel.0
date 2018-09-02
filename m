From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 02 Sep 2018 17:47:39 +0200
Subject: ASoC: pxa: remove pxa2xx-pcm driver, which caused regression
In-Reply-To: <5bdc752d-d112-470a-151e-c40cf4ad97df@gmail.com> (Petr Cvek's
 message of "Sat, 1 Sep 2018 19:33:34 +0200")
References: <f12148b7c9102c67d92a0467f1d653e37c6548ee.1534534854.git.petrcvekcz@gmail.com>
 <87r2iwau3u.fsf@belgarion.home>
 <4deb5304-8efc-3093-7f8e-0dfe50781790@gmail.com>
 <87mutjbidr.fsf@belgarion.home>
 <16bb94b6-089d-f78e-1bb7-2550414be2fb@gmail.com>
 <878t4u96wq.fsf@belgarion.home>
 <1e1c5084-840d-a378-7c57-def6d6c0a096@gmail.com>
 <87y3cp6z5q.fsf@belgarion.home>
 <5bdc752d-d112-470a-151e-c40cf4ad97df@gmail.com>
Message-ID: <87sh2r6gv8.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petrcvekcz@gmail.com> writes:

> Dne 29.8.2018 v 16:11 Robert Jarzmik napsal(a):
>> Petr Cvek <petrcvekcz@gmail.com> writes:
>> If that's the case, Daniel would you have a look into it please ?
>> 
> I've put printks in almost every sound function by now ;-). It gets
> I got this log:
...zip...
I got this log :
[14540.460575]  ac97-0: adapter registered by pxa2xx-ac97
[14540.474726]  ac97-0: snd_ac97_bus_scan_one(codec_num=0): vendor_id=0x574d4c13
[14541.003160] mioa701-wm9713 mioa701-wm9713: ASoC: CODEC DAI wm9713-hifi not registered
[14541.978576] wm97xx-core pxa2xx-ac97:0: wm97xx core found, id=0x574d4c13
[14542.010897] wm9713-codec wm9713-codec: Control not supported for path Mic B Source -> [MPB] -> Mic B Pre Amp
[14542.096874] wm9713-codec wm9713-codec: ASoC: no dapm match for Mic B Source --> MPB --> Mic B Pre Amp
[14542.149488] wm9713-codec wm9713-codec: ASoC: Failed to add route Mic B Source -> MPB -> Mic B Pre Amp
[14542.195525] TEST component: 5c700a04 pxa2xx-ac97
[14542.201547] actually called=0
[14542.205938] TEST component: 3b89ec70 wm9713-codec
[14542.209549] TEST component: 58f79ee1 pxa-pcm-audio
[14542.215826] actually called=0
[14542.219567] mioa701-wm9713 mioa701-wm9713: wm9713-hifi <-> pxa2xx-ac97 mapping ok
[14542.227201] TEST component: 5c700a04 pxa2xx-ac97
[14542.232090] actually called=0
[14542.236140] TEST component: 3b89ec70 wm9713-codec
[14542.239595] TEST component: 58f79ee1 pxa-pcm-audio
[14542.244281] actually called=0
[14542.247944] mioa701-wm9713 mioa701-wm9713: wm9713-aux <-> pxa2xx-ac97-aux mapping ok
[14542.255778] wm9713-codec wm9713-codec: ASoC: mux Sidetone Mux has no paths
[14542.312582] mioa701-wm9713 mioa701-wm9713: Be warned that incorrect mixers/muxes setup will lead to overheating and possible destruction of your device. Do not use without a good knowledge of mio's board design!

>> Very true. I hope you're using CONFIG_PXA_DMA=1 and not CONFIG_MMP_PDMA, this
>> will enable us to debug when things will get out of control.
>> 
> I do from the beginning. Is it even possible to use CONFIG_MMP_PDMA on
> PXA27x?
It should be ... But I advice against it.

> It may be possible to remove the block bellow from SSP and I2S drivers
> but it will change the situation for every platform which uses SSP or I2S:
>
> 	.ops		= &pxa2xx_pcm_ops,
> 	.pcm_new	= pxa2xx_soc_pcm_new,
> 	.pcm_free	= pxa2xx_pcm_free_dma_buffers,
>
> The generic functions would be then called just from pxa-pcm-audio
> component.
That's up to Daniel and you.

Cheers.

-- 
Robert
