From: Jose.Abreu@synopsys.com (Jose Abreu)
Date: Mon, 13 Mar 2017 12:55:58 +0000
Subject: [PATCH] drm: dw_hdmi: Gate audio sampler clock from the
 enablement functions
In-Reply-To: <20170313093630.GE21222@n2100.armlinux.org.uk>
References: <20170310093509.19044-1-romain.perier@collabora.com>
 <25ad96a7-d907-2bcb-3a96-15a2956e7652@baylibre.com>
 <20170313093630.GE21222@n2100.armlinux.org.uk>
Message-ID: <724d599e-7285-3feb-9a18-d3fbc4000eb5@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On 13-03-2017 09:36, Russell King - ARM Linux wrote:
> On Mon, Mar 13, 2017 at 10:27:08AM +0100, Neil Armstrong wrote:
>> On 03/10/2017 10:35 AM, Romain Perier wrote:
>>> Currently, the audio sampler clock is enabled from dw_hdmi_setup() at
>>> step E. and is kept enabled for later use. This clock should be enabled
>>> and disabled along with the actual audio stream and not always on (that
>>> is bad for PM). Futhermore, this might cause sound glitches with some
>>> HDMI devices, as the CTS+N is forced to zero when the stream is disabled
>>> while the audio clock is still running.
>>>
>>> This commit adds a parameter to hdmi_audio_enable_clk() that controls
>>> when the audio sample clock must be enabled or disabled. Then, it moves
>>> the call to this function into dw_hdmi_audio_enable() and
>>> dw_hdmi_audio_disable().
>>>
>>> Signed-off-by: Romain Perier <romain.perier@collabora.com>
>>> ---
>>>  drivers/gpu/drm/bridge/dw-hdmi.c | 15 +++++++++------
>>>  1 file changed, 9 insertions(+), 6 deletions(-)
>>>
>> Hi Romain, Russell, Jose,
>>
>> This is a little out of scope, but I was wondering why the CTS calculation
>> was not left in AUTO mode in the dw-hdmi driver ?
> There is no indication in the iMX6 manuals that the iMX6 supports
> automatic CTS calculation.  Bits 7:4 of the AUD_CTS3 register are
> marked as "reserved".
>
> We're reliant on the information in the iMX6 manuals as we don't have
> access to Synopsis' databooks for these parts (I understand you have
> to be a customer to have access to that.)
>

(Synopsis -> Synopsys :))

Trying to catch up with the conversation:

1) In AHB audio mode the bits are always reserved.
2) I think we should enable/disable clock instead of just forcing
N/CTS, though, I don't know what could be the implications for
iMX platform. I remember at the time I tested this using I2S
(I've never used AHB), and HDMI protocol analyzers were
complaining about the N/CTS being forced to zero.
3) I also remember that there was something wrong with the N
calculations (I had to remove the if for pixel clock ==
25175000). I never submited a patch to that because I was running
out of time and didn't investigate this further (it could be for
example a problem specific to my setup).

Hope it helps a little bit.

Best regards,
Jose Miguel Abreu
