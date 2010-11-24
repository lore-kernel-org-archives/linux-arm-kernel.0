From: vbarshak@mvista.com (Valentine Barshak)
Date: Wed, 24 Nov 2010 20:40:43 +0300
Subject: [PATCH] ARM: V6 MPCore v6_dma_inv_range RWFO fix
In-Reply-To: <20101123224237.GF26510@n2100.arm.linux.org.uk>
References: <20101123222806.GA22936@mvista.com>
	<20101123224237.GF26510@n2100.arm.linux.org.uk>
Message-ID: <4CED4E1B.5000604@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Wed, Nov 24, 2010 at 01:28:06AM +0300, Valentine Barshak wrote:
>   
>> Cache ownership must be acqired by reading/writing data from the
>> cache line to make cache operation have the desired effect on the
>> SMP MPCore CPU. However, the ownership is never aquired in the
>> v6_dma_inv_range function when cleaning the first line and
>> flushing the last one, in case the address is not aligned
>> to D_CACHE_LINE_SIZE boundary.
>> Fix this by reading/writing data if needed, before performing
>> cache operations.
>>     
>
> You should do this on the data _inside_ the requested buffer.  We don't
> know if the overlapping cache line shares itself with some atomic
> variable, and doing a read-write on it could undo other updates to it.
>   
The same problem could hit us in v6_dma_flush_range as well, when we do 
r/w after bic.

Thanks,
Val.
