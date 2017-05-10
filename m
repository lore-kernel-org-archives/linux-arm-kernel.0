From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Wed, 10 May 2017 13:15:56 -0500
Subject: [PATCH v6 19/23] drivers/fsi: Add GPIO based FSI master
In-Reply-To: <CACPK8Xf1Y31+HBHb0ErpnZ4xVM+bzfHV-khj-kz8Unk1cTx6gw@mail.gmail.com>
References: <20170410194706.64280-1-cbostic@linux.vnet.ibm.com>
 <20170410194706.64280-20-cbostic@linux.vnet.ibm.com>
 <CACPK8Xf1Y31+HBHb0ErpnZ4xVM+bzfHV-khj-kz8Unk1cTx6gw@mail.gmail.com>
Message-ID: <c05599db-7767-e712-7199-7d5a4ac6486f@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 5/10/17 2:30 AM, Joel Stanley wrote:
> Hi Chris,
>
> On Tue, Apr 11, 2017 at 5:17 AM, Christopher Bostic
> <cbostic@linux.vnet.ibm.com> wrote:
>
>> From: Chris Bostic <cbostic@linux.vnet.ibm.com>
>>
>> Implement a FSI master using GPIO.  Will generate FSI protocol for
>> read and write commands to particular addresses.  Sends master command
>> and waits for and decodes a slave response.
>>
>> Includes changes from Edward A. James <eajames@us.ibm.com> and Jeremy
>> Kerr <jk@ozlabs.org>.
> I think the series is looking good. I've done a bunch of testing on
> some machines, and it worked for me.
>
> I've got a few comments and things to be clarified below.
>
>> Signed-off-by: Edward A. James <eajames@us.ibm.com>
>> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
>> Signed-off-by: Chris Bostic <cbostic@linux.vnet.ibm.com>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>>   drivers/fsi/Kconfig           |  11 +
>>   drivers/fsi/Makefile          |   1 +
>>   drivers/fsi/fsi-master-gpio.c | 610 ++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 622 insertions(+)
>>   create mode 100644 drivers/fsi/fsi-master-gpio.c
>>
>> diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
>> index 04c1a0e..448bc3b 100644
>> --- a/drivers/fsi/Kconfig
>> +++ b/drivers/fsi/Kconfig
>> @@ -9,4 +9,15 @@ config FSI
>>          ---help---
>>            FSI - the FRU Support Interface - is a simple bus for low-level
>>            access to POWER-based hardware.
>> +
>> +if FSI
>> +
>> +config FSI_MASTER_GPIO
>> +       tristate "GPIO-based FSI master"
>> +       depends on GPIOLIB
>> +       ---help---
>> +       This option enables a FSI master driver using GPIO lines.
>> +
>> +endif
>> +
>>   endmenu
>> diff --git a/drivers/fsi/Makefile b/drivers/fsi/Makefile
>> index db0e5e7..ed28ac0 100644
>> --- a/drivers/fsi/Makefile
>> +++ b/drivers/fsi/Makefile
>> @@ -1,2 +1,3 @@
>>
>>   obj-$(CONFIG_FSI) += fsi-core.o
>> +obj-$(CONFIG_FSI_MASTER_GPIO) += fsi-master-gpio.o
>> diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
>> new file mode 100644
>> index 0000000..9fedfaf
>> --- /dev/null
>> +++ b/drivers/fsi/fsi-master-gpio.c
>> @@ -0,0 +1,610 @@
>> +/*
>> + * A FSI master controller, using a simple GPIO bit-banging interface
>> + */
>> +
>> +#include <linux/platform_device.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/module.h>
>> +#include <linux/delay.h>
>> +#include <linux/fsi.h>
>> +#include <linux/device.h>
>> +#include <linux/io.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +
>> +#include "fsi-master.h"
>> +
>> +#define        FSI_GPIO_STD_DLY        1       /* Standard pin delay in nS */
>> +#define        FSI_ECHO_DELAY_CLOCKS   16      /* Number clocks for echo delay */
>> +#define        FSI_PRE_BREAK_CLOCKS    50      /* Number clocks to prep for break */
>> +#define        FSI_BREAK_CLOCKS        256     /* Number of clocks to issue break */
>> +#define        FSI_POST_BREAK_CLOCKS   16000   /* Number clocks to set up cfam */
>> +#define        FSI_INIT_CLOCKS         5000    /* Clock out any old data */
>> +#define        FSI_GPIO_STD_DELAY      10      /* Standard GPIO delay in nS */
>> +                                       /* todo: adjust down as low as */
>> +                                       /* possible or eliminate */
>> +#define        FSI_GPIO_CMD_DPOLL      0x2
>> +#define        FSI_GPIO_CMD_TERM       0x3f
>> +#define FSI_GPIO_CMD_ABS_AR    0x4
>> +
>> +#define        FSI_GPIO_DPOLL_CLOCKS   100      /* < 21 will cause slave to hang */
>> +
>> +/* Bus errors */
>> +#define        FSI_GPIO_ERR_BUSY       1       /* Slave stuck in busy state */
>> +#define        FSI_GPIO_RESP_ERRA      2       /* Any (misc) Error */
>> +#define        FSI_GPIO_RESP_ERRC      3       /* Slave reports master CRC error */
>> +#define        FSI_GPIO_MTOE           4       /* Master time out error */
>> +#define        FSI_GPIO_CRC_INVAL      5       /* Master reports slave CRC error */
>> +
>> +/* Normal slave responses */
>> +#define        FSI_GPIO_RESP_BUSY      1
>> +#define        FSI_GPIO_RESP_ACK       0
>> +#define        FSI_GPIO_RESP_ACKD      4
>> +
>> +#define        FSI_GPIO_MAX_BUSY       100
>> +#define        FSI_GPIO_MTOE_COUNT     1000
>> +#define        FSI_GPIO_DRAIN_BITS     20
>> +#define        FSI_GPIO_CRC_SIZE       4
>> +#define        FSI_GPIO_MSG_ID_SIZE            2
>> +#define        FSI_GPIO_MSG_RESPID_SIZE        2
>> +#define        FSI_GPIO_PRIME_SLAVE_CLOCKS     100
>> +
>> +static DEFINE_SPINLOCK(fsi_gpio_cmd_lock);     /* lock around fsi commands */
> Should this be per-master?

