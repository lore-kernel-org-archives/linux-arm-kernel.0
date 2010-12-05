From: daniel@ffwll.ch (Daniel Vetter)
Date: Sun, 5 Dec 2010 12:28:14 +0100
Subject: [PATCH 09/10] MCDE: Add build files and bus
In-Reply-To: <AANLkTinSb-9=xzX3LfZVYcKiDt5Qkm=qV6CiFGUyq+fC@mail.gmail.com>
References: <F45880696056844FA6A73F415B568C6953604E802E@EXDCVYMBSTM006.EQ1STM.local>
	<201011251747.48365.arnd@arndb.de>
	<C832F8F5D375BD43BFA11E82E0FE9FE0082586F430@EXDCVYMBSTM005.EQ1STM.local>
	<201011261224.59490.arnd@arndb.de>
	<AANLkTinSb-9=xzX3LfZVYcKiDt5Qkm=qV6CiFGUyq+fC@mail.gmail.com>
Message-ID: <20101205112813.GB12542@viiv.ffwll.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 04, 2010 at 04:34:22PM -0500, Alex Deucher wrote:
> This doesn't seem that different from the graphics chips we support
> with kms.  I don't think it would require much work to use KMS.  One
> thing we considered, but never ended up implementing was a generic
> overlay API for KMS.  Most PC hardware still has overlays, but we
> don't use them much any more on the desktop side.  It may be
> worthwhile to design an appropriate API for them for these type of
> hardware.

Just fyi about a generic overlay api: I've looked a bit into this when
doing the intel overlay support and I think adding special overlay crtcs
that can be attached real crtcs gives a nice clean api. We could the reuse
the existing framebuffer/pageflipping api to get the buffers to the
overlay engine.

The real pain starts when we want format discovery from userspace with all
the alignement/size/layout constrains. Add in tiling support and its
almost impossible to do in a generic way. But also for kms userspace needs
to know these constrains (implemented for generic use in libkms). I favor
such an approach for overlays, too (if it ever happens) - i.e. a few
helpers in libkms that allocate an appropriate buffer for a given format
and size and returns the buffer, strides and offsets for the different
planes.

-Daniel
-- 
Daniel Vetter
Mail: daniel at ffwll.ch
Mobile: +41 (0)79 365 57 48
