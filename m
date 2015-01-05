From: keescook@chromium.org (Kees Cook)
Date: Mon, 5 Jan 2015 12:01:13 -0800
Subject: kernel.org - master not booting on keystone (ARM v7 Cortex A15
 SoC) EVMs
In-Reply-To: <54997AC2.1040507@linaro.org>
References: <549490D6.3090804@ti.com> <20141219211816.GH10857@pengutronix.de>
 <CANMBJr5T6SJFiw4HwvK0cfJsyrM8WTPU6_aK0uzznEV4Mqcg3w@mail.gmail.com>
 <5494B932.6060602@ti.com> <20141221102925.GJ10857@pengutronix.de>
 <54983304.3080302@ti.com> <54997AC2.1040507@linaro.org>
Message-ID: <CAGXu5jLNXa-B_67Ay_cFF+==9YwyKuATJ3aF+dUodTPAk-_37g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 23, 2014 at 6:22 AM, Grygorii.Strashko at linaro.org
<grygorii.strashko@linaro.org> wrote:
> On 12/22/2014 05:04 PM, Murali Karicheri wrote:
>> On 12/21/2014 05:29 AM, Uwe Kleine-K?nig wrote:
>>> Hello,
>>>
>>> I cannot say anything here, but maybe the people being involved in
>>> 1e6b48116a950 can. I added them to Cc and didn't trim the mail for them.
>> Uwe,
>>
>> Thanks for copying the commit owners. Looking forward for a response
>> from them.
>>
>> Murali
>>>
>>> Best regards
>>> Uwe
>>>
>>> On Fri, Dec 19, 2014 at 06:48:02PM -0500, Murali Karicheri wrote:
>>>> On 12/19/2014 04:25 PM, Tyler Baker wrote:
>>>>> Hello,
>>>>>
>>>>> On 19 December 2014 at 13:18, Uwe Kleine-K?nig
>>>>> <u.kleine-koenig@pengutronix.de>   wrote:
>>>>>> Hello,
>>>>>>
>>>>>> On Fri, Dec 19, 2014 at 03:55:50PM -0500, Murali Karicheri wrote:
>>>>>>> I have pulled the latest master from
>>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git and
>>>>>>> tried booting on keystone k2hk and k2e EVM. The boot hangs with
>>>>>>> following log. Has anyone seen this? Keystone is an ARM v7 cortex
>>>>>>> A15 SMP platform. I am assuming master branch is broken for ARM v7
>>>>>>> and someone is working to address this. v3.18 booted up fine on my
>>>>>>> EVM.
>>>>>>>
>>>>>>> Any idea?
>>>>>> You forgot to attach the log?! So no, I don't have any idea. Did you
>>>>>> bisect?
>>>>
>>>> This was my first git bisect work. git bisect showed me below commit
>>>> as bad commit. But it is pretty old commit. I tried reverting the
>>>> commit and my board booted up fine. The boot log attached below. I
>>>> did following until I got the bad commit. v3.18 also worked fine.
>>>>
>>>> git bisect start
>>>> git bisect good<working commit>
>>>> git bisect bad<non working commit>
>>>>
>>>> I build and test. If boots fine, I did git bisect good and if not,
>>>> git bisect bad until I got the bad commit. Can someone comment if my
>>>> bisect steps look sane? If so, what is wrong with the below commit?
>>>> Ours is a LPAE SoC.
>>>>
>>>> commit 1e6b48116a95046ec51f3d40f83aff8b006674d7
>>>> Author: Kees Cook<keescook@chromium.org>
>>>> Date:   Thu Apr 3 17:28:11 2014 -0700
>>>>
>>>>      ARM: mm: allow non-text sections to be non-executable
>>>>
>>>>      Adds CONFIG_ARM_KERNMEM_PERMS to separate the kernel memory regions
>>>>      into section-sized areas that can have different permisions.
>>>> Performs
>>>>      the NX permission changes during free_initmem, so that init
>>>> memory can be
>>>>      reclaimed.
>>>>
>>>>      This uses section size instead of PMD size to reduce memory lost to
>>>>      padding on non-LPAE systems.
>>>>
>>>>      Based on work by Brad Spengler, Larry Bassel, and Laura Abbott.
>>>>
>>>>      Signed-off-by: Kees Cook<keescook@chromium.org>
>>>>      Tested-by: Laura Abbott<lauraa@codeaurora.org>
>>>>      Acked-by: Nicolas Pitre<nico@linaro.org>
>>>>
>
> Looks like kernel_x_start, kernel_x_end are calculated wrongly in LPAE case.
> kernel_x_start == 0x0000 0000
> kernel_x_end   == 0x0080 0000
>
> but should be:
> kernel_x_start == 0x0000 0008 0000 0000
> kernel_x_end   == 0x0000 0008 0080 0000
>
> Below diff restores boot for me:
>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index cda7c40..4e6ef89 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1329,8 +1329,8 @@ static void __init kmap_init(void)
>  static void __init map_lowmem(void)
>  {
>         struct memblock_region *reg;
> -       unsigned long kernel_x_start = round_down(__pa(_stext), SECTION_SIZE);
> -       unsigned long kernel_x_end = round_up(__pa(__init_end), SECTION_SIZE);
> +       phys_addr_t kernel_x_start = round_down(__pa(_stext), SECTION_SIZE);
> +       phys_addr_t kernel_x_end = round_up(__pa(__init_end), SECTION_SIZE);
>
>         /* Map all the lowmem memory banks. */
>         for_each_memblock(memory, reg) {
> --
> regards,
> -grygorii

Thanks for tracking this down!

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Chrome OS Security
