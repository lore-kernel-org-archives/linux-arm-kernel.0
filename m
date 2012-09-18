From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 18 Sep 2012 14:08:12 +0200
Subject: [PATCH 09/19] ARM: ux500: Enable SSP (SPI) for HREF when booting
 Device Tree
In-Reply-To: <505757D8.8090405@antcom.de>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-10-git-send-email-lee.jones@linaro.org>
 <CACRpkdaC_enpxUFNM_wteAQWKER_naUNUH-s1pJtiGzVFSV+og@mail.gmail.com>
 <505757D8.8090405@antcom.de>
Message-ID: <CACRpkdZLdernphVSfwHS43HptS+33=PzorihQ0bBKm689u_oFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 7:03 PM, Roland Stigge <stigge@antcom.de> wrote:
> On 09/10/2012 01:11 PM, Linus Walleij wrote:
>>
>> It appears Roland has written his bindings such that DT
>> data augments platform data (yes, I am also getting crazy
>> about this prioritization, mea culpa for ACKing this without
>> proper discussion) so it appears that you could actually
>> use AUXDATA and some stuff in the DT at the same
>> time.
>
> Sorry for the incompleteness of the devicetree conversion. I'm sending a
> patch (separately) that makes it possible to specify everything via
> devicetree, so you can choose between dt and platform data.

OK it was not such a big deal, but many many thanks for fixing this
up! :-)

> Except in case of callback specification (dma_filter()), you need to
> provide platform data.

OK.

> Interestingly, when I removed the actual platform data from the board
> file, I noticed that I still needed to specify a device name (like
> dev:ssp0) to make it work. But this seems to be expected according to
> the documentation of OF_DEV_AUXDATA(). Are there any plans or ideas how
> to fix this?

This is very likely because the clock tree has a name like "dev:ssp0"
encoded for this device, and if you don't nail it down like that the
device name will be the same as the node in your device tree and
then clock lookup will fail.

The "real fix" is to convert the clock drivers to use device tree so
the drivers can just refer to the phandles to figure out what clock
node they need.

Along with the DMA channel mapping this is one of the major
roadblocks to finalizing the device tree adoptions.

> When we have sorted out this driver change (please check the new pl022
> specific dt property names!), I will provide patches for arm-soc to
> actually use this new interface via dts files.

OK cool I guess you will do this for the LPC32xx? Or are you testing
this on some other platforms?

Yours,
Linus Walleij
