From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 13 Mar 2017 10:27:08 +0100
Subject: [PATCH] drm: dw_hdmi: Gate audio sampler clock from the
 enablement functions
In-Reply-To: <20170310093509.19044-1-romain.perier@collabora.com>
References: <20170310093509.19044-1-romain.perier@collabora.com>
Message-ID: <25ad96a7-d907-2bcb-3a96-15a2956e7652@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/2017 10:35 AM, Romain Perier wrote:
> Currently, the audio sampler clock is enabled from dw_hdmi_setup() at
> step E. and is kept enabled for later use. This clock should be enabled
> and disabled along with the actual audio stream and not always on (that
> is bad for PM). Futhermore, this might cause sound glitches with some
> HDMI devices, as the CTS+N is forced to zero when the stream is disabled
> while the audio clock is still running.
> 
> This commit adds a parameter to hdmi_audio_enable_clk() that controls
> when the audio sample clock must be enabled or disabled. Then, it moves
> the call to this function into dw_hdmi_audio_enable() and
> dw_hdmi_audio_disable().
> 
> Signed-off-by: Romain Perier <romain.perier@collabora.com>
> ---
>  drivers/gpu/drm/bridge/dw-hdmi.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 

Hi Romain, Russell, Jose,

This is a little out of scope, but I was wondering why the CTS calculation was not left
in AUTO mode in the dw-hdmi driver ?

In the Amlogic Vendor tree, they don't set the HDMI_AUD_CTS3_CTS_MANUAL bit and leave
the CTS value to 0.

I am wondering if the AUTO feature is specific to newer IP version, or it was disabled
in the iMX.6 IP configuration ? or simply tied to the AHB audio specificity.

It would be simpler and smarter to leave the AUTO feature enabled for I2S and S/PDIF
input when the IP supports it.

Jose, is there a config bit for this feature, or a specific IP version where it landed ?

Anyway, we should really differentiate the AHB audio and I2S/SPDIF audio in the CTS/N calculation,
since the I2S/SPDIF depends on an different clock for audio input and the AUTO CTS calculation
feature will certainly offer a better clock synchronization.

Thanks,
Neil
