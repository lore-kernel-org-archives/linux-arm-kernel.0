From: ddaney@caviumnetworks.com (David Daney)
Date: Mon, 18 May 2015 14:52:30 -0700
Subject: [PATCH net-next v3 2/2] net: Adding support for Cavium ThunderX
 network controller
In-Reply-To: <20150518.160931.2235555994068443513.davem@davemloft.net>
References: <1431747401-20847-1-git-send-email-aleksey.makarov@auriga.com>
 <1431747401-20847-3-git-send-email-aleksey.makarov@auriga.com>
 <20150518.160931.2235555994068443513.davem@davemloft.net>
Message-ID: <555A5F1E.1010509@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2015 01:09 PM, David Miller wrote:
> From: Aleksey Makarov <aleksey.makarov@auriga.com>
> Date: Fri, 15 May 2015 20:36:39 -0700
>
>> +/* Register read/write APIs */
>> +static void nic_reg_write(struct nicpf *nic, u64 offset, u64 val)
>> +{
>> +	writeq_relaxed(val, nic->reg_base + offset);
>> +}
>> +
>> +static u64 nic_reg_read(struct nicpf *nic, u64 offset)
>> +{
>> +	return readq_relaxed(nic->reg_base + offset);
>> +}
>
> Are you really sure it's OK to used relaxed ordering for all register
> accesses like this?

Yes.

>
> Personally, I think it's asking for trouble.
>
 > Maybe in _extremely_ specific situations in the packet processing
 > fast path where you can clearly define the ordering needs when
 > programming the mailbox registers, I'd say it's OK.
 >
 > But universally across the entire driver?  No way, no way at all.
 >

I think for an ordinary NIC you would be 100% correct.  However, ...

... there is something that may not be evident from the patch:

The Cavium ThunderX network controller can *only* be found in SoCs 
containing the ThunderX ARM64 CPU implementation.  So, we know quite a 
bit (i.e. everything) about the memory ordering semantics of the system.

A slightly more detailed explanation of why it is safe to use 
writeq_relaxed/readq_relaxed is that all accesses to the device 
registers are implicitly strongly ordered with respect to memory 
accesses, so even though the function names imply otherwise, there is no 
relaxed ordering.  The readq/writeq functions add explicit ordering 
operation which in this case are redundant, and only add overhead.

So this leaves us with the question:  What should we do?

As I see it there are two options:

1) Keep the writeq_relaxed()/readq_relaxed(), but add a comment about 
why they are safe.

2) Change the patch so that we are using writeq()/readq() and suffer a 
decrease in performance.

I/we wouldn't object to either of these, so it is really up to you. 
Please let us know what you think the best way forward is.

Thanks,
David Daney
