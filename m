From: olof@lixom.net (Olof Johansson)
Date: Sun, 20 Nov 2011 09:54:42 -0800
Subject: [PATCH] ARM: Do not call flush_cache_user_range with mmap_sem held
In-Reply-To: <20111117104546.GM9581@n2100.arm.linux.org.uk>
References: <20111107172836.5615.64219.stgit@e102109-lin.cambridge.arm.com>
 <CAOesGMhWxEKUe7C4A+Xqv3RjN_u1t4k8eHWSZE4qMoBPD9=1qw@mail.gmail.com>
 <20111116235024.GH9581@n2100.arm.linux.org.uk>
 <CAOesGMgmVdck4rP9iQ+eBc+R1p-eVChnumiszB_D77Q0Rtyf3Q@mail.gmail.com>
 <20111117104546.GM9581@n2100.arm.linux.org.uk>
Message-ID: <CAOesGMhhWKcu8Zjp--1g1++Dv8482Rx7qB+nzB29keOVONaLCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 17, 2011 at 2:45 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Nov 16, 2011 at 04:16:17PM -0800, Olof Johansson wrote:
>> Yep, I would agree if we actually needed the vma for the flags, but we
>> don't with the current implementation.
>
> That's just one reason. ?I mentioned more than one reason why the locking
> was necessary in my mail but you seem to have ignored that. ?The second
> reason is a far more serious problem.

Just to make sure we're talking about the same thing here: With 'the
second reason' you mean the fact that we will fault if the cache flush
is done on an address that has since (for example) been unmapped?

Since the flush ops are in the exception tables, the page fault code
should be handling this properly and deliver the fault up to the
process, shouldn't it? The one remaining piece for this to work is to
make sure that the exception table annotations are in place in all
cache flush implementations, and it seems like they are only there in
v6 and v7. I'll be happy to add them to the others.

Address space changes done such that they race with the cache flush
ops will cause problems for the application. However, this is not
unlike the architectures where cache flushes can be done entirely in
userspace, for those the same code will cause problems as well. We
just let the application developers deal with it there, and they don't
seem to complain.

>> We also don't continue iterating over the vmas, we only flush for the
>> first one in the range that we find. That is possibly a bug.
>
> No, that's intentional. ?This function is not supposed to be used to
> invalidate across several mappings. ?It's there to deal with JIT code,
> which will be written into some allocated memory. ?It is extremely
> unlikely that JIT code will be written into two consecutive, independently
> created mappings and a single cache operation requested over both.
>
> What if the two independent mappings are located at wildly different
> addresses?

I was more concerned with the case where a VMA has split because of
page protection changes, for example. But if no application developers
are complaining about this then I don't see a reason for us to argue
over it -- let's leave those aspects of the code alone at this time --
having the sanity check of the VMA and the range of it is a good idea
overall.


-Olof
