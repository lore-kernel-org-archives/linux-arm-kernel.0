From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 1 Feb 2013 10:59:10 +0530
Subject: [PATCH v3 04/15] ARM: mcpm: Add baremetal voting mutexes
In-Reply-To: <1359445870-18925-5-git-send-email-nicolas.pitre@linaro.org>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
 <1359445870-18925-5-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <510B52A6.1030503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 January 2013 01:20 PM, Nicolas Pitre wrote:
> From: Dave Martin <dave.martin@linaro.org>
>
> This patch adds a simple low-level voting mutex implementation
> to be used to arbitrate during first man selection when no load/store
> exclusive instructions are usable.
>
> For want of a better name, these are called "vlocks".  (I was
> tempted to call them ballot locks, but "block" is way too confusing
> an abbreviation...)
>
> There is no function to wait for the lock to be released, and no
> vlock_lock() function since we don't need these at the moment.
> These could straightforwardly be added if vlocks get used for other
> purposes.
>
> For architectural correctness even Strongly-Ordered memory accesses
> require barriers in order to guarantee that multiple CPUs have a
> coherent view of the ordering of memory accesses.  Whether or not
> this matters depends on hardware implementation details of the
> memory system.  Since the purpose of this code is to provide a clean,
> generic locking mechanism with no platform-specific dependencies the
> barriers should be present to avoid unpleasant surprises on future
> platforms.
>
> Note:
>
>    * When taking the lock, we don't care about implicit background
>      memory operations and other signalling which may be pending,
>      because those are not part of the critical section anyway.
>
>      A DMB is sufficient to ensure correctly observed ordering if
>      the explicit memory accesses in vlock_trylock.
>
>    * No barrier is required after checking the election result,
>      because the result is determined by the store to
>      VLOCK_OWNER_OFFSET and is already globally observed due to the
>      barriers in voting_end.  This means that global agreement on
>      the winner is guaranteed, even before the winner is known
>      locally.
>
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> ---
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