Hi Joel,

I don't think we'd want this per master.   The lock is for the 'top' 
master issuing commands.  Only the top master can initiate any 
transactions on the bus to any devices connected downstream. Downstream 
masters such as hub masters, etc... cannot initiate a command.
>
>> +
>> +struct fsi_master_gpio {
>> +       struct fsi_master       master;
>> +       struct device           *dev;
>> +       struct gpio_desc        *gpio_clk;
>> +       struct gpio_desc        *gpio_data;
>> +       struct gpio_desc        *gpio_trans;    /* Voltage translator */
>> +       struct gpio_desc        *gpio_enable;   /* FSI enable */
>> +       struct gpio_desc        *gpio_mux;      /* Mux control */
>> +};
>> +
>> +#define to_fsi_master_gpio(m) container_of(m, struct fsi_master_gpio, master)
>> +
>> +struct fsi_gpio_msg {
>> +       uint64_t        msg;
>> +       uint8_t         bits;
>> +};
>> +
>> +static void clock_toggle(struct fsi_master_gpio *master, int count)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < count; i++) {
>> +               ndelay(FSI_GPIO_STD_DLY);
>> +               gpiod_set_value(master->gpio_clk, 0);
>> +               ndelay(FSI_GPIO_STD_DLY);
>> +               gpiod_set_value(master->gpio_clk, 1);
>> +       }
>> +}
>> +
>> +static int sda_in(struct fsi_master_gpio *master)
>> +{
>> +       int in;
>> +
>> +       ndelay(FSI_GPIO_STD_DLY);
>> +       in = gpiod_get_value(master->gpio_data);
>> +       return in ? 1 : 0;
>> +}
>> +
>> +static void sda_out(struct fsi_master_gpio *master, int value)
>> +{
>> +       gpiod_set_value(master->gpio_data, value);
>> +}
>> +
>> +static void set_sda_input(struct fsi_master_gpio *master)
>> +{
>> +       gpiod_direction_input(master->gpio_data);
>> +       if (master->gpio_trans)
>> +               gpiod_set_value(master->gpio_trans, 0);
> gpiod_set_value checks for the first argument being NULL. You could
> drop your check here.

Will remove the check.
>> +}
>> +
>> +static void set_sda_output(struct fsi_master_gpio *master, int value)
>> +{
>> +       if (master->gpio_trans)
>> +               gpiod_set_value(master->gpio_trans, 1);
>> +       gpiod_direction_output(master->gpio_data, value);
>> +}
>> +
>> +static void clock_zeros(struct fsi_master_gpio *master, int count)
>> +{
>> +       set_sda_output(master, 1);
>> +       clock_toggle(master, count);
>> +}
>> +
>> +static void serial_in(struct fsi_master_gpio *master, struct fsi_gpio_msg *msg,
>> +                       uint8_t num_bits)
>> +{
>> +       uint8_t bit, in_bit;
>> +
>> +       set_sda_input(master);
>> +
>> +       for (bit = 0; bit < num_bits; bit++) {
>> +               clock_toggle(master, 1);
>> +               in_bit = sda_in(master);
>> +               msg->msg <<= 1;
>> +               msg->msg |= ~in_bit & 0x1;      /* Data is negative active */
> "Active low" makes more sense than negative active.

Will reword.

>> +       }
>> +       msg->bits += num_bits;
>> +}
>> +
>> +static void serial_out(struct fsi_master_gpio *master,
>> +                       const struct fsi_gpio_msg *cmd)
>> +{
>> +       uint8_t bit;
>> +       uint64_t msg = ~cmd->msg;       /* Data is negative active */
>> +       uint64_t sda_mask = 0x1ULL << (cmd->bits - 1);
>> +       uint64_t last_bit = ~0;
>> +       int next_bit;
>> +
>> +       if (!cmd->bits) {
>> +               dev_warn(master->dev, "trying to output 0 bits\n");
>> +               return;
>> +       }
>> +       set_sda_output(master, 0);
>> +
>> +       /* Send the start bit */
>> +       sda_out(master, 0);
>> +       clock_toggle(master, 1);
>> +
>> +       /* Send the message */
>> +       for (bit = 0; bit < cmd->bits; bit++) {
>> +               next_bit = (msg & sda_mask) >> (cmd->bits - 1);
>> +               if (last_bit ^ next_bit) {
>> +                       sda_out(master, next_bit);
>> +                       last_bit = next_bit;
>> +               }
>> +               clock_toggle(master, 1);
>> +               msg <<= 1;
>> +       }
>> +}
>> +
>> +static void msg_push_bits(struct fsi_gpio_msg *msg, uint64_t data, int bits)
>> +{
>> +       msg->msg <<= bits;
>> +       msg->msg |= data & ((1ull << bits) - 1);
>> +       msg->bits += bits;
>> +}
>> +
>> +static void msg_push_crc(struct fsi_gpio_msg *msg)
>> +{
>> +       uint8_t crc;
>> +       int top;
>> +
>> +       top = msg->bits & 0x3;
>> +
>> +       /* start bit, and any non-aligned top bits */
>> +       crc = fsi_crc4(0,
>> +                       1 << top | msg->msg >> (msg->bits - top),
>> +                       top + 1);
>> +
>> +       /* aligned bits */
>> +       crc = fsi_crc4(crc, msg->msg, msg->bits - top);
>> +
>> +       msg_push_bits(msg, crc, 4);
>> +}
>> +
>> +static void build_abs_ar_command(struct fsi_gpio_msg *cmd,
>> +               uint8_t id, uint32_t addr, size_t size, const void *data)
> What is abs_ar? Perhaps a comment would help.

