From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Fri, 9 Jul 2010 11:59:44 +0900
Subject: [PATCH] ARM: S5PV210: add clocks (struct clk).
In-Reply-To: <023a01cb1f0f$90a5da30$b1f18e90$%kim@samsung.com>
References: <1278395327-9072-1-git-send-email-myungjoo.ham@samsung.com>
	<023a01cb1f0f$90a5da30$b1f18e90$%kim@samsung.com>
Message-ID: <AANLkTimCd5cDOZI1ylQEble1RQT6mYypTV9laizbNO2h@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Jul 9, 2010 at 11:36 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> MyungJoo Ham wrote:
>>
> Hi,
>
> Please include Ben Dooks in the Cc..
> And...excuse me..who is benh at kernel.crashing.org?

Ah.. I was confused by my own reply regarding common struct clk, which
had benh at kernel.crashing.org as Cc. I'll update the CC setting.

>
>> Many clocks were not listed in the previous
>> arch/arm/mach-s5pv210/clock.c
>>
>> We have added clocks defined as CLK_GATE_IPx[] in the user manual of
>> S5PV210. However, the clocks that were not turned on at the boot time
>> when tested with the previous kernel versions (2.6.32, 2.6.29) are
>> defined in "init_clocks_disabled" so that they are turned off at the
>> boot time.
>
> I think, no need to register all of clocks which are in the CLK_GATE_IPx
> into 'init_clocks_disabled'..because it depends on each platform or project.
>
>>
>> The clocks added from CLK_GATE_IPx are:
>> ? ? ? CSIS, JPEG, FIMC0 - 2, NFCON, SROMC, TVENC, HDMI, MIXER, VP,
>> ? ? ? DSIM, TSI, HOSTIF, MODEM, PCM0 - 2, I2C-HDMI-PHY, I2C-HDMI-DDC,
>> ? ? ? AC97, SPDIF, SECKEY, IEM-APC, IEM-IEC, CHIP-ID, PDMA0 - 1,
>> ? ? ? MDMA, DMC0 - 1, NANDXL, TZIC0 - 3, VIC0 - 3, SECJTAG, CORESIGHT,
>> ? ? ? SDM, SECSS, SYSCON, GPIO, TZPC0 - 3
>>
>
> For example...in the case of JPEG, FIMC, disabling is better at the booting
> time..because can be enabled dynamically in the device driver when it is
> used.
> But if CORESIGHT which does not having own driver is disabled at that time,
> basically can't use JTAG debugger.
>
> So need to sort out clocks to register into 'init_clocks_disabled'
>

Yes, I agree. I'll put some clocks including CORESIGHT out of
init_clocks_disabled.


Anyway, I've been considering adding "flag" to struct clk, which has
the following bits:

#define CLKFLAGS_BOOT_ON        (0x1)
#define CLKFLAGS_CANNOT_DISABLE (0x2)
#define CLKFLAGS_ALWAYS_ON      (CLKFLAGS_BOOT_ON | CLKFLAGS_CANNOT_DISABLE)
#define CLKFLAGS_BOOT_OFF       (0x4) /* Force off when boot */
#define CLKFLAGS_DEPRECATED     (0x8) /* Warn when clk_get'd */
/* Note that CLKFLAGS_BOOT_ON and CLKFLAGS_CANNOT_DISABLE overrides
 * CLKFLAGS_BOOT_OFF */

and merging init_clocks and init_clocks_disabled. This provides more
precise control on clocks, and we've been using such features in other
versions of the kernel. Besides, combined with
powerdomain control, these flags are helpful on implementing
powerdomain/block-gating control.


>> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> ?arch/arm/mach-s5pv210/clock.c | ?298
>> ++++++++++++++++++++++++++++++++++++++++-
>> ?1 files changed, 297 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
>> index b3d156c..aa2b1c5 100644
>> --- a/arch/arm/mach-s5pv210/clock.c
>> +++ b/arch/arm/mach-s5pv210/clock.c
>
> (snip)
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>

Cheers!
- MyungJoo

-- 
MyungJoo Ham (???), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
