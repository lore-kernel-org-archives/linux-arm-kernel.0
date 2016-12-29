From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 29 Dec 2016 19:33:53 +0900
Subject: [PATCH 1/4] pinctrl: dt-bindings: samsung: add drive strength
 macros for Exynos5433
In-Reply-To: <37b86cdb-b5e9-a5fa-fbb1-46e8d8c90cd8@samsung.com>
References: <20161229084211.20442-1-andi.shyti@samsung.com>
 <CGME20161229084221epcas5p43926b87dccbee0db4045faa5ddca565d@epcas5p4.samsung.com>
 <20161229084211.20442-2-andi.shyti@samsung.com>
 <37b86cdb-b5e9-a5fa-fbb1-46e8d8c90cd8@samsung.com>
Message-ID: <6bf77b57-c2a4-2dff-9763-1cd1bfa23b9d@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andi,

On 2016? 12? 29? 18:17, Chanwoo Choi wrote:
> Hi Andi,
> 
> On 2016? 12? 29? 17:42, Andi Shyti wrote:
>> Commit 5db7e3bb87df ("pinctrl: dt-bindings: samsung: Add header with
>> values used for configuration") has added a header file for defining the
>> pinctrl values in order to avoid hardcoded settings in the Exynos
>> DTS related files.
>>
>> Extend samsung.h to the Exynos5433 for drive strength values
>> which are strictly related to the particular SoC and may defer
>> from others.
>>
>> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
>> ---
>>  include/dt-bindings/pinctrl/samsung.h | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/include/dt-bindings/pinctrl/samsung.h b/include/dt-bindings/pinctrl/samsung.h
>> index 6276eb785e2b..58868313d64b 100644
>> --- a/include/dt-bindings/pinctrl/samsung.h
>> +++ b/include/dt-bindings/pinctrl/samsung.h
>> @@ -45,6 +45,12 @@
>>  #define EXYNOS5420_PIN_DRV_LV3		2
>>  #define EXYNOS5420_PIN_DRV_LV4		3
>>  
>> +/* Drive strengths for Exynos5433 */
>> +#define EXYNOS5433_PIN_DRV_LV1		0
>> +#define EXYNOS5433_PIN_DRV_LV2		1
>> +#define EXYNOS5433_PIN_DRV_LV3		2
>> +#define EXYNOS5433_PIN_DRV_LV4		3
> 
> Exynos5433 has the same value with EXYNOS5420. So, I'd like you to use the EXYNOS5420_PIN_DRV_LVx instead of separate the definitions.

I found the problem to handle the *_DRV register of Exynos5433. Because Exynos5433 has the different width length of *_DRV (PINCFG_TYPE_DRV) bitfields from Exynos542x as following. When I was sending the exynos5433 pinctrl patches, I was missing this issue.

Exynos5422/Exynos5410 have two different bitfields in the same register to set the DRV_LVx as following:
(n=0 to 7)
[2n+1:2n] : 2bits
 0x0 = 1x,
 0x1 = 2x,
 0x2 = 3x,
 0x3 = 4x,

[n+16:16]
 0x0 = Fast Slew Rate,
 0x1 = Slow Slew Rate,

But, Exynos5433 has the following value for PIN_DRV_LVx without additional bitfields to separate 'Fast Slew Rate' and 'Slow Slew Rate'. Just exynos5433 defines the 'Fast Slew Rate(0x0 ~ 0x5)' and 'Slow Slew Rate (0x8 ~ 0xF)'.
(n=0 to 7)
[4n+3:4n] : 4 bits
0x0 = Fast Slew Rate 1x
0x1 = Fast Slew Rate 2x
0x2 = Fast Slew Rate 3x
0x3 = Fast Slew Rate 4x
0x4 = Fast Slew Rate 5x
0x5 = Fast Slew Rate 6x
0x8 = Slow Slew Rate 1x
0x9 = Slow Slew Rate 2x
0xA = Slow Slew Rate 3x
0xB = Slow Slew Rate 4x
0xC = Slow Slew Rate 5x
0xF = Slow Slew Rate 6x

So, before this patch, we have to fix it to support the DRV reigster of Exynos5433.
I'll fix it.

> 
>> +
>>  #define EXYNOS_PIN_FUNC_INPUT		0
>>  #define EXYNOS_PIN_FUNC_OUTPUT		1
>>  #define EXYNOS_PIN_FUNC_2		2
>>
> 

-- 
Regards,
Chanwoo Choi
