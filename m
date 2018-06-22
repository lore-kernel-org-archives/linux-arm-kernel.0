From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 22 Jun 2018 10:01:24 +0100
Subject: [PATCH 5/6] coresight: catu: Add support for scatter gather tables
In-Reply-To: <20180621171337.GA10307@xps15>
References: <1529319379-17895-1-git-send-email-suzuki.poulose@arm.com>
 <1529319379-17895-6-git-send-email-suzuki.poulose@arm.com>
 <20180621171337.GA10307@xps15>
Message-ID: <d5bbff9b-2730-f708-8a4e-f16241f6f5ce@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,

On 21/06/18 18:13, Mathieu Poirier wrote:

>> +
>> +/*
>> + * catu_populate_table : Populate the given CATU table.
>> + * The table is always populated as a circular table.
>> + * i.e, the "prev" link of the "first" table points to the "last"
>> + * table and the "next" link of the "last" table points to the
>> + * "first" table. The buffer should be made linear by calling
>> + * catu_set_table().
>> + */
>> +static void
>> +catu_populate_table(struct tmc_sg_table *catu_table)
>> +{
>> +	int i, dpidx, s_dpidx;
>> +	unsigned long offset, buf_size, last_offset;
>> +	dma_addr_t data_daddr;
>> +	dma_addr_t prev_taddr, next_taddr, cur_taddr;
>> +	cate_t *table_ptr, *next_table;
>> +
>> +	buf_size = tmc_sg_table_buf_size(catu_table);
>> +	dpidx = s_dpidx = 0;
> 
>  From the reading the code below variable s_dpidx stands for "small" data page
> index, which isn't obvious from the get go and could easily be mistaken for
> "system" data page index.  Please add a comment to make your intentions clear.

Sure, I will add comments. They are supposed to mean :

dpidx => Data page index
s_dpidx => Sub-page index within the System page.

May be I can rename the variables to =>

sys_pidx and catu_pidx


> 
>> +	offset = 0;
>> +
>> +	table_ptr = catu_get_table(catu_table, 0, &cur_taddr);
>> +	prev_taddr = 0;	/* Prev link for the first table */
>> +
>> +	while (offset < buf_size) {
>> +		/*
>> +		 * The @offset is always 1M aligned here and we have an
>> +		 * empty table @table_ptr to fill. Each table can address
>> +		 * upto 1MB data buffer. The last table may have fewer
>> +		 * entries if the buffer size is not aligned.
>> +		 */
>> +		last_offset = (offset + SZ_1M) < buf_size ?
>> +			      (offset + SZ_1M) : buf_size;
>> +		for (i = 0; offset < last_offset;
>> +		     i++, offset += CATU_PAGE_SIZE) {
> 
> I really like the choice of "table_end" in function catu_dump_table().  I think
> using the same denomination here would make it easier to understand the code.
> 
> I wouldn't bother with such details if you weren't respinning this set.  But now
> that you are and these are extremely simple I think it's worth it, and it will
> help slowing the prolifiration of gray hair around my head when I look back at
> this a year or two down the road.

Sure, I can make those changes in the next revision. Thanks for the review.

Cheers
Suzuki
