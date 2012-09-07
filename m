From: will.deacon@arm.com (Will Deacon)
Date: Fri, 7 Sep 2012 11:04:22 +0100
Subject: [PATCH 2/2] ARM: kexec: Check segment memory addresses
In-Reply-To: <20120907084937.GC13739@n2100.arm.linux.org.uk>
References: <1347007260-13271-1-git-send-email-matthew.leach@arm.com>
 <1347007260-13271-3-git-send-email-matthew.leach@arm.com>
 <20120907084937.GC13739@n2100.arm.linux.org.uk>
Message-ID: <20120907100422.GD15916@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2012 at 09:49:38AM +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 07, 2012 at 09:41:00AM +0100, Matthew Leach wrote:
> > Ensure that the memory regions that are set within the segments
> > correspond to physical contiguous memory regions.
> > 
> > Reviewed-by: Simon Horman <horms@verge.net.au>
> > Reviewed-by: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: Matthew Leach <matthew.leach@arm.com>
> 
> What about platforms which pull out bits of physical RAM from memblock
> via arm_memblock_steal() ?  Doesn't this mean such platforms will reduce
> their available memory on each subsequent kexec?

I don't think that will happen. All that kexec does is check that the
location where it wants to load the new kernel is physically contiguous -- the
memblock configuration is not inherited by the target kernel.

What *might* happen is that a memblock_steal on the host kernel could cause
the kexec to fail with -EINVAL if the area removed corresponds to the area
where the target kernel wants to be loaded. I think this is correct
behaviour, because we have no idea what the stolen region is being used for.

Will
