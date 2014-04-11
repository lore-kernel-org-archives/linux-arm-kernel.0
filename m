From: monstr@monstr.eu (Michal Simek)
Date: Fri, 11 Apr 2014 08:57:25 +0200
Subject: [PATCH 1/2] GPIO: Add driver for Zynq GPIO controller
In-Reply-To: <CACRpkdbk0Ru=txcF3DGBDD=CitqHYFR8w-1fUDR9wSinQBQyvw@mail.gmail.com>
References: <1395933906-2268-1-git-send-email-harinik@xilinx.com>
 <CACRpkdbU35xG1QtagB+9e9vxvehf1UQFaF4PikJhsPNAMw=D1Q@mail.gmail.com>
 <CAFcVECJsEp_s2V5=oK_UJahGRUpWYWMCxTMxqdpX+O0qebP41A@mail.gmail.com>
 <CACRpkdZEFsJubRVwCp6nTie7s7+DZOym6SWsA2ZynN_devi-2Q@mail.gmail.com>
 <533BA67B.6070905@monstr.eu>
 <CACRpkdbk0Ru=txcF3DGBDD=CitqHYFR8w-1fUDR9wSinQBQyvw@mail.gmail.com>
Message-ID: <53479255.4070206@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2014 07:52 PM, Linus Walleij wrote:
> On Wed, Apr 2, 2014 at 7:56 AM, Michal Simek <monstr@monstr.eu> wrote:
>> On 03/31/2014 10:22 AM, Linus Walleij wrote:
>>> On Sat, Mar 29, 2014 at 5:44 AM, Harini Katakam
>>> <harinikatakamlinux@gmail.com> wrote:
>>>> On Sat, Mar 29, 2014 at 3:20 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>>>> On Thu, Mar 27, 2014 at 4:25 PM, Harini Katakam <harinik@xilinx.com> wrote:
>>>
>>>>>> +/* Read/Write access to the GPIO PS registers */
>>>>>> +static inline u32 zynq_gpio_readreg(void __iomem *offset)
>>>>>> +{
>>>>>> +       return readl_relaxed(offset);
>>>>>> +}
>>>>>> +
>>>>>> +static inline void zynq_gpio_writereg(void __iomem *offset, u32 val)
>>>>>> +{
>>>>>> +       writel_relaxed(val, offset);
>>>>>> +}
>>>>>
>>>>> I think this is unnecessary and confusing indirection.
>>>>> Just use the readl_relaxed/writel_relaxed functions directly in
>>>>> the code.
>>>>>
>>>>
>>>> This is just to be flexible.
>>>
>>> Define exactly what you mean with "flexible" in this context. I
>>> only see unnecessary overhead and hard-to-read code.
>>
>> We have just passed this discussion for watchdog driver
>> here: https://lkml.org/lkml/2014/4/1/843
>>
>> Are you ok with doing it in this way?
> 
> No :-)
> 
> Subsystem maintainers do not necessarily agree on such issues.

I think your sentence is right.  :-)
But what to do to convince you to agree with it?
We can use readl/writel directly (or relaxed versions) but it will
just end up that we will have a patch in our xilinx git tree
which won't be in the mainline.

Having central point for IO access functions it not an unused technique.
I was able to find out some cases in drivers/gpio/
gpio-bt8xx.c, gpio-msm-v1.c, gpio-tegra.c, gpio-xilinx.c (almost similar reason
here :-))
and just one in pinctrl-spear.h.
But I have to admit most of gpio/pinmux drivers are using them directly
but on the other hand they are not FPGA based. :-)

BTW: Shouldn't be __raw_ versions replaced by _relaxed?

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140411/be9bda66/attachment.sig>
