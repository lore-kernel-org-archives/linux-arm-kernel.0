From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Mon, 4 Jan 2016 17:12:14 +0100
Subject: [PATCH linux-next 2/5] mtd: spi-nor: fix Quad SPI mode support
 for Spansion, Micron and Macronix
In-Reply-To: <20151218021857.GI10460@google.com>
References: <cover.1449494420.git.cyrille.pitchen@atmel.com>
 <7f2a084da433f1936a1305dfa30327bc5abc802c.1449494420.git.cyrille.pitchen@atmel.com>
 <20151218021857.GI10460@google.com>
Message-ID: <568A99DE.5010502@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

Le 18/12/2015 03:18, Brian Norris a ?crit :
> On Mon, Dec 07, 2015 at 03:09:11PM +0100, Cyrille Pitchen wrote:
>> This patch reworks the support of Quad and Dual SPI protocols for Micron,
>> Spansion and Macronix Quad/Dual capable memories. Indeed, in the best
>> case, only Spansion memories are correctly supported by the current
>> spi-nor framework.
> 
> ^^ Ah, so this is what I was struggling with at first. I agree that
> Micron looks broken. Quite possibly Macronix too. Unfortunately, I
> haven't had great test hardware for some of the quad modes. Especially
> not anything that supports generic SPI, and not completely on mainline.
> 

To explain the origin of this series of patches I would say that at first
I was only supposed to write a driver for the Atmel QSPI controller. I was
using (ans still use) a sama5d2 xplained board with a Micron n25q128a13
memory. Hence, testing the driver, I found that the probe failed inside the
old micron_quad_enable() function.
Indeed nor->write_reg() was successfully called to clear the Quad Enable bit
in the Enhanced Volatile Configuration Register but immediately after
spi_nor_wait_till_ready() failed.
The reason was that the Micron memory was switched to its Quad Mode and then
expected all the following commands to use the SPI 4-4-4 protocol. However
the Atmel QSPI controller driver was not aware of this protocol change and
kept on using the SPI 1-1-1 protocol.

So in the very first version of this series of patches, I inserted a call of
spi_nor_set_protocol(), a new function simply calling an optional hook,
between the nor->write_reg() and spi_nor_wait_till_ready() calls. This way
the (Q)SPI controller driver was now notified about the protocol switch and
can eventually adapt to this change.

After some discussions on the mailing list, it appeared that using such a
hook to handle protocol changes would required to insert calls of the new
spi_nor_set_protocol() function before all the calls of nor->read_reg(),
nor->write_reg(), nor->read(), nor->write() and nor->erase().
Indeed some manufacturers like Spansion use different numbers of I/O lines
depending on the type of operation:
- Fast Read: 1-1-4
- register read/write: 1-1-1

So the addition inside struct spi_nor of the new reg_proto, read_proto,
write_proto and erase_proto fields was prefered to the first
spi_nor_set_protocol() proposal. This fields are set once for all by
spi_nor_scan(). SPI controller drivers have to worry about their values only
if they claim to support Dual or Quad protocols through the 'mode' argument
of spi_nor_scan().

Then about the Micron case, I did test it and it didn't work without patching.
To be cautious, I wondered whether it might have work with a
different configuration/SPI controller because I don't want to break
something working. I wondered about a mean for the SPI controller driver to
detect the protocol change. Maybe parsing the SPI message and checking the
command op code. However it looked a highly inefficient method and also it
simply can not work since the very same op code, for instance 0x6B, is used
by both the 1-1-4 and 4-4-4 protocols.
So my conclusion was it could not have worked before: I don't have to worry
about breaking the support of Quad protocols for Micron memories.

I don't think there is a real need to revert Bean's commit since this series
fixes the issue anyway. However if you feel it would be better to revert it to
start from a cleaner base, I'm fine with it. Just let me know your choice so
I can adapt my series before sending the next version.


