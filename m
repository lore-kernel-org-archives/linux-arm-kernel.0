From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Fri, 14 Aug 2015 17:01:49 -0700
Subject: [PATCH] ARM: keystone: add a work around to handle asynchronous
 external abort
In-Reply-To: <55CE633C.10402@ti.com>
References: <1439320409-20084-1-git-send-email-m-karicheri2@ti.com>
 <55CDF579.4050408@ti.com> <20150814140934.GX7557@n2100.arm.linux.org.uk>
 <55CE05EC.4040909@oracle.com> <55CE633C.10402@ti.com>
Message-ID: <55CE816D.1020809@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/14/15 2:53 PM, Murali Karicheri wrote:
> On 08/14/2015 11:14 AM, santosh shilimkar wrote:
>> On 8/14/2015 7:09 AM, Russell King - ARM Linux wrote:
>>> On Fri, Aug 14, 2015 at 10:04:41AM -0400, Murali Karicheri wrote:
>>>> On 08/11/2015 03:13 PM, Murali Karicheri wrote:
>>>>> Currently on some devices, an asynchronous external abort exception
>>>>> happens during boot up when exception handlers are enabled in kernel
>>>>> before switching to user space. This patch adds a workaround to handle
>>>>> this once during boot. Many customers are already using this
>>>>> with out any issues and is required to workaround the above issue.
>>>>>
>>>>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>>>>> ---
>>>>>   arch/arm/mach-keystone/keystone.c | 26 ++++++++++++++++++++++++++
>>>>>   1 file changed, 26 insertions(+)

[...]

>>>>> +
>>>>> +    /*
>>>>> +     * Add a one time exception handler to catch asynchronous
>>>>> external
>>>>> +     * abort
>>>>> +     */
>>>>> +    hook_fault_code(17, keystone_async_ext_abort_fault, SIGBUS, 0,
>>>>> +            "async external abort handler");
>>>>>   }
>>>>>
>>>>>   static phys_addr_t keystone_virt_to_idmap(unsigned long x)
>>>>>
>>>> Can this be applied if it looks good?
>>>
>>> What causes the abort?  We shouldn't be adding hacks like this to the
>>> kernel without having the full picture...
>>>
>> Indeed. These external aborts are notorious and often hides dangerous
>> bugs. On OMAP as well many folks burn their had with it till the
>> interconnect handlers were added to detect those and hunt those
>> bugs.
>>
>> In my experience such aborts happen outside ARM subsystem, either in
>> the interconnect or at the salve targets which are reported over
>> the ARM bus as async external aborts. And often these errors are
>> due to bad accesses/wrong accesses/un-clocked accesses at slaves.
>>
> We have spend some time already to debug the root cause. Do you have
> idea on how this was hunted down on OMAP that we can learn from? The bad
> address is NULL and it seems to happen very rarely and is not easily
> reproducible. Don't want to put this workaround, but we couldn't track
> it down either. So any help to debug this will be appreciated.
>
As RMK pointed out, try Lucas patch and see if it gives any useful
information to narrow it down.

On OMAP, fortunately interconnect has IRQ(s) which are hooked with
ARM subsystem. So the bus driver(drivers/bus/omap-l3*) was able to
handle those events and report the offenders.

Regards,
Santosh
