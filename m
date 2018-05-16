From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 16 May 2018 15:44:12 +0530
Subject: [PATCH 2/4] ARM: davinci: board-da850-evm: fix GPIO lookup for
 MMC/SD
In-Reply-To: <CAHCN7x+eNpeyv27WPqZyy-X9S7Ffvujo+y3Mmt1ZP=LEk+4+=g@mail.gmail.com>
References: <20180424143506.25793-1-nsekhar@ti.com>
 <20180424143506.25793-3-nsekhar@ti.com>
 <fa8feb04-2231-88b8-4d2b-10264187ba7e@lechnology.com>
 <CAHCN7x+eNpeyv27WPqZyy-X9S7Ffvujo+y3Mmt1ZP=LEk+4+=g@mail.gmail.com>
Message-ID: <bf023e5e-5831-c9ad-bcd6-c9bb587ba848@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 May 2018 04:23 AM, Adam Ford wrote:
> On Thu, Apr 26, 2018 at 8:40 PM, David Lechner <david@lechnology.com> wrote:
>> On 04/24/2018 09:35 AM, Sekhar Nori wrote:
>>>
>>> The GPIO chip is called davinci_gpio.0 in legacy mode. Fix it, so that
>>> mmc can correctly lookup the wp and cp gpios. Also fix the GPIO numbers
>>> as they are not offsets within a bank.
>>>
>>> Note that it is the gpio-davinci driver that sets the gpiochip label to
>>> davinci_gpio.0.
>>>
>>> Fixes: bdf0e8364fd3 ("ARM: davinci: da850-evm: use gpio descriptor for mmc
>>> pins")
>>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>>> ---
>>>   arch/arm/mach-davinci/board-da850-evm.c | 9 +++++++--
>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-davinci/board-da850-evm.c
>>> b/arch/arm/mach-davinci/board-da850-evm.c
>>> index 3063478bcc36..158ed9a1483f 100644
>>> --- a/arch/arm/mach-davinci/board-da850-evm.c
>>> +++ b/arch/arm/mach-davinci/board-da850-evm.c
>>> @@ -763,12 +763,17 @@ static const short da850_evm_mcasp_pins[]
>>> __initconst = {
>>>         -1
>>>   };
>>>   +#define DA850_MMCSD_CD_PIN           GPIO_TO_PIN(4, 0)
>>> +#define DA850_MMCSD_WP_PIN             GPIO_TO_PIN(4, 1)
>>> +
>>>   static struct gpiod_lookup_table mmc_gpios_table = {
>>>         .dev_id = "da830-mmc.0",
>>>         .table = {
>>>                 /* gpio chip 2 contains gpio range 64-95 */
>>> -               GPIO_LOOKUP("davinci_gpio.2", 0, "cd", GPIO_ACTIVE_LOW),
>>> -               GPIO_LOOKUP("davinci_gpio.2", 1, "wp", GPIO_ACTIVE_LOW),
>>> +               GPIO_LOOKUP("davinci_gpio.0", DA850_MMCSD_CD_PIN, "cd",
>>> +                           GPIO_ACTIVE_LOW),
>>> +               GPIO_LOOKUP("davinci_gpio.0", DA850_MMCSD_WP_PIN, "wp",
>>> +                           GPIO_ACTIVE_LOW),
> 
> I don't think the WP polarity is working correctly.  If I boot the
> board 'rw' enabled but WP disabled on the SD card, the system crashes.
> If I enable WP, the board boots correctly.
> 
> Comparing this to the device tree version that I did, and double
> checking the behavior for my sanity, I believe WP needs to be
> GPIO_ACTIVE_HIGH

You are right, I see the issue on my board too. Although this patch did
not touch the polarity, we could have fixed it here.

Anyway, do you want to send a patch for that? Or I can do it too. A
similar fix is needed for DA830 EVM too.

Thanks,
Sekhar
