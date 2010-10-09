From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Sat, 9 Oct 2010 20:59:15 +0200 (CEST)
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <201010091643.25065.arnd@arndb.de>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<201010091311.26335.arnd@arndb.de>
	<AANLkTimDd10oj=rruYcB=qTaWWMAJvSCQAJNi+nQqzp7@mail.gmail.com>
	<201010091643.25065.arnd@arndb.de>
Message-ID: <Pine.LNX.4.64.1010092049030.648@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 9 Oct 2010, Arnd Bergmann wrote:

> On Saturday 09 October 2010 13:59:45 Felipe Contreras wrote:
> > I know of tidspbridge, in my original mail I listed some links, one
> > which mentions: sh_mobile_ceu_camera, maybe i.MX31 users of the
> > mx3_camera driver: pcm037 and mx31moboard.
> >
> > http://article.gmane.org/gmane.linux.ports.sh.devel/8560
> 
> sh_mobile_ceu_camera looks fine on mainline. It only remaps
> the mmio registers, so no problem there. No arm platform even
> declares the device, so the report must be with an external tree.
> 
> The mx3_camera driver also looks fine, there is only one ioremap
> in there, which is completely sane.

Arnd, the drivers are fine, they just use the videobuf-dma-contig.c 
driver, which calls dma_alloc_coherent(). But the platforms, that use 
those drivers reserve that memory from system RAM dma_alloc_coherent(NULL, 
...) and dma_declare_coherent_memory(), and this is what breaks currently. 
As Felipe and Uwe in another mail in this thread mention, there are 
currently two platforms in the mainline, that do this. mx1, mx2, omap1 and 
mach-shmobile platforms are potentially affected too.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
