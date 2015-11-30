From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 30 Nov 2015 14:42:11 +0900
Subject: [PATCHv2] ARM: dts: use vmmc-supply of emmc/sd for
 exynos5422-odroidxu3
In-Reply-To: <CANAwSgR+UTZSQYhXcP1a_T9AvJCS98dj1fafzJZ1S3oXvMUx+A@mail.gmail.com>
References: <1445345793-5189-1-git-send-email-linux.amoon@gmail.com>
 <56283582.5010908@samsung.com>
 <CANAwSgQFqcM++D6FoTXTnZJryaoi92pEiSvbjyz8rj79VmGOMQ@mail.gmail.com>
 <CANAwSgR+UTZSQYhXcP1a_T9AvJCS98dj1fafzJZ1S3oXvMUx+A@mail.gmail.com>
Message-ID: <565BE1B3.1070505@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27.11.2015 15:42, Anand Moon wrote:
> hi Krzysztof,
> 
> On 22 October 2015 at 18:34, Anand Moon <linux.amoon@gmail.com> wrote:
>> hi Krzysztof,
>>
>> On 22 October 2015 at 06:31, Krzysztof Kozlowski
>> <k.kozlowski@samsung.com> wrote:
>>> On 20.10.2015 21:56, Anand Moon wrote:
>>>> Changes need for host controller to detect UHS-I highspeed cards.
>>>> Changes in VDDQ_MMC2 voltage range help scale
>>>> the required voltage to detect and load the microSD cards.
>>>
>>> Thanks for updating description of commit.
>>>
>>>>
>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>> ---
>>>> Changes based on git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git v4.4-next/dt-samsung branch
>>>>
>>>> Changes:
>>>> Drop the ranp_delay for LDO9.
>>>>
>>>> Thanks to : Krzysztof, Doug Anderson, Jaehoon Chung for helping
>>>> me out figure out the mmc core requirement.
>>>>
>>>> Also drop the previous changes:
>>>> use cd-gpio method to detect sd-card.
>>>> Added UHS-I bus speed support.
>>>>
>>>> [    4.713553] random: nonblocking pool is initialized
>>>> [    4.718423] 14530000.hdmi supply hdmi-en not found, using dummy regulator
>>>> [    4.726206] exynos-drm exynos-drm: bound 14400000.fimd (ops fimd_component_ops)
>>>> [    4.732555] exynos-drm exynos-drm: bound 14450000.mixer (ops mixer_component_ops)
>>>> [    4.740180] exynos-drm exynos-drm: bound 14530000.hdmi (ops hdmi_component_ops)
>>>> [    4.746936] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
>>>> [    4.753428] [drm] No driver support for vblank timestamp query.
>>>> [    4.940794] Console: switching to colour frame buffer device 274x77
>>>> [    4.995344] exynos-drm exynos-drm: fb0:  frame buffer device
>>>> [    5.024573] [drm] Initialized exynos 1.0.0 20110530 on minor 0
>>>> [    5.031164] exynos-dwc3 usb at 12000000: no suspend clk specified
>>>> [    5.054571] usb 2-1: new full-speed USB device number 2 using exynos-ohci
>>>> [    5.159527] dwmmc_exynos 12220000.mmc: Busy; trying anyway
>>>> [    5.163705] mmc_host mmc1: Timeout sending command (cmd 0x202000 arg 0x0 status 0x0)
>>>> ---
>>>>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 7 ++++++-
>>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>>>> index 1af5bdc..a4be3e0 100644
>>>> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>>>> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>>>> @@ -182,9 +182,10 @@
>>>>
>>>>                       ldo13_reg: LDO13 {
>>>>                               regulator-name = "vdd_ldo13";
>>>> -                             regulator-min-microvolt = <2800000>;
>>>> +                             regulator-min-microvolt = <1800000>;
>>>
>>> You did not convinced me in previous discussion about the change to
>>> 1.8V. I said that:
>>>> On the same diagram few lines below:
>>>> VDDQ_MMC2: 2.8V 250mA
>>>
>>> You responded:
>>>> You are correct.
>>>
>>> So I am confused. Are you sure that this SD card block can/should
>>> operate on 1.8V? Have you actually tried this?
>>>
>>
>> Look like I missed this point. Here is the link I would like to share.
>>
>> http://www.hjreggel.net/cardspeed/cs_sdxc.html
>> Section: Summary of SD modes
>>
>> https://en.wikipedia.org/wiki/Secure_Digital
>> Section: Power consumption
>>
>> Their different requirement for voltage requirement for UHS-I, the max
>> value is around 3.3V
> 
> Do you have any comment on this voltage selection for UHS-I card (1.8V).

I asked whether you tried this, whether setting real 1.8V works fine.
You did not respond. As you can see on Odroid schematics, the VDDQ for
MMC[01] operates under 1.8V.

The VDDQ for MMC2 - under 2.8V.

In commit description you mentioned that this voltage "helps scale the
required voltage to detect and load the microSD cards". What does it
mean "help"? I would expect that detecting and loading of microSD cards
either works or does not work. I am not sure how does it help.

Best regards,
Krzysztof
