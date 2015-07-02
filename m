From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 2 Jul 2015 15:52:49 +0300
Subject: [PATCH 2/2] ARM: DTS: am437x-sk-evm: Switch using
 simple-audio-card for audio support
In-Reply-To: <20150702122337.GE5837@saruman.tx.rr.com>
References: <1435838286-30491-1-git-send-email-peter.ujfalusi@ti.com>
 <1435838286-30491-3-git-send-email-peter.ujfalusi@ti.com>
 <20150702122337.GE5837@saruman.tx.rr.com>
Message-ID: <55953421.30009@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/2015 03:23 PM, Felipe Balbi wrote:
> On Thu, Jul 02, 2015 at 02:58:06PM +0300, Peter Ujfalusi wrote:
>> The sound support consist only Headset output on the board and can be
>> handled by "simple-audio-card"
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Still works fine:
> 
> Tested-by: Felipe Balbi <balbi@ti.com>
> 
> one question though, should Line In be listed below ?

Does the board have Line-in? I don't have the board, but I know this patch
works on it ;)
We only had playback path before also.

> Also, unrelated to
> $subject, but if I wait for a few seconds between runs of speaker-test
> (iow, if I allow mcasp to idle) then I hear a slight chopping sound when
> starting, perhaps we're unmuting too early ?

Is it only with this patch (via simple-card) or was it the same via the
davinci-evm (ti,da830-evm-audio)?

-- 
P?ter

> 
>> ---
>>  arch/arm/boot/dts/am437x-sk-evm.dts | 30 ++++++++++++++++++++++--------
>>  1 file changed, 22 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
>> index b5de6b0d622c..e09216cb14df 100644
>> --- a/arch/arm/boot/dts/am437x-sk-evm.dts
>> +++ b/arch/arm/boot/dts/am437x-sk-evm.dts
>> @@ -32,14 +32,26 @@
>>  	};
>>  
>>  	sound {
>> -		compatible = "ti,da830-evm-audio";
>> -		ti,model = "AM437x-SK-EVM";
>> -		ti,audio-codec = <&tlv320aic3106>;
>> -		ti,mcasp-controller = <&mcasp1>;
>> -		ti,codec-clock-rate = <24000000>;
>> -		ti,audio-routing =
>> -			"Headphone Jack",       "HPLOUT",
>> -			"Headphone Jack",       "HPROUT";
>> +		compatible = "simple-audio-card";
>> +		simple-audio-card,name = "AM437x-SK-EVM";
>> +		simple-audio-card,widgets =
>> +			"Headphone", "Headphone Jack";
>> +		simple-audio-card,routing =
>> +			"Headphone Jack",	"HPLOUT",
>> +			"Headphone Jack",	"HPROUT";
>> +		simple-audio-card,format = "dsp_b";
>> +		simple-audio-card,bitclock-master = <&sound_master>;
>> +		simple-audio-card,frame-master = <&sound_master>;
>> +		simple-audio-card,bitclock-inversion;
>> +
>> +		simple-audio-card,cpu {
>> +			sound-dai = <&mcasp1>;
>> +		};
>> +
>> +		sound_master: simple-audio-card,codec {
>> +			sound-dai = <&tlv320aic3106>;
>> +			system-clock-frequency = <24000000>;
>> +		};
>>  	};
>>  
>>  	matrix_keypad: matrix_keypad at 0 {
>> @@ -489,6 +501,7 @@
>>  	};
>>  
>>  	tlv320aic3106: tlv320aic3106 at 1b {
>> +		#sound-dai-cells = <0>;
>>  		compatible = "ti,tlv320aic3106";
>>  		reg = <0x1b>;
>>  		status = "okay";
>> @@ -649,6 +662,7 @@
>>  };
>>  
>>  &mcasp1 {
>> +	#sound-dai-cells = <0>;
>>  	pinctrl-names = "default", "sleep";
>>  	pinctrl-0 = <&mcasp1_pins>;
>>  	pinctrl-1 = <&mcasp1_pins_sleep>;
>> -- 
>> 2.4.5
>>
> 
