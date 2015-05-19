From: david.vrabel@citrix.com (David Vrabel)
Date: Tue, 19 May 2015 16:25:53 +0100
Subject: [Xen-devel] [RFC 16/23] xen/events: fifo: Make it running on
 64KB granularity
In-Reply-To: <1431622863-28575-17-git-send-email-julien.grall@citrix.com>
References: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
 <1431622863-28575-17-git-send-email-julien.grall@citrix.com>
Message-ID: <555B5601.5020906@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/05/15 18:00, Julien Grall wrote:
> Only use the first 4KB of the page to store the events channel info. It
> means that we will wast 60KB every time we allocate page for:
>      * control block: a page is allocating per CPU
>      * event array: a page is allocating everytime we need to expand it
> 
> I think we can reduce the memory waste for the 2 areas by:
> 
>     * control block: sharing between multiple vCPUs. Although it will
>     require some bookkeeping in order to not free the page when the CPU
>     goes offline and the other CPUs sharing the page still there
> 
>     * event array: always extend the array event by 64K (i.e 16 4K
>     chunk). That would require more care when we fail to expand the
>     event channel.

I think you want an xen_alloc_page_for_xen() or similar to allocate a 4
KiB size/aligned block.

But as-is:

Reviewed-by: David Vrabel <david.vrabel@citrix.com>

David
