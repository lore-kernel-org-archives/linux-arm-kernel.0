From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 8 Apr 2014 12:49:49 +0100
Subject: memcpy alignment for DEVICE_nGnRnE
In-Reply-To: <20140408003547.GA18321@codeaurora.org>
References: <53072343.4080505@marvell.com> <20140221105307.GE25363@localhost>
 <20140408003547.GA18321@codeaurora.org>
Message-ID: <20140408114949.GB21054@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 08, 2014 at 01:35:47AM +0100, Michael Bohan wrote:
> On Fri, Feb 21, 2014 at 10:53:08AM +0000, Catalin Marinas wrote:
> > On Fri, Feb 21, 2014 at 09:58:27AM +0000, Zhou Zhu wrote:
> > > We faced one issue using memcpy for memory type DEVICE_nGnRnE 
> > > (pgprot_noncached). If the address is not aligned, exception would 
> > > happen due to the alignment of this type could not be handled by hardware.
> > 
> > Indeed, that's expected. This memory type is the equivalent of Strongly
> > Ordered.
> > 
> > > Is there any plan and ongoing patch to support this or we need to keep 
> > > address aligned for memcpy using pgprot_noncached memory in drivers?
> > 
> > You either change the memory type to pgprot_writecombine() or use the
> > right API (memcpy_toio/memcpy_fromio, these could be further optimised,
> > similar to powerpc for example, but I didn't get there yet).
> 
> How should we handle Device Memory with copy_from_user / copy_to_user?
> Should we follow the same scheme and create
> copy_from_user_io / copy_to_user_io, or rather enforce that the stock
> routines handle alignment?

We have generic copy_from_user_toio() and copy_to_user_fromio(). Are
these what you need? As with the memcpy_(to|from)io, they can be further
optimised.

-- 
Catalin
