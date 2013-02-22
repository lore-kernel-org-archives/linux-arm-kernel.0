From: scottwood@freescale.com (Scott Wood)
Date: Thu, 21 Feb 2013 18:19:15 -0600
Subject: [U-Boot] [RFC] Kbuild support for ARM FIT images
In-Reply-To: <20130221231106.GA24426@obsidianresearch.com> (from
 jgunthorpe@obsidianresearch.com on Thu Feb 21 17:11:06 2013)
Message-ID: <1361492355.1574.7@snotra>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/21/2013 05:11:06 PM, Jason Gunthorpe wrote:
> On Thu, Feb 21, 2013 at 05:05:54PM -0500, Nicolas Pitre wrote:
> > No it is not.  FIT is about bundling a multi-platform kernel with a
> > bunch of DTBs together in a single file.  I don't think you need  
> that
> > for your embedded system.  The "wrong message" here is to distribute
> > multiple DTBs around, whether it is with FIT or on a distro install
> > media.
> 
> Actually we do this on PPC, the boot kernel image runs on three
> similar hardware platforms, the image has three DTBs built into it and
> the right one is selected at runtime. The kernel boot image does this
> (call it a second stage boot loader), not the primary boot
> loader.
> 
> I strongly disagree with the idea that keeping the DTB seperated from
> the kernel is appropriate for all users, or even most users. To me
> that only seems appropriate for certain kinds of hardware, eg general
> purpose computing devices that are designed to primarily run a Linux
> distro.
> 
> An embedded SOC eval board, a development platform, an embedded
> appliance - these are cases where the kernel and DTB should generally
> be more tightly coupled.
> 
> This is more or less how PPC has evolved, big commerical PPC systems
> like Apple's and IBM's stuff all provide a DTB to the kernel - and
> this is actually a bit different then the DT's people are writing for
> SOCs, it is firmware generated and includes a full description of all
> the probed hardware - including pluggable PCI cards and other
> stuff. The hardware is also left configured so there is less for Linux
> to do and less that needs to be described in DT.
> 
> While embedded focused PPC stuff seems to tend to keep the kernel and
> DT together.

At least on the Freescale side of "embedded focused PPC stuff", we have  
not kept the kernel and DT together.  It's actually U-Boot that the dts  
files in the kernel tree are tied to, since they contain assumptions  
about how U-Boot lays out the memory map (there are some inherent  
limits to "the device tree just describes the hardware", barring some  
radical changes in the form device trees take), which things U-Boot  
will fill in/modify, and what U-Boot looks for to find out where to  
make the modification.  Usually U-Boot is the only relevant loader for  
a particular board, but not always -- hence "adder875-redboot.dts" and  
"adder875-uboot.dts".  Even when U-Boot is the only relevant loader,  
there are sometimes changes from one version or configuration of U-Boot  
to another that cause problems (e.g. the device trees that come in  
"32b" and "36b" variants).

-Scott
