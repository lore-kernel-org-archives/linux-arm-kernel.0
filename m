From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Tue, 8 Nov 2016 10:59:59 -0800
Subject: [PATCH 3/4] fpga mgr: zynq: Add support for encrypted bitstreams
In-Reply-To: <20161108183217.GV14444@xsjsorenbubuntu>
References: <20161107001326.7395-1-moritz.fischer@ettus.com>
 <20161107001326.7395-4-moritz.fischer@ettus.com>
 <20161108183217.GV14444@xsjsorenbubuntu>
Message-ID: <CAAtXAHciSxhEDf+dcG2fvXdHR_BMEs0vaGjc9ynwMi-HdVbWMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi S?ren,

On Tue, Nov 8, 2016 at 10:32 AM, S?ren Brinkmann
<soren.brinkmann@xilinx.com> wrote:
> On Sun, 2016-11-06 at 17:13:25 -0700, Moritz Fischer wrote:
>> Add new flag FPGA_MGR_DECRYPT_BISTREAM as well as a matching
>> capability FPGA_MGR_CAP_DECRYPT to allow for on-the-fly
>> decryption of an encrypted bitstream.
>>
>> If the system is not booted in secure mode AES & HMAC units
>> are disabled by the boot ROM, therefore the capability
>> is not available.
>>
>> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
>> Cc: Alan Tull <atull@opensource.altera.com>
>> Cc: Michal Simek <michal.simek@xilinx.com>
>> Cc: S?ren Brinkmann <soren.brinkmann@xilinx.com>
>> Cc: linux-kernel at vger.kernel.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> ---
>>  drivers/fpga/fpga-mgr.c       |  7 +++++++
>>  drivers/fpga/zynq-fpga.c      | 21 +++++++++++++++++++--
>>  include/linux/fpga/fpga-mgr.h |  2 ++
>>  3 files changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
>> index 98230b7..e4d08e1 100644
>> --- a/drivers/fpga/fpga-mgr.c
>> +++ b/drivers/fpga/fpga-mgr.c
>> @@ -61,6 +61,12 @@ int fpga_mgr_buf_load(struct fpga_manager *mgr, u32 flags, const char *buf,
>>               return -ENOTSUPP;
>>       }
>>
>> +     if (flags & FPGA_MGR_DECRYPT_BITSTREAM &&
>> +         !fpga_mgr_has_cap(FPGA_MGR_CAP_DECRYPT, mgr->caps)) {
>> +             dev_err(dev, "Bitstream decryption not supported\n");
>> +             return -ENOTSUPP;
>> +     }
>> +
>>       /*
>>        * Call the low level driver's write_init function.  This will do the
>>        * device-specific things to get the FPGA into the state where it is
>> @@ -170,6 +176,7 @@ static const char * const state_str[] = {
>>  static const char * const cap_str[] = {
>>       [FPGA_MGR_CAP_FULL_RECONF] = "Full reconfiguration",
>>       [FPGA_MGR_CAP_PARTIAL_RECONF] = "Partial reconfiguration",
>> +     [FPGA_MGR_CAP_DECRYPT] = "Decrypt bitstream on the fly",
>>  };
>>
>>  static ssize_t name_show(struct device *dev,
>> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
>> index 1d37ff0..0aa4705 100644
>> --- a/drivers/fpga/zynq-fpga.c
>> +++ b/drivers/fpga/zynq-fpga.c
>> @@ -71,6 +71,10 @@
>>  #define CTRL_PCAP_PR_MASK            BIT(27)
>>  /* Enable PCAP */
>>  #define CTRL_PCAP_MODE_MASK          BIT(26)
>> +/* Needed to reduce clock rate for secure config */
>> +#define CTRL_PCAP_RATE_EN_MASK               BIT(25)
>> +/* System booted in secure mode */
>> +#define CTRL_SEC_EN_MASK             BIT(7)
>>
>>  /* Miscellaneous Control Register bit definitions */
>>  /* Internal PCAP loopback */
>> @@ -252,12 +256,20 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
>>
>>       /* set configuration register with following options:
>>        * - enable PCAP interface
>> -      * - set throughput for maximum speed
>> +      * - set throughput for maximum speed (if we're not decrypting)
>>        * - set CPU in user mode
>>        */
>>       ctrl = zynq_fpga_read(priv, CTRL_OFFSET);
>> -     zynq_fpga_write(priv, CTRL_OFFSET,
>> +     if (flags & FPGA_MGR_DECRYPT_BITSTREAM) {
>> +             zynq_fpga_write(priv, CTRL_OFFSET,
>> +                     (CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK |
>> +                      CTRL_PCAP_RATE_EN_MASK | ctrl));
>> +
>> +     } else {
>> +             ctrl &= ~CTRL_PCAP_RATE_EN_MASK;
>> +             zynq_fpga_write(priv, CTRL_OFFSET,
>>                       (CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK | ctrl));
>> +     }
>
> Minor nit:
> Assuming that there may be more caps to check to come, wouldn't it be
> slightly easier to write this in a way like?:
>   if (flags & SOME_FLAG)
>      ctrl |= FOO;
>   if (flags & SOME_OTHER_FLAG)
>      ctrl |= BAR;
>   zynq_fpga_write(priv, CTRL_OFFSET, ctrl);
>
> i.e. moving the fpga_write outside of the conditionals.

Yeah, will do. Definitely better that way.

Thanks for the review,

Moritz
