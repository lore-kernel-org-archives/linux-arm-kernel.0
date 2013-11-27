From: richard.genoud@gmail.com (Richard Genoud)
Date: Wed, 27 Nov 2013 11:09:15 +0100
Subject: [PATCH 1/2] ASoC: atmel: sam9x5_wm8731: fix oops when unload
 module
In-Reply-To: <52954739.1090501@atmel.com>
References: <1385439472-23352-1-git-send-email-voice.shen@atmel.com>
 <CACQ1gAh3W3vyTpFv8CkbO8hFJtU_SDjVuh2pRSFWCbUZPmidsw@mail.gmail.com>
 <52954739.1090501@atmel.com>
Message-ID: <5295C4CB.2060003@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/11/2013 02:13, Bo Shen wrote:
> Hi Richard,
Hi !
> 
> On 11/26/2013 07:32 PM, Richard Genoud wrote:
>> 2013/11/26 Bo Shen <voice.shen@atmel.com>:
>>> As the priv is not assigned to card->drvdata, it is NULL, so when
>>> unload module, it will cause NULL pointer oops.
>>> Assign priv to card->drvdata to fix this issue.
>>>
>>> Signed-off-by: Bo Shen <voice.shen@atmel.com>
>>> ---
>>>   sound/soc/atmel/sam9x5_wm8731.c |    1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/sound/soc/atmel/sam9x5_wm8731.c
>>> b/sound/soc/atmel/sam9x5_wm8731.c
>>> index 992ae38..6dc33ac 100644
>>> --- a/sound/soc/atmel/sam9x5_wm8731.c
>>> +++ b/sound/soc/atmel/sam9x5_wm8731.c
>>> @@ -99,6 +99,7 @@ static int sam9x5_wm8731_driver_probe(struct
>>> platform_device *pdev)
>>>
>>>          card->dev = &pdev->dev;
>>>          card->owner = THIS_MODULE;
>>> +       card->drvdata = priv;
>>>          card->dai_link = dai;
>>>          card->num_links = 1;
>>>          card->dapm_widgets = sam9x5_dapm_widgets;
>>> -- 
>>> 1.7.9.5
>>>
>> There's no oops any more !
>>
>> Tested-by: Richard Genoud <richard.genoud@gmail.com>
>>
>> This should also go in -stable don't you think ?
> 
> After this patch go into mainline tree, I think we can ask it to go in
> -stable tree.
So, you should add "Cc: stable at vger.kernel.org" just after your signed-off (maybe with a note that it applies on 3.12+)
[ actually, that's more a question than an advice :) ]

> 
>> Maybe it's a bug on my kernel, but did you try to reload the module
>> and play something ?
> 
> When we reload the module, as the codec is not configured outside, so it
> use default value, the 'Output Mixer HiFi Playback Switch' is in off
> state.If you want to play something, you need make it in on state.
> Please take the following command as a reference:
> --->8---
> amixer cset numid=14,iface=MIXER,name='Output Mixer HiFi Playback
> Switch' on
> ---8<---
It doesn't seems to be related to the playback switches.
I check the TK/TD/TF lines, and nothing happens on them after the module has been unloaded/reloaded.
I enabled I2C/dma logs (on a 3.13-rc1 + your 2 patches kernel + at91sam9g35ek) and it seems that the DMA doesn't fill the SSC :

# # before unloading the module :
# alsactl -f /etc/asound.state restore
# aplay tone-stereo-100Hz_right-440Hz-left.wav -Dplug:default
Playing WAVE 'tone-stereo-100Hz_right-440Hz-left.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0x10, to go 1
at91_i2c f8010000.i2c: wrote 0x0, to go 0
at91_i2c f8010000.i2c: transfer complete
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0xe, to go 1
at91_i2c f8010000.i2c: wrote 0x42, to go 0
at91_i2c f8010000.i2c: transfer complete
dma dma0chan4: atc_control (3)
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0xc, to go 1
at91_i2c f8010000.i2c: wrote 0x5f, to go 0
at91_i2c f8010000.i2c: transfer complete
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0x12, to go 1
at91_i2c f8010000.i2c: wrote 0x1, to go 0
at91_i2c f8010000.i2c: transfer complete
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0xc, to go 1
at91_i2c f8010000.i2c: wrote 0x57, to go 0
at91_i2c f8010000.i2c: transfer complete
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0xc, to go 1
at91_i2c f8010000.i2c: wrote 0x47, to go 0
at91_i2c f8010000.i2c: transfer complete
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0xa, to go 1
at91_i2c f8010000.i2c: wrote 0x0, to go 0
at91_i2c f8010000.i2c: transfer complete
dma dma0chan4: prep_dma_cyclic: TO DEVICE buf@0x27b30000 - 8 (65536/8192)
dma dma0chan4: scanned 1 descriptors on freelist
dma dma0chan4: scanned 1 descriptors on freelist
dma dma0chan4: scanned 1 descriptors on freelist
dma dma0chan4: scanned 1 descriptors on freelist
dma dma0chan4: scanned 1 descriptors on freelist
dma dma0chan4: scanned 1 descriptors on freelist
dma dma0chan4: scanned 1 descriptors on freelist
dma dma0chan4: scanned 1 descriptors on freelist
dma dma0chan4: tx_submit: started 2
dma dma0chan4:   channel 4 : imr = 0xff00ff, chsr = 0xff0000
dma dma0chan4:   channel: s0x0 d0x0 ctrl0x0:0x0 cfg0x100022dd l0x0
dma dma0chan4:   channel 4 : imr = 0xff00ff, chsr = 0xff0010
dma dma0chan4:   channel: s0x27b30418 d0xf0010024 ctrl0x1100020c:0x20200010 cfg0x100022dd l0x27981d5c
dma dma0chan4: issue_pending
at_hdmac ffffec00.dma-controller: interrupt: status = 0x00000010, 0x00ff00ff, 0x00000010
dma dma0chan4: new cyclic period llp 0x27981da8
at_hdmac ffffec00.dma-controller: interrupt: status = 0x00000010, 0x00ff00ff, 0x00000010
dma dma0chan4: new cyclic period llp 0x27981df4
[...]
at_hdmac ffffec00.dma-controller: interrupt: status = 0x00000010, 0x00ff00ff, 0x00000010
dma dma0chan4: new cyclic period llp 0x27981ed8
at_hdmac ffffec00.dma-controller: interrupt: status = 0x00000010, 0x00ff00ff, 0x00000010
dma dma0chan4: new cyclic period llp 0x27981f24
at_hdmac ffffec00.dma-controller: interrupt: status = 0x00000010, 0x00ff00ff, 0x00000010
dma dma0chan4: new cyclic period llp 0x27981d10
dma dma0chan4: atc_control (0)
dma dma0chan4: descriptor 2 complete
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0xa, to go 1
at91_i2c f8010000.i2c: wrote 0x8, to go 0
at91_i2c f8010000.i2c: transfer complete
# 
# # unloading the module
# rmmod snd_soc_sam9x5_wm8731i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0xc, to go 1
at91_i2c f8010000.i2c: wrote 0x57, to go 0
at91_i2c f8010000.i2c: transfer complete
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0xc, to go 1
at91_i2c f8010000.i2c: wrote 0x5f, to go 0
at91_i2c f8010000.i2c: transfer complete
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0xc, to go 1
at91_i2c f8010000.i2c: wrote 0x7f, to go 0
at91_i2c f8010000.i2c: transfer complete
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0x12, to go 1
at91_i2c f8010000.i2c: wrote 0x0, to go 0
at91_i2c f8010000.i2c: transfer complete
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0xc, to go 1
at91_i2c f8010000.i2c: wrote 0x7f, to go 0
at91_i2c f8010000.i2c: transfer complete

i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0xff, to go 1
at91_i2c f8010000.i2c: wrote 0xff, to go 0
at91_i2c f8010000.i2c: transfer complete
dma dma0chan4: free_chan_resources: (descs allocated=64)
dma dma0chan4:   freeing descriptor c885dd10
dma dma0chan4:   freeing descriptor c885dd5c
dma dma0chan4:   freeing descriptor c885dda8
dma dma0chan4:   freeing descriptor c885ddf4
[...]
dma dma0chan4:   freeing descriptor c888bed8
dma dma0chan4:   freeing descriptor c888bf24
dma dma0chan4:   freeing descriptor c888bf70
dma dma0chan4:   freeing descriptor c888d000
dma dma0chan4:   freeing descriptor c888d04c
dma dma0chan4: free_chan_resources: done
dma dma0chan5: free_chan_resources: (descs allocated=64)
dma dma0chan5:   freeing descriptor c888d098
dma dma0chan5:   freeing descriptor c888d0e4
dma dma0chan5:   freeing descriptor c888d130
[...]
dma dma0chan5:   freeing descriptor c888f2ac
dma dma0chan5:   freeing descriptor c888f2f8
dma dma0chan5:   freeing descriptor c888f344
dma dma0chan5:   freeing descriptor c888f390
dma dma0chan5: free_chan_resources: done
# # reloading the module
# modprobe snd_soc_sam9x5_wm8731
dmaengine: private_candidate: dma0chan0 busy
dmaengine: private_candidate: dma0chan1 busy
dmaengine: private_candidate: dma0chan2 busy
dmaengine: private_candidate: dma0chan3 busy
dma dma0chan4: alloc_chan_resources
dma dma0chan4: alloc_chan_resources: allocated 64 descriptors
dmaengine: __dma_request_channel: success (dma0chan4)
dmaengine: private_candidate: dma0chan0 busy
dmaengine: private_candidate: dma0chan1 busy
dmaengine: private_candidate: dma0chan2 busy
dmaengine: private_candidate: dma0chan3 busy
dmaengine: private_candidate: dma0chan4 busy
dma dma0chan5: alloc_chan_resources
dma dma0chan5: alloc_chan_resources: allocated 64 descriptors
dmaengine: __dma_request_channel: success (dma0chan5)
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0x1e, to go 1
at91_i2c f8010000.i2c: wrote 0x0, to go 0
at91_i2c f8010000.i2c: transfer complete
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0x0, to go 1
at91_i2c f8010000.i2c: wrote 0x9a, to go 0
at91_i2c f8010000.i2c: transfer complete
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0x2, to go 1
at91_i2c f8010000.i2c: wrote 0x9a, to go 0
at91_i2c f8010000.i2c: transfer complete
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0x4, to go 1
at91_i2c f8010000.i2c: wrote 0x74, to go 0
at91_i2c f8010000.i2c: transfer complete
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0x6, to go 1
at91_i2c f8010000.i2c: wrote 0x74, to go 0
at91_i2c f8010000.i2c: transfer complete
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0x8, to go 1
at91_i2c f8010000.i2c: wrote 0x12, to go 0
at91_i2c f8010000.i2c: transfer complete
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0xff, to go 1
at91_i2c f8010000.i2c: wrote 0xff, to go 0
at91_i2c f8010000.i2c: transfer complete
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0xe, to go 1
at91_i2c f8010000.i2c: wrote 0x42, to go 0
at91_i2c f8010000.i2c: transfer complete
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0x1e, to go 1
at91_i2c f8010000.i2c: wrote 0x0, to go 0
at91_i2c f8010000.i2c: transfer complete
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0xff, to go 1
at91_i2c f8010000.i2c: wrote 0x7f, to go 0
at91_i2c f8010000.i2c: transfer complete
sam9x5-snd-wm8731 sound.5: wm8731-hifi <-> f0010000.ssc mapping ok
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0xe, to go 1
at91_i2c f8010000.i2c: wrote 0x42, to go 0
at91_i2c f8010000.i2c: transfer complete
# # restoring codec state
# alsactl -f /etc/asound.state restore
# aplay tone-stereo-100Hz_right-440Hz-left.wav -Dplug:default
Playing WAVE 'tone-stereo-100Hz_right-440Hz-left.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0x10, to go 1
at91_i2c f8010000.i2c: wrote 0x0, to go 0
at91_i2c f8010000.i2c: transfer complete
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0xe, to go 1
at91_i2c f8010000.i2c: wrote 0x42, to go 0
at91_i2c f8010000.i2c: transfer complete
dma dma0chan4: atc_control (3)
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0xff, to go 1
at91_i2c f8010000.i2c: wrote 0x5f, to go 0
at91_i2c f8010000.i2c: transfer complete
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0x12, to go 1
at91_i2c f8010000.i2c: wrote 0x1, to go 0
at91_i2c f8010000.i2c: transfer complete
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0xff, to go 1
at91_i2c f8010000.i2c: wrote 0x57, to go 0
at91_i2c f8010000.i2c: transfer complete
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0xff, to go 1
at91_i2c f8010000.i2c: wrote 0x47, to go 0
at91_i2c f8010000.i2c: transfer complete
i2c i2c-0: master_xfer[0] W, addr=0x1a, len=2
i2c i2c-0: at91_xfer: processing 1 messages:
at91_i2c f8010000.i2c: transfer: write 2 bytes.
at91_i2c f8010000.i2c: wrote 0xa, to go 1
at91_i2c f8010000.i2c: wrote 0x0, to go 0
at91_i2c f8010000.i2c: transfer complete
dma dma0chan4: prep_dma_cyclic: TO DEVICE buf at 0x27950000 - 8 (65536/8192)
dma dma0chan4: scanned 1 descriptors on freelist
dma dma0chan4: scanned 1 descriptors on freelist
dma dma0chan4: scanned 1 descriptors on freelist
dma dma0chan4: scanned 1 descriptors on freelist
dma dma0chan4: scanned 1 descriptors on freelist
dma dma0chan4: scanned 1 descriptors on freelist
dma dma0chan4: scanned 1 descriptors on freelist
dma dma0chan4: scanned 1 descriptors on freelist
dma dma0chan4: tx_submit: started 2
dma dma0chan4:   channel 4 : imr = 0xff00ff, chsr = 0xff0000
dma dma0chan4:   channel: s0x27b3eb20 d0xf0010024 ctrl0x91000590:0x20200010 cfg0x100022dd l0x27981d10
dma dma0chan4:   channel 4 : imr = 0xff00ff, chsr = 0xff0010
dma dma0chan4:   channel: s0x27950010 d0xf0010024 ctrl0x11000008:0x20200010 cfg0x100022dd l0x27a58344
dma dma0chan4: issue_pending
[ blocks here forever (or at least a looooong time) ]


Anyway, this should not prevent this patch from being mainlined :)
