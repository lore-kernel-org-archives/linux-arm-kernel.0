From: mzoran@crowfest.net (Michael Zoran)
Date: Mon, 07 Nov 2016 07:41:27 -0800
Subject: [PATCH] staging: vc04_services: add vchiq_pagelist_info structure
In-Reply-To: <20161107100331.GA19666@kroah.com>
References: <20161031081035.22677-1-mzoran@crowfest.net>
 <20161107100331.GA19666@kroah.com>
Message-ID: <1478533287.17065.1.camel@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-11-07 at 11:03 +0100, Greg KH wrote:
> On Mon, Oct 31, 2016 at 01:10:35AM -0700, Michael Zoran wrote:
> > The current dma_map_sg based implementation for bulk messages
> > computes many offsets into a single allocation multiple times in
> > both the create and free code paths.??This is inefficient,
> > error prone and in fact still has a few lingering issues
> > with arm64.
> > 
> > This change replaces a small portion of that inplementation with
> > new code that uses a new struct vchiq_pagelist_info to store the
> > needed information rather then complex offset calculations.
> > 
> > This improved implementation should be more efficient and easier
> > to understand and maintain.
> > 
> > Tests Run(Both Pass):
> > vchiq_test -p 1
> > vchiq_test -f 10
> > 
> > Signed-off-by: Michael Zoran <mzoran@crowfest.net>
> > ---
> > ?.../interface/vchiq_arm/vchiq_2835_arm.c???????????| 223
> > +++++++++++----------
> > ?1 file changed, 113 insertions(+), 110 deletions(-)
> 
> This doesn't apply to the tree anymore because of your previous patch
> :(
> 
> Can you refresh it and resend?
> 
> thanks,
> 
> greg k-h

OK, I resubmitted it.

Once this patch gets applied 64-bit should be in decent shape.  I'm not
seeing any warnings or errors anymore and functional tests from a 64-
bit OS look good.

The only remaining issue that I know of is that it needs a 32-bit
compatibility layer for the ioctls when running a 32-bit OS(Raspbian)
on top of a 64-bit kernel.
