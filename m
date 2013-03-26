From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 26 Mar 2013 21:14:33 +0100
Subject: [PATCH 1/2] ARM: kirkwood: fix a not initialized variable in
 the sound subsystem
In-Reply-To: <20130326210512.6c9c8990@armhf>
References: <20130326190513.1671a3be@armhf> <5151F9F4.2040005@gmail.com>
 <20130326210512.6c9c8990@armhf>
Message-ID: <515201A9.5030003@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2013 09:05 PM, Jean-Francois Moine wrote:
> On Tue, 26 Mar 2013 20:41:40 +0100
> Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>  wrote:
>
>> On 03/26/2013 07:05 PM, Jean-Francois Moine wrote:
>>> In the function kirkwood_set_rate, in case of a non dco supported rate
>>> and no external clock, the clock source was set to an undefined value.
>>> This patch just displays a message without changing the clock source.
>>>
>>> Signed-off-by: Jean-Francois Moine<moinejf@free.fr>
>>> ---
>>>    sound/soc/kirkwood/kirkwood-i2s.c |    3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
>>> index c74c890..afca1ec 100644
>>> --- a/sound/soc/kirkwood/kirkwood-i2s.c
>>> +++ b/sound/soc/kirkwood/kirkwood-i2s.c
>>> @@ -118,6 +118,9 @@ static void kirkwood_set_rate(struct snd_soc_dai *dai,
>>>    		clk_set_rate(priv->extclk, 256 * rate);
>>>
>>>    		clks_ctrl = KIRKWOOD_MCLK_SOURCE_EXTCLK;
>>> +	} else {
>>> +		dev_err(dai->dev, "%s: no clock\n", __func__);
>>> +		return;
>>>    	}
>>>    	writel(clks_ctrl, priv->io + KIRKWOOD_CLOCKS_CTRL);
>>>    }
>>
>> NACK.
>>
>> Having no clock at all should be catched during _probe. Moreover,
>> not having the internal clock enabled will lead to system hang due to
>> clock gating. You should rather pass an optional (DT-only) extclk phandle
>> on the second clocks property.
>>
>> Sebastian
>>
>> P.S. as this is alsa stuff you should have some alsa maintainers on your
>> Cc list. Please run ./scripts/get_maintainer.pl on your patches next time.
>> It will give you a list of people you have to to Cc.
>
> It is a compilation error: the variable clks_ctrl is not initialized.

If it is about non-initialized clks_ctrl, I suggest to remove it
completely and clone the writel to both if and else branch.

> The sequence has been created by the commit 363589bf110aa0352a2031
>     "ASoC: kirkwood-i2s: add support for external clock rates"
> Russell is in the Cc list.

Russell was the commit author and also should be added because of his
ARM maintainer status. But kirkwood-i2s is alsa and needs some sound
maintainers to be Cc'd:

$ ./scripts/get_maintainer.pl -f sound/soc/kirkwood/kirkwood-i2s.c
Liam Girdwood <lgirdwood@gmail.com> (supporter:SOUND - SOC LAYER...)
Mark Brown <broonie@opensource.wolfsonmicro.com> (supporter:SOUND - SOC 
LAYER...,commit_signer:9/11=82%)
Jaroslav Kysela <perex@perex.cz> (maintainer:SOUND)
Takashi Iwai <tiwai@suse.de> (maintainer:SOUND)
Russell King <rmk+kernel@arm.linux.org.uk> (commit_signer:6/11=55%)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (commit_signer:2/11=18%)
Andrew Lumm <andrew@lunn.ch> (commit_signer:2/11=18%)
Thierry Reding <thierry.reding@avionic-design.de> (commit_signer:1/11=9%)
alsa-devel at alsa-project.org (moderated list:SOUND - SOC LAYER...)
linux-kernel at vger.kernel.org (open list)

Sebastian
