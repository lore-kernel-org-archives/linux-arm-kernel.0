From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 15 Dec 2015 15:42:40 +0000
Subject: [Linaro-acpi] Touching the initrd before paging_init
In-Reply-To: <567031F2.8060102@redhat.com>
References: <566D3090.9090509@redhat.com>
 <20151213165942.GN25034@bivouac.eciton.net>
 <23071B8C-D1F9-47A6-9DB4-B26842150B76@redhat.com>
 <566DEB04.2030806@redhat.com> <566DEDFC.909@redhat.com>
 <566F9C3D.4090306@redhat.com> <yw1xd1u8gcnk.fsf@unicorn.mansr.com>
 <567031F2.8060102@redhat.com>
Message-ID: <20151215154240.GB7228@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 10:29:54AM -0500, Jon Masters wrote:
> On 12/15/2015 06:43 AM, M?ns Rullg?rd wrote:
> > Jon Masters <jcm@redhat.com> writes:
> 
> >> But the reading of that cpio content into the new table locations is
> >> done using the kernel memcpy routine to early_ioremap'd memory (Device
> >> memory), which is architecturally sensitive to missaligned accesses.
> > 
> > As others have pointed out, your error is twofold: first using
> > early_ioremap() when early_memremap() would do, then using regular
> > memcpy() and not memcpy_fromio() on that.  Seems like your precious ACPI
> > code is to blame here.
> 
> So I get that this could be changed. But I still want to understand
> whether memcpy is behaving correctly. Will it guaranteed /never/ occur
> that a copy will involve Device memory?

It is guaranteed in the same sense that other problems resulting from
misuses of kernel APIs are guaranteed never to occur -- so long as the
contract between the API and the programmer is respected.

It is physically possible that a programmer may violate that contract.
It is a programming error if that happens.

> All other such occurrences in the kernel will be caught and fixed so
> this will never be an issue?

No-one has the prescience to be able to tell you whether a particular
bug will or will not be introduced in future. If the programmer pays
attention to their tools (e.g. sparse warnings about address space
mismatches), this class of error is fairly easy to avoid.

If you have found another occurrence of this issue, please report it.

Mark.
