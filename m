From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Tue, 23 Oct 2018 10:53:50 +0000
Subject: [PATCH] zynq-fpga: Only route PR via PCAP when required
In-Reply-To: <20181023090119.GA2205@archbook>
References: <1540276279-2903-1-git-send-email-mike.looijmans@topic.nl>
 <20181023090119.GA2205@archbook>
Message-ID: <1781ed23-e03c-f70a-ea8c-3e9fa6eec9d4@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23-10-18 11:01, Moritz Fischer wrote:
> Hi Mike,
> 
> seems like a good usecase (though uncommon), question below

Usecases for ICAP:
- It's considerably faster than PCAP
- Self-repairing logic (e.g. single-event upsets)
- Being programmed from a remote FPGA
- Programming through another bus (e.g. PCIe)


> 
> On Tue, Oct 23, 2018 at 08:31:19AM +0200, Mike Looijmans wrote:
>> The Xilinx Zynq FPGA driver takes ownership of the PR interface, making
>> it impossible to use the ICAP interface for partial reconfiguration.
>>
>> This patch changes the driver to only activate PR over PCAP while the
>> device is actively being accessed by the driver for programming.
>>
>> This allows both PCAP and ICAP interfaces to be used for PR.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>>   drivers/fpga/zynq-fpga.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
>> index 3110e00..f6c205a 100644
>> --- a/drivers/fpga/zynq-fpga.c
>> +++ b/drivers/fpga/zynq-fpga.c
>> @@ -497,6 +497,10 @@ static int zynq_fpga_ops_write_complete(struct fpga_manager *mgr,
>>   	int err;
>>   	u32 intr_status;
>>   
>> +	/* Release 'PR' control back to the ICAP */
>> +	zynq_fpga_write(priv, CTRL_OFFSET,
>> +		zynq_fpga_read(priv, CTRL_OFFSET) & ~CTRL_PCAP_PR_MASK);
>> +
> 
> Shouldn't that be after the below stanza that enables the clock?

I'm actually not sure, and I did not encounter any problems while testing 
this, but it's easier to just move it than to find out, so I'll go for "yes, 
let's enable the clock first".
I'll await a bit more feedback and post a v2 for that.

> 
>>   	err = clk_enable(priv->clk);
>>   	if (err)
>>   		return err;
>> -- 
>> 1.9.1
>>
> 
> Cheers,
> 
> Moritz
> 
