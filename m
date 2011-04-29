From: hunold@linuxtv.org (Michael Hunold)
Date: Fri, 29 Apr 2011 14:50:37 +0200
Subject: dma_alloc_writecombine() and MAX_ORDER
Message-ID: <4DBAB41D.7030705@linuxtv.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm using dma_alloc_writecombine() to allocate memory in my framebuffer
device driver just like many other drivers do.

Now I have a new panel with a higher resolution and more bits-per-pixel.
I want to use double-buffering with DirectFB and so my framebuffer size
exceeds 4Mb.

Even though my embedded system has plenty of memory, now I receive the
following warning and the allocation fails:

WARNING: at /home/teemhu/mcu/has/topas/mm/page_alloc.c:2012
__alloc_pages_nodemask+0x444/0x650()

This is due to the following check in __alloc_pages_slowpath():
	if (order >= MAX_ORDER) {
		WARN_ON_ONCE(!(gfp_mask & __GFP_NOWARN));
		return NULL;
	}

Because MAX_ORDER is 11, only memory chunks of size (PAGE_SIZE <<
MAX_ORDER_NR_PAGES) = 4Mb can be allocated.

Apparently this topic has come up when using the OMAP DSS already:
http://www.spinics.net/lists/linux-omap/msg08124.html

Another user has asked this question on the linuxfb-dev mailing list in
October 2010, but did not receive an answer:
http://www.spinics.net/lists/linux-fbdev/msg01745.html

So, would increasing MAX_ORDER in order to allow bigger memory chunks to
be allocated via dma_alloc_writecombine() be acceptable?

If not, can anybody give me some advice how to do the memory allocation
for the framebuffer memory instead in order to circumvent the problem?

CU
Michael.
