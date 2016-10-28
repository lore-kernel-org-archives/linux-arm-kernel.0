From: mzoran@crowfest.net (Michael Zoran)
Date: Fri, 28 Oct 2016 09:02:49 -0700
Subject: [PATCH] staging: vc04_services: tie up loose ends with
 dma_map_sg conversion
In-Reply-To: <20161028154245.GA19454@kroah.com>
References: <20161028151651.3430-1-mzoran@crowfest.net>
 <20161028153124.GA29906@kroah.com> <1477668994.12378.1.camel@crowfest.net>
 <20161028154245.GA19454@kroah.com>
Message-ID: <1477670569.12378.3.camel@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-10-28 at 11:42 -0400, Greg KH wrote:
> On Fri, Oct 28, 2016 at 08:36:34AM -0700, Michael Zoran wrote:
> > On Fri, 2016-10-28 at 11:31 -0400, Greg KH wrote:
> > > On Fri, Oct 28, 2016 at 08:16:51AM -0700, Michael Zoran wrote:
> > > > The conversion to dma_map_sg left a few loose ends.??This
> > > > change
> > > > ties up those loose ends.
> > > > 
> > > > 1. Settings the DMA mask is mandatory on 64 bit even though it
> > > > is optional on 32 bit.??Set the mask so that DMA space is
> > > > always
> > > > in the lower 32 bit range of data on both platforms.
> > > > 
> > > > 2. The scatterlist was not completely initialized correctly.
> > > > Initialize the list with sg_init_table so that DMA works
> > > > correctly
> > > > if scatterlist debugging is enabled in the build configuration.
> > > > 
> > > > 3. The error paths in create_pagelist were not
> > > > consistent.??Make
> > > > them all consistent by calling a helper function called
> > > > cleanup_pagelistinfo to cleanup regardless of what state the
> > > > pagelist
> > > > is in.
> > > > 
> > > > 4. create_pagelist and free_pagelist had a very large amount of
> > > > duplication in computing offsets into a single allocation of
> > > > memory
> > > > in the DMA area.??Introduce a new structure called the
> > > > pagelistinfo
> > > > that is appened to the end of the allocation to store necessary
> > > > information to prevent duplication of code and make cleanup on
> > > > errors
> > > > easier.
> > > > 
> > > > When combined with a fix for vchiq_copy_from_user which is not
> > > > included at this time, both functional and pings tests of
> > > > vchiq_test
> > > > now pass in both 32 bit and 64 bit modes.
> > > > 
> > > > Even though this cleanup could have been broken down to chunks,
> > > > all the changes are to a single file and submitting it as a
> > > > single
> > > > related change should make reviewing the diff much easier then
> > > > if
> > > > it
> > > > were submitted piecemeal.
> > > 
> > > No, it's harder.??A patch should only do one type of thing, this
> > > patch
> > > has to be reviewed thinking of 4 different things all at once,
> > > making
> > > it
> > > much more difficult to do so.
> > > 
> > > We write patches to be read easily, and make them easy to
> > > review.??We
> > > don't write them in a way to be easy for the developer to create
> > > :)
> > > 
> > > Can you please break this up into a patch series?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Point #1 and #2 would be very easy to seperate.???Point #3 and #4
> > are
> > essentually a redo of two major functions and are where most of the
> > changes are.
> > 
> > Would making #1 and #2 independent but combining #3 and #4
> > sufficient?
> 
> I don't know, try it and see what the patches look like.
> 
> Think about it from my point of view, which would be easier to
> review?
> 
> thanks,
> 
> greg k-h

Greg, I totally agree with you here and I understand your point of
view.

I'm wondering if it would be best to have me reword the description to
say that I completely rewrote a section of the file.  And essentially
consider it a ground up rewrite rather then a change.

Eric had some complaints about the way that specific section of the
code is structured, so maybe a rewrite is best.

 
