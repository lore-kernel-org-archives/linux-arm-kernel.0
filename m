From: joe@perches.com (Joe Perches)
Date: Fri, 18 Oct 2013 10:06:13 -0700
Subject: [RFC PATCH] device: Add kernel standard devm_k.alloc functions
In-Reply-To: <CAGa+x864VYoGvOxoK0XnxXH9hKNq9WAZ16XHiFawZY7_2WJttw@mail.gmail.com>
References: <1381296747.2040.17.camel@joe-AO722>
 <20131011131138.3bc5b2acf60df3a5d79d0d24@linux-foundation.org>
 <CAGa+x864VYoGvOxoK0XnxXH9hKNq9WAZ16XHiFawZY7_2WJttw@mail.gmail.com>
Message-ID: <1382115973.2041.3.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-10-18 at 09:57 -0700, Kevin Hilman wrote:
[]
> A handful of boot panics on ARM platforms were bisected to point at
> the version of this commit that's in linux-next (commit
> 64c862a839a8db2c02bbaa88b923d13e1208919d).  Reverting this commit
> makes things happy again.
> 
> Upon further digging, it seems that users of devres_alloc() are
> relying on the previous behavior of having the memory zero'd which is
> no longer the case after $SUBJECT patch.  The change below on top of
> -next makes these ARM boards happy again.
[]
> commit 64c862a8 (devres: add kernel standard devm_k.alloc functions) changed
> the default behavior of alloc_dr() to no longer zero the allocated
> memory.  However,
> only the devm.k.alloc() function were modified to pass in __GFP_ZERO
> which leaves
> any users of devres_alloc() or __devres_alloc() with potentially wrong
> assumptions
> about memory being zero'd upon allocation.
> 
> To fix, add __GFP_ZERO to devres_alloc() calls to preserve previous
> behavior of zero'ing memory upon allocation.
[]
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
[]
> @@ -136,7 +136,7 @@ void * devres_alloc(dr_release_t release, size_t
> size, gfp_t gfp)
>  {
>   struct devres *dr;
> 
> - dr = alloc_dr(release, size, gfp);
> + dr = alloc_dr(release, size, gfp | __GFP_ZERO);
>   if (unlikely(!dr))
>   return NULL;
>   return dr->data;

Wouldn't the __devres_alloc need that too?


#ifdef CONFIG_DEBUG_DEVRES
void * __devres_alloc(dr_release_t release, size_t size, gfp_t gfp,
		      const char *name)
{
	struct devres *dr;

	dr = alloc_dr(release, size, gfp);
	if (unlikely(!dr))
		return NULL;
	set_node_dbginfo(&dr->node, name, size);
	return dr->data;
}
EXPORT_SYMBOL_GPL(__devres_alloc);
