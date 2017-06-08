From: jk@ozlabs.org (Jeremy Kerr)
Date: Thu, 8 Jun 2017 10:06:16 +0800
Subject: [PATCH v8 16/24] drivers/fsi: Add tracepoints for low-level
 operations
In-Reply-To: <20170607151610.52f7bc88@gandalf.local.home>
References: <20170606210859.80431-1-cbostic@linux.vnet.ibm.com>
 <20170606210859.80431-17-cbostic@linux.vnet.ibm.com>
 <20170607151610.52f7bc88@gandalf.local.home>
Message-ID: <4441a1ba-e66e-368a-cc07-8e3859dc8c13@ozlabs.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steven,

Thanks for checking this out.

>> +TRACE_EVENT(fsi_master_write,
>> +	TP_PROTO(const struct fsi_master *master, int link, int id,
>> +			uint32_t addr, size_t size, const void *data),
>> +	TP_ARGS(master, link, id, addr, size, data),
>> +	TP_STRUCT__entry(
>> +		__field(int,	master_idx)
>> +		__field(int,	link)
>> +		__field(int,	id)
>> +		__field(__u32,	addr)
>> +		__field(size_t,	size)
>> +		__field(__u32,	data)
>> +	),
>> +	TP_fast_assign(
>> +		__entry->master_idx = master->idx;
>> +		__entry->link = link;
>> +		__entry->id = id;
>> +		__entry->addr = addr;
>> +		__entry->size = size;
>> +		__entry->data = 0;
>> +		memcpy(&__entry->data, data, size);
> 
> 
> Um, can size ever be greater than 4? If so, this is a bug.

No, size will only ever be 1, 2, or 4, as they're the only valid FSI bus
transactions. Hence storing ->data as a u32 to keep things simple.

> I think you may want to use a dynamic array here.
> 
> 	TP_STRUCT__entry(
> 		[..]
> 		__dynamic_array(char, data, size)
> 	[..]
> 
> 	TP_fast_assign(
> 		[..]
> 		memcpy(__get_dynamic_array(data), data, size);
> 	[..]
> 
> 	TP_printk(...
> 		[..]
> 		__entry->size,
> 		__get_dynamic_array(data)
> 
> You may also want to look at __print_array() too.

The %ph specifier seems to do a decent job though...

Cheers,


Jeremy
