From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Tue, 20 Mar 2018 09:23:59 -0600
Subject: [PATCH v4 1/6] RDMA/bnxt_re: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <3e6cfa25-6b9f-24ff-499a-6df2740b658b@codeaurora.org>
References: <1521514068-8856-1-git-send-email-okaya@codeaurora.org>
 <1521514068-8856-2-git-send-email-okaya@codeaurora.org>
 <20180320144801.GE19744@ziepe.ca>
 <d31c062b-5629-62b8-c291-c656e23c6f82@codeaurora.org>
 <3e6cfa25-6b9f-24ff-499a-6df2740b658b@codeaurora.org>
Message-ID: <20180320152359.GL19744@ziepe.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 20, 2018 at 10:08:16AM -0500, Sinan Kaya wrote:

> Never mind, it will break some architectures. I'll only change the first one.
> 
>  (1) On some systems, I/O stores are not strongly ordered across all CPUs, and
>      so for _all_ general drivers locks should be used and mmiowb() must be
>      issued prior to unlocking the critical section.

I think the kernel could do well to have a spin_unlock_mmiowb()
function. We have this patern quite a bit.

Arches like x86 can just make it == spin_unlock, while PPC and ARM can
add their extra barriers.

Then we can safely and efficiently use _realxed within such a
spinlock region.

Jason
