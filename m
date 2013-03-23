From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 23 Mar 2013 16:25:54 +0100
Subject: [PATCH] ARM: Kirkwood: fix unused mvsdio gpio pins
In-Reply-To: <20130323161744.5d13c570@skate>
References: <1364043420-17641-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130323161744.5d13c570@skate>
Message-ID: <514DC982.3010706@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/23/2013 04:17 PM, Thomas Petazzoni wrote:
> On Sat, 23 Mar 2013 13:56:58 +0100, Sebastian Hesselbarth wrote:
>> mvsdio_platform_data allows to pass card detect and write protect gpio
>> numbers to the driver. Some kirkwood boards don't use both pins as
>> they are not connected, and don't set the corresponding value in
>> platform_data.
>>
>> This will leave the unset values in platform_data initialized as 0,
>> which is in fact a valid gpio pin. mvsdio will grab that pin and
>> configure it as gpio, which in turn breaks nand controller as mpp0
>> also carries nand_io2.
>>
>> This patch fixes the above by initializing unused gpio functions in
>> the platform_data with an invalid (-1) value.
>>
>> Signed-off-by: Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>
>> Reported-by: Soeren Moch<smoch@web.de>
>
> This somewhat "conflicts" with the patch I've submitted on the mvsdio
> driver to exclude 0 as a valid GPIO, see
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-March/157157.html.
> This patch ensures that the mvsdio driver behaves as it was behaving
> before 3.9 as far as legacy probing is concerned.

Thomas,

I understand that you proposed patch fixes mvsdio grab mpp0 by accident.
But what if you have a kirkwood board where cd-gpio _is_ connected to mpp0?

Not that there is one I know of, but IMHO the only useful patch is to
set passed values to an invalid gpio number.

> That said, I have nothing against explicitly setting those GPIO values
> to an invalid value. Maybe -EINVAL would make more sense than just -1 ?

Every invalid gpio number will be sufficient. But -EINVAL doesn't make
more sense than -1 does. Having no cd-gpio is not an "Invalid argument".

Sebastian
