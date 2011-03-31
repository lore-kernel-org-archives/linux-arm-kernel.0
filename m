From: mina86@mina86.com (Michal Nazarewicz)
Date: Fri, 01 Apr 2011 00:51:32 +0200
Subject: [PATCH 04/12] mm: alloc_contig_freed_pages() added
In-Reply-To: <1301610411.30870.29.camel@nimitz>
References: <1301577368-16095-1-git-send-email-m.szyprowski@samsung.com>
	<1301577368-16095-5-git-send-email-m.szyprowski@samsung.com>
	<1301587083.31087.1032.camel@nimitz>
	<op.vs77qfx03l0zgt@mnazarewicz-glaptop>
	<1301606078.31087.1275.camel@nimitz>
	<op.vs8awkrx3l0zgt@mnazarewicz-glaptop>
	<1301610411.30870.29.camel@nimitz>
Message-ID: <op.vs8cf5xd3l0zgt@mnazarewicz-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 01 Apr 2011 00:26:51 +0200, Dave Hansen <dave@linux.vnet.ibm.com>  
wrote:

> On Fri, 2011-04-01 at 00:18 +0200, Michal Nazarewicz wrote:
>> On Thu, 31 Mar 2011 23:14:38 +0200, Dave Hansen wrote:
>> > We BUG_ON() in bootmem.  Basically if we try to allocate an early-boot
>> > structure and fail, we're screwed.  We can't keep running without an
>> > inode hash, or a mem_map[].
>> >
>> > This looks like it's going to at least get partially used in drivers,  
>> at
>> > least from the examples.  Are these kinds of things that, if the  
>> driver
>> > fails to load, that the system is useless and hosed?  Or, is it
>> > something where we might limp along to figure out what went wrong  
>> before
>> > we reboot?
>>
>> Bug in the above place does not mean that we could not allocate  
>> memory.  It means caller is broken.
>
> Could you explain that a bit?
>
> Is this a case where a device is mapped to a very *specific* range of
> physical memory and no where else?  What are the reasons for not marking
> it off limits at boot?  I also saw some bits of isolation and migration
> in those patches.  Can't the migration fail?

The function is called from alloc_contig_range() (see patch 05/12) which
makes sure that the PFN is valid.  Situation where there is not enough
space is caught earlier in alloc_contig_range().

alloc_contig_freed_pages() must be given a valid PFN range such that all
the pages in that range are free (as in are within the region tracked by
page allocator) and of MIGRATETYPE_ISOLATE so that page allocator won't
touch them.

That's why invalid PFN is a bug in the caller and not an exception that
has to be handled.

Also, the function is not called during boot time.  It is called while
system is already running.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Michal "mina86" Nazarewicz    (o o)
ooo +-----<email/xmpp: mnazarewicz@google.com>-----ooO--(_)--Ooo--
