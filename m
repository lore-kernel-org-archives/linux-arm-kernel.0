From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 14 Feb 2013 00:01:03 -0500 (EST)
Subject: [PATCH 1/2] arm: mm: Ignore memory banks which are in front of the
 kernel when HIGHMEM is ON
In-Reply-To: <CAHTX3dJXtx5V2SN4Wd7mrnhUzMyK86vT_h_xLOzmQKGo3rcDqQ@mail.gmail.com>
References: <1360745925-20952-1-git-send-email-michal.simek@xilinx.com>
 <20130213090317.GY17833@n2100.arm.linux.org.uk>
 <CAHTX3dLy=t43+oNXMrsdz1_5AGf6==z=vG7K8V6dSG0tm6U4=g@mail.gmail.com>
 <20130213145208.GC17833@n2100.arm.linux.org.uk>
 <CAHTX3dJXtx5V2SN4Wd7mrnhUzMyK86vT_h_xLOzmQKGo3rcDqQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.03.1302132353290.8736@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Feb 2013, Michal Simek wrote:

> The Linux kernel has some requirements, limitations, etc,  that's all truth.
> 
> Placing the kernel to the main memory to any location you want which end
> up with kernel panic is from my point of view fault.

I may agree with that, up to a point.

> Saying that the kernel is always loaded withing the 16MB of memory is limitation
> but it doesn't mean that we shouldn't remove it.

The actual limitation should be 128MB for zImage.  It will relocate the 
final kernel binary within the first 16MB by itself.

> Ignoring the memory before the kernel can be one solution which I
> would like to discuss.
> What about the second patch used for !HIGHMEM case?

Highmem is irrelevant.

If you want to ignore memory that way, you must look at the _physical_ 
addresses for each bank, and simply truncate anything that is below 
PHYS_OFFSET.  The comparison should be trivial with physical addresses 
as they're not limited to 32 bits.


Nicolas
