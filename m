From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Tue, 15 Dec 2015 15:27:21 +0200
Subject: [PATCH v2 0/2] i2c:dw: Add APM X-Gene ACPI I2C device support
In-Reply-To: <566F6485.2000508@amd.com>
References: <1449782357-22982-1-git-send-email-lho@apm.com>
 <566F6485.2000508@amd.com>
Message-ID: <20151215132721.GJ1762@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 06:53:25PM -0600, Suravee Suthikulanit wrote:
> I'm not sure if this has been discussed earlier. But after looking at the
> the acpi_apd driver, all we need is just the platform-specific input clock
> frequency value used by the drivers/i2c/busses/i2c-designware-core.c:
> i2c_dw_init() to calculate the values to program into the DW_IC_SS_SCL_HCNT
> and DW_IC_SS_SCL_LCNT registers.

There is a way to pass *CNT values already from ACPI to the driver -- It
looks for method called FMCN (or SSCN) and retrieves the values from
there if found.

The driver could be modified not to require clock if it already knows
*CNT values.

> So, instead of hard-coding this value into the driver/acpi/acpi_apd.c (which
> really has nothing to do with the I2C driver), what if we introduce a new
> ACPI key-value pair in the ACPI DSDT such as:
> 
>     Device(I2C0)    // I2C controller
>     {
>       Name(_HID, "AMDI0510")
>       Name(_UID, 0)
>       Name(_CRS, ResourceTemplate() {
>         Memory32Fixed (ReadWrite, 0xE1000000, 0x1000)
>         Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive,,,) { 389
> } // GSIV
>       })
>       Name (_DSD, Package () {
>         ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>         Package () {
>           Package (2) {"clock-source-frequency", 100000000 }

If this is to be done then I think it is better to use Linux clk
framework to provide the clock (with corresponding properties in place).

But ACPI specification wants clocks as PowerResources and those do not
have support for reading rate of the clock.

>         }
>       }) // _DSD()
>     }