ok, will add some text here.

>> +{
>> +       bool write = !!data;
>> +       uint8_t ds;
>> +       int i;
>> +
>> +       cmd->bits = 0;
>> +       cmd->msg = 0;
>> +
>> +       msg_push_bits(cmd, id, 2);
>> +       msg_push_bits(cmd, FSI_GPIO_CMD_ABS_AR, 3);
>> +       msg_push_bits(cmd, write ? 0 : 1, 1);
>> +
>> +       /*
>> +        * The read/write size is encoded in the lower bits of the address
>> +        * (as it must be naturally-aligned), and the following ds bit.
>> +        *
>> +        *      size    addr:1  addr:0  ds
>> +        *      1       x       x       0
>> +        *      2       x       0       1
>> +        *      4       0       1       1
>> +        *
>> +        */
>> +       ds = size > 1 ? 1 : 0;
>> +       addr &= ~(size - 1);
>> +       if (size == 4)
>> +               addr |= 1;
>> +
>> +       msg_push_bits(cmd, addr & ((1 << 21) - 1), 21);
>> +       msg_push_bits(cmd, ds, 1);
>> +       for (i = 0; write && i < size; i++)
>> +               msg_push_bits(cmd, ((uint8_t *)data)[i], 8);
>> +
>> +       msg_push_crc(cmd);
>> +}
>> +
>> +static void build_dpoll_command(struct fsi_gpio_msg *cmd, uint8_t slave_id)
>> +{
>> +       cmd->bits = 0;
>> +       cmd->msg = 0;
>> +
>> +       msg_push_bits(cmd, slave_id, 2);
>> +       msg_push_bits(cmd, FSI_GPIO_CMD_DPOLL, 3);
>> +       msg_push_crc(cmd);
>> +}
>> +
>> +static void echo_delay(struct fsi_master_gpio *master)
>> +{
>> +       set_sda_output(master, 1);
>> +       clock_toggle(master, FSI_ECHO_DELAY_CLOCKS);
>> +}
>> +
>> +static void build_term_command(struct fsi_gpio_msg *cmd, uint8_t slave_id)
>> +{
>> +       cmd->bits = 0;
>> +       cmd->msg = 0;
>> +
>> +       msg_push_bits(cmd, slave_id, 2);
>> +       msg_push_bits(cmd, FSI_GPIO_CMD_TERM, 6);
>> +       msg_push_crc(cmd);
>> +}
>> +
>> +/*
>> + * Store information on master errors so handler can detect and clean
>> + * up the bus
>> + */
>> +static void fsi_master_gpio_error(struct fsi_master_gpio *master, int error)
>> +{
>> +
>> +}
>> +
>> +static int read_one_response(struct fsi_master_gpio *master,
>> +               uint8_t data_size, struct fsi_gpio_msg *msgp, uint8_t *tagp)
>> +{
>> +       struct fsi_gpio_msg msg;
>> +       uint8_t id, tag;
>> +       uint32_t crc;
>> +       int i;
>> +
>> +       /* wait for the start bit */
>> +       for (i = 0; i < FSI_GPIO_MTOE_COUNT; i++) {
>> +               msg.bits = 0;
>> +               msg.msg = 0;
>> +               serial_in(master, &msg, 1);
>> +               if (msg.msg)
>> +                       break;
>> +       }
>> +       if (i >= FSI_GPIO_MTOE_COUNT) {
> Testing for == will do.
Will change.

>> +               dev_dbg(master->dev,
>> +                       "Master time out waiting for response\n");
>> +               fsi_master_gpio_error(master, FSI_GPIO_MTOE);
>> +               return -EIO;
>> +       }
>> +
>> +       msg.bits = 0;
>> +       msg.msg = 0;
>> +
>> +       /* Read slave ID & response tag */
>> +       serial_in(master, &msg, 4);
>> +
>> +       id = (msg.msg >> FSI_GPIO_MSG_RESPID_SIZE) & 0x3;
>> +       tag = msg.msg & 0x3;
>> +
>> +       /* if we have an ACK, and we're expecting data, clock the
>> +        * data in too
>> +        */
> The comment should fit on one line.
Will correct.

>> +       if (tag == FSI_GPIO_RESP_ACK && data_size)
>> +               serial_in(master, &msg, data_size * 8);
>> +
>> +       /* read CRC */
>> +       serial_in(master, &msg, FSI_GPIO_CRC_SIZE);
>> +
>> +       /* we have a whole message now; check CRC */
>> +       crc = fsi_crc4(0, 1, 1);
>> +       crc = fsi_crc4(crc, msg.msg, msg.bits);
>> +       if (crc) {
>> +               dev_dbg(master->dev, "ERR response CRC\n");
>> +               fsi_master_gpio_error(master, FSI_GPIO_CRC_INVAL);
>> +               return -EIO;
>> +       }
>> +
>> +       if (msgp)
>> +               *msgp = msg;
>> +       if (tagp)
>> +               *tagp = tag;
>> +
>> +       return 0;
>> +}
>> +
>> +static int issue_term(struct fsi_master_gpio *master, uint8_t slave)
>> +{
>> +       struct fsi_gpio_msg cmd;
>> +       uint8_t tag;
>> +       int rc;
>> +
>> +       build_term_command(&cmd, slave);
>> +       serial_out(master, &cmd);
>> +       echo_delay(master);
>> +
>> +       rc = read_one_response(master, 0, NULL, &tag);
>> +       if (rc) {
>   read_one_response returns zero on success and a negative error code
> on failure. Do you mean if (rc < 0)?

I can make the change.  Makes sense to make that more explicit.

>> +               dev_err(master->dev,
>> +                               "TERM failed; lost communication with slave\n");
>> +               return -EIO;
>> +       } else if (tag != FSI_GPIO_RESP_ACK) {
>> +               dev_err(master->dev, "TERM failed; response %d\n", tag);
>> +               return -EIO;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int poll_for_response(struct fsi_master_gpio *master,
>> +               uint8_t slave, uint8_t size, void *data)
>> +{
>> +       struct fsi_gpio_msg response, cmd;
>> +       int busy_count = 0, rc, i;
>> +       uint8_t tag;
>> +
>> +retry:
>> +       rc = read_one_response(master, size, &response, &tag);
>> +       if (rc)
>> +               return rc;
>> +
>> +       switch (tag) {
>> +       case FSI_GPIO_RESP_ACK:
>> +               if (size && data) {
>> +                       uint64_t val = response.msg;
>> +                       /* clear crc & mask */
>> +                       val >>= 4;
>> +                       val &= (1ull << (size * 8)) - 1;
>>
>> You could write this as a GENMASK. Not sure if it's more readable though.
>>
>> val &= GENMASK_ULL(size * 8 - 1, 0)

I could make that change but as you mention I'm not sure its any more 
readable.  For now
I'd prefer to leave as is unless there is a strong preference to update it.

>> +
>> +                       for (i = 0; i < size; i++) {
>> +                               ((uint8_t *)data)[size-i-1] =
>> +                                       val & 0xff;
>> +                               val >>= 8;
> Put this on one line so it's easier to read:
>
> ((uint8_t *)data)[size-i-1] = val & 0xff;
>
> You can drop the 0xff; this is happening implicitly when assigning to
> the uint_8 array.
>
> I suggest creating a local variable of type uint8_t * so you don't
> need the cast.

Ok, will update.
>
>> +                       }
>> +               }
>> +               break;
>> +       case FSI_GPIO_RESP_BUSY:
>> +               /*
>> +                * Its necessary to clock slave before issuing
>> +                * d-poll, not indicated in the hardware protocol
>> +                * spec. < 20 clocks causes slave to hang, 21 ok.
>> +                */
>> +               clock_zeros(master, FSI_GPIO_DPOLL_CLOCKS);
>> +               if (busy_count++ < FSI_GPIO_MAX_BUSY) {
>> +                       build_dpoll_command(&cmd, slave);
>> +                       serial_out(master, &cmd);
>> +                       echo_delay(master);
>> +                       goto retry;
>> +               }
>> +               dev_warn(master->dev,
>> +                       "ERR slave is stuck in busy state, issuing TERM\n");
>> +               issue_term(master, slave);
>> +               rc = -EIO;
>> +               break;
>> +
>> +       case FSI_GPIO_RESP_ERRA:
>> +       case FSI_GPIO_RESP_ERRC:
>> +               dev_dbg(master->dev, "ERR%c received: 0x%x\n",
>> +                       tag == FSI_GPIO_RESP_ERRA ? 'A' : 'C',
>> +                       (int)response.msg);
>> +               fsi_master_gpio_error(master, response.msg);
>> +               rc = -EIO;
>> +               break;
>> +       }
>> +
>> +       /* Clock the slave enough to be ready for next operation */
>> +       clock_zeros(master, FSI_GPIO_PRIME_SLAVE_CLOCKS);
> Do you need to do this after an issue_term?

Yes, from hardware tests I found it is necessary to clock the slave.  
The slave relies
on the master to provide it clocks so that it can advance its state 
machines (if configured
to rely on external master clocks).

> How about after a fsi_master_gpio_error? I suspect yes, for now, as
> this function is empty (?!).

Not sure I understand.   Are you asking if clock_zeroes() should be done 
after
fsi_master_gpio_error( ) ?
>> +       return rc;
>> +}
>> +
>> +static int fsi_master_gpio_xfer(struct fsi_master_gpio *master, uint8_t slave,
>> +               struct fsi_gpio_msg *cmd, size_t resp_len, void *resp)
>> +{
>> +       unsigned long flags;
>> +       int rc;
>> +
>> +       spin_lock_irqsave(&fsi_gpio_cmd_lock, flags);
>> +       serial_out(master, cmd);
>> +       echo_delay(master);
>> +       rc = poll_for_response(master, slave, resp_len, resp);
>> +       spin_unlock_irqrestore(&fsi_gpio_cmd_lock, flags);
>> +
>> +       return rc;
>> +}
>> +
>> +static int fsi_master_gpio_read(struct fsi_master *_master, int link,
>> +               uint8_t id, uint32_t addr, void *val, size_t size)
>> +{
>> +       struct fsi_master_gpio *master = to_fsi_master_gpio(_master);
>> +       struct fsi_gpio_msg cmd;
>> +
>> +       if (link != 0)
>> +               return -ENODEV;
> Is this because we only support one link?

Correct.  Some of the general scan function allows for multiple master 
links but
like here it is stubbed out.   Will be modified once multi link support 
is required.
>
>> +
>> +       build_abs_ar_command(&cmd, id, addr, size, NULL);
>> +       return fsi_master_gpio_xfer(master, id, &cmd, size, val);
>> +}
>> +
>> +static int fsi_master_gpio_write(struct fsi_master *_master, int link,
>> +               uint8_t id, uint32_t addr, const void *val, size_t size)
>> +{
>> +       struct fsi_master_gpio *master = to_fsi_master_gpio(_master);
>> +       struct fsi_gpio_msg cmd;
>> +
>> +       if (link != 0)
>> +               return -ENODEV;
>> +
>> +       build_abs_ar_command(&cmd, id, addr, size, val);
>> +       return fsi_master_gpio_xfer(master, id, &cmd, 0, NULL);
>> +}
>> +
>> +static int fsi_master_gpio_term(struct fsi_master *_master,
>> +               int link, uint8_t id)
>> +{
>> +       struct fsi_master_gpio *master = to_fsi_master_gpio(_master);
>> +       struct fsi_gpio_msg cmd;
>> +
>> +       if (link != 0)
>> +               return -ENODEV;
>> +
>> +       build_term_command(&cmd, id);
>> +       return fsi_master_gpio_xfer(master, id, &cmd, 0, NULL);
>> +}
>> +
>> +/*
>> + * Issue a break command on link
>> + */
> Redundant comment, remove it.
Removing...

>> +static int fsi_master_gpio_break(struct fsi_master *_master, int link)
>> +{
>> +       struct fsi_master_gpio *master = to_fsi_master_gpio(_master);
>> +
>> +       if (link != 0)
>> +               return -ENODEV;
>> +
>> +       set_sda_output(master, 1);
>> +       sda_out(master, 1);
>> +       clock_toggle(master, FSI_PRE_BREAK_CLOCKS);
>> +       sda_out(master, 0);
>> +       clock_toggle(master, FSI_BREAK_CLOCKS);
>> +       echo_delay(master);
>> +       sda_out(master, 1);
>> +       clock_toggle(master, FSI_POST_BREAK_CLOCKS);
>> +
>> +       /* Wait for logic reset to take effect */
>> +       udelay(200);
>> +
>> +       return 0;
>> +}
>> +
>> +static void fsi_master_gpio_init(struct fsi_master_gpio *master)
>> +{
>> +       if (master->gpio_mux)
>> +               gpiod_direction_output(master->gpio_mux, 1);
>> +       if (master->gpio_trans)
>> +               gpiod_direction_output(master->gpio_trans, 1);
>> +       if (master->gpio_enable)
>> +               gpiod_direction_output(master->gpio_enable, 1);
>> +       gpiod_direction_output(master->gpio_clk, 1);
>> +       gpiod_direction_output(master->gpio_data, 1);
>> +
>> +       /* todo: evaluate if clocks can be reduced */
>> +       clock_zeros(master, FSI_INIT_CLOCKS);
>> +}
>> +
>> +static int fsi_master_gpio_link_enable(struct fsi_master *_master, int link)
>> +{
>> +       struct fsi_master_gpio *master = to_fsi_master_gpio(_master);
>> +
>> +       if (link != 0)
>> +               return -ENODEV;
>> +       if (master->gpio_enable)
>> +               gpiod_set_value(master->gpio_enable, 1);
>> +
>> +       return 0;
>> +}
>> +
>> +static void fsi_master_gpio_release(struct device *dev)
>> +{
>> +}
> Empty function?

Will remove.

>> +
>> +static int fsi_master_gpio_probe(struct platform_device *pdev)
>> +{
>> +       struct fsi_master_gpio *master;
>> +       struct gpio_desc *gpio;
>> +
>> +       master = devm_kzalloc(&pdev->dev, sizeof(*master), GFP_KERNEL);
>> +       if (!master)
>> +               return -ENOMEM;
>> +
>> +       master->dev = &pdev->dev;
>> +       master->master.dev.parent = master->dev;
>> +       master->master.dev.release = fsi_master_gpio_release;
>> +
>> +       gpio = devm_gpiod_get(&pdev->dev, "clock", 0);
>> +       if (IS_ERR(gpio)) {
>> +               dev_err(&pdev->dev, "failed to get clock gpio\n");
>> +               return PTR_ERR(gpio);
>> +       }
>> +       master->gpio_clk = gpio;
>> +
>> +       gpio = devm_gpiod_get(&pdev->dev, "data", 0);
>> +       if (IS_ERR(gpio)) {
>> +               dev_err(&pdev->dev, "failed to get data gpio\n");
>> +               return PTR_ERR(gpio);
>> +       }
>> +       master->gpio_data = gpio;
>> +
>> +       /* Optional GPIOs */
>> +       gpio = devm_gpiod_get_optional(&pdev->dev, "trans", 0);
>> +       if (IS_ERR(gpio)) {
>> +               dev_err(&pdev->dev, "failed to get trans gpio\n");
>> +               return PTR_ERR(gpio);
>> +       }
>> +       master->gpio_trans = gpio;
>> +
>> +       gpio = devm_gpiod_get_optional(&pdev->dev, "enable", 0);
>> +       if (IS_ERR(gpio)) {
>> +               dev_err(&pdev->dev, "failed to get enable gpio\n");
>> +               return PTR_ERR(gpio);
>> +       }
>> +       master->gpio_enable = gpio;
>> +
>> +       gpio = devm_gpiod_get_optional(&pdev->dev, "mux", 0);
>> +       if (IS_ERR(gpio)) {
>> +               dev_err(&pdev->dev, "failed to get mux gpio\n");
>> +               return PTR_ERR(gpio);
>> +       }
>> +       master->gpio_mux = gpio;
>> +
>> +       master->master.n_links = 1;
>> +       master->master.read = fsi_master_gpio_read;
>> +       master->master.write = fsi_master_gpio_write;
>> +       master->master.term = fsi_master_gpio_term;
>> +       master->master.send_break = fsi_master_gpio_break;
>> +       master->master.link_enable = fsi_master_gpio_link_enable;
>> +       platform_set_drvdata(pdev, master);
>> +
>> +       fsi_master_gpio_init(master);
>> +
>> +       fsi_master_register(&master->master);
> This function can return an error.

Don't understand.   On detect of error it returns immediately.  If makes 
it to end then no
error encountered.
>> +
>> +       return 0;
>> +}
>> +
>> +
>> +static int fsi_master_gpio_remove(struct platform_device *pdev)
>> +{
>> +       struct fsi_master_gpio *master = platform_get_drvdata(pdev);
>> +
>> +       devm_gpiod_put(&pdev->dev, master->gpio_clk);
>> +       devm_gpiod_put(&pdev->dev, master->gpio_data);
>> +       if (master->gpio_trans)
>> +               devm_gpiod_put(&pdev->dev, master->gpio_trans);
>> +       if (master->gpio_enable)
>> +               devm_gpiod_put(&pdev->dev, master->gpio_enable);
>> +       if (master->gpio_mux)
>> +               devm_gpiod_put(&pdev->dev, master->gpio_mux);
> Given you're removing the driver here, can you omit the devm_gpiod_put calls?

This would be called on an unbind op so I'm thinking we'd still want to 
explicitly release
the pins with devm_gpiod_put( ).

Thanks for your input,
Chris.
>> +       fsi_master_unregister(&master->master);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct of_device_id fsi_master_gpio_match[] = {
>> +       { .compatible = "fsi-master-gpio" },
>> +       { },
>> +};
>> +
>> +static struct platform_driver fsi_master_gpio_driver = {
>> +       .driver = {
>> +               .name           = "fsi-master-gpio",
>> +               .of_match_table = fsi_master_gpio_match,
>> +       },
>> +       .probe  = fsi_master_gpio_probe,
>> +       .remove = fsi_master_gpio_remove,
>> +};
>> +
>> +module_platform_driver(fsi_master_gpio_driver);
>> +MODULE_LICENSE("GPL");
>> --
>> 1.8.2.2
>>
