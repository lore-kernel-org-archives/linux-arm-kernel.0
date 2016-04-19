From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 19 Apr 2016 10:45:14 -0600
Subject: [PATCH V2 13/15] coresight: tmc: implementing TMC-ETF AUX space
 API
In-Reply-To: <571659E0.4090605@arm.com>
References: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
 <1460483692-25061-14-git-send-email-mathieu.poirier@linaro.org>
 <571659E0.4090605@arm.com>
Message-ID: <CANLsYkz4NSNbLHUH6c+6oCo-3cxrHQ9eP9E=JACQ5qymMF0qaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 April 2016 at 10:16, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
> On 12/04/16 18:54, Mathieu Poirier wrote:
>>
>> This patch implement the AUX area interfaces required to
>> use the TMC (configured as an ETF) from the Perf sub-system.
>>
>> The heuristic is heavily borrowed from the ETB10 implementation.
>>
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> ---
>>   drivers/hwtracing/coresight/coresight-tmc-etf.c | 198
>> ++++++++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-tmc.h     |  21 +++
>>   2 files changed, 219 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> b/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> index a440784e3b27..fff175d4020d 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> @@ -15,7 +15,9 @@
>>    * this program.  If not, see <http://www.gnu.org/licenses/>.
>>    */
>>
>> +#include <linux/circ_buf.h>
>>   #include <linux/coresight.h>
>> +#include <linux/perf_event.h>
>>   #include <linux/slab.h>
>>   #include "coresight-priv.h"
>>   #include "coresight-tmc.h"
>> @@ -295,9 +297,205 @@ static void tmc_disable_etf_link(struct
>> coresight_device *csdev,
>>         dev_info(drvdata->dev, "TMC disabled\n");
>>   }
>>
>> +static void *tmc_alloc_etf_buffer(struct coresight_device *csdev, int
>> cpu,
>> +                                 void **pages, int nr_pages, bool
>> overwrite)
>
>
>
>
>> +
>> +static void tmc_free_etf_buffer(void *config)
>> +{
>
>
>> +
>> +static int tmc_set_etf_buffer(struct coresight_device *csdev,
>> +                             struct perf_output_handle *handle,
>> +                             void *sink_config)
>
>
>
>> +static unsigned long tmc_reset_etf_buffer(struct coresight_device *csdev,
>> +                                         struct perf_output_handle
>> *handle,
>> +                                         void *sink_config, bool *lost)
>> +{
>
>
>
>>   /**
>> + * struct cs_buffer - keep track of a recording session' specifics
>> + * @cur:       index of the current buffer
>> + * @nr_pages:  max number of pages granted to us
>> + * @offset:    offset within the current buffer
>> + * @data_size: how much we collected in this run
>> + * @lost:      other than zero if we had a HW buffer wrap around
>> + * @snapshot:  is this run in snapshot mode
>> + * @data_pages:        a handle the ring buffer
>> + */
>> +struct cs_tmc_buffers {
>> +       unsigned int            cur;
>> +       unsigned int            nr_pages;
>> +       unsigned long           offset;
>> +       local_t                 data_size;
>> +       local_t                 lost;
>> +       bool                    snapshot;
>> +       void                    **data_pages;
>> +};
>
>
>
> All of the above look exactly the same as what we have in etb10.c (as you
> have mentioned).
> Is there any chance we could reuse them under a generic name ?

I toyed with the idea many times...

Today the structures are similar and can be used in both drivers but
it is only a matter for time (probably months) before someone adds new
functionality on one side that isn't compatible with the other side.
When that happens we'll get a bloated struct with fields that aren't
used, depending on where it gets instantiated.  Or the struct will be
split again, coming back to what we have today.

>
>> +
>> +static void tmc_update_etf_buffer(struct coresight_device *csdev,
>
>
>
>> +        * Get a hold of the status register and see if a wrap around
>> +        * has occurred.  If so adjust things accordingly.
>> +        */
>> +       status = readl_relaxed(drvdata->base + TMC_STS);
>> +       if (status & TMC_STS_FULL) {
>> +               local_inc(&buf->lost);
>> +               to_read = drvdata->size;
>> +       } else {
>> +               to_read = CIRC_CNT(write_ptr, read_ptr, drvdata->size);
>> +       }
>> +
>> +       /*
>> +        * The TMC RAM buffer may be bigger than the space available in
>> the
>> +        * perf ring buffer (handle->size).  If so advance the RRP so that
>> we
>> +        * get the latest trace data.
>> +        */
>> +       if (to_read > handle->size) {
>> +               u32 mask = 0;
>> +
>> +               /*
>> +                * The value written to RRP must be byte-address aligned
>> to
>> +                * the width of the trace memory databus _and_ to a frame
>> +                * boundary (16 byte), whichever is the biggest. For
>> example,
>> +                * for 32-bit, 64-bit and 128-bit wide trace memory, the
>> four
>> +                * LSBs must be 0s. For 256-bit wide trace memory, the
>> five
>> +                * LSBs must be 0s.
>> +                */
>> +               switch (drvdata->memwidth) {
>> +               case TMC_MEM_INTF_WIDTH_32BITS:
>> +               case TMC_MEM_INTF_WIDTH_64BITS:
>> +               case TMC_MEM_INTF_WIDTH_128BITS:
>> +                       mask = GENMASK(31, 5);
>> +                       break;
>> +               case TMC_MEM_INTF_WIDTH_256BITS:
>> +                       mask = GENMASK(31, 6);
>> +                       break;
>> +               }
>> +
>> +               /*
>> +                * Make sure the new size is aligned in accordance with
>> the
>> +                * requirement explained above.
>> +                */
>> +               to_read -= handle->size & mask;
>
>
> Shouldn't this be :
>
>                 to_read = handle->size & mask;

You are correct.

>
>> +               /* Move the RAM read pointer up */
>> +               read_ptr = (write_ptr + drvdata->size) - to_read;
>> +               /* Make sure we are still within our limits */
>> +               read_ptr &= ~(drvdata->size - 1);
>> +               /* Tell the HW */
>> +               writel_relaxed(read_ptr, drvdata->base + TMC_RRP);
>> +               local_inc(&buf->lost);
>> +       }
>
>
>
> Suzuki
