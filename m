From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 3 Sep 2013 17:42:20 +0530
Subject: [PATCH] dmaengine: sirf: add dmaengine_prep_slave_single/sg
 support
In-Reply-To: <CAGsJ_4wpFNq7Rv3Y9keJjko70VKnsiivwpzGM2YT_pROo59Xtg@mail.gmail.com>
References: <1377435433-23202-1-git-send-email-Baohua.Song@csr.com>
 <20130826085607.GN2748@intel.com>
 <CAGsJ_4yhVFL+j9PV-srAXdYkbEN62X18n-_+cXa+xy4wcOF7Qw@mail.gmail.com>
 <20130902062549.GG7376@intel.com>
 <CAGsJ_4w4dNOy=8HMQqy9sCL=UVWXSgADjoqBD9FmSxdoyzZ6pQ@mail.gmail.com>
 <20130903113925.GF15824@intel.com>
 <CAGsJ_4wpFNq7Rv3Y9keJjko70VKnsiivwpzGM2YT_pROo59Xtg@mail.gmail.com>
Message-ID: <20130903121220.GH15824@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 03, 2013 at 08:42:36PM +0800, Barry Song wrote:
> > Why not:
> >
> > Okay there are two ways to this
> > 1. Advertize your capablity and let client use that to break. You cna do so
> > using dma_set/get_max_seg_size().
> >
> 
> this way is ok. does max_seg also match with interleaved mode?
i dont see a reason not to..
> 
> 
> > 2. in DMAC, nothing stops you from breaking the given sg_list into smaller
> > chunks. So if you get a buffer exceeding what you do, you cna internally split
> > to multiple descriptors and chain those to parent one.
> 
> this way still need hacking in dmac driver.
Yup but you get a driver which cna handle any buffers any lists, which is very
nice from users POV
> 
> >
> >>
> >> >
> >> >> >> +     spin_lock_irqsave(&schan->lock, iflags);
> >> >> >> +     list_for_each(l, &schan->free)
> >> >> >> +             desc_cnt++;
> >> >> > why dont you allocate descriptors here. That will remove this limitation..
> >> >>
> >> >> i understand. here sirf user scenerios will never be over the
> >> >> limitation of SIRFSOC_DMA_DESCRIPTORS = 16. so i don't want to make it
> >> >> too complex.
> >> > I think you can make code simler by dynamically allocating and freeing
> >> > descriptors...
> >>
> >> when do you think is the right time to free? while the whole sg
> >> finished? i always think the code will be ugly.
> > when the descriptor has been completed. You allocate in prepare. Bunch of driver
> > already do so... I dont think its so complicated
> 
> here sirf dmac alloc all 16 desc in alloc_resoures and free all in
> free_resources. if we can move the way you said, it is fine.
> but it seems it means another separate patch for that.
Sure...

~Vinod
-- 
