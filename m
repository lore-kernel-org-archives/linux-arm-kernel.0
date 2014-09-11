From: anders.berg@avagotech.com (Anders Berg)
Date: Thu, 11 Sep 2014 23:29:43 +0200
Subject: [PATCH] spi: pl022: Add support for chip select extension
In-Reply-To: <CACRpkdavQBJkaC40GJkD396JkwPjSr_dzWegn8veLpG-Fcn-SQ@mail.gmail.com>
References: <1410360030-26634-1-git-send-email-anders.berg@avagotech.com>
 <CACRpkdavQBJkaC40GJkD396JkwPjSr_dzWegn8veLpG-Fcn-SQ@mail.gmail.com>
Message-ID: <CAE0=X_2W43VdysVJ6JGEMPuwq2nUSyYRX6Rm=Ds+Hait0i4gsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 3:26 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Sep 10, 2014 at 4:40 PM, Anders Berg <anders.berg@avagotech.com> wrote:
>
>> Add support for a extended PL022 which has an extra register for controlling up
>> to five chip select signals. This controller is found on the AXM5516 SoC.
>> Unfortunately the PrimeCell identification registers are identical to a
>> standard ARM PL022. To work around this, the peripheral ID must be overridden
>> in the device tree using the "arm,primecell-periphid" property with the value
>> 0x000b6022.
>>
>> Signed-off-by: Anders Berg <anders.berg@avagotech.com>
> (...)
>> +               /*
>> +                * PL022 variant that has a chip select control register whih
>> +                * allows control of 5 output signals nCS[0:4].
>> +                */
>> +               .id     = 0x000b6022,
>
> OK so you're defining 0xb6 to the the 8bit ID for LSI.
>
> Do you have some special reason for this, like that it appears
> in some other silicon block from LSI? Otherwise I suggest using
> 0x4c (uppercase 'L') so as to follow the pattern of the other
> vendor IDs.

I picked 0xb6 since I've seen some reference manuals for other AMBA
peripherals the use of JEDEC assigned vendor IDs in this register
field (see the PL390 TRM for example). So I put the LSI Logic 7-bit
JEDEC ID (0x36) there: [0:6] = 0x36, [7] = 1 (the MSB set to '1' to
signify the use of JEDEC ID instead of a "classic" AMBA vendor).

/Anders
