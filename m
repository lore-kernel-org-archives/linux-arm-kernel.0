From: anssi.hannula@iki.fi (Anssi Hannula)
Date: Sat, 09 May 2015 19:49:44 +0300
Subject: [alsa-devel] [PATCH 12/13] drm: bridge/dw_hdmi-ahb-audio: add
 audio driver
In-Reply-To: <E1Yr1y8-0006lG-Mw@rmk-PC.arm.linux.org.uk>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1y8-0006lG-Mw@rmk-PC.arm.linux.org.uk>
Message-ID: <554E3AA8.8060601@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

A couple of things I noticed below:

09.05.2015, 13:26, Russell King kirjoitti:
> Add ALSA based HDMI AHB audio driver for dw_hdmi.  The only buffer
> format supported by the hardware is its own special IEC958 based format,
> which is not compatible with any ALSA format.  To avoid doing too much
> data manipulation within the driver, we support only ALSAs IEC958 LE and
> 24-bit PCM formats for 2 to 6 channels, which we convert to its hardware
> format.
> 
> A more desirable solution would be to have this conversion in userspace,
> but ALSA does not appear to allow such transformations outside of
> libasound itself.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/gpu/drm/bridge/Kconfig             |  10 +
>  drivers/gpu/drm/bridge/Makefile            |   1 +
>  drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c | 560 +++++++++++++++++++++++++++++
>  drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.h |  13 +
>  drivers/gpu/drm/bridge/dw_hdmi.c           |  24 ++
>  drivers/gpu/drm/bridge/dw_hdmi.h           |   3 +
>  6 files changed, 611 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c
>  create mode 100644 drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.h
> 
[...]
> +static void dw_hdmi_create_cs(struct snd_dw_hdmi *dw,
> +	struct snd_pcm_runtime *runtime)
> +{
> +	u8 cs[4];
> +	unsigned ch, i, j;
> +
> +	snd_pcm_create_iec958_consumer(runtime, cs, sizeof(cs));


I think generally drivers have left the iec958 bits for userspace to
handle, i.e. via a "IEC958 Playback Default"
(SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT)) mixer element, with
defaults coming from /usr/share/alsa/pcm/hdmi.conf...

Looking at the sound driver tree, now, though, they are already somewhat
inconsistent:

1. Most drivers: iec958 bits from userspace, except for hw-set bits.

2. Some drivers (e.g. ctxfi, fsl_spdif): Some bits such as rate set by
driver, but everything is also exposed to userspace.
At least in fsl_spdif case the driver sets the stuff in hw_params which
would then get overwritten by userspace (which sets them after hw_params).

3. Some drivers (e.g. omap-hdmi-audio): Set by driver, not exposed to
userspace, like in this patch.

(Of course having userspace set them requires that the device has a
proper entry in /usr/share/alsa/cards and the pcm device is accessed via
the standard "hdmi" or "iec958" device names which perform the channel
status word setup. I guess the ARM SoC stuff generally doesn't bother
with that, explaining a bit why some kernel drivers set them by themselves).

The main interest to iec958 bits from userspace is probably towards the
non-audio bit, used for audio passthrough (the bit is not mandatory
there, but it helps).

Other drivers (well, I guess just HDA has this so far) also use the
userspace-provided non-audio bit to also select (in conjunction with
channels==8) the HBR mode, i.e. HD audio passthrough (which dw_hdmi also
supports via DMA_CONF0 but not enabled on this patch).


Since this isn't the first driver doing things this way, and this
doesn't really prevent exposing them to userspace later on, I guess this
patch is still OK here, unless the ALSA people think otherwise...


[...]
> +static struct snd_pcm_hardware dw_hdmi_hw = {
> +	.info = SNDRV_PCM_INFO_INTERLEAVED |
> +		SNDRV_PCM_INFO_BLOCK_TRANSFER |
> +		SNDRV_PCM_INFO_MMAP |
> +		SNDRV_PCM_INFO_MMAP_VALID,
> +	.formats = SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE |
> +		   SNDRV_PCM_FMTBIT_S24_LE,
> +	.rates = SNDRV_PCM_RATE_32000 |
> +		 SNDRV_PCM_RATE_44100 |
> +		 SNDRV_PCM_RATE_48000 |
> +		 SNDRV_PCM_RATE_88200 |
> +		 SNDRV_PCM_RATE_96000 |
> +		 SNDRV_PCM_RATE_176400 |
> +		 SNDRV_PCM_RATE_192000,
> +	.channels_min = 2,
> +	.channels_max = 8,

You are providing multichannel support, but AFAICS you are not setting
the channel allocation (CA) bits in the audio infoframe anywhere
(HDMI_FC_AUDICONF2 register).

HDMI_FC_AUDICONF2 register default value is 0x00, which means plain
stereo (per CEA-861). If this is what goes on to the HDMI link as well,
the audio sink should ignore the other channels.
Did you check that multichannel PCM actually works? (maybe I'm just
missing where CA is set)


Note also that I think this HW uses the native HDMI channel order (from
CEA-861), which is different from the ALSA default channel order, so you
should inform userspace of the channel order (via
snd_pcm_add_chmap_ctls()). The channel order is specified by the CA
value I mentioned above.

Assuming I'm not missing something which makes everything work already,
one of these should be implemented:

(a) Provide all the chmaps (i.e. one per CA value) as a list for
userspace to select one, and provide the active chmap to userspace as well.

(b) Just hardcode a single CA value per channel count (which covers 99%
of use cases), and provide the corresponding active chmap to userspace.

(c) channels_max = 2.

Both (a) and (b) are generic stuff that could/should be in helpers for
all drivers to use (if (b), preferably with an interface that allows
easily extending it to (a) in the future).

Some of the code from sound/pci/hda/patch_hdmi.c should be useful (at
least the CA table it has - this stuff really shoud be outside the
driver). Note that much of the complexity of patch_hdmi.c comes from the
fact that the HW there supports channel remapping
(SNDRV_CTL_TLVT_CHMAP_VAR or _PAIRED), which dw_hdmi doesn't
(SNDRV_CTL_TLVT_CHMAP_FIXED).


-- 
-- 
Anssi Hannula
