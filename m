From: robherring2@gmail.com (Rob Herring)
Date: Tue, 30 Dec 2014 17:05:16 -0600
Subject: [PATCH 3/9] ARM: versatile: add DT based PCI detection
In-Reply-To: <13417872.31IhE1RbAx@wuerfel>
References: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
 <1419967718-26909-4-git-send-email-robherring2@gmail.com>
 <13417872.31IhE1RbAx@wuerfel>
Message-ID: <CAL_Jsq+iVWPsN9LXEMT6DmjS7MGsnmgJLgyb33N3me=OcCet6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 30, 2014 at 3:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 30 December 2014 13:28:32 Rob Herring wrote:
>> From: Rob Herring <robh@kernel.org>
>>
>> Disable the Versatile PCI DT node when no PCI backplane is detected. This
>> will prevent the Versatile PCI driver from probing when PCI is not
>> populated.
>
> Can you explain why the check is done in platform code instead of the PCI
> driver probe function itself?

Because the register to check is not part of the PCI controller, but
part of the system registers. There was no infrastructure for the
system registers when I originally wrote this, but there's some syscon
support now for VExpress that may be able to be used. I think it is
cleaner if we can avoid syscon dependencies in drivers in general, but
it is pretty much zero chance the Versatile PCI driver will ever be
used on another platform.

>> +     /* Check if PCI backplane is detected */
>> +     val = __raw_readl(base + VERSATILE_SYS_PCICTL_OFFSET);
>> +     if (val & 1)
>> +             goto err;
>
> Using __raw_readl prevents this from working with big-endian kernels, so just
> use readl here.

So does the fact that this is an ARM926, but yes there's not really
any reason not to use readl.

Rob
