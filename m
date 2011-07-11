From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 11 Jul 2011 10:59:05 -0400 (EDT)
Subject: [PATCH 01/52] ARM: introduce atag_offset to replace
 boot_params
In-Reply-To: <alpine.LFD.2.00.1107081714251.14596@xanadu.home>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
	<20110708203634.GU4812@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107081714251.14596@xanadu.home>
Message-ID: <alpine.LFD.2.00.1107111046350.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Jul 2011, Nicolas Pitre wrote:

> On Fri, 8 Jul 2011, Russell King - ARM Linux wrote:
> 
> > On Tue, Jul 05, 2011 at 10:46:46PM -0400, Nicolas Pitre wrote:
> > > The boot_params member of the mdesc structure is used to provide a
> > > default physical address for the ATAG list.  Since this value is fixed
> > > at compile time and often based on ARCH_PHYS_OFFSET, it gets in the way
> > > of runtime PHYS_OFFSET usage.
> > > 
> > > Let's introduce atag_offset which should contains only the relative
> > > offset from start of memory instead of an absolute value, in preparation
> > > to move all instance of boot_params over to it.
> > 
> > I don't like this.
> > 
> > While I understand the issue (the oops when we try to dereference the
> > absolute address), the fact is that's how it is.
> > 
> > Take a moment to think about this.  The ATAG list is normally setup at a
> > fixed physical address by the boot loader.  While there are some boot
> > loaders which allow you to load the kernel at different physical addresses,
> > they still place the ATAG list at that same physical address.
> 
> Would they really load the kernel at a different address?
> 
> > That means if you change this into an offset from the kernels idea of
> > PHYS_OFFSET, it's not going to find the ATAGs.
> 
> Is this going to be a real issue in practice?
> 
> > So we're probably better off checking whether the platform provided ATAG
> > pointer is below our idea of PHYS_OFFSET, and if it is to ignore that.
> 
> The code already does that.
> 
> Alternatively, I can make the boot_params values into numeric values 
> instead of PLAT_PHYS_OFFSET or any other symbolic define I'd like to get 
> rid of.  What do you think?

After looking at it some more, this can't work either as on ep93xx the 
RAM offset is currently selected a kernel config time and we do want to 
get rid of that.

Furthermore, the code in setup_machine_tags() always validates the atags 
pointer with ATAG_CORE and assigns it the address of init_tags 
otherwise.  Given that the atag offset is always within the first 
megabyte which is always mapped, the kernel won't crash even if the 
ATAGs are not there.


Nicolas
