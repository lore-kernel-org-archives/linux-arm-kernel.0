From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Jan 2014 20:43:51 +0100
Subject: [PATCH V2 1/6] Documentation: add dts binding for X-Gene reboot
 dts node.
In-Reply-To: <CAL85gmCTsxng3jCaAcCjePE6Pxu7Jg98TDUqQrDFzsfW2GQwEg@mail.gmail.com>
References: <1389135041-16062-1-git-send-email-fkan@apm.com>
 <201401131619.35030.arnd@arndb.de>
 <CAL85gmCTsxng3jCaAcCjePE6Pxu7Jg98TDUqQrDFzsfW2GQwEg@mail.gmail.com>
Message-ID: <201401132043.52491.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 13 January 2014, Feng Kan wrote:
> FKAN: I could remove this dts node and create another dts node that
> describe the range of registers on the SCU and use that node in this driver.
> I am not sure which subsystem I can use to handle this case, I do see a reset
> subsystem in the kernel but more used for ip resets. Please kindly let
> me know. Thanks for the great feedback.

Is this related to the standard ARM SCU that manages multiprocessor
systems, or a different unit that uses the same name?

Since this is a global register range with a variety of things in it,
the best candidate IMHO would be to use the "syscon" driver. You can
mark the device node as 'compatible="apm,xgene-scu","syscon"' to let
it get picked up by the drivers/mfd/syscon driver, which creates
a "regmap" structure for it.

The reset driver then uses a DT reference with a phandle to the
SCU node and calls syscon_regmap_lookup_by_phandle() to get the
regmap. It can get the register number inside the regmap from DT
as well and use the regmap API to perform the reset.

	Arnd
