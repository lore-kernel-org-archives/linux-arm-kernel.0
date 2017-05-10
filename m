From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Wed, 10 May 2017 13:24:41 -0500
Subject: [PATCH v6 09/23] drivers/fsi: scan slaves & register devices
In-Reply-To: <CACPK8XfAtMzXnfS4TD7QXXwvrqgnwmpoQWoZcTbD2Hj2Dcnwgw@mail.gmail.com>
References: <20170410194706.64280-1-cbostic@linux.vnet.ibm.com>
 <20170410194706.64280-10-cbostic@linux.vnet.ibm.com>
 <CACPK8XfAtMzXnfS4TD7QXXwvrqgnwmpoQWoZcTbD2Hj2Dcnwgw@mail.gmail.com>
Message-ID: <277d5a2d-b78d-11da-3986-0cc42914b149@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 5/10/17 2:30 AM, Joel Stanley wrote:
> On Tue, Apr 11, 2017 at 5:16 AM, Christopher Bostic
> <cbostic@linux.vnet.ibm.com> wrote:
>> From: Jeremy Kerr <jk@ozlabs.org>
>>
>> Now that we have fsi_slave devices, scan each for endpoints, and
>> register them on the fsi bus.
>>
>> Includes contributions from Chris Bostic <cbostic@linux.vnet.ibm.com>
>>
>> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
>> Signed-off-by: Chris Bostic <cbostic@linux.vnet.ibm.com>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>>   drivers/fsi/fsi-core.c | 127 +++++++++++++++++++++++++++++++++++++++++++++++--
>>   include/linux/fsi.h    |   4 ++
>>   2 files changed, 128 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
>> index b7b138b..a8faa89 100644
>> --- a/drivers/fsi/fsi-core.c
>> +++ b/drivers/fsi/fsi-core.c
>> @@ -21,6 +21,19 @@
>>
>>   #include "fsi-master.h"
>>
>> +#define FSI_SLAVE_CONF_NEXT_MASK       0x80000000
>> +#define FSI_SLAVE_CONF_SLOTS_MASK      0x00ff0000
>> +#define FSI_SLAVE_CONF_SLOTS_SHIFT     16
>> +#define FSI_SLAVE_CONF_VERSION_MASK    0x0000f000
>> +#define FSI_SLAVE_CONF_VERSION_SHIFT   12
>> +#define FSI_SLAVE_CONF_TYPE_MASK       0x00000ff0
>> +#define FSI_SLAVE_CONF_TYPE_SHIFT      4
>> +#define FSI_SLAVE_CONF_CRC_SHIFT       4
>> +#define FSI_SLAVE_CONF_CRC_MASK                0x0000000f
>> +#define FSI_SLAVE_CONF_DATA_BITS       28
> You could use GENAMSK for these. It would make it easier to check eg.
> that 0x00ff0000 needs to be shifted by 16.

Hi Joel,

