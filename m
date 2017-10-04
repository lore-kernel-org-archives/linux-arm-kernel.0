From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Wed, 4 Oct 2017 13:49:33 +0200
Subject: [Tee-dev] [PATCH v1 12/14] tee: optee: enable dynamic SHM support
In-Reply-To: <31f5c449-ab0c-f033-6a7e-0ce23c7cc452@arm.com>
References: <1506621851-6929-1-git-send-email-volodymyr_babchuk@epam.com>
 <1506621851-6929-13-git-send-email-volodymyr_babchuk@epam.com>
 <31f5c449-ab0c-f033-6a7e-0ce23c7cc452@arm.com>
Message-ID: <20171004114932.GA27797@jax>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 03, 2017 at 11:06:38AM -0500, Stuart Yoder wrote:
> 
> 
> On 9/28/17 1:04 PM, Volodymyr Babchuk wrote:
> >From: Volodymyr Babchuk <vlad.babchuk@gmail.com>
> >
> >Previous patches added various features that are needed for dynamic SHM.
> >Dynamic SHM allows Normal World to share any buffers with OP-TEE.
> >While original design suggested to use pre-allocated region (usually of
> >1M to 2M of size), this new approach allows to use all non-secure RAM for
> >command buffers, RPC allocations and TA parameters.
> >
> >This patch checks capability OPTEE_SMC_SEC_CAP_DYNAMIC_SHM. If it was set
> >by OP-TEE, then kernel part of OP-TEE will use kernel page allocator
> >to allocate command buffers. Also it will set TEE_GEN_CAP_REG_MEM
> >capability to tell userspace that it supports shared memory registration.
> >
> >Signed-off-by: Volodymyr Babchuk <vlad.babchuk@gmail.com>
> >---
> >  drivers/tee/optee/core.c | 69 +++++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 51 insertions(+), 18 deletions(-)
> >
> >diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> >index 8e012ea..e8fd9af 100644
> >--- a/drivers/tee/optee/core.c
> >+++ b/drivers/tee/optee/core.c
> >@@ -28,6 +28,7 @@
> >  #include <linux/uaccess.h>
> >  #include "optee_private.h"
> >  #include "optee_smc.h"
> >+#include "shm_pool.h"
> >  #define DRIVER_NAME "optee"
> >@@ -227,6 +228,10 @@ static void optee_get_version(struct tee_device *teedev,
> >  		.impl_caps = TEE_OPTEE_CAP_TZ,
> >  		.gen_caps = TEE_GEN_CAP_GP,
> >  	};
> >+	struct optee *optee = tee_get_drvdata(teedev);
> >+
> >+	if (optee->sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
> >+		v.gen_caps |= TEE_GEN_CAP_REG_MEM;
> >  	*vers = v;
> >  }
> >@@ -405,21 +410,22 @@ static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
> >  }
> >  static struct tee_shm_pool *
> >-optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
> >+optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm,
> >+			  u32 sec_caps)
> >  {
> >  	union {
> >  		struct arm_smccc_res smccc;
> >  		struct optee_smc_get_shm_config_result result;
> >  	} res;
> >-	struct tee_shm_pool *pool;
> >  	unsigned long vaddr;
> >  	phys_addr_t paddr;
> >  	size_t size;
> >  	phys_addr_t begin;
> >  	phys_addr_t end;
> >  	void *va;
> >-	struct tee_shm_pool_mem_info priv_info;
> >-	struct tee_shm_pool_mem_info dmabuf_info;
> >+	struct tee_shm_pool_mgr *priv_mgr;
> >+	struct tee_shm_pool_mgr *dmabuf_mgr;
> >+	void *rc;
> >  	invoke_fn(OPTEE_SMC_GET_SHM_CONFIG, 0, 0, 0, 0, 0, 0, 0, &res.smccc);
> >  	if (res.result.status != OPTEE_SMC_RETURN_OK) {
> >@@ -449,22 +455,49 @@ optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
> >  	}
> >  	vaddr = (unsigned long)va;
> >-	priv_info.vaddr = vaddr;
> >-	priv_info.paddr = paddr;
> >-	priv_info.size = OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE;
> >-	dmabuf_info.vaddr = vaddr + OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE;
> >-	dmabuf_info.paddr = paddr + OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE;
> >-	dmabuf_info.size = size - OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE;
> >-
> >-	pool = tee_shm_pool_alloc_res_mem(&priv_info, &dmabuf_info);
> >-	if (IS_ERR(pool)) {
> >-		memunmap(va);
> >-		goto out;
> 
> Now that you removed the call to tee_shm_pool_alloc_res_mem() it is dead
> code and no longer used.  Do we still need tee_shm_pool_alloc_res_mem at
> all?

Yes, we still need that function in order to support static shared
memory. We'll always need to optionally support static shared memory as
some hardware configurations depend on it.

> 
> >+	/*
> >+	 * If OP-TEE can work with unregistered SHM, we will use own pool
> >+	 * for private shm
> >+	 */
> >+	if (sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM) {
> >+		rc = optee_shm_pool_alloc_pages();
> >+		if (IS_ERR(rc))
> >+			goto err_memunmap;
> >+		priv_mgr = rc;
> >+	} else {
> >+		const size_t sz = OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE;
> >+
> >+		rc = tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, sz,
> >+						    3 /* 8 bytes aligned */);
> >+		if (IS_ERR(rc))
> >+			goto err_memunmap;
> >+		priv_mgr = rc;
> >+
> >+		vaddr += sz;
> >+		paddr += sz;
> >+		size -= sz;
> >  	}
> >+	rc = tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, size, PAGE_SHIFT);
> >+	if (IS_ERR(rc))
> >+		goto err_free_priv_mgr;
> >+	dmabuf_mgr = rc;
> >+
> >+	rc = tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
> >+	if (IS_ERR(rc))
> >+		goto err_free_dmabuf_mgr;
> >+
> >  	*memremaped_shm = va;
> >-out:
> >-	return pool;
> >+
> >+	return rc;
> >+
> >+err_free_dmabuf_mgr:
> >+	tee_shm_pool_mgr_destroy(dmabuf_mgr);
> >+err_free_priv_mgr:
> >+	tee_shm_pool_mgr_destroy(priv_mgr);
> >+err_memunmap:
> >+	memunmap(va);
> >+	return rc;
> >  }
> 
> This function now mixes dynamic and shared memory based allocation in a way that
> only applies to certain cases.
> 
> We're going to have the following cases:
>  -Linux OP-TEE driver sees only static shared memory advertised (older versions
>   of OP-TEE)
>  -Linux OP-TEE driver sees only dynamic shared memory advertised (e.g. a guest
>   kernel in a VM)
>  -Linux OP-TEE driver sees both static and dynamic memory advertised
> 
> We are not handling the 'only dynamic shared memory' case currently and this code
> is going to have to be refactored again to support that.  Since we are substantially
> re-working it anyway here, why don't we support all the cases.

