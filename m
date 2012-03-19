From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 19 Mar 2012 12:53:48 -0400 (EDT)
Subject: [PATCH] ARM: lib: use LDRD/STRD for data copy
In-Reply-To: <4F6760A5.9040506@gmail.com>
References: <007201cd059e$4af2cc10$e0d86430$%kim@samsung.com>
 <20120319085503.GL15988@n2100.arm.linux.org.uk> <4F674479.8090101@gmail.com>
 <20120319154123.GP15988@n2100.arm.linux.org.uk> <4F6760A5.9040506@gmail.com>
Message-ID: <alpine.LFD.2.02.1203191244390.24151@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Mar 2012, Rob Herring wrote:

> On 03/19/2012 10:41 AM, Russell King - ARM Linux wrote:
> > On Mon, Mar 19, 2012 at 09:36:41AM -0500, Rob Herring wrote:
> >> On 03/19/2012 03:55 AM, Russell King - ARM Linux wrote:
> >>> On Mon, Mar 19, 2012 at 04:02:48PM +0900, Boojin Kim wrote:
> >>>> This patch uses LDRD/STRD that loads and stores data as DWORD unit
> >>>> for the copy of 8-words data.
> >>>> It brings better performance than LDRM/STRM that was used originally.
> >>>
> >>> And what about CPUs that don't have ldrd/strd ?
> >>>
> >>
> >> And what about CPUs that do have ldrd/strd but is slower than ldm/stm?
> >> I'm pretty sure that is almost everything currently out there.
> > 
> > The double-word load/stores were introduced in ARMv6.  Some Intel based
> > CPUs prior to this have the support as well.  Everything else doesn't.
> > 
> > So taht's nowhere close to 'almost everything'.
> 
> I meant of all platforms that support both instructions, ldm/stm will be
> faster than ldrd/strd on almost all of them AFAIK. I don't think the
> claim about being faster is true for an CortexA9 or anything prior.
> Linaro folks have done some benchmarking in this area and would be
> better to comment.

And more importantly, the generic copy functions in the kernel are 
typically used for small copies in most cases, while people tend to 
benchmark copy functions with large buffers, leading to wrong decisions.
  
The functions worth optimizing for throughput are rather copy_page(), 
copy_user_page(), clear_page(), etc.  And not forgetting that some of 
them areinvoked with a typical cache state for the involved memory.



Nicolas
