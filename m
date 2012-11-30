From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Fri, 30 Nov 2012 10:54:52 -0500
Subject: [PATCH v4 01/14] ARM: Add page table and page defines needed by
 KVM
In-Reply-To: <20121130114634.GC26305@mudshark.cambridge.arm.com>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154217.2836.41905.stgit@chazy-air>
 <20121119141417.GT3205@mudshark.cambridge.arm.com>
 <CANM98q+H6J56HqidqKTpTT1Er-wHsSNyJi4zwGVG2eX6N04vPw@mail.gmail.com>
 <20121130114634.GC26305@mudshark.cambridge.arm.com>
Message-ID: <CANM98qLj=GNiJa6Lt_AmY16cF-PPhcEECe+O0PQhmPqHtGLLqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 30, 2012 at 6:46 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, Nov 29, 2012 at 03:57:00PM +0000, Christoffer Dall wrote:
>> On Mon, Nov 19, 2012 at 9:14 AM, Will Deacon <will.deacon@arm.com> wrote:
>> > On Sat, Nov 10, 2012 at 03:42:17PM +0000, Christoffer Dall wrote:
>> >>
>> >> +#ifdef CONFIG_ARM_LPAE
>> >> +#define s2_policy(policy)    policy
>> >> +#else
>> >> +#define s2_policy(policy)    0
>> >> +#endif
>> >
>> > Put the macro in pgtable-{2,3}level.h?
>> >
>>
>> I think that's weird, defining something far away from where it's used
>> will only make it harder to read, pgtable.h is not included in this
>> file, and there are other #ifdef CONFIG_ARM_LPAE in that file.
>
>
> Of course pgtable.h is included in this file -- we have direct references to
> L_PTE_MT_UNCACHED, for example, so by your logic we should inline all of
> that too!

no, not at all!

>
> Yes, there are other CONFIG_ARM_LPAE checks in this file, but only where
> there's a piece of code that is not applicable one way or the other. For
> data definitions, it's really easy to fix in the headers so please do it
> there instead.
>
I don't see that macro as a data definition, it's a way to avoid
compile error when those defines are not there, and I don't see where
that would ever be used outside this file, so moving it just makes you
go hunting for the definition elsewhere.

Perhaps there's an idea behind these files stating that it's
universally better to have things in a header file, but I don't quite
see why?

(I can definitely move it, and I don't want to fight over it, I'm
merely trying to understand why it would make the code cleaner/better
to maintain/etc.)

-Christoffer
