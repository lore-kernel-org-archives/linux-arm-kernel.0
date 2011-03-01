From: javier.martin@vista-silicon.com (javier Martin)
Date: Tue, 1 Mar 2011 15:36:13 +0100
Subject: [PATCH v2 1/4] ASoC: Add TI tlv320aic32x4 codec support.
In-Reply-To: <20110301142231.GH9662@opensource.wolfsonmicro.com>
References: <1298988128-11520-1-git-send-email-javier.martin@vista-silicon.com>
	<1298988128-11520-2-git-send-email-javier.martin@vista-silicon.com>
	<20110301142231.GH9662@opensource.wolfsonmicro.com>
Message-ID: <AANLkTinSqVuuiif33yd1zZBTzeb4mvvLpDd4+=RPiHHM@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you for your fast response.

On 1 March 2011 15:22, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Mar 01, 2011 at 03:02:05PM +0100, Javier Martin wrote:
>
>> + ? ? SOC_DOUBLE_R_TLV("ADC Level Volume", AIC32X4_LADCVOL,
>> + ? ? ? ? ? ? ? ? ? ? AIC32X4_RADCVOL, 0, 0x28, 0, tlv_step_0_5),
>> + ? ? SOC_DOUBLE_R_TLV("PGA Gain Level Volume", AIC32X4_LMICPGAVOL,
>> + ? ? ? ? ? ? ? ? ? ? AIC32X4_RMICPGAVOL, 0, 0x5f, 0, tlv_step_0_5),
>
> I suspect you don't want to have Gain and Level in there.
>
>> + ? ? SOC_SINGLE("AGC Left Enable Switch", AIC32X4_LAGC1, 7, 1, 0),
>> + ? ? SOC_SINGLE("AGC Right Enable Switch", AIC32X4_RAGC1, 7, 1, 0),
>
> A switch is obviously an enable.
>

Yes, let me fix that in a following version.

>> +static const struct aic32x4_configs aic32x4_reg_init[] = {
>
> As I said in reply to your previous posting this looks like it shouldn't
> be here. ?A few things jump out as suspicious but not everything you're
> doing is clear:
>
>> + ? ? {AIC32X4_LDOCTL, AIC32X4_LDOCTLEN},
>
> This looks like it should be dynamically managed at runtime, either via
> DAPM or in the bias level functions.
>
>> + ? ? {AIC32X4_CMMODE, AIC32X4_LDOIN_18_36 | AIC32X4_LDOIN2HP},
>> + ? ? {AIC32X4_CLKMUX, AIC32X4_PLLCLKIN},
>> + ? ? {AIC32X4_IFACE3, AIC32X4_DACMOD2BCLK},
>> + ? ? {AIC32X4_DACSETUP,
>> + ? ? ?AIC32X4_LDAC2LCHN | AIC32X4_RDAC2RCHN | AIC32X4_SSTEP2WCLK},
>> + ? ? {AIC32X4_LMICPGANIN, AIC32X4_LMICPGANIN_IN2R_10K},
>> + ? ? {AIC32X4_RMICPGANIN, AIC32X4_RMICPGANIN_IN1L_10K},
>
> These look like platform configuration.
>
>> + ? ? {AIC32X4_LMICPGAVOL, 0x00},
>> + ? ? {AIC32X4_RMICPGAVOL, 0x00},
>
> These look like volume controls which should be exposed to users.
>
>> + ? ? /* Unmute ADC left and right channels */
>> + ? ? {AIC32X4_ADCFGA, 0x00},
>
> This looks like it should be user visible.
>
>> + ? ? /* MICBIAS = 2.075V(CM=0.75V) generated from LDOIN */
>> + ? ? {AIC32X4_MICBIAS, 0x68},
>
> This should be configured by the platform.
>

Ok, let me organize all this stuff for better understanding. By the
way, when you said it should be configured by platform are you
referring to machine driver or to board specific code? Can you please
point me to a codec driver which uses a similar approach?

Thank you.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
