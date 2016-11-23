From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 22 Nov 2016 21:38:58 -0800
Subject: [PATCH 1/4] ARM: davinci: da8xx: VPIF: enable DT init
In-Reply-To: <31948202-333f-b465-07b8-6260cce29b59@lechnology.com> (David
 Lechner's message of "Tue, 22 Nov 2016 14:06:07 -0600")
References: <20161122194551.3420-1-khilman@baylibre.com>
 <20161122194551.3420-2-khilman@baylibre.com>
 <31948202-333f-b465-07b8-6260cce29b59@lechnology.com>
Message-ID: <7hlgwaiwlp.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Lechner <david@lechnology.com> writes:

> On 11/22/2016 01:45 PM, Kevin Hilman wrote:
>> Add basic support for DT initializaion of VPIF (capture) via DT.  Clocks
>> and mux still need to happen in this file until there are real clock and
>> pinctrl drivers, but the video nodes and subdevs can all come from DT.
>>
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> ---
>>  arch/arm/mach-davinci/da8xx-dt.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
>> index c9f7e9274aa8..7b41611f2665 100644
>> --- a/arch/arm/mach-davinci/da8xx-dt.c
>> +++ b/arch/arm/mach-davinci/da8xx-dt.c
>> @@ -17,6 +17,7 @@
>>  #include <mach/common.h>
>>  #include "cp_intc.h"
>>  #include <mach/da8xx.h>
>> +#include <mach/mux.h>
>>
>>  static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
>>  	OF_DEV_AUXDATA("ti,davinci-i2c", 0x01c22000, "i2c_davinci.1", NULL),
>> @@ -38,14 +39,30 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
>>  		       NULL),
>>  	OF_DEV_AUXDATA("ti,da830-mcasp-audio", 0x01d00000, "davinci-mcasp.0", NULL),
>>  	OF_DEV_AUXDATA("ti,da850-aemif", 0x68000000, "ti-aemif", NULL),
>> +	OF_DEV_AUXDATA("ti,da850-vpif", 0x01e17000, "vpif", NULL),
>>  	{}
>>  };
>>
>>  #ifdef CONFIG_ARCH_DAVINCI_DA850
>>
>> +#if IS_ENABLED(CONFIG_VIDEO_DAVINCI_VPIF_CAPTURE)
>> +static __init void da850_vpif_capture_init(void)
>> +{
>> +	int ret;
>> +
>> +	ret = davinci_cfg_reg_list(da850_vpif_capture_pins);
>
> Why can't we use the existing pinctrl-single node in device tree for
> muxing the pins?

Oops, you're right.  They can.

Kevin
