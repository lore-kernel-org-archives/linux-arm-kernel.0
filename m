From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 13 Nov 2014 18:41:10 +0200
Subject: [PATCH v2 1/5] video: omapdss: Add opa362 driver
In-Reply-To: <9FD016B8-4EA2-4A0D-B790-6494AB449B31@goldelico.com>
References: <1415830247-31633-1-git-send-email-marek@goldelico.com>
 <1415830247-31633-2-git-send-email-marek@goldelico.com>
 <54649B43.1000801@ti.com>
 <9FD016B8-4EA2-4A0D-B790-6494AB449B31@goldelico.com>
Message-ID: <5464DF26.2010707@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/11/14 18:25, Dr. H. Nikolaus Schaller wrote:
> Hi,
> 
> Am 13.11.2014 um 12:51 schrieb Tomi Valkeinen <tomi.valkeinen@ti.com>:
> 
>> On 13/11/14 00:10, Marek Belisko wrote:
>>> opa362 is amplifier for video and can be connected to the tvout pads
>>> of the OMAP3. It has one gpio control for enable/disable of the output
>>> (high impedance).
>>>
>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>> ---
>>> drivers/video/fbdev/omap2/displays-new/Kconfig     |   6 +
>>> drivers/video/fbdev/omap2/displays-new/Makefile    |   1 +
>>> .../fbdev/omap2/displays-new/amplifier-opa362.c    | 343 +++++++++++++++++++++
>>
>> I think it would be better to rename this to encoder-opa362.c. It's not
> 
> When developing this driver we did simply rename the encoder-tfp410 file,
> but thent hough that it does not fit into the ?encoder? category, because we
> would expect something digital or digital to analog ?encoding? which it does not.

That is true, but we already have other "encoders" like
encoder-tpd12s015.c, which also do not encode. "encoder" in this context
means something that takes a video input, and has a video output. In
contrast to a panel or a connector.

>>> +
>>> +	in->ops.atv->set_timings(in, &ddata->timings);
>>> +	/* fixme: should we receive the invert from our consumer, i.e. the connector? */
>>> +	in->ops.atv->invert_vid_out_polarity(in, true);
>>
>> Well this does seem to be broken. I don't know what the answer to the
>> question above is, but the code doesn't work properly.
>>
>> In the opa362_invert_vid_out_polarity function below, you get the invert
>> boolean from the connector. This you pass to the OMAP venc. However,
>> above you always override that value in venc with true.
>>
>> So, either the invert_vid_out_polarity value has to be always true or
>> false, because _OPA362_ requires it to be true or false, OR you need use
>> the value from the connector.
>>
>> Seeing the comment in opa362_invert_vid_out_polarity, my guess is the
>> latter, and the call above should be removed.
> 
> Yes, you are right - this is not systematic.
> 
> But the problem is that we can?t ask the connector here what it wants
> to see. It might (or might not) call our opa362_invert_vid_out_polarity() later
> which we can then forward to overwrite the inital state of this opa362_enable().

You don't need to ask. The connector calls invert_vid_out_polarity
before enabling the output. You can just pass it forward inverted, as
you already do in this driver. If it doesn't, it's either a bug or you
can just rely on the value that is already programmed to venc.

>> We are going to support only DT boot at some point. Thus I think the
>> whole platform data code should be left out.
> 
> Is there already a decision? I think it should not be done before. And it
> does not harm to still have it.

It's just a matter of time. I don't accept any new boards using platform
data for display, or new display drivers using platform data, because I
don't want to spend my time converting them later. And as this is a new
driver, no existing board can be using the opa362 platform_data. So we
can support DT only.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141113/26f87c09/attachment.sig>
