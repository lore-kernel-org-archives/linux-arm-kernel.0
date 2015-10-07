From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Oct 2015 11:18:27 +0200
Subject: [PATCH] drm/amdgpu: fix 32-bit compiler warning
In-Reply-To: <5614DE67.2070507@amd.com>
References: <14056299.vVOiOhUXfA@wuerfel> <5614DE67.2070507@amd.com>
Message-ID: <5244259.kNg2jHSi3h@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 October 2015 10:57:11 Christian K?nig wrote:
> On 07.10.2015 09:41, Arnd Bergmann wrote:
> > The new amdgpu driver passes a user space pointer in a 64-bit structure
> > member, which is the correct way to do it, but it attempts to
> > directly cast it to a __user pointer in the kernel, which causes
> > a warning in three places:
> >
> > drm/amd/amdgpu/amdgpu_cs.c: In function 'amdgpu_cs_parser_init':
> > drm/amd/amdgpu/amdgpu_cs.c:180:21: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> >    chunk_array_user = (uint64_t __user *)(cs->in.chunks);
> >
> > This changes all three to add an intermediate cast to 'unsigned long'
> > as other drivers do. This avoids the warning and works correctly on
> > both 32-bit and 64-bit architectures.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Well if I'm not completely mistaken this is the second time we need to 
> fix this because somebody thought the cast was unnecessary.
> 
> Anyway the patch is Reviewed-by: Christian K?nig 
> <christian.koenig@amd.com> and I'm going to keep an eye open for the 
> next time somebody tries to remove this.
> 

Ok, thanks.

I guess I should have added

Fixes: e60b344f6c0eff ("drm/amdgpu: optimize amdgpu_parser_init")

	Arnd
