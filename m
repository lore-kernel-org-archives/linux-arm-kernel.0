From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Aug 2015 16:00:31 +0100
Subject: [PATCH 0/4] Efficiency cleanups
In-Reply-To: <20150824143619.GD20147@arm.com>
References: <CABXk95C=CpeL4mNmS6-jJ-0bMJf6fawwfs6DM1-p8FctTEFbpw@mail.gmail.com>
 <20150821133043.GV7557@n2100.arm.linux.org.uk>
 <20150821134630.GW7557@n2100.arm.linux.org.uk>
 <20150824143619.GD20147@arm.com>
Message-ID: <20150824150031.GC7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 03:36:20PM +0100, Will Deacon wrote:
> On Fri, Aug 21, 2015 at 02:46:30PM +0100, Russell King - ARM Linux wrote:
> > While developing the previous patch set, I noticed that the kernel's
> > "fast" exit path efficiency was not what it's supposed to be due to the
> > addition of trace and context tracking.
> > 
> > These add several instances of register stacking and unstacking around
> > various function calls, several of which we can avoid.  Many of these
> > instances don't need to stack any register other than r0.
> > 
> > Moreover, we can avoid stacking and unstacking r0 if these features are
> > enabled by storing r0 in the pt_regs as we would do in our slow return
> > path.
> > 
> > Various other cleanups are included in this set as well.  Acks welcome.
> 
> All four patches look fine to me:
> 
>   Acked-by: Will Deacon <will.deacon@arm.com>
> 
> For some reason, I thought the numbering of the TIF_ flags was important
> for some immediate construction in asm code, but either I'm mistaken or
> it's no longer the case.

The only reason they're important is to ensure that the bits are close
enough together - we use the definitions directly in the asm code.

Over the years, I think we've deleted a number of flags, and grown some
others, and we've left holes in the bit allocation.  By compressing them,
we can change the assembly code to check for "is there _any_ work at all
that needs to be done" as opposed to the two-step approach we've been
doing up to now.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