OK will update to use GENMASK.
>
>> +
>> +static const int engine_page_size = 0x400;
>> +
>>   #define FSI_SLAVE_BASE                 0x800
>>
>>   /*
>> @@ -61,6 +74,30 @@ static int fsi_master_read(struct fsi_master *master, int link,
>>   static int fsi_master_write(struct fsi_master *master, int link,
>>                  uint8_t slave_id, uint32_t addr, const void *val, size_t size);
>>
>> +/* FSI endpoint-device support */
>> +
>> +static void fsi_device_release(struct device *_device)
>> +{
>> +       struct fsi_device *device = to_fsi_dev(_device);
>> +
>> +       kfree(device);
>> +}
>> +
>> +static struct fsi_device *fsi_create_device(struct fsi_slave *slave)
>> +{
>> +       struct fsi_device *dev;
>> +
>> +       dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>> +       if (!dev)
>> +               return NULL;
>> +
>> +       dev->dev.parent = &slave->dev;
>> +       dev->dev.bus = &fsi_bus_type;
>> +       dev->dev.release = fsi_device_release;
>> +
>> +       return dev;
>> +}
>> +
>>   /* crc helpers */
>>   static const uint8_t crc4_tab[] = {
>>          0x0, 0x7, 0xe, 0x9, 0xb, 0xc, 0x5, 0x2,
>> @@ -138,6 +175,91 @@ static int fsi_slave_write(struct fsi_slave *slave, uint32_t addr,
>>                          addr, val, size);
>>   }
>>
>> +static int fsi_slave_scan(struct fsi_slave *slave)
>> +{
>> +       uint32_t engine_addr;
>> +       uint32_t conf;
>> +       int rc, i;
>> +
>> +       /*
>> +        * scan engines
>> +        *
>> +        * We keep the peek mode and slave engines for the core; so start
>> +        * at the third slot in the configuration table. We also need to
>> +        * skip the chip ID entry at the start of the address space.
>> +        */
>> +       engine_addr = engine_page_size * 3;
>> +       for (i = 2; i < engine_page_size / sizeof(uint32_t); i++) {
>> +               uint8_t slots, version, type, crc;
>> +               struct fsi_device *dev;
>> +
>> +               rc = fsi_slave_read(slave, (i + 1) * sizeof(conf),
>> +                               &conf, sizeof(conf));
>> +               if (rc) {
>> +                       dev_warn(&slave->dev,
>> +                               "error reading slave registers\n");
>> +                       return -1;
>> +               }
>> +               conf = be32_to_cpu(conf);
>> +
>> +               crc = fsi_crc4(0, conf, 32);
>> +               if (crc) {
>> +                       dev_warn(&slave->dev,
>> +                               "crc error in slave register at 0x%04x\n",
>> +                               i);
>> +                       return -1;
>> +               }
>> +
>> +               slots = (conf & FSI_SLAVE_CONF_SLOTS_MASK)
>> +                       >> FSI_SLAVE_CONF_SLOTS_SHIFT;
>> +               version = (conf & FSI_SLAVE_CONF_VERSION_MASK)
>> +                       >> FSI_SLAVE_CONF_VERSION_SHIFT;
>> +               type = (conf & FSI_SLAVE_CONF_TYPE_MASK)
>> +                       >> FSI_SLAVE_CONF_TYPE_SHIFT;
>> +
>> +               /*
>> +                * Unused address areas are marked by a zero type value; this
>> +                * skips the defined address areas
>> +                */
>> +               if (type != 0 && slots != 0) {
>> +
>> +                       /* create device */
>> +                       dev = fsi_create_device(slave);
>> +                       if (!dev)
>> +                               return -ENOMEM;
>> +
>> +                       dev->slave = slave;
>> +                       dev->engine_type = type;
>> +                       dev->version = version;
>> +                       dev->unit = i;
>> +                       dev->addr = engine_addr;
>> +                       dev->size = slots * engine_page_size;
>> +
>> +                       dev_info(&slave->dev,
>> +                       "engine[%i]: type %x, version %x, addr %x size %x\n",
>> +                                       dev->unit, dev->engine_type, version,
>> +                                       dev->addr, dev->size);
> This produces a lot of noise in the kernel log. I suggest making it
> drv_dbg if you require it. If you don't then remove it.

Will need for debug purposes so will change to dev_dbg( ).
>
>> +
>> +                       dev_set_name(&dev->dev, "%02x:%02x:%02x:%02x",
>> +                                       slave->master->idx, slave->link,
>> +                                       slave->id, i - 2);
>> +
>> +                       rc = device_register(&dev->dev);
>> +                       if (rc) {
>> +                               dev_warn(&slave->dev, "add failed: %d\n", rc);
>> +                               put_device(&dev->dev);
>> +                       }
>> +               }
>> +
>> +               engine_addr += slots * engine_page_size;
>> +
>> +               if (!(conf & FSI_SLAVE_CONF_NEXT_MASK))
>> +                       break;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>   /* Encode slave local bus echo delay */
>>   static inline uint32_t fsi_smode_echodly(int x)
>>   {
>> @@ -253,9 +375,8 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
>>                  return rc;
>>          }
>>
>> -       /* todo: perform engine scan */
>> -
>> -       return rc;
>> +       fsi_slave_scan(slave);
>> +       return 0;
> You don't check the return value of fsi_slave_scan.
Will correct.

Thanks,
-Chris

>>   }
>>
>>   /* FSI master support */
>> diff --git a/include/linux/fsi.h b/include/linux/fsi.h
>> index 273cbf6..efa55ba 100644
>> --- a/include/linux/fsi.h
>> +++ b/include/linux/fsi.h
>> @@ -21,6 +21,10 @@ struct fsi_device {
>>          struct device           dev;
>>          u8                      engine_type;
>>          u8                      version;
>> +       u8                      unit;
>> +       struct fsi_slave        *slave;
>> +       uint32_t                addr;
>> +       uint32_t                size;
>>   };
>>
>>   struct fsi_device_id {
>> --
>> 1.8.2.2
>>
