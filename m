From: tommyhebb@gmail.com (Tom Hebb)
Date: Wed, 4 Jul 2018 17:14:24 -0400
Subject: [PATCH] ARM: dts: berlin: switch to earlycon
In-Reply-To: <20180704171435.6b6113de@xhacker.debian>
References: <7f67507ad697fc8c6d012f734c4d9a631d1afad1.1527608389.git.tommyhebb@gmail.com>
 <20180704171435.6b6113de@xhacker.debian>
Message-ID: <03049848-f627-41aa-0808-152c4f959ed8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng,

On 07/04/2018 05:14 AM, Jisheng Zhang wrote:
> Hi Thomas,
> 
> On Tue, 29 May 2018 11:41:42 -0400 Thomas Hebb wrote:
> 
>> The Synopsys DesignWare 8250 UART in Berlin SoCs is now supported by
>> 8250_early, so we can use earlycon for early console output instead
>> of earlyprintk, which requires an SoC-specific kernel.
> 
> IIRC, earlyprintk still works during the decompress progress while the
> earlycon doesn't.

Yes, I believe that's correct. My original rationale for this patch was
that earlycon is generally preferred over earlyprintk since it doesn't
require SoC-specific kernels, but now I'm not convinced that either of
the two parameters belongs in the dts file. As you point out,
earlyprintk can do things that earlycon cannot, and in the common case,
neither are needed.

Perhaps removing the bootargs property altogether is more correct. I'm
happy to send another patch to do that if you concur.

>>
>> Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
>> ---
>>  arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts        | 2 +-
>>  arch/arm/boot/dts/berlin2cd-google-chromecast.dts | 2 +-
>>  arch/arm/boot/dts/berlin2q-marvell-dmp.dts        | 2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts b/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
>> index 1c475796d17f..f98798bb684f 100644
>> --- a/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
>> +++ b/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
>> @@ -45,7 +45,7 @@
>>  	compatible = "sony,nsz-gs7", "marvell,berlin2", "marvell,berlin";
>>  
>>  	chosen {
>> -		bootargs = "earlyprintk";
>> +		bootargs = "earlycon";
> 
> Is there something missing here? example, uart8250,mmio,<addr>?

No explicit MMIO info is needed for earlycon on DT systems where an
stdout-path property is present. I've tested the patch as-is and the
early output works fine.

>>  		stdout-path = "serial0:115200n8";
>>  	};
>>  
>> diff --git a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
>> index ca24def0ce13..20f31cdeaf38 100644
>> --- a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
>> +++ b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
>> @@ -46,7 +46,7 @@
>>  	compatible = "google,chromecast", "marvell,berlin2cd", "marvell,berlin";
>>  
>>  	chosen {
>> -		bootargs = "earlyprintk";
>> +		bootargs = "earlycon";
>>  		stdout-path = "serial0:115200n8";
>>  	};
>>  
>> diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
>> index 57aa5f8a7c77..9834e84a0797 100644
>> --- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
>> +++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
>> @@ -49,7 +49,7 @@
>>  	};
>>  
>>  	chosen {
>> -		bootargs = "earlyprintk";
>> +		bootargs = "earlycon";
>>  		stdout-path = "serial0:115200n8";
>>  	};
>>  
>
