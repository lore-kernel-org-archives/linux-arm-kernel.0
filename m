From: dianders@google.com (Doug Anderson)
Date: Fri, 6 Jun 2014 13:49:11 -0700
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <CAM4voa=cTbobQHi+sBOCy_CDYAnQ6CsvvuoE7XwqFZV_E3gEbQ@mail.gmail.com>
References: <CAD=FV=UX90hgyojW3k_kpT=mt8eX9=AyHr+AGjhK=MrE1hHbUA@mail.gmail.com>
 <539145B4.5000200@gmail.com>
 <CAD=FV=XqwEQNJmij-4Gh62OY+B66AjdQjZC0=f_6tbot3UfQaA@mail.gmail.com>
 <CAM4voaknx3+X4O8MUwaruUFPyquY8Opq61ucKX08xTrv8PqfLg@mail.gmail.com>
 <CAD=FV=Vo1JR6n496Q3FqXjRBkbTBRg89_fJQNsqeRx8WQW_a9w@mail.gmail.com>
 <CAM4voakAMN4jdAZDPz55tnc3woZDieZ5aL3TVU2kYsNHT+AMqg@mail.gmail.com>
 <CAD=FV=UjmN5AwWMPy7mQt-J4A_niO8Ug4r15Ez2ZWPT1g3L=VA@mail.gmail.com>
 <CAM4voa=1FY5bfk095BU=3X=vzqjnCSfdLoXpCix5tOwDgOoioQ@mail.gmail.com>
 <CAD=FV=UwgPQVm_KvHbpoJNs-5EtpyaYJ2rp2f-466uhnob=ixA@mail.gmail.com>
 <CAM4voa=cTbobQHi+sBOCy_CDYAnQ6CsvvuoE7XwqFZV_E3gEbQ@mail.gmail.com>
