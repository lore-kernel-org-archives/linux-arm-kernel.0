From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 20 Sep 2009 09:15:50 +0100
Subject: [PATCH 1/2] ARM: Pass IFSR register to do_PrefetchAbort()
In-Reply-To: <20090919110316.GA23452@n2100.arm.linux.org.uk>
References: <c9f73fa56a41bc1051cd347cc453081235e3d776.1253307263.git.kirill@shutemov.name>
	<20090919110316.GA23452@n2100.arm.linux.org.uk>
Message-ID: <20090920081550.GA830@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 19, 2009 at 12:03:16PM +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 18, 2009 at 11:55:42PM +0300, Kirill A. Shutemov wrote:
> > It needed for proper prefetch abort handling on ARMv7.
> 
> I think the only thing which is missing is an explaination about why
> this is desirable given that only later CPUs can give this additional
> information.

So you've posted it to the patch system, without further discussion here.

I think the solution is wrong - it makes instruction permission faults
unnecessarily noisy, which is not what the decoding table is supposed
to be doing.  The decoding table's bad entries are there to catch those
_unexpected_ cases.

Instead, I suggest that you have a look at this:

        if (fsr & (1 << 11)) /* write? */
                mask = VM_WRITE;
        else
                mask = VM_READ|VM_EXEC|VM_WRITE;

        fault = VM_FAULT_BADACCESS;
        if (!(vma->vm_flags & mask))
                goto out;

in __do_page_fault - if we are handling a prefetch abort, we really only
want to check that the VMA has VM_EXEC permission, not that it can be
read and written as well.
