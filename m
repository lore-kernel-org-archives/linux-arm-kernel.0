From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 16 Jan 2018 23:07:34 -0500 (EST)
Subject: [PATCH] ARM: make memzero optimization smarter
In-Reply-To: <CAK8P3a2bfErHxu2i-3JJpUdG64RSoYgmpip2xLAutiSSM9UEkw@mail.gmail.com>
References: <20180116162905.1404585-1-arnd@arndb.de>
 <nycvar.YSQ.7.76.1801161205560.13881@knanqh.ubzr>
 <CAK8P3a2bfErHxu2i-3JJpUdG64RSoYgmpip2xLAutiSSM9UEkw@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1801162150190.13881@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Jan 2018, Arnd Bergmann wrote:

> On Tue, Jan 16, 2018 at 6:10 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Tue, 16 Jan 2018, Arnd Bergmann wrote:
> >
> >> However, we can avoid this class of bogus warnings for the memset() macro
> >> by only doing the micro-optimization for zero-length arguments when the
> >> length is a compile-time constant. This should also reduce code size by
> >> a few bytes, and avoid an extra branch for the cases that a variable-length
> >> argument is always nonzero, which is probably the common case anyway.
> >>
> >> I have made sure that the __memzero implementation can safely handle
> >> a zero length argument.
> >
> > Why not simply drop the test on (__n) != 0 then? I fail to see what the
> > advantage is in that case.
> 
> Good point. We might actually get even better results by dropping the
> __memzero path entirely, since gcc has can optimize trivial memset()
> operations and inline them.
> 
> If I read arch/arm/lib/memzero.S correctly, it saves exactly two 'orr'
> instructions compared to the memset.S implementation, but calling
> memset() rather than __memzero() from C code ends up saving a
> function call at least some of the time.
> 
> Building a defconfig kernel with gcc-7.2.1, I see 1919 calls to __memzero()
> and 636 calls to memset() in vmlinux. If I remove the macro entirely,
> I get 1775 calls to memset() instead, so 780 memzero instances got
> inlined, and kernel shrinks by 5488 bytes (0.03%), not counting the
> __memzero implementation that we could possibly also drop.

I get 3668 fewer bytes just by removing the test against 0 in the macro.

And an additional 5092 fewer bytes by removing the call-to-__memzero 
optimization.

That's using gcc v6.3.1.

> FWIW, the zero-length check saves five references to __memzero()
> and one reference to memset(), or 16 bytes in kernel size, I have not
> checked what those are.

They apparently are:

security/keys/key.c:1117:2:
  memset(&ktype->lock_class, 0, sizeof(ktype->lock_class));
crypto/drbg.c:615:3:
   memset(drbg->V, 1, drbg_statelen(drbg));
crypto/drbg.c:1120:3:
   memset(drbg->V, 0, drbg_statelen(drbg));
crypto/drbg.c:1121:3:
   memset(drbg->C, 0, drbg_statelen(drbg));
drivers/crypto/bcm/cipher.c:1963:2:
  memset(ctx->bcm_spu_req_hdr, 0, alloc_len);
drivers/media/platform/vivid/vivid-vbi-cap.c:106:2:
  memset(vbuf, 0x10, vb2_plane_size(&buf->vb.vb2_buf, 0));
drivers/media/platform/vivid/vivid-vbi-cap.c:127:2:
  memset(vbuf, 0, vb2_plane_size(&buf->vb.vb2_buf, 0));
drivers/gpu/drm/nouveau/nvkm/subdev/bios/conn.c:50:2:
  memset(info, 0x00, sizeof(*info));


Nicolas
