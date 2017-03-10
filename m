From: romain.perier@collabora.com (Romain Perier)
Date: Fri, 10 Mar 2017 11:21:53 +0100
Subject: [PATCH] drm: dw_hdmi: Gate audio sampler clock from the
 enablement functions
In-Reply-To: <20170310094613.GQ21222@n2100.armlinux.org.uk>
References: <20170310093509.19044-1-romain.perier@collabora.com>
 <20170310094613.GQ21222@n2100.armlinux.org.uk>
Message-ID: <7888eb1f-2781-d4ed-6f26-cb76e1ead4d2@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Le 10/03/2017 ? 10:46, Russell King - ARM Linux a ?crit :
> On Fri, Mar 10, 2017 at 10:35:09AM +0100, Romain Perier wrote:
>> Currently, the audio sampler clock is enabled from dw_hdmi_setup() at
>> step E. and is kept enabled for later use. This clock should be enabled
>> and disabled along with the actual audio stream and not always on (that
>> is bad for PM). Futhermore, this might cause sound glitches with some
>> HDMI devices, as the CTS+N is forced to zero when the stream is disabled
>> while the audio clock is still running.
>>
>> This commit adds a parameter to hdmi_audio_enable_clk() that controls
>> when the audio sample clock must be enabled or disabled. Then, it moves
>> the call to this function into dw_hdmi_audio_enable() and
>> dw_hdmi_audio_disable().
> How does this interact with the workaround given in my commit introducing
> these functions?  (Commit b90120a96608).
>
> Setting N=0 is a work-around for iMX6, and we need the audio FIFO to be
> loaded with data prior to setting N non-zero.  If disabling the audio
> clock prevents the audio FIFO being loaded, your patch will break iMX6.
>
Mhhh, the fact is I have no IMX6 devices here (only Rockchip). So
I only tested on Rockchip devices. An approach might be to introduce an
option for handling this errata, because that's platform specific and
other platforms (like Rockchip) are in conflict with this.

Romain
