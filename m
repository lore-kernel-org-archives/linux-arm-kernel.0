From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 15 Sep 2010 09:06:02 +0800
Subject: [RFC] mmaping with VIVT cache
In-Reply-To: <20100914235043.GA31500@n2100.arm.linux.org.uk>
References: <210713.63745.qm@web120207.mail.ne1.yahoo.com>
	<20100914235043.GA31500@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinKkoZsEEpM52yhp8yP5W9J_Ym-HfT3j+prDsUJ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 15, 2010 at 7:50 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Sep 13, 2010 at 12:58:41PM -0700, P F wrote:
>> Hi,
>>
>> Please excuse the pseudonym.
>>
>> I have recently encountered a problem in the context of the UVC (webcam)
>> driver. ?The driver maintainer, Laurent, suggested that we bring the
>> thread to linux-arm-kernel for wider discussion. ?See here for reference:
>> http://lists.berlios.de/pipermail/linux-uvc-devel/2010-August/005864.html
>>
>> The problem I encountered was this: using an ARM926EJ-S with OHCI USB host,
>> I noticed intermittent graphical corruption of frames captured by several
>> different webcams, both UVC and non-UVC.
>>
>> I was able to isolate the corruption down to one specific instance. ?In
>> this instance, I collected three images:
>> 1A.jpg - collected from host, prior to corruption
>> 2A.jpg - collected from host, demonstrating corruption
>> 2B.jpg - collected from inline USB analyzer, same image as 2A
>>
>> Images 1A and 2A are in sequence, i.e., 2A immediately follows 1A. ?2B is
>> not corrupted, and a binary diff between 2A and 2B shows two 32-byte
>> chunks have been changed. ?A binary diff between 2A and 1A shows that
>> these same two chunks match. ?Therefore, it seems there is some
>> contamination of the second image by the first.
>>
>> As I described in the linked message, I found a workaround for this issue
>> by adding
>> ? vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot)
>> in the UVC driver's mmap() function, but Laurent explained that this was
>> invalid.
>>
>> Does anybody have ideas for a proper fix? ?I can reproduce this corruption
>> easily, and would be happy to test proposed patches.
>
> The fact is that mapping buffers as cacheable into userspace on non-
> coherent architectures _will_ result in the cache contents getting in
> the way of updates to the DMA'd buffer. ?It's a fundamental property
> of such hardware implementations.
>

Maybe we can just detect if the buffer is mapped in alias, and modify the
PTE, just as what we did to inconsistent write-combine? So to make this
transparent to other consistent architectures?

> I've tried to introduce an API for mapping "coherent" DMA buffers
> into userspace, and it got nowhere (well, only ARM implements it,
> and hardly anyone uses it) - hence why we still have these problems.
>
> So I don't have an answer to solve your problem - afaiac, it's up to
> the device driver authors to sort it out, and apply pressure to other
> parts of the kernel community (those who resist a way to make this
> kind of thing work) to sort out how to cleanly map buffers used for
> DMA into userspace.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
