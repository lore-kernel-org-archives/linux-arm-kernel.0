From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 12 Oct 2011 16:04:53 +0200
Subject: [PATCH v2] ARM: EXYNOS4: Add support for M-5MOLS camera on Nuri
	board
In-Reply-To: <069701cc88dc$7a484100$6ed8c300$%kim@samsung.com>
References: <034f01cc8705$199b0dc0$4cd12940$%kim@samsung.com>
	<1318238959-28012-1-git-send-email-s.nawrocki@samsung.com>
	<069701cc88dc$7a484100$6ed8c300$%kim@samsung.com>
Message-ID: <4E959E85.7070504@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kgene,

On 10/12/2011 02:43 PM, Kukjin Kim wrote:
> Kukjin Kim wrote:
>> Sylwester Nawrocki wrote:
>>>
>>> Add voltage regulator and platform data definition for M-5MOLS sensor
>>> and MIPI-CSI receiver drivers. Add CAM power domain dependencies for
>>> FIMC device and set up camera port A GPIO. Configure I2C0 bus timings.
>>>
>>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>>> Signed-off-by: HeungJun Kim <riverful.kim@samsung.com>
>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>> ---
>>> Hi Kgene,
>>>
>>> I have corrected the white space issues as you pointed out and removed
>>> unnecessary gpio_free() in this patch.
>>>
>>> Thanks,
>>>  Sylwester
>>> ---
>>>  arch/arm/mach-exynos4/Kconfig     |    8 ++
>>>  arch/arm/mach-exynos4/mach-nuri.c |  156
>>> +++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 164 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-exynos4/Kconfig
> b/arch/arm/mach-exynos4/Kconfig
>>> index dd660eb..4bc4b1f 100644
>>> --- a/arch/arm/mach-exynos4/Kconfig
>>> +++ b/arch/arm/mach-exynos4/Kconfig
> 
> (snip)
> 
>>> +static struct s5p_platform_fimc fimc_md_platdata = {
>>> +	.isp_info	= nuri_camera_sensors,
>>> +	.num_clients	= ARRAY_SIZE(nuri_camera_sensors),
>>> +};
> 
> Hi Sylwester,
> 
> You need to move 'struct platform_device s5p_device_fimc_md' to
> plat-samsung/devs.c or add 'static' because following error is happened.

Yes, indeed there is an issue with multiple device definition, and the
boards should really not create their own instance.
I'll prepare a patch moving s5p_fimc_device_md to plat-samsung/devs.c
This device instance is also needed for the aggregate FIMC driver to be
initialized on other boards, even if they use only video mem-to-mem.
So the patch should fix the driver initialization issue on these boards.

Sorry about the trouble.

> 
> arch/arm/mach-exynos4/mach-nuri.o: In function `  CC      kernel/sysctl.o
> .LANCHOR1':
> mach-nuri.c:(.data+0x38): multiple definition of `s5p_device_fimc_md'
> arch/arm/mach-exynos4/mach-universal_c210.o:mach-universal_c210.c:(.data+0x1
> 8): first defined here
> make[2]: *** [arch/arm/mach-exynos4/built-in.o] Error 1
> make[1]: *** [arch/arm/mach-exynos4] Error 2
> make[1]: *** Waiting for unfinished jobs....

Regards,
-- 
Sylwester Nawrocki
Samsung Poland R&D Center
