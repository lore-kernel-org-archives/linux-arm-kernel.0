From: charu@ti.com (Varadarajan, Charulatha)
Date: Thu, 25 Nov 2010 14:01:35 +0530
Subject: [PATCH v7 05/11] OMAP2420: hwmod data: Add GPIO
In-Reply-To: <4CEE1807.9040404@ti.com>
References: <1290524213-395-1-git-send-email-charu@ti.com>
	<1290524213-395-6-git-send-email-charu@ti.com>
	<4CED8DF7.6040606@ti.com>
	<AANLkTimRK=eKBG3pqGN8Ota5EO8EdmEibQN5C3Lwfheq@mail.gmail.com>
	<4CEE1807.9040404@ti.com>
Message-ID: <AANLkTik1p0gqe6s8t-q0koehWBhc6nceU9=T74k3iw9_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 25, 2010 at 13:32, Cousson, Benoit <b-cousson@ti.com> wrote:
> On 11/25/2010 5:36 AM, Varadarajan, Charulatha wrote:
>>
>> Benoit,
>>
>> On Thu, Nov 25, 2010 at 03:43, Cousson, Benoit<b-cousson@ti.com> ?wrote:
>>>
>>> On 11/23/2010 3:56 PM, Varadarajan, Charulatha wrote:
>>>>
>>>> Add GPIO hwmod data for OMAP2420
>>>>
>>>> Signed-off-by: Charulatha V<charu@ti.com>
>>>> ---
>>>> ?arch/arm/mach-omap2/omap_hwmod_2420_data.c | ?229
>>>> ++++++++++++++++++++++++++++
>>>> ?arch/arm/plat-omap/include/plat/gpio.h ? ? | ? ?5 +
>>>> ?2 files changed, 234 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
>>>> b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
>>>> index a1a3dd6..c951061 100644
>>>> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
>>>> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
>>>> @@ -17,6 +17,7 @@
>>>> ?#include<plat/dma.h>
>>>> ?#include<plat/serial.h>
>>>> ?#include<plat/i2c.h>
>>>> +#include<plat/gpio.h>
>>>> ?#include<plat/omap24xx.h>
>>>
>>> Do you still need that header file?
>>
>> Yes, for the gpio_dev_attr
>
> I'm still confused, gpio_dev_attr just contains an int and a bool:

I am talking about gpio.h file which is required for using
omap_gpio_dev_attr. If you are pointing out omap24xx.h file,
I am not sure. It was in the original code.

