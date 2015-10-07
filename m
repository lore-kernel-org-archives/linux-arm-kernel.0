From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Oct 2015 13:04:06 +0200
Subject: [PATCH] drm/virtio: use %llu format string form atomic64_t
In-Reply-To: <20151007104502.GH21513@n2100.arm.linux.org.uk>
References: <5082760.FgB9zHNfte@wuerfel>
 <20151007104502.GH21513@n2100.arm.linux.org.uk>
Message-ID: <6260324.3MlUEc3veg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 October 2015 11:45:02 Russell King - ARM Linux wrote:
> On Wed, Oct 07, 2015 at 12:41:21PM +0200, Arnd Bergmann wrote:
> > The virtgpu driver prints the last_seq variable using the %ld or
> > %lu format string, which does not work correctly on all architectures
> > and causes this compiler warning on ARM:
> > 
> > drivers/gpu/drm/virtio/virtgpu_fence.c: In function 'virtio_timeline_value_str':
> > drivers/gpu/drm/virtio/virtgpu_fence.c:64:22: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'long long int' [-Wformat=]
> >   snprintf(str, size, "%lu", atomic64_read(&fence->drv->last_seq));
> >                       ^
> > drivers/gpu/drm/virtio/virtgpu_debugfs.c: In function 'virtio_gpu_debugfs_irq_info':
> > drivers/gpu/drm/virtio/virtgpu_debugfs.c:37:16: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'long long int' [-Wformat=]
> >   seq_printf(m, "fence %ld %lld\n",
> >                 ^
> > 
> > In order to avoid the warnings, this changes the format strings to %llu
> > and adds a cast to u64, which makes it work the same way everywhere.
> 
> You have to wonder why atomic64_* functions do not use u64 types.
> If they're not reliant on manipulating 64-bit quantities, then what's
> the point of calling them atomic _64_.

I haven't checked all architectures, but I assume what happens is that
64-bit ones just #define atomic64_t atomic_long_t, so they don't have
to provide three sets of functions.

	Arnd
