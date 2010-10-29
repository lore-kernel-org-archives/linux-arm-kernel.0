From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Oct 2010 23:14:37 +0100
Subject: [PATCH] msm: fix debug-macro.S build failure
In-Reply-To: <1288387033.6631.13.camel@m0nster>
References: <20101028163518.GG3122@n2100.arm.linux.org.uk>
	<1288284066.2683.9.camel@c-dwalke-linux.qualcomm.com>
	<20101028174653.GH3122@n2100.arm.linux.org.uk>
	<1288288824.2683.24.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1010281422190.3227@xanadu.home>
	<20101028182851.GI3122@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1010281441540.3227@xanadu.home>
	<20101028184627.GK3122@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1010282226460.5029@xanadu.home>
	<1288387033.6631.13.camel@m0nster>
Message-ID: <20101029221437.GA31224@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 29, 2010 at 02:17:13PM -0700, Daniel Walker wrote:
> On Thu, 2010-10-28 at 23:03 -0400, Nicolas Pitre wrote:
> > On Thu, 28 Oct 2010, Russell King - ARM Linux wrote:
> > 
> > > On Thu, Oct 28, 2010 at 02:43:16PM -0400, Nicolas Pitre wrote:
> > > > On Thu, 28 Oct 2010, Russell King - ARM Linux wrote:
> > > > 
> > > > > On Thu, Oct 28, 2010 at 02:24:33PM -0400, Nicolas Pitre wrote:
> > > > > > On Thu, 28 Oct 2010, Daniel Walker wrote:
> > > > > > 
> > > > > > > This is what the function currently has,
> > > > > > > 
> > > > > > >         .macro  addruart, rp, rv
> > > > > > >         ldr     \rp, =MSM_DEBUG_UART_PHYS
> > > > > > >         ldr     \rv, =MSM_DEBUG_UART_BASE
> > > > > > >         .endm
> > > > > > > 
> > > > > > > So if we have a MSM_DEBUG_UART_PHYS and MSM_DEBUG_UART_BASE we're
> > > > > > > returning it. We don't actually have those values for all the boards
> > > > > > > tho. My understanding was that there are some generic arm changes
> > > > > > > needed, but I need to confirm that.
> > > > > > 
> > > > > > Just return 0 in both registers when you have nothing better to return.
> > > > > 
> > > > > That's not a good idea - it'll cause 512MB of 1:1 mappings to be setup
> > > > > at virtual location 0 using the IO flags, which may conflict on ARMv6+.
> > > > > A better idea would be to return 0xfff00000, which'll cause it to only
> > > > > populate the top-most 1MB.
> > > > 
> > > > Given that this a phony address, better test for 0 explicitly and skip 
> > > > the mapping as well as bailing out early from putchar, etc.
> > > 
> > > That could be 0 phys, which given there is no defined memory layout on
> > > ARM, I would not put it past someone to put a UART at phys location 0
> > > one day.
> > 
> > Who knows.  But in this case I think it is probably cleaner to just care 
> > about the virtual address, and do something like this:
> 
> I need something for this merge window (which is closing soon) .. So I'm
> just going to go with my original revert .. It seems like anything I do
> to get addruart to return something turns into too large a patch which I
> don't want to force.
> 
> I think the revert should be fine until we come up with a good way to
> fix this, either what you suggested or something entirely in msm.

Your original patch is unsuitable as it leaves the values uninitialized.

What will happen is that rp will be the value of the procinfo mmuflags,
so effectively zero.  rv will be page table value for the section
following the kernel, which is effectively the physical address of that.

This I guess will mean that it generally won't overwrite an existing
mapping, unless the folowing 512MB of mappings does so.

As I've said, the safest thing is to set rv to 0xfff00000 and have it
only setup one mapping.  Set rp to whatever you like - leave it
uninitialised if you're not filling in the other functions, it doesn't
matter (but note that.)
