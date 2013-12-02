From: angus.clark@st.com (Angus Clark)
Date: Mon, 2 Dec 2013 11:19:23 +0000
Subject: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <529C5BBF.6000604@freescale.com>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
 <20131127043253.GA9468@ld-irv-0074.broadcom.com> <5298AA23.7080404@st.com>
 <529C5BBF.6000604@freescale.com>
Message-ID: <529C6CBB.4000008@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Huang Shijie

On 12/02/2013 10:06 AM, Huang Shijie wrote:
> Hi Angus:
>   thanks for the long suggestion. it's very useful.
> 
> Let's push the spi nor framework.:)
[...]
>>
>> /**
>>   * struct spi_nor_xfer_cfg - Structure for defining a Serial Flash
>> transfer
>>   * @wren:        command for "Write Enable", or 0x00 for not required
> why this wren is needed?

Issuing WREN is needed for certain sequences of operations.  I guess your
question relates to why have I included it as part of the 'spi_nor_xfer_cfg'
structure, when it could be controlled from the spi_nor layer with a separate
spi_nor_xfer.

Well, firstly, I am aware of at least one H/W controller that can be optimised
to issue the WREN command as part of a longer erase or write sequence, thereby
avoiding the overheads of issuing a separate spi_nor_xfer.

However, the main reason was to try and come up with a generic representation
for a typical Serial Flash transfer, capturing, where possible, the semantics of
the intended operation, just in case that information can be used by the
underlying H/W in some way.  In this instance, the WREN cycles just represents
another part of the transfer, in the same way as the command, address, mode, and
dummy cycles.

>>   * @cmd:        command for operation
>>   * @cmd_pins:        number of pins to send @cmd (1, 2, 4)
>>   * @addr:        address for operation
>>   * @addr_pins:        number of pins to send @addr (1, 2, 4)
>>   * @addr_width:     number of address bytes (3,4, or 0 for address
>> not required)
> this field has been in the spi_nor{} , it should be a fixed value.
> so i think we do not need this argument.

The aim of the 'spi_nor_xfer_cfg' is to provide an interface between the spi-nor
layer and the underlying H/W driver.   In some cases, the H/W may need to know
the address width (e.g. issuing a new command sequence, with an incremented
address, following an arbitration stall).  You could argue that the H/W driver
should be able query the spi_nor structure, or perhaps store the addr_width
field during an initialisation process, but I feel having it as part of the
'spi_nor_xfer_cfg' provides a cleaner interface between the two layers.

>>   * @mode:        mode data
>>   * @mode_pins:        number of pins to send @mode (1, 2, 4)
>>   * @mode_cycles:    number of mode cycles (0 for mode not required)
>>   * @dummy_cycles:    number of dummy cycles (0 for dummy not required)
>>   */
>> struct spi_nor_xfer_cfg {
>>     uint8_t        wren;
>>     uint8_t        cmd;
>>     int        cmd_pins;
>>     uint32_t    addr;
>>     int        addr_pins;
>>     int        addr_width;
>>     uint32_t    mode;
>>     int        mode_pins;
>>     int        mode_cycles;
>>     int        dummy_cycles;
>> };
>>
>> We could then build up layers of functionality, based on two
>> fundamental primitives:
>>
>>     int (*read_xfer)(struct spi_nor_info *info,
>>              struct spi_nor_xfer_cfg *cfg,
>>              uint8_t *buf, size_t len);
>>     
>>     int (*write_xfer)(struct spi_nor_info *info,
>>               struct spi_nor_xfer_cfg *cfg,
>>               uint8_t *buf, size_t len);
>>     
>> Default implementations for standard operations could follow:
>>
>>     int (*read_reg)(struct spi_nor_info *info,
>>             uint8_t cmd, uint8_t *reg, int len);
>>     int (*write_reg)(struct spi_nor_info *info,
>>              uint8_t cmd, uint8_t *reg, int len,
>>              int wren, int wtr);
>>
>>     int (*readid)(struct spi_nor_info *info, uint8_t *readid);
>>     int (*wait_till_ready)(struct spi_nor_info *info);
> 
> currently, we poll the status register.
> why this hook is needed?

The default implementation would do just as you suggest, and I would expect most
H/W drivers to use the default implementation.  However, some H/W Controllers
can automate the polling of status registers, so having a hook allows the driver
override the default behaviour.

>>     int (*read)(struct spi_nor_info *info, uint8_t buf, off_t offs,
>> size_t len);
>>     int (*write)(struct spi_nor_info *info, off_t offs, size_t len);
>>     int (*erase_sector)(struct spi_nor_info *info, off_t offs);
> I also confused at this hook.
> 
> if we need erase_sector, do we still need the erase_chip()?

Serial Flash devices support various "Erase Sector" commands, and an "Erase
Chip" command.  The erase_sector() and erase_chip() hooks would just form the
appropriate command sequences (e.g. Erase Chip does not require address cycles).

I have to admit, the circumstances that provoke an erase_chip() are rather
limited.  As far as I can see, the MTD tool 'mtd_debug' is the only component
that can lead to an Erase Chip operation, and even then, only when the device is
not partitioned.  However, m25p80 supports Erase Chip, so I thought I would
maintain that support here.

As I said before, my proposal was just some initial ramblings of my mind, and I
am definitely open to discussion and other suggestions.

To be honest, I am just glad that someone is taking a look at this area.
However, whether or not is it possible to come up with something that solves all
our problems remains to be seen.  It might turn out that the various H/W
Controllers are just too different to fit into a single unified framework.

Cheers,

Angus
