From: parkch98@gmail.com (Chanho Park)
Date: Tue, 14 Jul 2015 16:13:26 +0900
Subject: [PATCHv6] ARM: dts: add exynos5422-cpus.dtsi to correct cpu order
In-Reply-To: <06b101d0bdf2$8aad8fb0$a008af10$@kernel.org>
References: <1436833441-8405-1-git-send-email-parkch98@gmail.com>
 <55A45C63.2030907@samsung.com>
 <06b101d0bdf2$8aad8fb0$a008af10$@kernel.org>
Message-ID: <CAPTzV15+BWEo6PjJMwHVjqVdUnZuJ=PBAUprF_vZaSRTYiuNXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On Tue, Jul 14, 2015 at 2:04 PM, Kukjin Kim <kgene@kernel.org> wrote:
> Krzysztof Kozlowski wrote:
>>
>> On 14.07.2015 09:24, Chanho Park wrote:
>> > The odroid-xu3 board which is based on exynos5422 not exynos5800 is
>> > booted from cortex-a7 core unlike exynos5800. The odroid-xu3's cpu order
>> > is quite strange. cpu0 and cpu5-7 are cortex-a7 cores and cpu1-4 are
>> > cortex-a15 cores. To correct this mis-odering, I added exynos5422-cpus.dtsi
>> > and reversing cpu orders from exynos5420. Now, cpu0-3 are cortex-a7 and
>> > cpu4-7 are cortex-a15.
>> >
>> > Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> > Signed-off-by: Chanho Park <parkch98@gmail.com>
>> > ---
>> > Change from v4:
>> >  - Resend patch with correct signed-off
>> >
>> > Changes from v4:
>> >  - Remove temporal patch in e-mail body
>> >
>> > Changes from v3:
>> >  - include this exynos5422-cpus.dtsi in the exynos5422-odroidxu3-common.dtsi
>> >
>> > Changes from v2:
>> >  - drop inclusion of exynos5420.dtsi from exynos5422-cpus.dtsi
>> >  - drop compatibles from exynos5422-cpus.dtsi
>> >
>> > Changes from v1:
>> >  - rename exynos5422.dtsi to exynos5422-cpus.dtsi
>> >  - include the dtsi file top of the exynos5422-odroidxu3.dts
>> >
>> > Secondary cpu booting problem[1] is not resolved yet. Need more investigations
>> > to work booting 8 cores correctly.
>> >
>> > [1]: http://www.spinics.net/lists/linux-samsung-soc/msg45525.html
>> >
>> >  arch/arm/boot/dts/exynos5422-cpus.dtsi             | 81 ++++++++++++++++++++++
>> >  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  1 +
>> >  2 files changed, 82 insertions(+)
>> >  create mode 100644 arch/arm/boot/dts/exynos5422-cpus.dtsi
>>
>> Thanks, applied to my tree. I'll send it to Kukjin for v4.3 unless he
>> picks it also.
>>
> Well, let me see. I'm thinking we need to sort out the cpu ordering and dtsi
> inclusions for exynos5420, 5422 and 5800 related to DT files.
>
> See,
>
> 1) exynos5420 DT (cpu0~3: a15, cpu 4~7: a7)
> 2) exynos5800 DT is including exynos5420 DT
> 3) exynos5422 and exynos5800 based boards are including exynos5800 DT.
>
> Then making exynos5422-cpus DT for exynos5422 based boards?
> (cpu0~3: a7, cpu4~7: a15)
>
> I think, it could cause confusion when new board based on them are added
> because it's not clear and the boot cpu could be selected by bootloader part.

The iROM will check the GPIO pin to select which core is run as cpu0.
I think no one will change the GPIO pin if a new board which is based
on exynos5422 :)

>
> So how about creating exynos5422-cpus and exynos5420-cpus then including the
> cpus DT file in each board accordingly?
>
> Or more clear way to avoid confusion?

In this situation, all exynos5422 boards(odroid xu3 series and mobile
phone) have same cpu configurations. If we move the exynos5420 cpu
configuration from exynos5420.dtsi, we should change all dts which
including exynos5420.dtsi.
I think we'd better to defer the change until a new exynos5422 board
which has different cpu configurations is added.

-- 
Best Regards,
Chanho Park
