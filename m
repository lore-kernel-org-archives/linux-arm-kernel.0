From: d-gerlach@ti.com (Dave Gerlach)
Date: Fri, 6 Jan 2017 10:29:43 -0600
Subject: [PATCH 1/2] ARM: mm: fix set_memory_*() bounds checks
In-Reply-To: <20161129175920.GZ14217@n2100.armlinux.org.uk>
References: <E1c8r91-0007wL-Fl@rmk-PC.armlinux.org.uk>
 <24932a5a-4cbf-dd84-2e87-de29b07da5b3@ti.com>
 <20161129175920.GZ14217@n2100.armlinux.org.uk>
Message-ID: <b7d5fa1e-9301-2b3a-f773-67cfd2c4136f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,
On 11/29/2016 11:59 AM, Russell King - ARM Linux wrote:
> On Tue, Nov 29, 2016 at 09:25:19AM -0600, Dave Gerlach wrote:
>> Hi,
>> On 11/21/2016 10:08 AM, Russell King wrote:
>>> +static bool in_range(unsigned long start, unsigned long size,
>>> +	unsigned long range_start, unsigned long range_end)
>>> +{
>>> +	return start >= range_start && start < range_end &&
>>> +		size <= range_end - start;
>>> +}
>>> +
>>> static int change_memory_common(unsigned long addr, int numpages,
>>> 				pgprot_t set_mask, pgprot_t clear_mask)
>>> {
>>> -	unsigned long start = addr;
>>> -	unsigned long size = PAGE_SIZE*numpages;
>>> -	unsigned long end = start + size;
>>> +	unsigned long start = addr & PAGE_SIZE;
>>
>> This doesn't work as is, I believe 'start' should be set to
>> PAGE_ALIGN(addr), addr & PAGE_SIZE as it is doesn't make sense. If I make
>> this change this code works ok.
>
> You're right, but we want to round 'addr' _down_, not up as PAGE_ALIGN()
> will do.  So that should've been PAGE_MASK.
>

Do you plan to send an updated version of this patch? I'd be happy to 
update it and resend.

Regards,
Dave
