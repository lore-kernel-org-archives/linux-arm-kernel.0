From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Oct 2015 09:41:27 +0200
Subject: [PATCH] drm/amdgpu: fix 32-bit compiler warning
Message-ID: <14056299.vVOiOhUXfA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new amdgpu driver passes a user space pointer in a 64-bit structure
member, which is the correct way to do it, but it attempts to
directly cast it to a __user pointer in the kernel, which causes
a warning in three places:

drm/amd/amdgpu/amdgpu_cs.c: In function 'amdgpu_cs_parser_init':
drm/amd/amdgpu/amdgpu_cs.c:180:21: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
  chunk_array_user = (uint64_t __user *)(cs->in.chunks);

This changes all three to add an intermediate cast to 'unsigned long'
as other drivers do. This avoids the warning and works correctly on
both 32-bit and 64-bit architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index cb3c274edb0a..fd16652aa277 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -177,7 +177,7 @@ int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, void *data)
 
 	/* get chunks */
 	INIT_LIST_HEAD(&p->validated);
-	chunk_array_user = (uint64_t __user *)(cs->in.chunks);
+	chunk_array_user = (uint64_t __user *)(unsigned long)(cs->in.chunks);
 	if (copy_from_user(chunk_array, chunk_array_user,
 			   sizeof(uint64_t)*cs->in.num_chunks)) {
 		ret = -EFAULT;
@@ -197,7 +197,7 @@ int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, void *data)
 		struct drm_amdgpu_cs_chunk user_chunk;
 		uint32_t __user *cdata;
 
-		chunk_ptr = (void __user *)chunk_array[i];
+		chunk_ptr = (void __user *)(unsigned long)chunk_array[i];
 		if (copy_from_user(&user_chunk, chunk_ptr,
 				       sizeof(struct drm_amdgpu_cs_chunk))) {
 			ret = -EFAULT;
@@ -208,7 +208,7 @@ int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, void *data)
 		p->chunks[i].length_dw = user_chunk.length_dw;
 
 		size = p->chunks[i].length_dw;
-		cdata = (void __user *)user_chunk.chunk_data;
+		cdata = (void __user *)(unsigned long)user_chunk.chunk_data;
 		p->chunks[i].user_ptr = cdata;
 
 		p->chunks[i].kdata = drm_malloc_ab(size, sizeof(uint32_t));
