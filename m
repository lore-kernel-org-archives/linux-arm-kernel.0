From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 08 Aug 2012 16:43:16 +0300
Subject: [PATCH 04/11] MFD: twl4030-audio: Add DT support
In-Reply-To: <20120808131356.GS16861@opensource.wolfsonmicro.com>
References: <1344418887-5262-1-git-send-email-peter.ujfalusi@ti.com>
 <1344418887-5262-5-git-send-email-peter.ujfalusi@ti.com>
 <20120808131356.GS16861@opensource.wolfsonmicro.com>
Message-ID: <50226CF4.1010202@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2012 04:13 PM, Mark Brown wrote:
> On Wed, Aug 08, 2012 at 12:41:20PM +0300, Peter Ujfalusi wrote:
> 
>> +Required properties:
>> +- compatible : must be "ti,twl4030-audio"
> 
> So, as I mentioned before I find this sort of direct mapping of the
> Linux device representation into the device tree really troubling.
> I'm just way too aware of the fact that even the Linux split of these
> things can change over time and often represents internal Linux
> considerations.

Yes, I remember. This is however a bit different case compared to the twl6040.
The twl4030 series of PMIC includes the following parts:
twl4030, twl5030, twl5031, tps65950, tps65930 - contains audio block
tps65920, tps65921 - does not contain audio block

So the audio block within these PMICs are really a block, it is present on
some PMIC and it is missing on other's.

This is what we discussed regarding to twl6040. I only expose the audio block
and not the Linux implementation (that we have separate driver for vibra and
codec sub functionality).

>> +-ti,hs_extmute: Use external mute for HS pop reduction
>> +-ti,hs_extmute_gpio: Use external GPIO to control the external mute
>> +-ti,hs_extmute_disable_level: The desired level of the GPIO line when the
>> +			      external mute is disabled. valuse: 0 or 1
> 
> This doesn't seem like something that should be in the CODEC driver
> really, there's a general need for something which can unmute controls
> at the end of the power up sequence and mute before power down.  Also,
> if this is going to be part of the binding shouldn't we just omit the
> first property and simply check for the presence of the property which
> specifies the GPIO?

The hs_extmute is used for reducing pop noise on the headset. The sequence is
described in the TRM and it need to be done within the codec driver since it
is within the sequence.
Now there's two ways for boards to implement it:
using the dedicated pin from twl4030 PMIC (MUTE/GPIO6) - if only
"ti,hs_extmute" present we use this mode.
Some boards are using the GPIO6 from twl4030 for other purposes, in this case
an external GPIO is used for the same purpose - thus we have
ti,hs_extmute_gpio and ti,hs_extmute_disable_level to tell the driver this.
As for the ti,hs_extmute_disable_level: some boards chosen that the mute is
disabled when the signal is high on the GPIO (don't ask me why). This property
tells this.

All of this has to be in the driver due to the sequencing requirements.

> 
>> +#ifdef CONFIG_OF
>> +	if (of_find_node_by_name(node, "codec"))
>> +		return true;
>> +#endif
> 
> This really seems like we should be stubbing out of_find_node_by_name()
> to return false in non-OF cases.

Yes, most likely the of_find_node_by_name() deserves the same treatment as
some selected of_* function in case CONFIG_OF is not selected.
But at the moment this is not the case, we need to protect with ifdef since we
might break other randconfigs where CONFIG_OF is not set.

>> +#ifdef CONFIG_OF
>> +	if (!of_property_read_u32(node, "ti,enable-vibra", &vibra) && vibra)
>> +		return true;
>> +#endif
> 
> Similarly here.

Here the ifdef is no needed. of_property_read_u32() return -ENOSYS in case
CONFIG_OF is not selected.

-- 
P?ter
