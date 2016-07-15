From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 15 Jul 2016 12:12:50 +0200
Subject: [PATCH 1/4] Support for building in a Xen binary
In-Reply-To: <5784C91C.30709@arm.com>
References: <20160620150934.1729-1-andre.przywara@arm.com>
 <20160620150934.1729-2-andre.przywara@arm.com>
 <5784C91C.30709@arm.com>
Message-ID: <20160715101250.GB29219@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2016 at 11:40:28AM +0100, Julien Grall wrote:
> Hi Andre,
> 
> On 20/06/16 16:09, Andre Przywara wrote:
> >diff --git a/Makefile.am b/Makefile.am
> >index 692d2cc..1a801c0 100644
> >--- a/Makefile.am
> >+++ b/Makefile.am
> >@@ -85,7 +85,6 @@ TEXT_LIMIT	:= 0x80080000
> >  endif
> >
> >  LD_SCRIPT	:= model.lds.S
> >-IMAGE		:= linux-system.axf
> >
> >  FS_OFFSET	:= 0x10000000
> >  FILESYSTEM_START:= $(shell echo $$(($(PHYS_OFFSET) + $(FS_OFFSET))))
> >@@ -108,6 +107,11 @@ CHOSEN_NODE	:= chosen {						\
> >  		   };
> >  endif
> >
> >+if XEN
> >+XEN		:= -DXEN=$(XEN_IMAGE)
> >+XEN_OFFSET	:= 0x08200000
> >+endif
> >+
> >  CPPFLAGS	+= $(INITRD_FLAGS)
> >  CFLAGS		+= -Iinclude/ -I$(ARCH_SRC)/include/
> >  CFLAGS		+= -Wall -fomit-frame-pointer
> >@@ -117,11 +121,11 @@ LDFLAGS		+= --gc-sections
> >  OFILES		+= boot_common.o bakery_lock.o platform.o $(GIC) cache.o lib.o
> >  OFILES		+= $(addprefix $(ARCH_SRC),boot.o stack.o $(BOOTMETHOD) utils.o)
> >
> >-all: $(IMAGE)
> >+all: $(IMAGE) $(XIMAGE)
> 
> I cannot find where XIMAGE is set. What XIMAGE is used for?
> 
I can't remember (it's been ages since I wrote this patch, then
something happened that required a more substantial rewrite of the whole
bootwrapper, which I think was then aborted anyhow, and this got lost
somehow, or something like that, and I've sort of lost momentum here),
but I think the idea was that you would build the normal linux Image
IMAGE, and XIMAGE for the xen image, so that a single build would output
both images so you could test with the same settings if the basic build
worked, and then test with Xen.

-Christoffer
