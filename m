From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 18 Oct 2013 10:04:11 -0700
Subject: [RFC PATCH] device: Add kernel standard devm_k.alloc functions
In-Reply-To: <CAGa+x864VYoGvOxoK0XnxXH9hKNq9WAZ16XHiFawZY7_2WJttw@mail.gmail.com>
References: <1381296747.2040.17.camel@joe-AO722>
 <20131011131138.3bc5b2acf60df3a5d79d0d24@linux-foundation.org>
 <CAGa+x864VYoGvOxoK0XnxXH9hKNq9WAZ16XHiFawZY7_2WJttw@mail.gmail.com>
Message-ID: <CAGa+x86aS+C8iEb1P4ZYxPBix=Anjh4JZoAof=R-i9fGw=bq6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> A handful of boot panics on ARM platforms were bisected to point at
> the version of this commit that's in linux-next (commit
> 64c862a839a8db2c02bbaa88b923d13e1208919d).  Reverting this commit
> makes things happy again.
>
> Upon further digging, it seems that users of devres_alloc() are
> relying on the previous behavior of having the memory zero'd which is
> no longer the case after $SUBJECT patch.  The change below on top of
> -next makes these ARM boards happy again.

Oops, it should've fixed __devres_alloc() also.  Updated patch below.

Kevin

>From a1962ed4a999fb630a48f75a5ecaf84401d5dbfc Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@linaro.org>
Date: Fri, 18 Oct 2013 09:41:39 -0700
Subject: [PATCH] devres: restore zeroing behavior of devres_alloc()

commit 64c862a8 (devres: add kernel standard devm_k.alloc functions) changed
the default behavior of alloc_dr() to no longer zero the allocated
memory.  However,
only the devm.k.alloc() function were modified to pass in __GFP_ZERO
which leaves
any users of devres_alloc() or __devres_alloc() with potentially wrong
assumptions
about memory being zero'd upon allocation.

To fix, add __GFP_ZERO to devres_alloc() calls to preserve previous
behavior of zero'ing memory upon allocation.

Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 drivers/base/devres.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 37e67a2..545c4de 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -111,7 +111,7 @@ void * __devres_alloc(dr_release_t release, size_t
size, gfp_t gfp,
 {
  struct devres *dr;

- dr = alloc_dr(release, size, gfp);
+ dr = alloc_dr(release, size, gfp | __GFP_ZERO);
  if (unlikely(!dr))
  return NULL;
  set_node_dbginfo(&dr->node, name, size);
@@ -136,7 +136,7 @@ void * devres_alloc(dr_release_t release, size_t
size, gfp_t gfp)
 {
  struct devres *dr;

- dr = alloc_dr(release, size, gfp);
+ dr = alloc_dr(release, size, gfp | __GFP_ZERO);
  if (unlikely(!dr))
  return NULL;
  return dr->data;
-- 
1.8.3
