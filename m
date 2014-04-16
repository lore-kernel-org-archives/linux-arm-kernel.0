From: davem@davemloft.net (David Miller)
Date: Wed, 16 Apr 2014 13:38:31 -0400 (EDT)
Subject: [RFC PATCH v4] ARM: uprobes xol write directly to userspace
In-Reply-To: <20140416164310.GA15739@redhat.com>
References: <20140416145107.GA11039@redhat.com>
 <20140416.110031.1269128188581361698.davem@davemloft.net>
 <20140416164310.GA15739@redhat.com>
Message-ID: <20140416.133831.364304583096073299.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Oleg Nesterov <oleg@redhat.com>
Date: Wed, 16 Apr 2014 18:43:10 +0200

> But did you really mean get_unmapped_area(pgoff => page_to_pfn(area->page)) ?

Yes.

> I simply can't understand how this can work, arm (and x86) really use it as
> "pgoff << PAGE_SHIFT" align_offset accounted in unmapped_area() ?

When a platform has D-cache aliasing issues, it must make sure that
every shared page is mapped to the same D-cache alias in all such
shared mappings.

The way this is done is to map each pgoff to a page in the D-cache.
For example, pgoff 0 would be given a virtual address that maps to the
first page in the D-cache, pgoff 1 to the second, and so forth.

What we're doing with this get_unmapped_area() call is to make it so
that userspace's virtual address will land@the same virtual alias
as the kernel one does.

So that stores on the kernel side will be seen properly, without any
cache flushing, by the user side mapping.

>> So we end up with all of the benefits of storing directly to
>> userspace, along with what you're trying to achieve.
> 
> And in this case we can avoid copy_to_user(), right ?

Yes, that's the whole idea, you can forget about the VM_WRITE etc.
that caused your concerns.

It'd be just memcpy to kernel side mapping of the page + i-cache flush
where necessary.
