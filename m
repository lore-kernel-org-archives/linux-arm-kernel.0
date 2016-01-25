From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 25 Jan 2016 10:19:15 -0300
Subject: [PATCH V2 2/2] regulator: mt6323: Add support for MT6323 regulator
In-Reply-To: <56A61F78.6070703@openwrt.org>
References: <1453718405-40815-1-git-send-email-blogic@openwrt.org>
 <1453718405-40815-2-git-send-email-blogic@openwrt.org>
 <CABxcv=kWnUwpCo=JJbnPAARRM226YfBJw_6yF7MiE8-7iqBD+Q@mail.gmail.com>
 <56A612E2.1010509@openwrt.org>
 <20160125123538.GO6588@sirena.org.uk>
 <56A61F78.6070703@openwrt.org>
Message-ID: <CABxcv=m32FLmLzuGC-KFmZ5q-8TmC1FrhdOw+WB-d_L53gg_tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello John,

On Mon, Jan 25, 2016 at 10:13 AM, John Crispin <blogic@openwrt.org> wrote:
>
>
> On 25/01/2016 13:35, Mark Brown wrote:
>> On Mon, Jan 25, 2016 at 01:19:46PM +0100, John Crispin wrote:
>>> On 25/01/2016 13:11, Javier Martinez Canillas wrote:
>>
>>>> You don't have a .of_match table but according the DT bindings, the
>>>> compatible string "mediatek,mt6323-regulator" should be used so there
>>>> should be a OF match table or the vendor prefix of the compatible
>>>> string won't be used for matching (i.e: fallbacks to the driver .name
>>>> for match).
>>
>>> the driver is probed via drivers/mfd/mt6397-core.c and does not require
>>> the OF match table. It loads fine just like the mt6397 driver.
>>
>> That's fine but you shouldn't have the compatible string in your binding
>> document since it's not actually used or needed.
>>
> Hi,
>
> correct me if i am wrong but if we remove the compatible string from the
> binding document, then we will also have to remove it from the dts and
> then the kernel won't be able to match the node to the driver and thus
> the regulator phandle derefs will fail.
>

The kernel doesn't need to match the compatible since the MFD driver
register the device explicitly with mfd_add_devices().

In fact, the kernel is currently not matching the compatible, it is
only matching because you provided a .of_compatible is provided in the
mfd_cell.

If you wan't subdevices for a MFD to be registered automatically by OF
and the compatible matched like other buses, then your MFD driver
needs to call of_platform_populate() instead mfd_add_devices().

>         John

Best regards,
Javier