>
> +static struct omap_gpio_dev_attr gpio_dev_attr = {
> + ? ? ? .bank_width = 32,
> + ? ? ? .dbck_flag = false,
> +};
>
>>
>>>
>>>>
>>>> ?#include "omap_hwmod_common_data.h"
>>>> @@ -38,6 +39,10 @@ static struct omap_hwmod omap2420_iva_hwmod;
>>>> ?static struct omap_hwmod omap2420_l3_main_hwmod;
>>>> ?static struct omap_hwmod omap2420_l4_core_hwmod;
>>>> ?static struct omap_hwmod omap2420_wd_timer2_hwmod;
>>>> +static struct omap_hwmod omap2420_gpio1_hwmod;
>>>> +static struct omap_hwmod omap2420_gpio2_hwmod;
>>>> +static struct omap_hwmod omap2420_gpio3_hwmod;
>>>> +static struct omap_hwmod omap2420_gpio4_hwmod;
>>>>
>>>> ?/* L3 -> ? ?L4_CORE interface */
>>>> ?static struct omap_hwmod_ocp_if omap2420_l3_main__l4_core = {
>>>> @@ -557,6 +562,224 @@ static struct omap_hwmod omap2420_i2c2_hwmod = {
>>>> ? ? ? ?.flags ? ? ? ? ?= HWMOD_16BIT_REG,
>>>> ?};
>>>>
>>>> +/* l4_wkup -> ? ?gpio1 */
>>>> +static struct omap_hwmod_addr_space omap2420_gpio1_addr_space[] = {
>>>> + ? ? ? {
>>>> + ? ? ? ? ? ? ? .pa_start ? ? ? = 0x48018000,
>>>> + ? ? ? ? ? ? ? .pa_end ? ? ? ? = 0x480181ff,
>>>> + ? ? ? ? ? ? ? .flags ? ? ? ? ?= ADDR_TYPE_RT
>>>> + ? ? ? },
>>>> +};
>>>> +
>>>> +static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio1 = {
>>>> + ? ? ? .master ? ? ? ? =&omap2420_l4_wkup_hwmod,
>>>> + ? ? ? .slave ? ? ? ? ?=&omap2420_gpio1_hwmod,
>>>> + ? ? ? .clk ? ? ? ? ? ?= "gpios_ick",
>>>> + ? ? ? .addr ? ? ? ? ? = omap2420_gpio1_addr_space,
>>>> + ? ? ? .addr_cnt ? ? ? = ARRAY_SIZE(omap2420_gpio1_addr_space),
>>>> + ? ? ? .user ? ? ? ? ? = OCP_USER_MPU | OCP_USER_SDMA,
>>>> +};
>>>> +
>>>> +/* l4_wkup -> ? ?gpio2 */
>>>> +static struct omap_hwmod_addr_space omap2420_gpio2_addr_space[] = {
>>>> + ? ? ? {
>>>> + ? ? ? ? ? ? ? .pa_start ? ? ? = 0x4801a000,
>>>> + ? ? ? ? ? ? ? .pa_end ? ? ? ? = 0x4801a1ff,
>>>> + ? ? ? ? ? ? ? .flags ? ? ? ? ?= ADDR_TYPE_RT
>>>> + ? ? ? },
>>>> +};
>>>> +
>>>> +static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio2 = {
>>>> + ? ? ? .master ? ? ? ? =&omap2420_l4_wkup_hwmod,
>>>> + ? ? ? .slave ? ? ? ? ?=&omap2420_gpio2_hwmod,
>>>> + ? ? ? .clk ? ? ? ? ? ?= "gpios_ick",
>>>> + ? ? ? .addr ? ? ? ? ? = omap2420_gpio2_addr_space,
>>>> + ? ? ? .addr_cnt ? ? ? = ARRAY_SIZE(omap2420_gpio2_addr_space),
>>>> + ? ? ? .user ? ? ? ? ? = OCP_USER_MPU | OCP_USER_SDMA,
>>>> +};
>>>> +
>>>> +/* l4_wkup -> ? ?gpio3 */
>>>> +static struct omap_hwmod_addr_space omap2420_gpio3_addr_space[] = {
>>>> + ? ? ? {
>>>> + ? ? ? ? ? ? ? .pa_start ? ? ? = 0x4801c000,
>>>> + ? ? ? ? ? ? ? .pa_end ? ? ? ? = 0x4801c1ff,
>>>> + ? ? ? ? ? ? ? .flags ? ? ? ? ?= ADDR_TYPE_RT
>>>> + ? ? ? },
>>>> +};
>>>> +
>>>> +static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio3 = {
>>>> + ? ? ? .master ? ? ? ? =&omap2420_l4_wkup_hwmod,
>>>> + ? ? ? .slave ? ? ? ? ?=&omap2420_gpio3_hwmod,
>>>> + ? ? ? .clk ? ? ? ? ? ?= "gpios_ick",
>>>> + ? ? ? .addr ? ? ? ? ? = omap2420_gpio3_addr_space,
>>>> + ? ? ? .addr_cnt ? ? ? = ARRAY_SIZE(omap2420_gpio3_addr_space),
>>>> + ? ? ? .user ? ? ? ? ? = OCP_USER_MPU | OCP_USER_SDMA,
>>>> +};
>>>> +
>>>> +/* l4_wkup -> ? ?gpio4 */
>>>> +static struct omap_hwmod_addr_space omap2420_gpio4_addr_space[] = {
>>>> + ? ? ? {
>>>> + ? ? ? ? ? ? ? .pa_start ? ? ? = 0x4801e000,
>>>> + ? ? ? ? ? ? ? .pa_end ? ? ? ? = 0x4801e1ff,
>>>> + ? ? ? ? ? ? ? .flags ? ? ? ? ?= ADDR_TYPE_RT
>>>> + ? ? ? },
>>>> +};
>>>> +
>>>> +static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio4 = {
>>>> + ? ? ? .master ? ? ? ? =&omap2420_l4_wkup_hwmod,
>>>> + ? ? ? .slave ? ? ? ? ?=&omap2420_gpio4_hwmod,
>>>> + ? ? ? .clk ? ? ? ? ? ?= "gpios_ick",
>>>> + ? ? ? .addr ? ? ? ? ? = omap2420_gpio4_addr_space,
>>>> + ? ? ? .addr_cnt ? ? ? = ARRAY_SIZE(omap2420_gpio4_addr_space),
>>>> + ? ? ? .user ? ? ? ? ? = OCP_USER_MPU | OCP_USER_SDMA,
>>>> +};
>>>> +
>>>> +/* gpio dev_attr */
>>>> +static struct omap_gpio_dev_attr gpio_dev_attr = {
>>>> + ? ? ? .bank_width = 32,
>>>> + ? ? ? .dbck_flag = false,
>>>> +};
>>>> +
>>
>> <<snip>>
>>
>>>> ?};
>>>>
>>>> diff --git a/arch/arm/plat-omap/include/plat/gpio.h
>>>> b/arch/arm/plat-omap/include/plat/gpio.h
>>>
>>> That change should not necessarily be there, it is not directly related
>>> to
>>> the subject.
>>>
>>> Maybe that should be in an extra patch just before that one.
>>
>> I merged these two patches because of a comment to introduce
>> new variables/structures only in the patch where they are used.
>> Since "omap_gpio_dev_attr" is being used by hwmod DB I merged
>> these two patches. Do you think that hwmod DB patches should not
>> be merged with other patches?
>>
> Not necessarily, maybe you can just update the changelog and the subject
> to indicate that you add a new structure as well in this patch.

Okay. I will do that.

>>>
>>> Beside these 2 minor comments, that patch seems good to me.
>>>
>>> Almost-acked-by: Benoit Cousson<b-cousson@ti.com>
>>
>> Thanks.
>>
>>>
>>> Regards,
>>> Benoit
>>>
>>>> index 5bef86d..24892a6 100644
>>>> --- a/arch/arm/plat-omap/include/plat/gpio.h
>>>> +++ b/arch/arm/plat-omap/include/plat/gpio.h
>>>> @@ -79,6 +79,11 @@
>>>> ?#define METHOD_GPIO_24XX ? ? ?5
>>>> ?#define METHOD_GPIO_44XX ? ? ?6
>>>>
>>>> +struct omap_gpio_dev_attr {
>>>> + ? ? ? int bank_width; ? ? ? ? /* GPIO bank width */
>>>> + ? ? ? bool dbck_flag; ? ? ? ? /* dbck required or not - True for
>>>> OMAP3&4
>>>> */
>>>> +};
>>>> +
>>>> ?struct omap_gpio_platform_data {
>>>> ? ? ? ?u16 virtual_irq_start;
>>>> ? ? ? ?int bank_type;
>>>
>>>
>
>
