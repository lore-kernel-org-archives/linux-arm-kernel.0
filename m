From: richard.zhu@linaro.org (Richard Zhu)
Date: Mon, 29 Aug 2011 17:16:54 +0800
Subject: [PATCH V6 3/5] MX53 Enable the AHCI SATA on MX53 ARD board
In-Reply-To: <CAMPhdO944uQtpBfq12h1yHeXNzkTFiscPfZ6PbuMy6g2u0SDOw@mail.gmail.com>
References: <1314602339-18392-1-git-send-email-richard.zhu@linaro.org>
	<1314602339-18392-3-git-send-email-richard.zhu@linaro.org>
	<CAMPhdO944uQtpBfq12h1yHeXNzkTFiscPfZ6PbuMy6g2u0SDOw@mail.gmail.com>
Message-ID: <CAJNCFVJySmnVXahb0PGBwmLQQwwqB55_rR4mdhyJ6q5nCTGqJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric:
I agree with your suggestion.
One more exception about ahci on imx53 smd board.
one sata_pwr_en is used to control the pwr supply on smd board.
It's better to enable this pwer_en obviously although that this pin is
enabled reserved.

the ahci driver use the default sata platform data on ard and loco boards, and
 the smd platform data on smd board refer to the sata_pwr_en usage.

Best Regards
Richard Zhu

On 29 August 2011 16:47, Eric Miao <eric.miao@linaro.org> wrote:
> On Mon, Aug 29, 2011 at 3:18 PM, Richard Zhu <richard.zhu@linaro.org> wrote:
>> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
>> ---
>> ?arch/arm/mach-mx5/board-mx53_ard.c | ? ?7 +++++++
>> ?1 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-mx5/board-mx53_ard.c
>> index 76a67c4..d265cee 100644
>> --- a/arch/arm/mach-mx5/board-mx53_ard.c
>> +++ b/arch/arm/mach-mx5/board-mx53_ard.c
>> @@ -27,6 +27,7 @@
>> ?#include <mach/common.h>
>> ?#include <mach/hardware.h>
>> ?#include <mach/iomux-mx53.h>
>> +#include <mach/ahci_sata.h>
>>
>> ?#include <asm/mach-types.h>
>> ?#include <asm/mach/arch.h>
>> @@ -220,6 +221,11 @@ static struct platform_device *devices[] __initdata = {
>> ? ? ? ?&ard_smsc_lan9220_device,
>> ?};
>>
>> +static struct ahci_platform_data sata_data = {
>> + ? ? ? .init = sata_init,
>> + ? ? ? .exit = sata_exit,
>> +};
>> +
>
> As this platform data is same across most of these boards, I'd suggest we
> keep a common/default platform_data in
>
> arch/arm/plat-mxc/devices/platform-imx-ahci.c
>
> And pass NULL in these board files, making use of the above default one.
> For those boards with exceptions (e.g. special operations like GPIO to
> enable/disable something at init/exit), one can still have platform data
> and pass the pointer.
>
>> ?static void __init mx53_ard_board_init(void)
>> ?{
>> ? ? ? ?imx53_soc_init();
>> @@ -234,6 +240,7 @@ static void __init mx53_ard_board_init(void)
>> ? ? ? ?imx53_add_imx_i2c(1, &mx53_ard_i2c2_data);
>> ? ? ? ?imx53_add_imx_i2c(2, &mx53_ard_i2c3_data);
>> ? ? ? ?imx_add_gpio_keys(&ard_button_data);
>> + ? ? ? imx53_add_ahci_imx(0, &sata_data);
>> ?}
>>
>> ?static void __init mx53_ard_timer_init(void)
>> --
>> 1.7.1
>>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
