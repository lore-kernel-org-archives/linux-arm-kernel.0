From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Wed, 21 Mar 2018 14:08:08 -0600
Subject: [PATCH v4 0/6] ib: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <1521514068-8856-1-git-send-email-okaya@codeaurora.org>
References: <1521514068-8856-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20180321200808.GC22381@ziepe.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2018 at 10:47:42PM -0400, Sinan Kaya wrote:
> Code includes wmb() followed by writel() in multiple places. writel()
> already has a barrier on some architectures like arm64.
> 
> This ends up CPU observing two barriers back to back before executing the
> register write.
> 
> Since code already has an explicit barrier call, changing writel() to
> writel_relaxed().
> 
> I did a regex search for wmb() followed by writel() in each drivers
> directory.
> I scrubbed the ones I care about in this series.
> 
> I considered "ease of change", "popular usage" and "performance critical
> path" as the determining criteria for my filtering.
> 
> We used relaxed API heavily on ARM for a long time but
> it did not exist on other architectures. For this reason, relaxed
> architectures have been paying double penalty in order to use the common
> drivers.
> 
> Now that relaxed API is present on all architectures, we can go and scrub
> all drivers to see what needs to change and what can remain.
> 
> We start with mostly used ones and hope to increase the coverage over time.
> It will take a while to cover all drivers.
> 
> Feel free to apply patches individually.
> 
> Changes since v3:
> - https://www.spinics.net/lists/arm-kernel/msg641851.html
> - group patches together into subsystems ib:...
> - collect reviewed and tested bys
> - scrub barrier()

> Sinan Kaya (6):
>   IB/mlx4: Eliminate duplicate barriers on weakly-ordered archs
>   infiniband: cxgb4: Eliminate duplicate barriers on weakly-ordered
>     archs

I took these two patches to for-next since they seem OK to me

>   RDMA/bnxt_re: Eliminate duplicate barriers on weakly-ordered archs
>   RDMA/i40iw: Eliminate duplicate barriers on weakly-ordered archs
>   IB/nes: Eliminate duplicate barriers on weakly-ordered archs
>   RDMA/qedr: eliminate duplicate barriers on weakly-ordered archs #2

These will need their comments addressed

Thanks,
Jason
