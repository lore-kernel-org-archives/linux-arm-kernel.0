From: patrice.chotard@st.com (Patrice Chotard)
Date: Wed, 10 Aug 2016 18:00:22 +0200
Subject: [PATCH v2 02/10] mfd: stmpe: Add reset support for all STMPE
 variant
In-Reply-To: <8798334c6e5272a08ed665f7fc649fd1@agner.ch>
References: <1461845589-4826-1-git-send-email-patrice.chotard@st.com>
 <1461845589-4826-3-git-send-email-patrice.chotard@st.com>
 <8798334c6e5272a08ed665f7fc649fd1@agner.ch>
Message-ID: <6fcee179-45e1-6480-c4da-7dbc03b1843d@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan


On 08/07/2016 04:54 AM, Stefan Agner wrote:
> On 2016-04-28 05:13, patrice.chotard at st.com wrote:
>> From: Patrice Chotard <patrice.chotard@st.com>
>>
>> Reset was only implemented for STMPE1801 variant despite
>> all variant have a SOFT_RESET bit.
>>
>> For STMPE2401/2403/801/1601/1801 SOFT_RESET bit is bit 7
>> of SYS_CTRL register.
>> For STMPE610/811 (which have the same variant id) SOFT_RESET
>> bit is bit 1 of SYS_CTRL register.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> Acked-by: Lee Jones <lee.jones@linaro.org>
>> ---
>>  drivers/mfd/stmpe.c | 23 +++++++++++++++--------
>>  drivers/mfd/stmpe.h |  7 +++++--
>>  2 files changed, 20 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
>> index c553b73..af682d0 100644
>> --- a/drivers/mfd/stmpe.c
>> +++ b/drivers/mfd/stmpe.c
>> @@ -735,13 +735,22 @@ static int stmpe1801_enable(struct stmpe *stmpe,
>> unsigned int blocks,
>>  				enable ? mask : 0);
>>  }
>>  
>> -static int stmpe1801_reset(struct stmpe *stmpe)
>> +static int stmpe_reset(struct stmpe *stmpe)
>>  {
>> +	u16 id_val = stmpe->variant->id_val;
>>  	unsigned long timeout;
>>  	int ret = 0;
>> +	u8 reset_bit;
>> +
>> +	if (id_val == STMPE811_ID)
>> +		/* STMPE801 and STMPE610 use bit 1 of SYS_CTRL register */
>> +		reset_bit = STMPE811_SYS_CTRL_RESET;
>> +	else
>> +		/* all other STMPE variant use bit 7 of SYS_CTRL register */
>> +		reset_bit = STMPE_SYS_CTRL_RESET;
> Wouldn't it be nicer to have this in struct stmpe_variant_info like
> id_mask...?

For information this series has just been pushed by Lee Jones.
I will have a look at your proposal and submit an update , but after my 3 weeks of vacations ;-)

Thanks

Patrice
