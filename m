From: angus.clark@st.com (Angus Clark)
Date: Tue, 17 Dec 2013 09:57:06 +0000
Subject: [PATCH v3 11/36] mtd: st_spi_fsm: Search for preferred FSM message
 sequence configurations
In-Reply-To: <20131211010636.GH27149@ld-irv-0074.broadcom.com>
References: <1385727565-25794-1-git-send-email-lee.jones@linaro.org>
 <1385727565-25794-12-git-send-email-lee.jones@linaro.org>
 <20131211010636.GH27149@ld-irv-0074.broadcom.com>
Message-ID: <52B01FF2.8010801@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2013 01:06 AM, Brian Norris wrote:
> This process sounds very much like something that is needed for other
> controllers: a way to match controller capabilties with the opcodes
> supported by the flash. 

Yes, I think this should be a primary aim of any 'spi-nor' framework".

> But it still isn't quite flexible enough for
> others, because it doesn't try to abstract the selection criteria -- it
> just uses lists that you presorted

Sure, the implementation here is very specific to the st_spi_fsm controller.
However, until there is something better or more generic available, I am not
sure what else to suggest.  Selecting a configuration based on a presorted list
is probably a reasonable strategy though; READ_1_4_4 is more efficient that
READ_1_1_4, and READ_1_1_4 is more efficient than READ_1_1_2 etc.

>> +/* Search for preferred configuration based on available flags */
>> +static struct seq_rw_config *
>> +stfsm_search_seq_rw_configs(struct stfsm *fsm,
>> +			    struct seq_rw_config cfgs[])
>> +{
>> +	struct seq_rw_config *config;
>> +	int flags = fsm->info->flags;
>> +
>> +	for (config = cfgs; cfgs->cmd != 0; config++)
> 
> This becomes an infinite loop if you can't find a matching config. You
> probably meant 'config->cmd != 0':
> 

I will leave Lee to defend himself on this one ;-)

>> +/* Parameters to configure a READ or WRITE FSM sequence */
>> +struct seq_rw_config {
>> +	uint8_t		mode_data;	/* MODE data */
> 
> What does this represent? As far as I can see, all the configurations
> you provide so far have this entry as 0x00.
> 
>> +	uint8_t		mode_cycles;	/* No. of MODE cycles */
> 
> What are MODE cycles? (Sorry if these are dumb questions.)

Mode data cyles are similar to dummy cycles, except they also transmit some
extended information on how the device should perform the transfer.  For
example, Spansion devices use mode data to enter/exit a "continuous read mode"
where subsequent read operations do not need to issue the read command, just
supply an address (and further mode/dummy cycles).  In practice, we have only
used this particular mode during testing; our boot-controller dislikes any form
of statefull mode!

> 
>> +	uint8_t		dummy_cycles;	/* No. of DUMMY cycles */
>> +};
> 
> Several pieces of this sequence struct seems suspiciously similar to
> what would be needed by several other controllers, while the remaining
> pieces don't seem to be so special that they cannot be configured
> beneath a SPI NOR framework. I'm becoming less convinced that your
> controller/driver is as unique as you say it is.

Other controllers/drivers would certainly benefit from something similar.
However, I thought the point was that no such framework exists at present and
any spi-nor proposal is going to take time to mature.  In the meantime,
integrating the st_spi_fsm driver would provide another example of H/W that
needs to be supported by a spi-nor framework, and maybe give a few ideas along
the way.

Cheers,

Angus
