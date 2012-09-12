From: b32955@freescale.com (Huang Shijie)
Date: Wed, 12 Sep 2012 10:15:44 +0800
Subject: [PATCH 3/9] mtd: gpmi: add a new field for HW_GPMI_TIMING1
In-Reply-To: <504F7C22.1050605@gmail.com>
References: <1347344231-10295-1-git-send-email-b32955@freescale.com>
 <1347344231-10295-4-git-send-email-b32955@freescale.com>
 <504F7C22.1050605@gmail.com>
Message-ID: <504FF050.1070202@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?09?12? 02:00, Vikram Narayanan ??:
> Hello Huang Shijie,
>
> On 9/11/2012 11:47 AM, Huang Shijie wrote:
>> The gpmi_nfc_compute_hardware_timing{} should contains all the
>> fields setting for gpmi timing registers. It already contains the fields
>> for HW_GPMI_TIMING0 and HW_GPMI_CTRL1.
>>
>> So it is better to add a new field setting for HW_GPMI_TIMING1 in
>> this data structure. This makes the code more clear in logic.
>>
>> This patch also changes some comments to make the code more readable.
>>
>> Signed-off-by: Huang Shijie<b32955@freescale.com>
>> ---
>> drivers/mtd/nand/gpmi-nand/gpmi-lib.c | 17 +++++++++--------
>> drivers/mtd/nand/gpmi-nand/gpmi-nand.h | 9 +++++++++
>> drivers/mtd/nand/gpmi-nand/gpmi-regs.h | 3 +++
>> 3 files changed, 21 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c 
>> b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
>> index 2289cf8..fb9b3c1 100644
>> --- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
>> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
>> @@ -728,6 +728,7 @@ return_results:
>> hw->address_setup_in_cycles = address_setup_in_cycles;
>> hw->use_half_periods = dll_use_half_periods;
>> hw->sample_delay_factor = sample_delay_factor;
>> + hw->device_busy_timeout = 0x500; /* default busy timeout value. */
>
> Can we make this value a macro and put the comment there?
ok.

thanks.
>
>> /* Return success. */
>> return 0;
>> @@ -752,26 +753,26 @@ void gpmi_begin(struct gpmi_nand_data *this)
>> goto err_out;
>> }
>>
>> - /* set ready/busy timeout */
>> - writel(0x500<< BP_GPMI_TIMING1_BUSY_TIMEOUT,
>> - gpmi_regs + HW_GPMI_TIMING1);
>> -
>> /* Get the timing information we need. */
>> nfc->clock_frequency_in_hz = clk_get_rate(r->clock[0]);
>> clock_period_in_ns = 1000000000 / nfc->clock_frequency_in_hz;
>>
>> gpmi_nfc_compute_hardware_timing(this,&hw);
>>
>> - /* Set up all the simple timing parameters. */
>> + /* [1] Set HW_GPMI_TIMING0 */
>> reg = BF_GPMI_TIMING0_ADDRESS_SETUP(hw.address_setup_in_cycles) |
>> BF_GPMI_TIMING0_DATA_HOLD(hw.data_hold_in_cycles) |
>> BF_GPMI_TIMING0_DATA_SETUP(hw.data_setup_in_cycles) ;
>>
>> writel(reg, gpmi_regs + HW_GPMI_TIMING0);
>>
>> - /*
>> - * DLL_ENABLE must be set to 0 when setting RDN_DELAY or HALF_PERIOD.
>> - */
>> + /* [2] Set HW_GPMI_TIMING1 */
>> + writel(BF_GPMI_TIMING1_BUSY_TIMEOUT(hw.device_busy_timeout),
>> + gpmi_regs + HW_GPMI_TIMING1);
>> +
>> + /* [3] The following code is to set the HW_GPMI_CTRL1. */
>> +
>> + /* DLL_ENABLE must be set to 0 when setting RDN_DELAY or 
>> HALF_PERIOD. */
>> writel(BM_GPMI_CTRL1_DLL_ENABLE, gpmi_regs + HW_GPMI_CTRL1_CLR);
>
>
> Are these [1], [2], [3] notation references to some other comments?
no.

These notations just help to comment the steps of setting timing registers.
Are you confused at this?


>
>> /* Clear out the DLL control fields. */
>> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h 
>> b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
>> index 1f61217..e68bbac 100644
>> --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
>> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
>> @@ -189,14 +189,23 @@ struct gpmi_nand_data {
>> * @data_setup_in_cycles: The data setup time, in cycles.
>> * @data_hold_in_cycles: The data hold time, in cycles.
>> * @address_setup_in_cycles: The address setup time, in cycles.
>> + * @device_busy_timeout: The timeout waiting for NAND Ready/Busy,
>> + * this value is the number of cycles multiplied
>> + * by 4096.
>> * @use_half_periods: Indicates the clock is running slowly, so the
>> * NFC DLL should use half-periods.
>> * @sample_delay_factor: The sample delay factor.
>> */
>> struct gpmi_nfc_hardware_timing {
>> + /* for HW_GPMI_TIMING0 */
>> uint8_t data_setup_in_cycles;
>> uint8_t data_hold_in_cycles;
>> uint8_t address_setup_in_cycles;
>> +
>> + /* for HW_GPMI_TIMING1 */
>> + uint16_t device_busy_timeout;
>> +
>> + /* for HW_GPMI_CTRL1 */
>> bool use_half_periods;
>> uint8_t sample_delay_factor;
>> };
>> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-regs.h 
>> b/drivers/mtd/nand/gpmi-nand/gpmi-regs.h
>> index 8343124..7961c14 100644
>> --- a/drivers/mtd/nand/gpmi-nand/gpmi-regs.h
>> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-regs.h
>> @@ -154,6 +154,9 @@
>>
>> #define HW_GPMI_TIMING1 0x00000080
>> #define BP_GPMI_TIMING1_BUSY_TIMEOUT 16
>> +#define BM_GPMI_TIMING1_BUSY_TIMEOUT (0xff<< 
>> BP_GPMI_TIMING1_BUSY_TIMEOUT)
>
> Isn't this 0xffff?
> My Rev C manual states so. I might be wrong if I'm referring to a 
> older one!
this is my mistake.
It should be 0xffff.

thanks a lot !

Best Regards
Huang Shijie
