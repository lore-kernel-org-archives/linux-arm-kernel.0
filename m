From: angus.clark@st.com (Angus Clark)
Date: Tue, 17 Dec 2013 09:17:20 +0000
Subject: [PATCH v3 09/36] mtd: st_spi_fsm: Provide device look-up table
In-Reply-To: <20131210220338.GF27149@ld-irv-0074.broadcom.com>
References: <1385727565-25794-1-git-send-email-lee.jones@linaro.org>
 <1385727565-25794-10-git-send-email-lee.jones@linaro.org>
 <20131210220338.GF27149@ld-irv-0074.broadcom.com>
Message-ID: <52B016A0.3080201@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/2013 10:03 PM, Brian Norris wrote:
> On Fri, Nov 29, 2013 at 12:18:58PM +0000, Lee Jones wrote:
>> --- a/drivers/mtd/devices/st_spi_fsm.h
>> +++ b/drivers/mtd/devices/st_spi_fsm.h
>> @@ -253,4 +253,141 @@ struct stfsm_seq {
>>  } __attribute__((__packed__, aligned(4)));
>>  #define STFSM_SEQ_SIZE sizeof(struct stfsm_seq)
>>  
>> +/* SPI Flash Device Table */
>> +struct flash_info {
>> +	char		*name;
>> +	/*
>> +	 * JEDEC id zero means "no ID" (most older chips); otherwise it has
>> +	 * a high byte of zero plus three data bytes: the manufacturer id,
>> +	 * then a two byte device id.
>> +	 */
>> +	u32		jedec_id;
>> +	u16             ext_id;
> 
> Will 5 bytes of ID be enough? I think we're running into a need for 6
> bytes of ID in m25p80.c right about now. Might make sense to start with
> the right number of bytes.

Yes, we will need 6 bytes of ID.  The "dirty" stm_spi_fsm driver already handles
arbitrary-length IDs.  This will need to be pulled into the "upstream" version
at some point.

>> +	int		(*config)(struct stfsm *);
> 
> Do you *really* need a configuration callback? Can the callback be
> represented as simply a flag for the special configuration behavior that
> is needed, then your driver calls the appropriate "callback" when it
> sees the flag?
> 
> BTW, your later patches have to introduce static declarations in this
> header, which seems very ugly to me; you are entwining data with your
> driver's implementation.

The config() callback is used to perform device/vendor specific initialisation
(e.g. how to set the QE bit) and configuration of the read, write, and erase
operations.  As such, it is related to the device, not to the driver or H/W
controller.

However, I take your point, it is rather ugly.  In some sense, the callback is
used to make up for the lack of information in the table that would otherwise
permit a generic configuration to be made.  One option would be to extend the
table structure to include the superset of properties required across all
devices, or perhaps an entry for extended, vendor-specific properties.

In any case, I think this discussion relates more to the spi-nor thread, rather
than the st_spi_fsm driver.

>> +static struct flash_info flash_types[] = {
>> +	/*
>> +	 * ST Microelectronics/Numonyx --
>> +	 * (newer production versions may have feature updates
>> +	 * (eg faster operating frequency)
>> +	 */
>> +#define M25P_FLAG (FLASH_FLAG_READ_WRITE | FLASH_FLAG_READ_FAST)
> 
> Please don't define macros in the middle of your table like this. (You
> have several of these.)

Personally, I think it is easier to read with the flag combinations defined near
where they are used.  I do not have strong feeling either way though, and it may
become a moot point if the table structure is changed :-)

Cheers,

Angus
