From: u.kleine-koenig@pengutronix.de (Uwe Kleine-König)
Date: Mon, 11 Jul 2011 16:40:15 +0200
Subject: [PATCH] new helper to define common struct resource constructs
In-Reply-To: <201107072304.05626.arnd@arndb.de>
References: <14C4E31473AF7E4B98176CB73615181C19FBD3@039-SN1MPN1-006.039d.mgd.msft.net>
	<201107071757.23405.arnd@arndb.de>
	<20110707204833.GL29624@pengutronix.de>
	<201107072304.05626.arnd@arndb.de>
Message-ID: <E1QgHeh-0004k8-2m@octopus.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

resource definitions that just define start, end and flags = IORESOURCE_MEM
or IORESOURCE_IRQ (with start=end) are quite common. So introduce a shortcut
for them. Also make available a macro to specify named resources of both
types which are less common.

Signed-off-by: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
---
Hello,

On Thu, 7 Jul 2011 23:04:05 +0200, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 07 July 2011 22:48:33 Uwe Kleine-K??nig wrote:
> > My thoughts on this is that it should better go to where struct resource
> > is defined (<linux/ioports.h>, as Arndt suggested) but then probably a
> > bit more generic as:
> > 
> >         #define RES_MEM_NAMED(_start, _end, _name)                      \
> >                 {                                                       \
> >                         .start = _start,                                \
> >                         .end = _end,                                    \
> >                         .name = _name,                                  \
> >                         .flags = IORESOURCE_MEM,                        \
> >                 }
> >         #define RES_MEM(_start, _end)                                   \
> >                 RES_MEM_NAMED(_start, _end, NULL)
> > 
> > (Maybe alternatively take a _size parameter instead of _end?)
> > While this makes the repetition shorter, it's still there.
> > 
> 
> This sounds reasonable, and I'd also prefer the size instead of end
> argument here. If you prepare a patch to do this, I can ack it for you.
Did that now. In reply to this mail I'll send a patch that converts
arch/arm/plat-mxc/devices to these new helpers which saves ~200 lines.

BTW, this bases on next-20110707. I will coordinate with Sascha and
rebase the follow-up patch accordingly when this one got in.

Best regards
Uwe

 include/linux/ioport.h |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 63eb429..6d493a1 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -109,6 +109,26 @@ struct resource_list {
 /* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM.  */
 #define IORESOURCE_PCI_FIXED		(1<<4)	/* Do not move resource */
 
+
+/* helpers to define resources */
+#define DEFINE_RES_NAMED(_start, _size, _name, _flags)			\
+	{								\
+		.start = _start,					\
+		.end = _start + _size - 1,				\
+		.name = _name,						\
+		.flags = _flags,					\
+	}
+
+#define DEFINE_RES_MEM_NAMED(_start, _size, _name)			\
+	DEFINE_RES_NAMED(_start, _size, _name, IORESOURCE_MEM)
+#define DEFINE_RES_MEM(_start, _size)					\
+	DEFINE_RES_MEM_NAMED(_start, _size, NULL)
+
+#define DEFINE_RES_IRQ_NAMED(_irq, _name)				\
+	DEFINE_RES_NAMED(_irq, 1, _name, IORESOURCE_IRQ)
+#define DEFINE_RES_IRQ(_irq)						\
+	DEFINE_RES_IRQ_NAMED(_irq, NULL)
+
 /* PC/ISA/whatever - the normal PC address spaces: IO and memory */
 extern struct resource ioport_resource;
 extern struct resource iomem_resource;
-- 
1.7.5.4

-- 
Pengutronix e.K.                           | Uwe Kleine-K??nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
