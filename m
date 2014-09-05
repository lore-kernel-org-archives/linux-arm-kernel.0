From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 04 Sep 2014 18:15:00 -0700
Subject: ccf vs iommu vs drm locking fun
In-Reply-To: <CAF6AEGtk=KhW+m-jc6VzH=pHGgnE1Uzq0tYiqqnX0sPHV1rbPQ@mail.gmail.com>
References: <CAF6AEGtk=KhW+m-jc6VzH=pHGgnE1Uzq0tYiqqnX0sPHV1rbPQ@mail.gmail.com>
Message-ID: <54090E94.1050602@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/14 17:46, Rob Clark wrote:
> So, I was looking at the below lockdep splat, and discussing it a bit
> w/ sboyd on IRC, and came to a slightly disturbing realization..
>
> The interaction between prepare_lock and debugfs bits is a little bit
> worrying.  In particular, it is probably not a good idea to assume
> that anyone who needs to grab prepare_lock does not already hold
> mmap_sem.  Not holding mmap_sem or locks that interact w/ mmap_sem is
> going to be pretty hard to avoid, at least for gpu drivers that are
> using iommus that are using CCF ;-)

I'm thinking one way to fix this is to replace the tree traversal for
debugfs registration with a list iteration of all registered clocks.
That way we don't hold the prepare mutex across debugfs directory/file
creation. This should break the chain.

Now that debugfs isn't a hierarchy, this becomes a lot easier, we just
need to keep a linked list of all the clocks that are registered. I
already have that patch for my wwmutex series, but I didn't convert
debugfs to use it. Two patches to follow.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
