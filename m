From: hs@denx.de (Heiko Schocher)
Date: Thu, 08 Dec 2011 08:47:05 +0100
Subject: [PATCH] arm,
 davinci: configure davinci aemif chipselects through OF
In-Reply-To: <DF0F476B391FA8409C78302C7BA518B603EFB2@DBDE01.ent.ti.com>
References: <1322991679-20947-1-git-send-email-hs@denx.de>
 <DF0F476B391FA8409C78302C7BA518B603EFB2@DBDE01.ent.ti.com>
Message-ID: <4EE06B79.7070804@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Nori,

Nori, Sekhar wrote:
> Hi Heiko,
> 
> On Sun, Dec 04, 2011 at 15:11:19, Heiko Schocher wrote:
> 
> Please provide a patch description. Nice to see device tree
> support being added for DaVinci devices.

fixed.

>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> Cc: davinci-linux-open-source at linux.davincidsp.com
>> Cc: devicetree-discuss at lists.ozlabs.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: grant.likely at secretlab.ca
>> Cc: Sekhar Nori <nsekhar@ti.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>> Cc: Wolfgang Denk <wd@denx.de>
>> ---
>>  .../devicetree/bindings/arm/davinci/aemif.txt      |   85 ++++++++++++++++
>>  arch/arm/mach-davinci/aemif.c                      |  105 +++++++++++++++++++-
>>  arch/arm/mach-davinci/include/mach/aemif.h         |    1 +
>>  3 files changed, 190 insertions(+), 1 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/davinci/aemif.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/davinci/aemif.txt b/Documentation/devicetree/bindings/arm/davinci/aemif.txt
>> new file mode 100644
>> index 0000000..c9ed551
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/davinci/aemif.txt
>> @@ -0,0 +1,85 @@
>> +* Texas Instruments Davinci AEMIF
>> +
>> +This file provides information, what the device node for the
>> +davinci aemifa interface contain.
>            ^^^^^^
>            aemif

fixed, thanks.

>> +
>> +Required properties:
>> +- compatible: "ti,davinci-emifa";

Shouldn't this also be "ti,davinci-aemif" ?

[...]
>> diff --git a/arch/arm/mach-davinci/aemif.c b/arch/arm/mach-davinci/aemif.c
>> index 1ce70a9..12c559f 100644
>> --- a/arch/arm/mach-davinci/aemif.c
>> +++ b/arch/arm/mach-davinci/aemif.c
>> @@ -13,12 +13,14 @@
>>  #include <linux/err.h>
>>  #include <linux/clk.h>
>>  #include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>>  #include <linux/time.h>
>>  
>>  #include <mach/aemif.h>
>>  
>>  /* Timing value configuration */
>> -
>> +#define ASIZE(x)	(x)
>>  #define TA(x)		((x) << 2)
>>  #define RHOLD(x)	((x) << 4)
>>  #define RSTROBE(x)	((x) << 7)
>> @@ -26,7 +28,10 @@
>>  #define WHOLD(x)	((x) << 17)
>>  #define WSTROBE(x)	((x) << 20)
>>  #define WSETUP(x)	((x) << 26)
>> +#define EW(x)		((x) << 30)
>> +#define SS(x)		((x) << 31)
> 
> You are adding support for additional configuration
> parameters which should be done in a separate patch.

Hmm.. they are only used in the OF case ... is this split
really needed?

[...]
>> +static int davinci_aemif_setup_timing_of_one(struct device_node *np,
>> +		void __iomem *base)
>> +{
[...]
>> +	val = ASIZE(asize) | TA(ta) | RHOLD(rhold) | RSTROBE(rstrobe) |
>> +		RSETUP(rsetup) | WHOLD(whold) | WSTROBE(wstrobe) |
>> +		WSETUP(wsetup) | EW(ew) | SS(ss);
>> +
>> +	__raw_writel(val, base + offset);
>> +
>> +	return 0;
>> +}
> 
> This shares a large amount of code with davinci_aemif_setup_timing().
> Can you try writing this as a OF wrapper to the existing function?

Done.

Waiting to your response to my 2 questions above, after that sending
the v2.

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
