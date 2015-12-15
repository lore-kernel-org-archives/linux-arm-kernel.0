From: suravee.suthikulpanit@amd.com (Suravee Suthikulanit)
Date: Mon, 14 Dec 2015 18:53:25 -0600
Subject: [PATCH v2 0/2] i2c:dw: Add APM X-Gene ACPI I2C device support
In-Reply-To: <1449782357-22982-1-git-send-email-lho@apm.com>
References: <1449782357-22982-1-git-send-email-lho@apm.com>
Message-ID: <566F6485.2000508@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm not sure if this has been discussed earlier. But after looking at 
the the acpi_apd driver, all we need is just the platform-specific input 
clock frequency value used by the 
drivers/i2c/busses/i2c-designware-core.c: i2c_dw_init() to calculate the 
values to program into the DW_IC_SS_SCL_HCNT and DW_IC_SS_SCL_LCNT 
registers.

So, instead of hard-coding this value into the driver/acpi/acpi_apd.c 
(which really has nothing to do with the I2C driver), what if we 
introduce a new ACPI key-value pair in the ACPI DSDT such as:

     Device(I2C0)    // I2C controller
     {
       Name(_HID, "AMDI0510")
       Name(_UID, 0)
       Name(_CRS, ResourceTemplate() {
         Memory32Fixed (ReadWrite, 0xE1000000, 0x1000)
         Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive,,,) { 
389 } // GSIV
       })
       Name (_DSD, Package () {
         ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
         Package () {
           Package (2) {"clock-source-frequency", 100000000 }
         }
       }) // _DSD()
     }


Then, in the drivers/i2c/busses/i2c-designware-platdrv.c, we can add the 
code to parse this information. This way, the I2C driver can just 
retrieve this value from the ACPI table of each platform, which should 
make it easier to manage. Eventually, we can free I2C driver from the 
driver/acpi/acpi_apd.c, which is currently only used by AMD x86 platform.

Also, this approach would allow the I2C drivers in other OSes to use 
this same information in the ACPI table. If this approach is okay, I can 
provide a patch to implement this.

Thanks,
Suravee

On 12/10/2015 3:19 PM, Loc Ho wrote:
> Add APM X-Gene ACPI I2C device support. These patches follow
> the same implementation as AMD I2C driver - changes in ACPI APD
> and Designware I2C drivers.
>
> v2:
> * Spilt the acpi_apd change with defines for AMD and X-Gene I2C's
>
> Signed-off-by: Loc Ho <lho@apm.com>
> ---
> Loc Ho (2):
>    acpi:apd: Add APM X-Gene ACPI I2C device support
>    i2c:dw: Add APM X-Gene ACPI I2C device support
>
>   drivers/acpi/acpi_apd.c                     |   16 +++++++++++++++-
>   drivers/i2c/busses/i2c-designware-platdrv.c |    1 +
>   2 files changed, 16 insertions(+), 1 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
