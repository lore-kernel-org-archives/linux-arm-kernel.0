From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 19 Aug 2014 16:59:33 +0200
Subject: [PATCH v5] arm64: fix VTTBR_BADDR_MASK
In-Reply-To: <53F363E3.8060108@amd.com>
References: <20140818203604.4654.99905.stgit@joelaarch64.amd.com>
 <20140819122420.GC31086@cbox> <53F35DFD.9070804@amd.com>
 <20140819143834.GE31086@cbox> <53F363E3.8060108@amd.com>
Message-ID: <20140819145933.GF31086@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 09:49:07AM -0500, Joel Schopp wrote:
> 
> >> The return is a value,not just an error code. Because of this returning
> >> an error overloads that value.  0 just seemed like a convenient invalid
> >> value to check since a vttbr_x of 0 is invalid, but returning a negative
> >> error code would be as equally invalid.  If this is the only issue it
> >> doesn't seem worth respinning the patch for, but I'll change it to
> >> -EINVAL if for some reason a v6 is needed.
> > Have you given up on doing the alignment check with the proper size on
> > the pgd allocation for this patch?
> Yes, I'd rather leave the extra check out of this patch.  If I were
> changing the pgd allocation code I would make sure to add a check, or if
> there were a static check there now I would update it for the dynamic
> value from the hardware, but it seems unrelated to add several checks to
> other parts of the code beyond those already in the patch.  I did leave
> the functions in the headers such that checks like this could be added
> when someone is updating the code for other reasons, say 4 level page
> tables.
> 

hmmm, the point is that we need to ensure that we have a properly
aligned allocated PGD, that's what this patch currently addresses, and as
you pointed out, the BUG_ON() just before trying to run a VM is not the
nicest solution - we should really be dealing with this properly at
allocation time.

But, if you don't have time to look at that, then ok, I'll have to pick
it up myself.

However, you are hinting that we do not support 4 levels of page tables,
yet you do allow the t0sz_to_vttbr_x funciton to pass even when using
t0sz values only supported under 4 levels of page tables....  What is
the rationale for that?

-Christoffer
