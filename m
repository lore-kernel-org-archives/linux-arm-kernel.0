From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 31 Oct 2013 11:10:45 +0200
Subject: [PATCHv9 00/43] ARM: TI SoC clock DT conversion
In-Reply-To: <52716799.6040002@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
 <526FDFF4.9030806@ti.com> <5270C1F3.6000409@ti.com> <52711F12.1090008@ti.com>
 <52716799.6040002@ti.com>
Message-ID: <52721E95.4080806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2013 10:10 PM, Nishanth Menon wrote:
> On 10/30/2013 10:00 AM, Nishanth Menon wrote:
>> On 10/30/2013 03:23 AM, Tero Kristo wrote:
>>> On 10/29/2013 06:19 PM, Nishanth Menon wrote:
>>>> On 10/25/2013 10:56 AM, Tero Kristo wrote:
>>>> <snip>
>>>>> Testing done:
>>>>> - omap3-beagle: boot + suspend/resume (ret + off)
>>>>> - omap4-panda-es: boot + suspend/resume
>>>>> - omap5-uevm: boot
>>>>> - dra7-evm: boot
>>>>> - am335x-bone: boot
>>>>>
>>>>> Test branches available:
>>>>>
>>>>> tree: https://github.com/t-kristo/linux-pm.git
>>>>
>>>> <snip>
>>>>> Fully functioning test branch: 3.12-rc6-dt-clks-v9
>>>>>
>>>> ^^ I tested this branch (boot testing):
>>>> Beagle-XM: http://pastebin.com/50A1qtFq (crashes + clkdm issues, dpll5
>>>> failed to transition)
>>>
>>> I just sent you a private email with a patch to try out, should fix the
>>> boot crash at least hopefully. Basically I forgot to convert one part of
>>> the kernel to the new regmap stuff for omap36xx.
>>
>> it does bootup yes.
>>>
>>> clkdm issues are caused by wrong data in omap_hwmod_3xxx_data.c, USB
>>> nodes are listing l3_init_clkdm for them, but this only exists on
>>> omap4+. Seems like some copy paste bug introduced by someone.
>>>
>>> dpll5 part I am not too sure, can you check if the same happens with
>>> non-dt boot?
>>
>> no-dt: http://pastebin.com/bYP9fTzH
>> dt: http://pastebin.com/xHup4L9Y
>>
>> dpll5 warning seems to be only in dt-boot?
>>
>
> Tracked this down: you were missing the following - looks like the
> conversion script might be missing converting the flags clock data
> over to dts?
>
> diff --git
> a/arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi
> b/arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi
> index 7e37e3e..c9b77c8 100644
> --- a/arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi
> +++ b/arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi
> @@ -30,6 +30,7 @@
>                  compatible = "ti,omap3-dpll-clock";
>                  clocks = <&sys_ck>, <&sys_ck>;
>                  reg = <0x0d04>, <0x0d24>, <0x0d34>, <0x0d4c>;
> +               ti,low-power-stop;
>          };
>
>          dpll5_m2_ck: dpll5_m2_ck {
>
>
>

Yea, seems I introduced the problem with the conversion script changes. 
The valid fix for this is actually at the end of this mail (this fixes 
both of the problems introduced, and also completes the fix you did), I 
will add the fixes to the next rev. Question to Mike/Paul/Tony/Benoit, 
shall I resend the complete series or only the two patches that will be 
changed?

----
diff --git 
a/arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi 
b/arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi
index 7e37e3e..08db6d8 100644
--- a/arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi
+++ b/arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi
@@ -30,6 +30,8 @@
                 compatible = "ti,omap3-dpll-clock";
                 clocks = <&sys_ck>, <&sys_ck>;
                 reg = <0x0d04>, <0x0d24>, <0x0d34>, <0x0d4c>;
+               ti,low-power-stop;
+               ti,lock;
         };

         dpll5_m2_ck: dpll5_m2_ck {
diff --git a/arch/arm/boot/dts/omap3xxx-clocks.dtsi 
b/arch/arm/boot/dts/omap3xxx-clocks.dtsi
index 417bb03..e834b1c 100644
--- a/arch/arm/boot/dts/omap3xxx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap3xxx-clocks.dtsi
@@ -335,8 +335,6 @@ cm: cm at 48004000 {
                 compatible = "ti,omap3-dpll-clock";
                 clocks = <&sys_ck>, <&dpll1_fck>;
                 reg = <0x0904>, <0x0924>, <0x0934>, <0x0940>;
-               ti,lock;
-               ti,low-power-bypass;
         };

         dpll1_x2_ck: dpll1_x2_ck {
