From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 6 Aug 2015 16:43:15 +0100
Subject: [Xen-devel] [PATCH v2 13/20] xen/events: fifo: Make it running
 on 64KB granularity
In-Reply-To: <55B21527.4010601@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-14-git-send-email-julien.grall@citrix.com>
 <55B21527.4010601@citrix.com>
Message-ID: <55C38093.8080609@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On 24/07/15 11:36, David Vrabel wrote:
> On 09/07/15 21:42, Julien Grall wrote:
>> Only use the first 4KB of the page to store the events channel info. It
>> means that we will wast 60KB every time we allocate page for:
>>      * control block: a page is allocating per CPU
>>      * event array: a page is allocating everytime we need to expand it
> 
> Reviewed-by: David Vrabel <david.vrabel@citrix.com>

Thank you!

>>
>> I think we can reduce the memory waste for the 2 areas by:
>>
>>     * control block: sharing between multiple vCPUs. Although it will
>>     require some bookkeeping in order to not free the page when the CPU
>>     goes offline and the other CPUs sharing the page still there
>>
>>     * event array: always extend the array event by 64K (i.e 16 4K
>>     chunk). That would require more care when we fail to expand the
>>     event channel.
> 
> I would extend it by 4 KiB each time but only allocate a new page every
> 16 times.  This minimizes the resources used in Xen.

I will keep it in mind when I will send a patch to reduce memory waster.

Regards,

-- 
Julien Grall
