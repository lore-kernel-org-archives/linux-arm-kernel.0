From: romain.perier@collabora.com (Romain Perier)
Date: Fri, 10 Mar 2017 13:58:58 +0100
Subject: [PATCH] drm: dw_hdmi: Gate audio sampler clock from the
 enablement functions
In-Reply-To: <20170310111504.GT21222@n2100.armlinux.org.uk>
References: <20170310093509.19044-1-romain.perier@collabora.com>
 <20170310094613.GQ21222@n2100.armlinux.org.uk>
 <7888eb1f-2781-d4ed-6f26-cb76e1ead4d2@collabora.com>
 <20170310102753.GR21222@n2100.armlinux.org.uk>
 <202cd871-eb1c-d8f4-62d6-bed479f0eece@collabora.com>
 <20170310111504.GT21222@n2100.armlinux.org.uk>
Message-ID: <4e8de49b-427f-2a7b-18c6-9224835c1f56@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,


Le 10/03/2017 ? 12:15, Russell King - ARM Linux a ?crit :
> On Fri, Mar 10, 2017 at 11:58:19AM +0100, Romain Perier wrote:
>> Hello,
>>
>> Le 10/03/2017 ? 11:27, Russell King - ARM Linux a ?crit :
>>> I also would not think that it's platform specific - remember that
>>> this is Designware IP, and it's likely that other platforms with
>>> exactly the same IP would suffer from the same problem.  It's
>>> probably revision specific, but we need Synopsis' input on that.
>>>
>>> However, I do believe that your patch probably doesn't have much
>>> merit in any case: on a mode set, you enable the audio clock, and
>>> it will remain enabled until the audio device is first opened and
>>> then closed.  If another mode set comes along, then exactly the
>>> same situation happens again.  So, really it isn't achieving all
>>> that much.
>> The fact is we still have sound glitches caused by this workaround on
>> Rockchip, we probably have a revision
>> of the IP without this issue. If CTS+N is not forced to zero we no
>> longer have the glitches :/ (with or without touching the clock)
> Are you sure that removing the workaround just doesn't result in the
> same bug as on iMX6 appearing?  The bug concerned is the ordering of
> the channels, so unless you're (eg0 monitoring left/right separately
> or directing audio to just one channel, you may not (with modern TVs)
> realise that the channels are swapped.  I'll include the errata
> description and impact below.
>
> There are occasional issues on iMX6 as well despite this work-around,
> but I don't clearly remember what devmem2 tweaks I've done in the past
> to get it to resolve itself, nor could I describe them from memory
> any better than "burbling audio".

Well, I have reverted locally your patch (I did it quickly by hand
because it did not work via git revert... anyway...),
And I no longer have the issue at all. It's working fine all the time
and it's truly deterministic (see attachment)

Also, I have found that the version of the IP is not exactly the same.
On Rockchip it's 0x20:0xa:0xa0:0xc1, on IMX.6 it's  0x13:0xa:0xa0:0xc1.
>
>
>   When the AHB Audio DMA is started, by setting to 1'b1 for the first
>   time the register field AHB_DMA_START.data_buffer_ready, the AHB
>   Audio DMA will request data from the AHB bus to fill its internal
>   AHB DMA FIFO. It is possible that a AHB DMA FIFO read action occurs
>   during the time window between the first sample stored on the AHB
>   DMA FIFO and when the AHB DMA FIFO has stored, at least, the number
>   of configured audio channels in samples. If this happens, the AHB
>   DMA FIFO will reply with samples that are currently on the AHB
>   Audio FIFO and will repeat the last sample after the empty condition
>   is reached.
>
>   Projected Impact:
>   This will miss-align the audio stream, causing a shift in the
>   distribution of audio on the channels on the HDMI sink side, with no
>   knowledge of the DWC_hdmi_tx enabled system.

Thanks for this, it helps!
It looks specific to AHB audio

>
>
> If you know that this definitely does not apply to your version, then
> we need to split the audio enable/disable functions between the AHB
> and I2S variants.
Mhhh, yeah both seem to work differently.

Romain

-------------- next part --------------
A non-text attachment was scrubbed...
Name: revert.patch
Type: text/x-patch
Size: 3551 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170310/f920ffa6/attachment.bin>
