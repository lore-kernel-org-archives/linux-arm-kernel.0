From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Oct 2013 18:54:14 +0100
Subject: [PATCH v2] ARM: head-common.S: relocate atags area if necessary
In-Reply-To: <52616B56.10407@gmail.com>
References: <1382112776-20300-1-git-send-email-zonque@gmail.com>
 <20131018162956.GE25034@n2100.arm.linux.org.uk> <52616B56.10407@gmail.com>
Message-ID: <20131018175414.GF25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 07:09:42PM +0200, Daniel Mack wrote:
> On 10/18/2013 06:29 PM, Russell King - ARM Linux wrote:
> > On Fri, Oct 18, 2013 at 06:12:56PM +0200, Daniel Mack wrote:
> >> If the supplied atags/dtb pointer is located at memory inside the bss
> >> section, it will be erased by __mmap_switched. The problem is that the
> >> code that sets up the pointer can't know about a safe value unless it
> >> examines the kernel's symbol tables, so we should care about that case
> >> and relocate the area if necessary.
> >>
> >> This patch does that from inside __vet_atags. In order to determine the
> >> size of the section in dtb cases, it reads the next word after the dtb
> >> binary magic, and also has to convert that value from big to CPU
> >> endianess. For the atags case, a total size of up to 4k is assumed for
> >> now.
> > 
> > I'm not convinced that this is a good solution.  If this oerlaps the
> > BSS region, it could well end up being overlapped by something else
> > more serious, like the data segment
> 
> My v1 had a cover letter, don't know if you've seen it. In that, I
> describe that the setup I see that faulty condition is caused by kexec,
> which currently assumes that the decompressed kernel size is max. 4
> times bigger than the zImage it executes. While that is naive, it seems
> to be an assumption that reflects reality in my tests.
>  
> Correct me if I'm wrong, but AFAIK the .bss section is the only thing
> that can grow to arbitrary size at runtime without accounting to the
> compressed image size; so in order to fix kernels executed by kexec that
> way, my fixup seems reasonable, doesn't it?

The BSS is actually fixed at compile time (which is how arm-linux-size
vmlinux can report this.)  Userspace is slightly different, because
after the BSS is a heap whose upper limit is controlled by brk().  The
kernel doesn't have that facility though.

> > - at which point doing the fixup
> > here means we've already lost.
> 
> The question is whether it does any harm to at least try to fix up
> things in that situation.

That's not really the question.  The real question is whether we will
end up having to revert this later because we've ended up with the
kernels .data section overlapping the DTB.

That's why I think this is the wrong place to be doing it - by the
time we get anywhere near to this place, we could have already lost
the game and overwritten the DTB.

> > We already give the decompressor the size of the kernel's BSS and take
> > action if we believe that the kernel's BSS will overlap the DTB/ATAGs
> > there.
> 
> Only for CONFIG_ARM_ATAG_DTB_COMPAT (which is unset in my config),
> right? I've read through the sources relevant for my system (AM33xx),
> and couldn't find any other place where my case is covered. The
> relocation I propose does fix it, though.

When things were at a fixed location, they were always placed at
around 256 bytes into the memory, below the kernel.  I guess now people
are placing them at some random location elsewhere.

This is becoming more a more of a pain.  We have all sorts of randomly
placed objects in memory now that its only a matter of time before we
hit something.  We keep on dreaming up these "well, let's move it"
solutions but does that really help?  Move it to where?  Another place
where we think there isn't going to be anything?  What if there is?

Back in the old days it was a lot more simple.  ATAGs started at +0x100
bytes.  The decompressor and kernel placed their initial page tables
at +0x4000, and the decompressed kernel started at +0x8000.  You could
then load the compressed kernel at a very high address, and place the
init ramdisk at an address sufficiently out of the way of all of that.
Yes, we made the compressed kernel care about whether it was going to
be overwritten by the decompressed image - that was more to cope with
the compressed image executing from the same location as the
decompressed image should be.

But now we have the situation where the DTB is located at some random
address, we have an initrd also at some unknown address, and we end
up hoping that we can move the compressed kernel to some other address
which doesn't trample over these, decompress it, and hope that the
decompressed image doesn't overwrite anything...

It's all extremely fragile and full of a hell of a lot of unknowns.

Should we continue sticking plasters over this by shifting objects
to other unknown locations in memory (which, incidentally, we don't
really know where or how much memory there is in early boot) ?
