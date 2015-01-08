From: robherring2@gmail.com (Rob Herring)
Date: Thu, 8 Jan 2015 17:53:15 -0600
Subject: [PATCH 5/9] dts: versatile: add sysregs nodes
In-Reply-To: <CACRpkdbinR3Uvi5zZmQJFxJgnWfvE6JZouMVxxRRGVtMNXkBQQ@mail.gmail.com>
References: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
 <1419967718-26909-6-git-send-email-robherring2@gmail.com>
 <CACRpkdbinR3Uvi5zZmQJFxJgnWfvE6JZouMVxxRRGVtMNXkBQQ@mail.gmail.com>
Message-ID: <CAL_JsqKBLx03E1w0NMH8CH+Pm_L8yQvnR6VTTDxqnpOwAoDhXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding VExpress maintainers...

On Thu, Jan 8, 2015 at 1:44 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Dec 30, 2014 at 8:28 PM, Rob Herring <robherring2@gmail.com> wrote:
>
>> From: Rob Herring <robh@kernel.org>
>>
>> The Versatile boards have the same sysregs as other ARM Ltd boards. Add
>> the nodes in preparation to enable support for 24MHz counter as
>> sched_clock and MMC card detect and write protect support.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> ---
>>  arch/arm/boot/dts/versatile-ab.dts | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/versatile-ab.dts
>> index 27d0d9c..62f04b0 100644
>> --- a/arch/arm/boot/dts/versatile-ab.dts
>> +++ b/arch/arm/boot/dts/versatile-ab.dts
>> @@ -252,6 +252,29 @@
>>                         #size-cells = <1>;
>>                         ranges = <0 0x10000000 0x10000>;
>>
>> +                       sysreg at 0 {
>> +                               compatible = "arm,vexpress-sysreg";
>
> vexpress? No...

Compatible with yes. Should perhaps be '"arm,versatile-sysreg",
"arm,vexpress-sysreg"' instead. Kind of backwards, as really the
versatile came first, but it would work. Or we just need another match
entry in the kernel.

I copied this whole chunk as is from VExpress and verified these sub
nodes are all the same hence why it is here.

> compatible = "syscon";

maybe? VExpress is missing that then...

>> +                               reg = <0x00000 0x1000>;
>> +
>> +                               v2m_led_gpios: sys_led at 08 {
>> +                                       compatible = "arm,vexpress-sysreg,sys_led";
>> +                                       gpio-controller;
>> +                                       #gpio-cells = <2>;
>> +                               };
>
> These are not GPIOs. These are LED registers really.

A register bit that controls an i/o signal sounds like a GPIO to me.

> see how to use LEDs from drivers/leds/leds-syscon.c and bindings.
> example in:
> arch/arm/boot/dts/integrator.dtsi
>
> Very straight-forward I think.

So we have 2 implementations and bindings for roughly the same hardware? Great!

>> +                               v2m_mmc_gpios: sys_mci at 48 {
>> +                                       compatible = "arm,vexpress-sysreg,sys_mci";
>> +                                       gpio-controller;
>> +                                       #gpio-cells = <2>;
>> +                               };
>> +
>> +                               v2m_flash_gpios: sys_flash at 4c {
>> +                                       compatible = "arm,vexpress-sysreg,sys_flash";
>> +                                       gpio-controller;
>> +                                       #gpio-cells = <2>;
>> +                               };
>
> I don't have drivers for these "gpio controllers" and I don't think they are
> GPIOs either, since they are not general purpose at all.

They are only general purpose until you connect the i/o lines to
something. But yes, if we went around making every misc internal
control line in SOCs a 1-bit GPIO controller that would be pretty
crazy.

Anyway, most of this is not actually used ATM on Versatile, but it is
present in VExpress. I added it only for sched_clock. We need to
resolve this with VExpress platforms, but it's already in use for MMC
and LEDs.

Rob

> For the latter I have some code boiling for the Integrators:
> https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-integrator.git/commit/?h=multiplatform&id=9c28e114ec957fadf1dade382d8e8b8aa43c8426
> https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-integrator.git/commit/?h=multiplatform&id=a3d4512abb85de290cdca0586bcff9147833917f
>
> Yours,
> Linus Walleij
