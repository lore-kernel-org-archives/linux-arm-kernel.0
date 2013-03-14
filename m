From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 14 Mar 2013 17:33:07 -0400 (EDT)
Subject: [PATCH] USB: EHCI: fix for leaking isochronous data
In-Reply-To: <5142383F.6010001@web.de>
Message-ID: <Pine.LNX.4.44L0.1303141719450.1194-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Mar 2013, Soeren Moch wrote:

> > If the memory really is being leaked here in some sort of systematic
> > way, we may be able to see it in your debugging output after a few
> > seconds.
> >
> 
> OK, here are the first seconds of the log. But the buffer exhaustion 
> usually occurs after several hours of runtime...

The log shows a 1-1 match between allocations and deallocations, except
for three excess allocations about 45 lines before the end.  I have no
idea what's up with those.  They may be an artifact arising from where
you stopped copying the log data.

There are as many as 400 iTDs being allocated before any are freed.  
That seems like a lot.  Are they all for the same isochronous endpoint?  
What's the endpoint's period?  How often are URBs submitted?

In general, there shouldn't be more than a couple of millisecond's
worth of iTDs allocated for any endpoint, depending on how many URBs 
are in the pipeline at any time.

Maybe a better way to go about this is, instead of printing out every
allocation and deallocation, to keep a running counter.  You could have
the driver print out the value of this counter every minute or so.  Any 
time the device isn't in use, the counter should be 0.

Alan Stern