About the Macronix case, I still don't have any memory sample to test.
However, reading some memory datasheet (again and again), my understanding
has changed a little bit: setting the Quad Enable (QE) non-volatile bit in
the Status Register doesn't mean enabling the Quad Peripheral Interface (QPI)
as I thought.
Two dedicated op codes are used when sending the required commands to
enable/disable the QPI. Once the QPI enabled, the memory expects ALL commands
to use the SPI 4-4-4 protocol. Enabling the QPI requires the QE bit to bit set
first in the Status Register.
However the QE bit is also required to use the SPI 1-1-4 protocol: QPI must be
disabled in that case.
Setting the QE bit only disables the Write Protect and Hold features: the two
associated pins then become the IO2 and IO3 lines, needed by Quad SPI
protocols.

Finally for the Winbond case, I don't have memory from this manufacturer
yet so once again I refer only to some datasheets: it looks like Winbond
memories use a pattern of behaviour very closed to Macronix' one.
Indeed, some Quad Enable non volatile bit must be set inside the Status
Register. Also two dedicated op codes are used to enable/disable the QPI mode.
The QPI mode requires the QE bit to be set and, once enabled, all commands
must use the SPI 4-4-4 protocol.
However the two op codes to enter/leave the QPI mode are not the same as
those of Macronix and both manufacturers use different offsets for their
QE bits.

What I've planned to do to support Macronix and Winbond memory is to sill
use the spi_nor_read_id() function to guess the current protocol. If the
caller of spi_nor_scan() asks for Quad SPI support through the 'mode'
argument, I will use the SPI 4-4-4 protocol if the QPI mode is already
enabled, the SPI 1-1-4 protocol otherwise: I won't change the state of the
QPI mode. Indeed, if spi_nor_read_id() has succeeded in reading the JEDEC
ID, the current state of QPI mode is supported whatever it is.


>> 1 - Micron:
>> When their Quad SPI mode is enabled, Micron spi-nor memories expect all
>> commands to use the SPI 4-4-4 protocol. Also when the Dual SPI mode is
>> enabled, all commands must use the SPI 2-2-2 protocol.
>>
>> Before this patch, the spi-nor framework used to always enable the Quad
>> mode when the mode argument of spi_nor_scan() took the value SPI_NOR_QUAD.
>> That was not suited with drivers only supporting SPI 1-x-4 protocols but
>> not the 4-4-4 (e.g. the m25p80 driver). Also the SPI controller was not
>> notified about which SPI protocol to use to transfert command. We cannot
>> rely only on the op code: in Extended SPI mode the 0x6b command must use
>> the SPI 1-1-4 protocol whereas in Quad SPi mode the SPI 4-4-4 protocol
>> must be use instead.
>>
>> After this patch, the spi-nor framework uses the result of the
>> spi_nor_read_id() function to choose the right SPI protocol to be used.
>> If the reg_proto was set to SPI_PROTO_4_4_4, we already know that the Quad
>> SPI mode is already enabled and that the SPI controller supports the SPI
>> 4-4-4 protocol (otherwise it would have fail to read the JEDEC ID with the
>> 0xaf op code). For the very same reason, if the reg_proto was set to
>> SPI_PROTO_2_2_2, we already know that the Dual mode is already enabled and
>> that the SPI controller supports the SPI 2-2-2 protocol.
>> Otherwise we switch back to the Extended SPI protocol, which supports at
>> least the Fast Read commands:
>> - 1-1-1 (0x0b)
>> - Dual Output 1-1-2 (0x3b)
>> - Quad Output 1-1-4 (0x6b)
>>
>> We also safely set the number of dummy cycles to 8 for Fast Read commands
>> through the Volatile Configuration Register (VCR): some drivers (m25p80)
>> or SPI controllers only support a number of dummy cycles multiple of 8.
>> This number may have previouly been set to an unsupported value by an
>> early bootloader or at reset thanks to the Non-Volatile Configuration
>> Register.
> 
> It's not clear to me how you're being safe with the dummy cycles at all.
> It seems like you're introducing new values that may be incompatible
> with drivers. That can be OK, but you have to give drivers a chance to
> opt-out... Maybe some kind of "host capability" flags?
> 

