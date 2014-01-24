From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 24 Jan 2014 18:29:12 +0100
Subject: [PATCH v3 15/24] drm/i2c: tda998x: use irq for connection status
 and EDID read
In-Reply-To: <20140122222705.GL15937@n2100.arm.linux.org.uk>
References: <cover.1390153344.git.moinejf@free.fr>
 <20140119195843.7ae9753d@armhf>
 <20140122222705.GL15937@n2100.arm.linux.org.uk>
Message-ID: <52E2A2E8.50806@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/14 23:27, Russell King - ARM Linux wrote:
> On Sun, Jan 19, 2014 at 07:58:43PM +0100, Jean-Francois Moine wrote:
>> This patch adds the optional treatment of the tda998x IRQ.
>>
>> The interrupt function is used to know the display connection status
>> without polling and to speedup reading the EDID.
>>
>> The interrupt number may be defined either in the DT or at encoder set
>> config time for non-DT boards.
>>
>> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
>> ---
[...]
>> @@ -720,6 +787,10 @@ tda998x_encoder_set_config(struct drm_encoder *encoder, void *params)
>>   		priv->audio_port = p->audio_cfg;
>>   		priv->audio_format = p->audio_format;
>>   	}
>> +
>> +	priv->irq = p->irq;
>> +	if (p->irq)
>> +		tda_irq_init(priv);
>
> If we're going to do it this way, this should probably release the IRQ if
> there was one before re-claiming it, just in case this function gets called
> more than once by some driver using it.
>
> The alternative is, as I said before, to use the infrastructure which is
> already there, namely setting the interrupt via struct i2c_client's
> irq member.  Yes, that doesn't satisfy Sebastian's comment about using
> a GPIO, but there's no sign of GPIO usage in here at the moment anyway.
> So we might as well use what's already provided.

Russell,

I am fine with using an irq instead of gpio here. I remember you telling
me on a similar patch, that from the gpio you can derive the irq but
not the other way round. Anyway, I also remember reading discussions
about DT gpios vs interrupts, and IIRC the outcome was that passing
interrupts is fine, too.

We usually have both interrupt-controller; and gpio-controller; set on
DT gpio controllers, so let's stick with irq.

And: Thanks for reviewing this again, I am still too busy to keep up
with it.

Sebastian
