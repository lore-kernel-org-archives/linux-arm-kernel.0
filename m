From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Tue, 8 Sep 2015 18:20:05 +0200
Subject: [PATCH linux-next v5 1/5] mtd: spi-nor: notify (Q)SPI controller
 about protocol change
In-Reply-To: <CAOiHx=m0FhuH5BR-EYp4yQyB83yGRzdCFAPVfqB0b0+BvRE-6Q@mail.gmail.com>
References: <cover.1440580764.git.cyrille.pitchen@atmel.com>
 <464fce12d75a5ba2105456cfd0a385b2d40305ba.1440580764.git.cyrille.pitchen@atmel.com>
 <CAOiHx=n+byfsbJNhnboqDEwhruOT8uKDJ+CcES7QBqPDLVAMsw@mail.gmail.com>
 <55DEDDBD.8060408@atmel.com>
 <CAOiHx=m0FhuH5BR-EYp4yQyB83yGRzdCFAPVfqB0b0+BvRE-6Q@mail.gmail.com>
Message-ID: <55EF0AB5.3070508@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonas,

taking your comments into account I'm about to test a new series with
additional patches to handle the Read ID command in multiple I/O protocols and
relying on new members in the struct spi_nor:

 * @erase_proto:	the SPI protocol used by erase operations
 * @read_proto:		the SPI protocol used by read operations
 * @write_proto:	the SPI protocol used by write operations
 * @reg_proto		the SPI protocol used by read_reg/write_reg operations

	enum spi_protocol	erase_proto;
	enum spi_protocol	read_proto;
	enum spi_protocol	write_proto;
	enum spi_protocol	reg_proto;

This way, the read(), write(), erase(), read_reg() and write_reg() hooks can
check the relevant protocol member so the spi-nor framework doesn't need to
call spi_nor_set_protocol() before any command.

Also the op codes for read, page program and erase commands will be tuned
depending on the memory manufacturer and the selected SPI protocol.

I'm likely to publish this new series tomorrow after my tests on a Micron
memory.

Best Regards,

Cyrille
 

