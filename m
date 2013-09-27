From: timothy.c.pepper@linux.intel.com (Timothy Pepper)
Date: Fri, 27 Sep 2013 08:39:52 -0700
Subject: mm: insure topdown mmap chooses addresses above security minimum
In-Reply-To: <20130925174436.GA14037@gmail.com>
References: <1380057811-5352-1-git-send-email-timothy.c.pepper@linux.intel.com>
 <20130925073048.GB27960@gmail.com>
 <20130925171243.GA7428@tcpepper-desk.jf.intel.com>
 <20130925174436.GA14037@gmail.com>
Message-ID: <20130927153951.GA15257@tcpepper-desk.jf.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 25 Sep at 19:44:36 +0200 mingo at kernel.org said:
> 
> * Timothy Pepper <timothy.c.pepper@linux.intel.com> wrote:
> 
> > On Wed 25 Sep at 09:30:49 +0200 mingo at kernel.org said:
> > > >  	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
> > > >  	info.length = len;
> > > > -	info.low_limit = PAGE_SIZE;
> > > > +	info.low_limit = max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));
> > > >  	info.high_limit = mm->mmap_base;
> > > >  	info.align_mask = filp ? get_align_mask() : 0;
> > > >  	info.align_offset = pgoff << PAGE_SHIFT;
> > > 
> > > There appears to be a lot of repetition in these methods - instead of 
> > > changing 6 places it would be more future-proof to first factor out the 
> > > common bits and then to apply the fix to the shared implementation.
> > 
> > Besides that existing redundancy in the multiple somewhat similar
> > arch_get_unmapped_area_topdown() functions, I was expecting people might
> > question the added redundancy of the six instances of:
> > 
> > 	max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));
> 
> That redundancy would be automatically addressed by my suggestion.

Yes.

I'm looking at the cleanup and will post a bisectable series that
introduces a common helper, addes the calls to use that helper where
applicable (looks like it might be a few dozen per arch locations), and
then the single line change for the topdown case within the common helper
to do:

	info->low_limit = max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));

-- 
Tim Pepper <timothy.c.pepper@linux.intel.com>
Intel Open Source Technology Center
