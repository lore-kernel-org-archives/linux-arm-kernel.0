From: javier.martin@vista-silicon.com (javier Martin)
Date: Tue, 3 Apr 2012 11:39:22 +0200
Subject: [PATCH] Use arm_memblock_steal
In-Reply-To: <20120403085623.GH3852@pengutronix.de>
References: <20120403081720.GP24211@n2100.arm.linux.org.uk>
 <20120403085623.GH3852@pengutronix.de>
Message-ID: <CACKLOr3o1FW7kB99eaFSb4ZZRnPUjtGY2Nu96YN2AkR0nvQHEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 April 2012 10:56, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Tue, Apr 03, 2012 at 09:17:21AM +0100, Russell King - ARM Linux wrote:
>> Use the provided function rather than re-coding this bit of code.
>> This also gets us protection against using these functions from
>> invalid contexts.
>>
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> ---
>> Please test this; I've not even compile tested this. ?Thanks.
>
> It compiles, so from my pov:
>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
>
> However, I don't have the hardware to test it, so I hope Javier follows
> up on this.
>
> Sascha
>
>>
>> ?arch/arm/mach-imx/mach-imx27_visstrim_m10.c | ? ?6 ++----
>> ?1 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
>> index f7b074f..c27058e 100644
>> --- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
>> +++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
>> @@ -32,12 +32,12 @@
>> ?#include <linux/delay.h>
>> ?#include <linux/dma-mapping.h>
>> ?#include <linux/leds.h>
>> -#include <linux/memblock.h>
>> ?#include <media/soc_camera.h>
>> ?#include <sound/tlv320aic32x4.h>
>> ?#include <asm/mach-types.h>
>> ?#include <asm/mach/arch.h>
>> ?#include <asm/mach/time.h>
>> +#include <asm/memblock.h>
>> ?#include <mach/common.h>
>> ?#include <mach/iomux-mx27.h>
>>
>> @@ -193,10 +193,8 @@ static void __init visstrim_camera_init(void)
>> ?static void __init visstrim_reserve(void)
>> ?{
>> ? ? ? /* reserve 4 MiB for mx2-camera */
>> - ? ? mx2_camera_base = memblock_alloc(MX2_CAMERA_BUF_SIZE,
>> + ? ? mx2_camera_base = arm_memblock_steal(MX2_CAMERA_BUF_SIZE,
>> ? ? ? ? ? ? ? ? ? ? ? MX2_CAMERA_BUF_SIZE);
>> - ? ? memblock_free(mx2_camera_base, MX2_CAMERA_BUF_SIZE);
>> - ? ? memblock_remove(mx2_camera_base, MX2_CAMERA_BUF_SIZE);
>> ?}
>>
>> ?/* GPIOs used as events for applications */
>>
>>
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 ? ?|
> Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? | Fax: ? +49-5121-206917-5555 |

Hi,
this patch works as expected in our Visstrim_SM10 board.

Tested-by: Javier Martin <javier.martin@vista-silicon.com>

Regards.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
