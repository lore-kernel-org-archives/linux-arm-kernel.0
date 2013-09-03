From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 3 Sep 2013 17:09:25 +0530
Subject: [PATCH] dmaengine: sirf: add dmaengine_prep_slave_single/sg
 support
In-Reply-To: <CAGsJ_4w4dNOy=8HMQqy9sCL=UVWXSgADjoqBD9FmSxdoyzZ6pQ@mail.gmail.com>
References: <1377435433-23202-1-git-send-email-Baohua.Song@csr.com>
 <20130826085607.GN2748@intel.com>
 <CAGsJ_4yhVFL+j9PV-srAXdYkbEN62X18n-_+cXa+xy4wcOF7Qw@mail.gmail.com>
 <20130902062549.GG7376@intel.com>
 <CAGsJ_4w4dNOy=8HMQqy9sCL=UVWXSgADjoqBD9FmSxdoyzZ6pQ@mail.gmail.com>
Message-ID: <20130903113925.GF15824@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 03, 2013 at 06:06:44PM +0800, Barry Song wrote:
> 2013/9/2 Vinod Koul <vinod.koul@intel.com>:
> > On Sun, Sep 01, 2013 at 09:02:01PM +0800, Barry Song wrote:
> >> 2013/8/26 Vinod Koul <vinod.koul@intel.com>:
> >> > On Sun, Aug 25, 2013 at 08:57:13PM +0800, Barry Song wrote:
> >> >> the dma engine of sirfsoc supports interleaved mode, but if we set
> >> >> xlen=width instead xlen<width, it will work as non-interleaved. as
> >> >> most clients of sirf dma driver still don't need interleaved mode,
> >> >> so here we still need to implement prep_slave_sg entry so that users
> >> >> like uart, spi can use these APIs instead of interleaved API.
> >> > Well in that case why dont you just create a wrapper on top of interleaved API
> >> > to make this work without driver changes
> >>
> >> Vinod, do you mean using interleaved API to provide sg/single API if
> >> specific drivers implement interleaved_dma but not implement sg_dma?
> >>
> >> the problem is that is difficult to set right legal sgl[i].size,
> >> sgl[i].icg and numf for all dmaengines as that depends on specific dma
> >> hardware limitation.
> > The whole premise of doing the generic interleaved api was to ensure we can use
> > any of the usuages as a case of interleaved api. Can you explain how it would be
> > difficult?
> 
> for example, if someone wants to do a 16Kbytes single transfer. how
> will interleaved dma set transfer length and interval between every
> row?
> if it sets the transfer length to 16KB directly, the dma hardware
> might not support such long a transfer at all.
> so it might want to set as two 8KB transfer without interval between them.
> 0~8KB                empty interval
> 8KB-16KB          empty interval
> or four 4KB transfer as
> 0~4KB                empty interval
> 4KB-8KB          empty interval
> 8KB-12KB          empty interval
> 12KB-16KB          empty interval
> 
> the problem is we don't know the hardware limitation of every dma
> controllers for transferring length of each row.
Why not:

Okay there are two ways to this
1. Advertize your capablity and let client use that to break. You cna do so
using dma_set/get_max_seg_size().

2. in DMAC, nothing stops you from breaking the given sg_list into smaller
chunks. So if you get a buffer exceeding what you do, you cna internally split
to multiple descriptors and chain those to parent one.

> 
> >
> >> >> +     spin_lock_irqsave(&schan->lock, iflags);
> >> >> +     list_for_each(l, &schan->free)
> >> >> +             desc_cnt++;
> >> > why dont you allocate descriptors here. That will remove this limitation..
> >>
> >> i understand. here sirf user scenerios will never be over the
> >> limitation of SIRFSOC_DMA_DESCRIPTORS = 16. so i don't want to make it
> >> too complex.
> > I think you can make code simler by dynamically allocating and freeing
> > descriptors...
> 
> when do you think is the right time to free? while the whole sg
> finished? i always think the code will be ugly.
when the descriptor has been completed. You allocate in prepare. Bunch of driver
already do so... I dont think its so complicated

~Vinod
-- 
