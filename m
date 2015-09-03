From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Thu, 3 Sep 2015 10:26:49 +0200
Subject: Cortex A9 MP: ARM errata 754323 implementation?
In-Reply-To: <20150903080502.GT21084@n2100.arm.linux.org.uk>
References: <55E7F965.8080802@de.bosch.com>
 <20150903080502.GT21084@n2100.arm.linux.org.uk>
Message-ID: <55E80449.9040308@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03.09.2015 10:05, Russell King - ARM Linux wrote:
> On Thu, Sep 03, 2015 at 09:40:21AM +0200, Dirk Behme wrote:
>> looking through the ARM Cortex A9 errata list [1] I wonder why we don't have
>> a workaround for
>>
>> (754323) Repeated Store in the same cache line might delay the visibility of
>> the Store
>>
>> in the kernel? Or have I missed it?
>
> The policy for errata is not to implement them unless there's a requirement
> to do so - and then the errata should be implemented in board firmware in
> preference to the kernel where possible.
>
> Are you seeing a problem directly attributable to this errata?


I got a report from some internal testing that an issue they see goes 
away if they enable 754327. I rejected this because i.MX6 is > r2p0 and 
therefore can't be affected by this errata. Looking through the list of 
erratas I then found the related 754323 which seems to apply to i.MX6, 
but is not implemented.


The issue we are talking about is

Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
PC is at kfree+0x10c/0x238
LR is at release_firmware+0x5c/0x70

which is said to be triggered by this code

void kfree(const void *x)
...
page = virt_to_head_page(x);
if (unlikely(!PageSlab(page))) {
BUG_ON(!PageCompound(page));
...

on a custom 3.14.x kernel. I haven't looked into this myself, but at 
least two people think that the kmalloc/kfree is correct with the 
request_firmware()/release_firmware() usage in the driver.

Best regards

Dirk