Le 31/08/2015 21:22, Jonas Gorski a ?crit :
> Hi,
> 
> On Thu, Aug 27, 2015 at 11:51 AM, Cyrille Pitchen
> <cyrille.pitchen@atmel.com> wrote:
>> Hi Jonas,
>>
>> Le 26/08/2015 16:02, Jonas Gorski a ?crit :
>>> On Wed, Aug 26, 2015 at 2:30 PM, Cyrille Pitchen
>>> <cyrille.pitchen@atmel.com> wrote:
>>>> Once the Quad SPI mode has been enabled on a Micron flash memory, this
>>>> device expects ALL the following commands to use the SPI 4-4-4 protocol.
>>>> The (Q)SPI controller needs to be notified about the protocol change so it
>>>> can adapt and keep on dialoging with the Micron memory.
>>>
>>> Doesn't that mean you need to disable quad mode on removal? Else the
>>> following will break/fail:
>>>
>>> insmod atmel-quadspi.ko ~> spi-nor attaches -> sees micron -> enables quad mode
>>> rmmod atmel-quadspi.ko ~> spi-nor detaches
>>> insmod atmel-quadspi.ko ~> spi-nor attaches -> fails to read the id
>>> because flash is still in quad mode.
>>>
>>
>> Indeed you're right such an issue does exist. So as you said one solution
>> could be create a new function to "clean" what have been done by spi_nor_scan()
>> then call it from remove() function of each driver calling spi_nor_scan() from
>> its probe().
>> However we could also enhance the probing of the memory. It is true that Micron
>> spi nor memories only accept SPI 4-4-4 commands once switched in quad mode but
>> actually they also provide a new command for this purpose:
>> "Multiple I/O Read ID" (0xAF).
>> Hence we could first try to probe using the regular Read ID (0x9F) command then
>> change the protocol, for instance to SPI 4-4-4, and try the 0xAF command.
>> I don't think all combinations for command/protocol need to be tested: for
>> Micron memories, their datasheets claim the 0x9F command is only supported in
>> "extended spi mode" so for the SPI 1-1-1 protocol whereas the 0xAF command
>> only works in dual or quad modes.
>> On the other hand Spansion memories still reply to the regular 0x9F command in
>> SPI 1-1-1 protocol even after their quad mode had been enabled.
>> For other manufacturers, well... I don't know!
> 
> At least from the two spansion datasheets I looked at, there is no 2_
> or 4_ mode for spansion flashes, and the quad mode only enables the
> 1_x_4 commands, where as on micron the 1_x_4 commands are always
> available, and you only need to switch to DIO or QIO if you want to
> use 2_2_2 or 4_4_4.
> 
> The question is how to detect if the READID command failed. Hopefully
> it will result in an invalid command, and we get 0xff... (or 0x00...)
> for the the id. And from there on we can first test 4_4_4 MIORDID (so
> it won't a a full command on a DIO-enabled flash), and if that fails,
> 2_2_2. We need to tell the spi-nor controller to send these
> accordingly though. I wonder if it might not be better to pass the
> c_a_d as an additional parameter to the read_reg/write_reg etc call
> backs, because they might change depending on the command used. E.g.
> when using SPI_NOR_QUAD, we might want to make use of the quad page
> program command (which is 1_1_4), but there is no 1_1_2 version, so we
> cannot rely on a global "protocol" member for that, unless we want to
> do a set_protocol before every command.
> 
>>
>> Some of the advantages of the probe solution as compared to the remove one are:
>> - we don't need to patch all drivers using spi_nor_scan() to call a new
>>   function from their remove().
>> - it doesn't rely on the assumption that the spi-nor memory starts in
>>   SPI 1-1-1 protocol. As a matter of fact the remove() won't be called for
>>   built-in modules or in many (all ?) cases of reset. Moreover some bootloaders
>>   may have already enabled the quad mode before starting the Linux kernel. This
>>   is what the sama5d2 romcode does when it is configured to boot from a QSPI
>>   memory.
>>
>> Anyway you're right and the issue need to be addressed but maybe in another
>> dedicated patch ?
> 
> Yes, probably as a prerequisite to the quad mode on micron flashes. I
> think we should also add a separate flag for the DIO/QIO modes for
> micron flashes, as these are something separate from just the DOR/QOR
> commands usually implied by SPI_NOR_DUAL/QUAD (well they are the same,
> but work differently)
> 
>>>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
>>>> Acked-by: Marek Vasut <marex@denx.de>
>>>> Acked-by: Bean Huo <beanhuo@micron.com>
>>>> ---
>>>>  drivers/mtd/spi-nor/spi-nor.c | 21 +++++++++++++++++++++
>>>>  include/linux/mtd/spi-nor.h   | 13 +++++++++++++
>>>>  2 files changed, 34 insertions(+)
>>>>
>>>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
>>>> index c27d427fead4..c8810313a752 100644
>>>> --- a/drivers/mtd/spi-nor/spi-nor.c
>>>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>>>> @@ -165,6 +165,22 @@ static inline int write_disable(struct spi_nor *nor)
>>>>         return nor->write_reg(nor, SPINOR_OP_WRDI, NULL, 0, 0);
>>>>  }
>>>>
>>>> +/*
>>>> + * Let the spi-nor framework notify lower layers, especially the driver of the
>>>> + * (Q)SPI controller, about the new protocol to be used. Indeed, once the
>>>> + * spi-nor framework has sent manufacturer specific commands to a memory to
>>>> + * enable its Quad SPI mode, it should immediately after tell the QSPI
>>>> + * controller to use the very same Quad SPI protocol as expected by the memory.
>>>> + */
>>>> +static inline int spi_nor_set_protocol(struct spi_nor *nor,
>>>> +                                      enum spi_protocol proto)
>>>> +{
>>>> +       if (nor->set_protocol)
>>>> +               return nor->set_protocol(nor, proto);
>>>> +
>>>> +       return 0;
>>>
>>> Shouldn't the default assumption be that it won't support it? Also it
>>> might make sense to first check if it's supported before enabling it
>>> in the chip, so that we don't enable something just to then find out
>>> we can't back out of it.
>>>
>>> I also wonder if we need an extra flag for that as at least SPI has
>>> RX_{DUAL,QUAD} and TX_{DUAL,QUAD} separated, so in theory there could
>>> be a controller that supports quad read, but not quad write, so we
>>> shouldn't be using the quad mode in that case. m25p80 currently sets
>>> SPI_NOR_{DUAL,QUAD} only based on SPI_RX_{DUAL,QUAD}, so that would
>>> then fail.
>>>
>>> At least the n25q32 seems to support the "boring" 1_1_2 and 1_1_4
>>> commands, so these should work in case the spi controller does not
>>> support quad tx, but quad rx.
>>>
>>> So maybe an additional flag for the "full" dual/quad modes would be in order.
>>>
>>
>> My first thought was to return -ENOSYS when the set_protocol() callback is not
>> implemented but logically none of the already existing drivers implements it.
>> So I made this new callback optional. This way, micron_quad_enable() works the
>> exact same way as before for all the existing drivers so no regression or side-
>> effect should be introduced by this patch.
> 
> If they don't implement the callback, then they won't know that they
> are supposed to use a different protocol, so change will definitely
> have broken them. Therefore an error return value and or a dev_warn
> would be IMHO better.
> 
>> So more accurate checks should be done before calling set_quad_mode(). Maybe
>> the range of values for the mode parameter of spi_nor_scan() is too small.
>> SPI_NOR_QUAD doesn't allow to make the difference between SPI protocols 1-1-4,
>> 1-4-4 or 4-4-4. Knowing the exact set of protocols supported by both the
>> controller and the memory could help making the right decision and choosing the
>> best suited Fast Read command.
>> The RX_{DUAL_QUAD} and TX_{DUAL,QUAD} flags from the spi->mode in the m25p80
>> driver provide more information than the limited "mode" argument of
>> spi_nor_scan().
> 
> so from the controller side we need to know whether it can do
> RX_{DUAL,QUAD} and TX_{DUAL,QUAD}; but for the flash supported
> commands we have a bit more variety (the x_y_z you mentioned).
> 
> Funny enough, once we are on QIO on spansion, there is no difference
> anymore between FAST (0x0b), QOR (0x6b) and QIOR (0xeb), they all work
> in the 4_4_4 mode.
> 
>>> Last but not least, the protocol probably should be stored somewhere
>>> in the nor struct, so that users don't have to store it themselves (I
>>> assume they will need to check it for each command again to know if
>>> the cmd/address should be send in serial or quad mode).
>>>
>>>
>> I agree with you, this could be an improvement for some spi controller drivers :)
>>
>>> Jonas
>>>
>>
>> thanks for your review!
>>
>> Best regards,
>>
>> Cyrille
> 
> 
> Regards
> Jonas
> 
