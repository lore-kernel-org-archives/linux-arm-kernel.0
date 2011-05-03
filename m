From: khilman@ti.com (Kevin Hilman)
Date: Tue, 03 May 2011 09:38:51 -0700
Subject: [PATCH 15/15] OMAP: GPIO: cleanup show revision,
	remove cpu_is checks, display only once
In-Reply-To: <BANLkTimwFezON_qX+wr3Gj+A3EOEbD81YQ@mail.gmail.com> (Charulatha
	Varadarajan's message of "Tue, 26 Apr 2011 17:18:47 +0530")
References: <1303513327-14532-1-git-send-email-khilman@ti.com>
	<1303513327-14532-16-git-send-email-khilman@ti.com>
	<BANLkTimwFezON_qX+wr3Gj+A3EOEbD81YQ@mail.gmail.com>
Message-ID: <874o5bg2n8.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Varadarajan, Charulatha" <charu@ti.com> writes:

> Kevin,
>
> On Sat, Apr 23, 2011 at 04:32, Kevin Hilman <khilman@ti.com> wrote:
>> Remove cpu_is_* checks from gpio_show_revision() by passing in the
>> revision address offset from platform data. ?SoCs with no revision
>> register (15xx, 7xx, and all MPUIOs) use -1 to signify no register.
>>
>> While here, all GPIO banks are assumed to be the same revision, so fix
>> show_revision() to only show the revision for the first bank it finds.
>> This removes duplicate GPIO revision prints during boot.
>>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>> ?arch/arm/mach-omap1/gpio15xx.c ? ? ? ? | ? ?2 ++
>> ?arch/arm/mach-omap1/gpio16xx.c ? ? ? ? | ? ?2 ++
>> ?arch/arm/mach-omap1/gpio7xx.c ? ? ? ? ?| ? ?2 ++
>> ?arch/arm/mach-omap2/gpio.c ? ? ? ? ? ? | ? ?2 ++
>> ?arch/arm/plat-omap/gpio.c ? ? ? ? ? ? ?| ? 14 ++++++--------
>> ?arch/arm/plat-omap/include/plat/gpio.h | ? ?1 +
>> ?6 files changed, 15 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
>> index 9175624..6f77c36 100644
>> --- a/arch/arm/mach-omap1/gpio15xx.c
>> +++ b/arch/arm/mach-omap1/gpio15xx.c
>> @@ -35,6 +35,7 @@ static struct __initdata resource omap15xx_mpu_gpio_resources[] = {
>> ?};
>>
>> ?static struct omap_gpio_reg_offs omap15xx_mpuio_regs = {
>> + ? ? ? .revision ? ? ? = -1,
>
> Assigning -1 to u16 type. Instead you may want to use 0xffff?
>

The compiler will do the right thing, so personally, I prefer using -1.
It's safer if/when the type is changed, but the mask not updated.

Kevin
