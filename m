From: julian.calaby@gmail.com (Julian Calaby)
Date: Fri, 27 Jan 2017 19:46:12 +1100
Subject: [linux-sunxi] Re: [PATCH 1/2] nvmem: sunxi-sid: add support for
 H3 and A64's SID controller
In-Reply-To: <20170127081712.x2hprtpo2aolungc@lukather>
References: <20170126113345.33686-1-icenowy@aosc.xyz>
 <20170127081712.x2hprtpo2aolungc@lukather>
Message-ID: <CAGRGNgUNqBjz+p0Km8oqpkC_zYJ4z9zrQeXnx5y0UaqKuH7nvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Fri, Jan 27, 2017 at 7:17 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Thu, Jan 26, 2017 at 07:33:44PM +0800, Icenowy Zheng wrote:
>> H3 and A64 SoCs have a bigger SID controller, which has its direct read
>> address at 0x200 position in the SID block, not 0x0.
>>
>> Also, H3 SID controller has some silicon bug that makes the direct read
>> value wrong at first, add code to workaround the bug. (This bug has
>> already been fixed on A64 and later SoCs)
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>> ---
>>  .../bindings/nvmem/allwinner,sunxi-sid.txt         |  22 +++-
>>  drivers/nvmem/sunxi_sid.c                          | 112 +++++++++++++++++++--
>>  2 files changed, 123 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
>> index 1567ccca8de3..2e327a66a938 100644
>> --- a/drivers/nvmem/sunxi_sid.c
>> +++ b/drivers/nvmem/sunxi_sid.c
>> @@ -20,10 +20,28 @@
>>  #include <linux/module.h>
>>  #include <linux/nvmem-provider.h>
>>  #include <linux/of.h>
>> +#include <linux/of_device.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/slab.h>
>>  #include <linux/random.h>
>>
>> +/* Registers and special values for doing register-based SID readout on H3 */
>> +#define SUN8I_SID_PRCTL              0x40
>> +#define SUN8I_SID_RDKEY              0x60
>> +
>> +#define SUN8I_SID_OP_LOCK    0xAC
>> +#define SUN8I_SID_OFFSET_MASK        0x1FF
>> +#define SUN8I_SID_OFFSET_SHIFT       16
>> +#define SUN8I_SID_LOCK_SHIFT 8
>> +#define SUN8I_SID_READ               BIT(1)
>> +
>> +/*
>> + * For newer SoCs with a larger eFUSE, the bytes beyond the first 16 bytes are
>> + * sparse, which makes it not suitable for adding randomness; legacy SoCs' SID
>> + * have only 16 bytes, so we choose to use at most 16 bytes to add randomness.
>> + */
>> +#define SUNXI_SID_MAX_RANDOMNESS_SIZE        16
>> +
>>  static struct nvmem_config econfig = {
>>       .name = "sunxi-sid",
>>       .read_only = true,
>> @@ -91,16 +167,17 @@ static int sunxi_sid_probe(struct platform_device *pdev)
>>       if (IS_ERR(nvmem))
>>               return PTR_ERR(nvmem);
>>
>> -     randomness = kzalloc(sizeof(u8) * (size), GFP_KERNEL);
>> +     randomness_size = max(size, SUNXI_SID_MAX_RANDOMNESS_SIZE);
>> +     randomness = kzalloc(sizeof(u8) * (randomness_size), GFP_KERNEL);
>
> Why is that change needed?

According to the definition of SUNXI_SID_MAX_RANDOMNESS_SIZE, only the
first 16 bytes of the SID data region are sufficiently non-zero to be
used for randomness.

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
