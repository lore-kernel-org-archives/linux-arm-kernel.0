From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 15 Mar 2013 16:05:18 +0100
Subject: [PATCH 0/2] Device Tree support for CMA (Contiguous Memory
 Allocator)
In-Reply-To: <20130214213013.GG1906@pengutronix.de>
References: <1360845928-8107-1-git-send-email-m.szyprowski@samsung.com>
 <20130214213013.GG1906@pengutronix.de>
Message-ID: <514338AE.60402@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

It took me some time to get back to this topic due to my holidays and other
urgent issues. I hope that this I will be able to participate a bit more 
actively.

On 2/14/2013 10:30 PM, Sascha Hauer wrote:
> Hi Marek,
>
> On Thu, Feb 14, 2013 at 01:45:26PM +0100, Marek Szyprowski wrote:
> > Hello,
> >
> > Here is my initial proposal for device tree integration for Contiguous
> > Memory Allocator. The code is quite straightforward, however I expect
> > that the memory bindings require some discussion.
> >
> > The proposed bindings allows to define contiguous memory regions of
> > specified base address and size. Then, the defined regions can be
> > assigned to the given device(s) by adding a property with a phanle to
> > the defined contiguous memory region. From the device tree perspective
> > that's all. Once the bindings are added, all the memory allocations from
> > dma-mapping subsystem will be served from the defined contiguous memory
> > regions.
> >
>
> I think CMA regions should not be described in the devicetre at all. The
> devicetree is about hardware description and it should be OS agnostic,
> but CMA is only a Linux specific implementation detail. It's not even
> specific to a particular board, it's specific to a particular usecase of
> a board.

Well, I see your point. The main problem is the fact that board files 
consisted
of both hw related definitions AND particular kernel configuration for 
the device
drivers (like the dma_declare_contiguous() calls for example). Now hw 
related
definitions are being moved to device tree, but what should we do with the
kernel configuration data, which was previously in the board files? I 
know that
in the ideal scenario there should be no such data at all and all 
drivers should
be able to automatically configure all related parameters or give 
userspace a
method for changing them in runtime. The real world is not ideal 
however. There
is a set of kernel configuration data/parameters which can be set only once,
usually early in the boot process. How should we handle it?

There is kernel command line parameter (surprisingly stored also in 
device tree,
which should not have such data...), but it intended mainly for 
debug/development
purposes and simple, usually one value parameters.

There have been discussion about CMA configuration via kernel cmd line 
long time
ago (in early CMA development days), but such attempt has been rejected, 
because
it introduced too complicated kernel parameters, see
http://thread.gmane.org/gmane.linux.kernel.mm/50669/focus=50679

So we need another solution. I'm aware of the idea that DT should be 
limited to
hw description. This principle is good and it might let us to find some 
better,
more generic approach. However, we already have some of Linux kernel 
specific
attributes ("git grep 'linux,' -- Documentation/devicetree | wc -l" 
gives 71,
most of them are in keypad and buttons drivers).

Are there any KNOWN use cases for using exiting DTS from Linux kernel 
with other
operating systems? I believe that 99% of the DTS files will be both 
developed and
used only together with Linux kernel. I'm also seeing the DT as a generic
way of describing different variants of the same hardware (what is quite 
common
in the development process) and a method for standardizing the hw 
description
to ease the developers (for a good example please just compare some old 
OMAP and
Exynos board files - each used completely different way of describing 
the same
things).

The CMA DT patches are quite short and lets anyone to put the required 
kernel
configuration together with the respective HW definitions in a very 
convenient
way. Especially referencing regions and device entries by phandle 
pointers allows
us to avoid any text-based config entries and in-kernel parsers for them.

If the presented approach is definitely prohibited then what way should 
we go?

As an alternative I'm thinking about extending 'chosen' node for such cases.
Embedding the CMA configuration data into a few sub-nodes and attributes 
there
should not be a problem. It would also keep all the config related 
entries in
a single place. The another advantage I see is the possibility to update
'chosen' node from the extended dt-aware bootloaders, which might also 
let one
to edit them. What's your opinion?

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
