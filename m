From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 2 Sep 2013 11:55:49 +0530
Subject: [PATCH] dmaengine: sirf: add dmaengine_prep_slave_single/sg
 support
In-Reply-To: <CAGsJ_4yhVFL+j9PV-srAXdYkbEN62X18n-_+cXa+xy4wcOF7Qw@mail.gmail.com>
References: <1377435433-23202-1-git-send-email-Baohua.Song@csr.com>
 <20130826085607.GN2748@intel.com>
 <CAGsJ_4yhVFL+j9PV-srAXdYkbEN62X18n-_+cXa+xy4wcOF7Qw@mail.gmail.com>
Message-ID: <20130902062549.GG7376@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 01, 2013 at 09:02:01PM +0800, Barry Song wrote:
> 2013/8/26 Vinod Koul <vinod.koul@intel.com>:
> > On Sun, Aug 25, 2013 at 08:57:13PM +0800, Barry Song wrote:
> >> the dma engine of sirfsoc supports interleaved mode, but if we set
> >> xlen=width instead xlen<width, it will work as non-interleaved. as
> >> most clients of sirf dma driver still don't need interleaved mode,
> >> so here we still need to implement prep_slave_sg entry so that users
> >> like uart, spi can use these APIs instead of interleaved API.
> > Well in that case why dont you just create a wrapper on top of interleaved API
> > to make this work without driver changes
> 
> Vinod, do you mean using interleaved API to provide sg/single API if
> specific drivers implement interleaved_dma but not implement sg_dma?
> 
> the problem is that is difficult to set right legal sgl[i].size,
> sgl[i].icg and numf for all dmaengines as that depends on specific dma
> hardware limitation.
The whole premise of doing the generic interleaved api was to ensure we can use
any of the usuages as a case of interleaved api. Can you explain how it would be
difficult?

> >> +     spin_lock_irqsave(&schan->lock, iflags);
> >> +     list_for_each(l, &schan->free)
> >> +             desc_cnt++;
> > why dont you allocate descriptors here. That will remove this limitation..
> 
> i understand. here sirf user scenerios will never be over the
> limitation of SIRFSOC_DMA_DESCRIPTORS = 16. so i don't want to make it
> too complex.
I think you can make code simler by dynamically allocating and freeing
descriptors...

~Vinod
-- 
