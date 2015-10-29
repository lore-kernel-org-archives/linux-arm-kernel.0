From: shubhrajyoti.datta@gmail.com (Shubhrajyoti Datta)
Date: Thu, 29 Oct 2015 20:27:43 +0530
Subject: [PATCH v2] i2c: cadence: Move to sensible power management
In-Reply-To: <20151028161810.GB6436@xsjsorenbubuntu>
References: <1446017200-30373-1-git-send-email-shubhraj@xilinx.com>
 <20151028161810.GB6436@xsjsorenbubuntu>
Message-ID: <CAKfKVtHbKrYK-JkQRWO3hEyOkGEW8q9zc6r90PNP8uEm3VXc4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2015 at 9:48 PM, S?ren Brinkmann
<soren.brinkmann@xilinx.com> wrote:
> Hi Shubhrajyoti,
>
>
> On Wed, 2015-10-28 at 12:56PM +0530, Shubhrajyoti Datta wrote:
>> Currently the clocks are enabled at probe and disabled at remove.
>> Which keeps the clocks enabled even if no transaction is going on.
>> This patch enables the clocks at the start of transfer and disables
>> after it.
>>
>> Also adapts to runtime pm.
>> Remove xi2c->suspended and use pm runtime status instead.
>>
>> converts dev pm to const to silence a checkpatch warning.
>>
>> Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>
>
> To me, this looks all good. Just one small concern below.

Thanks for the review.

>
>> ---
>> changes since v2
>> update the cc list
>>
>>  drivers/i2c/busses/i2c-cadence.c |   73 ++++++++++++++++++++++++--------------
>>  1 files changed, 46 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
>> index 84deed6..6b08d16 100644
>> --- a/drivers/i2c/busses/i2c-cadence.c
>> +++ b/drivers/i2c/busses/i2c-cadence.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/module.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/of.h>
>> +#include <linux/pm_runtime.h>
>>
>>  /* Register offsets for the I2C device. */
>>  #define CDNS_I2C_CR_OFFSET           0x00 /* Control Register, RW */
>> @@ -96,6 +97,8 @@
>>                                        CDNS_I2C_IXR_COMP)
>>
>>  #define CDNS_I2C_TIMEOUT             msecs_to_jiffies(1000)
>> +/* timeout for pm runtime autosuspend */
>> +#define CNDS_I2C_PM_TIMEOUT          1000    /* ms */
>>
>>  #define CDNS_I2C_FIFO_DEPTH          16
>>  /* FIFO depth at which the DATA interrupt occurs */
>> @@ -128,7 +131,6 @@
>>   * @xfer_done:               Transfer complete status
>>   * @p_send_buf:              Pointer to transmit buffer
>>   * @p_recv_buf:              Pointer to receive buffer
>> - * @suspended:               Flag holding the device's PM status
>>   * @send_count:              Number of bytes still expected to send
>>   * @recv_count:              Number of bytes still expected to receive
>>   * @curr_recv_count: Number of bytes to be received in current transfer
>> @@ -141,6 +143,7 @@
>>   * @quirks:          flag for broken hold bit usage in r1p10
>>   */
>>  struct cdns_i2c {
>> +     struct device           *dev;
>>       void __iomem *membase;
>>       struct i2c_adapter adap;
>>       struct i2c_msg *p_msg;
>> @@ -148,7 +151,6 @@ struct cdns_i2c {
>>       struct completion xfer_done;
>>       unsigned char *p_send_buf;
>>       unsigned char *p_recv_buf;
>> -     u8 suspended;
>
> There might have been a reason to store this flag here. Did you test
> this with lockdep and CONFIG_DEBUG_ATOMIC_SLEEP? Just to make sure that
> nothing that can sleep is called from atomic context.
Done now.


Essentially this is a flag is set in suspend routine. and checked in
the isr I use
pm_runtime_suspended(id->dev) instead.

>
>         S?ren
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
