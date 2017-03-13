From: Jose.Abreu@synopsys.com (Jose Abreu)
Date: Mon, 13 Mar 2017 18:49:47 +0000
Subject: [PATCH] drm: dw_hdmi: Gate audio sampler clock from the
 enablement functions
In-Reply-To: <20170313131053.GI21222@n2100.armlinux.org.uk>
References: <20170310093509.19044-1-romain.perier@collabora.com>
 <25ad96a7-d907-2bcb-3a96-15a2956e7652@baylibre.com>
 <20170313093630.GE21222@n2100.armlinux.org.uk>
 <724d599e-7285-3feb-9a18-d3fbc4000eb5@synopsys.com>
 <20170313131053.GI21222@n2100.armlinux.org.uk>
Message-ID: <296108ae-1720-63f1-1eed-ed5dbe1b8bad@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,


On 13-03-2017 13:10, Russell King - ARM Linux wrote:
> On Mon, Mar 13, 2017 at 12:55:58PM +0000, Jose Abreu wrote:
>> Hi,
>>
>>
>> On 13-03-2017 09:36, Russell King - ARM Linux wrote:
>>> On Mon, Mar 13, 2017 at 10:27:08AM +0100, Neil Armstrong wrote:
>>>> On 03/10/2017 10:35 AM, Romain Perier wrote:
>>>>> Currently, the audio sampler clock is enabled from dw_hdmi_setup() at
>>>>> step E. and is kept enabled for later use. This clock should be enabled
>>>>> and disabled along with the actual audio stream and not always on (that
>>>>> is bad for PM). Futhermore, this might cause sound glitches with some
>>>>> HDMI devices, as the CTS+N is forced to zero when the stream is disabled
>>>>> while the audio clock is still running.
>>>>>
>>>>> This commit adds a parameter to hdmi_audio_enable_clk() that controls
>>>>> when the audio sample clock must be enabled or disabled. Then, it moves
>>>>> the call to this function into dw_hdmi_audio_enable() and
>>>>> dw_hdmi_audio_disable().
>>>>>
>>>>> Signed-off-by: Romain Perier <romain.perier@collabora.com>
>>>>> ---
>>>>>  drivers/gpu/drm/bridge/dw-hdmi.c | 15 +++++++++------
>>>>>  1 file changed, 9 insertions(+), 6 deletions(-)
>>>>>
>>>> Hi Romain, Russell, Jose,
>>>>
>>>> This is a little out of scope, but I was wondering why the CTS calculation
>>>> was not left in AUTO mode in the dw-hdmi driver ?
>>> There is no indication in the iMX6 manuals that the iMX6 supports
>>> automatic CTS calculation.  Bits 7:4 of the AUD_CTS3 register are
>>> marked as "reserved".
>>>
>>> We're reliant on the information in the iMX6 manuals as we don't have
>>> access to Synopsis' databooks for these parts (I understand you have
>>> to be a customer to have access to that.)
>>>
>> (Synopsis -> Synopsys :))
>>
>> Trying to catch up with the conversation:
>>
>> 1) In AHB audio mode the bits are always reserved.
>> 2) I think we should enable/disable clock instead of just forcing
>> N/CTS, though, I don't know what could be the implications for
>> iMX platform. I remember at the time I tested this using I2S
>> (I've never used AHB), and HDMI protocol analyzers were
>> complaining about the N/CTS being forced to zero.
> What you're recommending is to basically ignore the published workaround,
> which, presumably, was arrived at by proper analysis of the issue both
> by Freescale engineers and Synopsys engineers, and instead try some other
> solution.
>
> I'm not sure that's a good idea.  Only those with knowledge of the IP can
> say what effect disabling the audio clock will have: will it still allow
> the FIFO to be loaded, as required by the errata?  If not, it's not a
> solution that AHB can use.  I would imagine that _if_ it was as simple as
> disabling the audio clock, that simple approach would have been documented
> in Freescale's errata documents, rather than the rather more complex
> method of zeroing the CTS/N values.

I'm just following what the user guide says: the final step of
configuration is enabling the audio clock. There is no reference
neither in datasheet neither in user guide about this behavior
but, as I said, I've never used AHB so I can't prove what is the
best solution. Could it be platform specific?

>
> I think there are two choices here:
>
> 1) get some definitive information about the IP and the errata for AHB,
>    and determine whether the solution you propose would work.  (That's
>    out of scope for me, I've no contacts with FSL/NXP and I'm not a
>    Synopsys customer.)

This is the right thing to do but if you can't test in the
Freescale platform then we have not much else to do.

Best regards,
Jose Miguel Abreu

>
> 2) the I2S audio support stops re-using the AHB audio support functions,
>    switching to their own implementation that behaves correctly for them.
>    (Remember, it was I2S's choice to re-use the AHB audio support functions
>    I added which we're now discussing - they didn't have to do that, and
>    regressing AHB audio just for I2S is not something we should ever
>    consider doing.)
>
