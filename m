From: monstr@monstr.eu (Michal Simek)
Date: Wed, 02 Apr 2014 07:56:11 +0200
Subject: [PATCH 1/2] GPIO: Add driver for Zynq GPIO controller
In-Reply-To: <CACRpkdZEFsJubRVwCp6nTie7s7+DZOym6SWsA2ZynN_devi-2Q@mail.gmail.com>
References: <1395933906-2268-1-git-send-email-harinik@xilinx.com>
 <CACRpkdbU35xG1QtagB+9e9vxvehf1UQFaF4PikJhsPNAMw=D1Q@mail.gmail.com>
 <CAFcVECJsEp_s2V5=oK_UJahGRUpWYWMCxTMxqdpX+O0qebP41A@mail.gmail.com>
 <CACRpkdZEFsJubRVwCp6nTie7s7+DZOym6SWsA2ZynN_devi-2Q@mail.gmail.com>
Message-ID: <533BA67B.6070905@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 03/31/2014 10:22 AM, Linus Walleij wrote:
> On Sat, Mar 29, 2014 at 5:44 AM, Harini Katakam
> <harinikatakamlinux@gmail.com> wrote:
>> On Sat, Mar 29, 2014 at 3:20 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>> On Thu, Mar 27, 2014 at 4:25 PM, Harini Katakam <harinik@xilinx.com> wrote:
> 
>>>> +/* Read/Write access to the GPIO PS registers */
>>>> +static inline u32 zynq_gpio_readreg(void __iomem *offset)
>>>> +{
>>>> +       return readl_relaxed(offset);
>>>> +}
>>>> +
>>>> +static inline void zynq_gpio_writereg(void __iomem *offset, u32 val)
>>>> +{
>>>> +       writel_relaxed(val, offset);
>>>> +}
>>>
>>> I think this is unnecessary and confusing indirection.
>>> Just use the readl_relaxed/writel_relaxed functions directly in
>>> the code.
>>>
>>
>> This is just to be flexible.
> 
> Define exactly what you mean with "flexible" in this context. I
> only see unnecessary overhead and hard-to-read code.

We have just passed this discussion for watchdog driver
here: https://lkml.org/lkml/2014/4/1/843

Are you ok with doing it in this way?

static inline u32 zynq_gpio_readreg(struct zynq_gpio *gpio, u32 offset)
{
       return readl_relaxed(gpio->base_addr + offset);
}

static inline void zynq_gpio_writereg(struct zynq_gpio *gpio, u32 offset, u32 val)
{
      writel_relaxed(val, gpio->base_addr + offset);
}

Or even like this to be able to handle error cases.

static inline int zynq_gpio_readreg(struct zynq_gpio *gpio, u32 offset, u32 *val)
{
	*val = readl_relaxed(gpio->base_addr + offset);
	return 0;
}

static inline int zynq_gpio_writereg(struct zynq_gpio *gpio, u32 offset, u32 val)
{
	writel_relaxed(val, gpio->base_addr + offset);
	return 0;
}

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140402/4b3a7af1/attachment.sig>