We're trying to keep this patchset as small as possible.

What you're proposing below is something that suits our long term
aspirations, but it's a bit more complicated than just adding the lines
below.

Once we're done with this patchset I'd be happy to work together to
implement what you're proposing.

Thanks,
Jens

> 
> It seems like we need logic along the lines of:
> 
>     invoke_fn(OPTEE_SMC_GET_SHM_CONFIG, 0, 0, 0, 0, 0, 0, 0, &res.smccc);
>     if (res.result.status == OPTEE_SMC_RETURN_OK)
>         optee_static_shm = true;
>     else
>         optee_static_shm = false;
> 
>     if (sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
>         optee_dynamic_shm = true;
>     else
>         optee_dynamic_shm = false;
> 
>     /* allocate private pool */
>     if (optee_dynamic_shm) {
>         rc = optee_shm_pool_alloc_pages();
>         priv_mgr = rc;
>     } else {
>         rc = tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, sz, 3);
>         priv_mgr = rc;
>     }
> 
>     /* allocate dmabuf pool */
>     if (optee_dynamic_shm && !optee_static_shm) {
>         dmabuf_mgr = NULL;
>     } else {
>         rc = tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, size, PAGE_SHIFT);
>         dmabuf_mgr = rc;
>     }
> 
>     rc = tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
> 
> >  /* Simple wrapper functions to be able to use a function pointer */
> >@@ -542,7 +575,7 @@ static struct optee *optee_probe(struct device_node *np)
> >  	if (!(sec_caps & OPTEE_SMC_SEC_CAP_HAVE_RESERVED_SHM))
> >  		return ERR_PTR(-EINVAL);
> 
> We should remove the above assumption that there must be static shared memory.  It
> shouldn't be an error.
> 
> Thanks,
> Stuart