Currently not all drivers support numbers of dummy cycles which are not
multiple of 8 bits. Especially this is the case of the m25p80 driver.
Other drivers, those supporting more numbers of dummy cycles still support
multiple of 8 bits. So now the spi-nor framework always  sets to 8 the number
of dummy cycles to be used by updating some Micron *volatile* register.
All drivers can deal with a value of 8. This value is almost always the
value used before. It is large enough to fit the highest SPI bus clock
frequencies but still provides good performances.
Actually, I'm pretty sure it was the only used value before.
And since the driver updates a volatile register, the configuration will
still be the same after reset for bootloaders.
In fact it should not change what worked before, it only gives a chance to
recover from bootloaders which would have used "strange" values of dummy
cycle number.
For instance, the romcode of the sama5d2 sets this number of dummy cycles to
10 for all Micron memories to limit the risk of incompatibility with memory
timing requirements. This romcode cannot be updated and tries to
support as many QSPI memories as possible within a limited code size: we
cannot afford using tables indexed by JEDEC ID but only by manufacturer ID.
However a value of 10 is not such a kind of value as expected by Linux
drivers. A value of 8 gives a chance to use the m25p80 driver to manufacturers
who don't want/can't develop a driver dedicated to their QSPI controller.

As a second thought, another solution is to only read the current value of dummy
cycle number and simply set use this value to initialize nor->read_dummy.
The assumption is now that is the value was fine for the QSPI controller during
the bootloader phase it's still fine under Linux as long as a driver can handle
this QSPI controller.

Please let me know which strategy you prefer for my next series.


>> Finally the XIP bit is always set in the VCR to disable the Continuous
>> Read mode as we don't want to care about mode cycles.
>>
>> 2 - Macronix:
>> When the QPI mode is enabled, all commands must use the SPI 4-4-4 protocol
>> and only the 0xeb op code is supported for Fast Read commands.
>> Before this patch, the spi-nor framework used to force the QPI mode but
>> used the 0x6b op code for Fast Read commands when the SPI controller
>> claims to support Quad SPI mode.
>> This patch uses the result of spi_nor_read_id() to guess whether the QPI
>> mode is both enable and supported by the SPI controller (otherwise it
>> would have failed to read the JEDEC ID with the 0xaf op code).
>> When the QPI mode is disabled, Macronix memories still support the
>> following Fast Read commands:
>> - 1-1-1 (0x0b)
>> - Dual Output 1-1-2 (0x3b)
>> - Quad Output 1-1-4 (0x6b)
>> So if the QPI mode has not already been enabled, there is not need to
>> enable it. We also avoid the 0xbb (Dual I/O 1-2-2) and 0xeb (Quad I/O
>> 1-4-4) op codes on purpose as we don't want to care about the value to set
>> in mode cycles not to enter the Continuous Read (Performance Enhance)
>> mode.
>>
>> As for Micron memories, the spi-nor framework now safely sets the number
>> of dummy cycles to 8 thanks to 2 volatile bits inside the Configuration
>> Register.
>>
>> 3 - Spansion:
>> As for Macronix, we avoid the 0xbb (Dual I/O 1-2-2) and 0xeb (Quad I/O
>> 1-4-4) op codes on purpose as we don't want to care about the value to set
>> in mode cycles not to enter in the Continuous Read mode.
>>
>> Besides, we only care about the Quad Enable bit inside the Configuration
>> Register (CR) when using Quad operations. In such a case, we first check
>> its state before trying to set it. Now we also notify the user about the
>> update of this non-volatile bit.
>>
>> We also check the Latency Code (LC) in CR to know the exact number of
>> dummy cycles to use when performing a Fast Read operation. Currently only
>> the 0x0b, 0x3b and 0x6b op codes are used to perform Fast Read operation
>> so the number of dummy cycles is always either 0 or 8. Hence no regression
>> should be introduced.
>>
>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
>> ---
>>  drivers/mtd/spi-nor/spi-nor.c | 783 +++++++++++++++++++++++++++++++++++++-----
>>  include/linux/mtd/spi-nor.h   |  15 +-
>>  2 files changed, 699 insertions(+), 99 deletions(-)
> 
> That's quite a lot to do in one patch, both in number of lines of code,
> and in number of tasks outlined in the commit description. Can this be
> broken down at all to be more modular and incremental?

I've already tried to split the series a bit more. I had troubles making
patches smaller without breaking functionnal dependencies but I'll try
to split it again before sending the next series.

> 
> Snipped the rest of the patch for now.
> 
> Brian
> 

Happy new year, all! :)

Best regards,

Cyrille
