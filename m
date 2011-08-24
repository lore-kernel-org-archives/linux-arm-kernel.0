From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Wed, 24 Aug 2011 15:15:27 +0200
Subject: [PATCH 1/7] omap: iommu: migrate to the generic IOMMU API
In-Reply-To: <CAK=WgbZAMbPhDuXZ2NwTTSDv2doT6WBSzCCaD0F02mybNEZyeA@mail.gmail.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
	<1313622608-30397-2-git-send-email-ohad@wizery.com>
	<20110823140746.GP2079@amd.com>
	<CAK=WgbZYuuKHUu6P+nfNzPgF4QmoL=T9+yquc=rMXRh4QE9grg@mail.gmail.com>
	<CAK=WgbZAMbPhDuXZ2NwTTSDv2doT6WBSzCCaD0F02mybNEZyeA@mail.gmail.com>
Message-ID: <20110824131527.GI2079@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 08:46:13AM -0400, Ohad Ben-Cohen wrote:
> On Tue, Aug 23, 2011 at 5:59 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> > On Tue, Aug 23, 2011 at 5:07 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> >> Can this be easily converted to a spin_lock?
> >
> > Sure, thanks for reviewing.
> 
> Taking a second look, I don't think it's necessary - the mutex isn't
> used to protect the page table. The page table is protected by a spin
> lock, so map/unmap operations can be called from an atomic context.
> 
> The mutex is only part of the attach/deattach operations, which are
> already used today in process context, so I guess it's safe.

Yes, it should be safe in your context. But the iommu-api is generic and
I would prefer that all functions it provides can be called from any
context.
Or is the time required for attaching/detaching too long so that it
makes sense to put secondary threads to sleep?

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
