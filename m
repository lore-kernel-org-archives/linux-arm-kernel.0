From: jeffrey.t.kirsher@intel.com (Jeff Kirsher)
Date: Tue, 03 Apr 2018 11:26:07 -0700
Subject: [PATCH v8 0/7] netdev: intel: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <92f46034-f041-05e4-56b7-01ae4cb04efc@codeaurora.org>
References: <1522695990-31082-1-git-send-email-okaya@codeaurora.org>
 <b8355df0-f3ba-c8c8-ccbb-53b1a294eab6@codeaurora.org>
 <CAKgT0UfbCzTGuwCnYiXOBL5Lm3AhYw6Kf5i0K2e19mTjise+Ew@mail.gmail.com>
 <92f46034-f041-05e4-56b7-01ae4cb04efc@codeaurora.org>
Message-ID: <1522779967.4236.22.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-04-03 at 13:50 -0400, Sinan Kaya wrote:
> > > What do you think about this version? Did I miss any SMP
> > > barriers?
> > 
> > I would say we should probably just drop the whole set and start
> > over.
> > If we don't need the wmb() we are going to need to go through and
> > clean up all of these paths and consider the barriers when updating
> > the layout of the code.
> > 
> > For example I have been thinking about it and in the case of x86 we
> > are probably better off not bothering with the wmb() and
> > writel_relaxed() and instead switch over to the smp_wmb() and
> > writel()
> > since in the case of a strongly ordered system like x86 or sparc
> > this
> > ends up translating out to a couple of compile barriers.
> > 
> > I will also need time to reevaluate the Rx paths since dropping the
> > wmb() may have other effects which I need to verify.
> 
> Sounds good, I'll let you work on it.
> 
> @Jeff Kirsher: can you drop this version from your development branch
> until
> Alex posts the next version?

Already on it, I will work with Alex on any possible future versions of
these patches.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180403/df3259a9/attachment.sig>
