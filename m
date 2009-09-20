From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Sun, 20 Sep 2009 12:35:19 +0300
Subject: [PATCH 1/2] ARM: Pass IFSR register to do_PrefetchAbort()
In-Reply-To: <20090920081550.GA830@n2100.arm.linux.org.uk>
References: <c9f73fa56a41bc1051cd347cc453081235e3d776.1253307263.git.kirill@shutemov.name>
	<20090919110316.GA23452@n2100.arm.linux.org.uk>
	<20090920081550.GA830@n2100.arm.linux.org.uk>
Message-ID: <cc557aab0909200235sbb4c1f5tdc84434732222988@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 20, 2009 at 11:15 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Sep 19, 2009 at 12:03:16PM +0100, Russell King - ARM Linux wrote:
>> On Fri, Sep 18, 2009 at 11:55:42PM +0300, Kirill A. Shutemov wrote:
>> > It needed for proper prefetch abort handling on ARMv7.
>>
>> I think the only thing which is missing is an explaination about why
>> this is desirable given that only later CPUs can give this additional
>> information.
>
> So you've posted it to the patch system, without further discussion here.
>
> I think the solution is wrong - it makes instruction permission faults
> unnecessarily noisy, which is not what the decoding table is supposed
> to be doing. ?The decoding table's bad entries are there to catch those
> _unexpected_ cases.
>
> Instead, I suggest that you have a look at this:
>
> ? ? ? ?if (fsr & (1 << 11)) /* write? */
> ? ? ? ? ? ? ? ?mask = VM_WRITE;
> ? ? ? ?else
> ? ? ? ? ? ? ? ?mask = VM_READ|VM_EXEC|VM_WRITE;
>
> ? ? ? ?fault = VM_FAULT_BADACCESS;
> ? ? ? ?if (!(vma->vm_flags & mask))
> ? ? ? ? ? ? ? ?goto out;
>
> in __do_page_fault - if we are handling a prefetch abort, we really only
> want to check that the VMA has VM_EXEC permission, not that it can be
> read and written as well.
>

Ok, so __do_page_fault() should know where we are: in data abort or in
prefetch abort. What is right way to do it? Should we create one more
argument or use one of reserved bits IFSR?