Message-ID: <CAD=FV=U6HuQj3MxZ-yF-MYdjzqjT5bu=K26JuHZP1hjJzkSqbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 6, 2014 at 12:09 PM, Abhilash Kesavan
<kesavan.abhilash@gmail.com> wrote:
> Hi Doug,
>
> On Sat, Jun 7, 2014 at 12:26 AM, Doug Anderson <dianders@google.com> wrote:
>> Abhilash,
>>
>> On Fri, Jun 6, 2014 at 11:31 AM, Abhilash Kesavan
>> <kesavan.abhilash@gmail.com> wrote:
>>> Hi Doug,
>>>
>>> On Fri, Jun 6, 2014 at 11:50 PM, Doug Anderson <dianders@google.com> wrote:
>>>> Abhilash,
>>>>
>>>>
>>>>
>>>> On Fri, Jun 6, 2014 at 11:12 AM, Abhilash Kesavan
>>>> <kesavan.abhilash@gmail.com> wrote:
>>>>> Hi Doug,
>>>>>
>>>>> On Fri, Jun 6, 2014 at 11:32 PM, Doug Anderson <dianders@google.com> wrote:
>>>>>> Abhilash,
>>>>>>
>>>>>> On Fri, Jun 6, 2014 at 10:36 AM, Abhilash Kesavan
>>>>>> <kesavan.abhilash@gmail.com> wrote:
>>>>>>> Hi Doug,
>>>>>>>
>>>>>>> The first change in the kernel (clearing an iRAM location) is needed
>>>>>>> because of an unnecessary change that we are carrying in the Chrome
>>>>>>> U-boot. There is no reason for us to have the workaround in the
>>>>>>> mainline kernel. Rather, we should remove the check from our u-boot.
>>>>>>> However AFAIR a clean-up patch that I had posted internally was not
>>>>>>> accepted as we had frozen the SPL at the time.
>>>>>>
>>>>>> Ah, is that this one, or a different one?
>>>>>>
>>>>>> https://chromium-review.googlesource.com/#/c/66049/
>>>>> Yes, this along with a kernel side change.
>>>>
>>>> Can we safely take this one without the kernel-side one?
>>> Yes, just the u-boot change should suffice.
>>>>
>>>>
>>>>>> If we land that patch now it won't help since nobody is going to be
>>>>>> updating their read-only firmware.  We'll need to put code somewhere
>>>>>> that fixes it.
>>>>> We just carry the workaround fix locally until we migrate to mainline
>>>>> u-boot for 5420 where the unnecessay check will not be present.
>>>>
>>>> I think there are people out there who want to run a mainline kernel
>>>> on existing Chromebook 2 hardware and don't want to rewrite their RO
>>>> firmware.  We need a solution for those people.
>>> Yes, I see your point. But, do you think someone who has changed the
>>> existing fused kernel on the device to a mainline one would be averse
>>> to applying a couple of small work-around changes as well ? Their
>>> finding this thread and the proposed "magic" fixes may be difficult
>>> but not the actual application I think.
>>>
>>> How about having a page similar to
>>> "http://www.chromium.org/chromium-os/how-tos-and-troubleshooting/using-an-upstream-kernel-on-snow"
>>> for Peach ? We could have the work-arounds listed there.
>>
>> We can (though the fewer weird things we have the better), but we
>> definitely need to provide workarounds that don't require people to
>> change their RO firmware.
> I do not quite agree with this. They do not need to change their RO
> firmware, just modify their boot commands.
>>
>> Thinking all that through, I think the answer is that we want to
>> abandon the U-Boot change above
>> <https://chromium-review.googlesource.com/#/c/66049/>.  At this point
>> we're never going to take it at this point and there's no possible way
>> to do it in an RW firmware update (right?) since any workaround would
>> be overwritten by the SPL at resume time.
> Sure, will abandon.
>>
>> So the proper "fix" for the "mw.l 02073028 0" is a kernel fix.  ...and
> I believe there is no "proper" fix for incorrect existing code in
> non-mainline u-boot.
>
>> if upstream doesn't want land it because it's impure then we'll just
>> have to list it on our "apply these hacks to your kernel".  You sent
>> me this as a kernel fix before and now I think I understand why (to
>> handle the s2r case).  Can you please post this up to the mailing
>> list?  Please make sure it will handle the suspend/resume case
>> whenever suspend/resume starts working (I haven't tested but I
>> remember hearing that it doesn't work).
>
> Are you talking about the re-writing the mcpm entry point address post-resume ?

Or even (as Andrew points out) just don't use it.

This works and IMHO is much cleaner because it totally removes the
U-Boot dependency.  I'll cleanup to not be so insane and post:

diff --git a/arch/arm/mach-exynos/mcpm-exynos.c
b/arch/arm/mach-exynos/mcpm-exynos.c
index 0498d0b..9c5df7b 100644
--- a/arch/arm/mach-exynos/mcpm-exynos.c
+++ b/arch/arm/mach-exynos/mcpm-exynos.c
@@ -290,6 +290,14 @@ static void __naked
exynos_pm_power_up_setup(unsigned int affinity_level)
        "b      cci_enable_port_for_self");
 }

+static void __naked exynos_mcpm_secondary_cpu_start(void)
+{
+       asm volatile ("\n"
+       "ldr    r0, [pc, #0]\n"
+       "bx     r0\n"
+       ".word  0" );
+}
+
 static const struct of_device_id exynos_dt_mcpm_match[] = {
        { .compatible = "samsung,exynos5420" },
        { .compatible = "samsung,exynos5800" },
@@ -346,8 +354,9 @@ static int __init exynos_mcpm_init(void)
         * Future entries into the kernel can now go
         * through the cluster entry vectors.
         */
-       __raw_writel(virt_to_phys(mcpm_entry_point),
-                       ns_sram_base_addr + MCPM_BOOT_ADDR_OFFSET);
+       __raw_writel(((u32*)exynos_mcpm_secondary_cpu_start)[0],
ns_sram_base_addr);
+       __raw_writel(((u32*)exynos_mcpm_secondary_cpu_start)[1],
ns_sram_base_addr + 4);
+       __raw_writel(virt_to_phys(mcpm_entry_point), ns_sram_base_addr + 8);

-Doug
