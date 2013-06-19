From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 19 Jun 2013 15:16:01 +0200
Subject: [PATCH v2] ARM: shmobile: uImage load address rework
In-Reply-To: <3243557.sP7VV5jPVm@avalon>
References: <20130610092857.19175.25629.sendpatchset@w520>
 <CANqRtoSoWesMgBmbfUKxeyfwWcKZ77MyckCdPpKwK4WxYynWbA@mail.gmail.com>
 <3243557.sP7VV5jPVm@avalon>
Message-ID: <76205076.EsFJngGrIh@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Wednesday 12 June 2013 04:31:26 Laurent Pinchart wrote:
> On Wednesday 12 June 2013 11:21:34 Magnus Damm wrote:
> > On Wed, Jun 12, 2013 at 6:50 AM, Laurent Pinchart wrote:
> > > On Monday 10 June 2013 18:28:57 Magnus Damm wrote:
> > >> From: Magnus Damm <damm@opensource.se>
> > >> 
> > >> This is V2 of the mach-shmobile uImage load address rework patch.
> > >> 
> > >> Rework the mach-shmobile uImage load address calculation by storing
> > >> the per-board load addresses in Makefile.boot. This removes the
> > >> CONFIG_MEMORY_START dependency from Makefile.boot, and it also makes
> > >> it possible to create safe kernel images that boot on multiple boards.
> > >> 
> > >> This is one of several series of code that reworks code not to rely on
> > >> CONFIG_MEMORY_START/SIZE which in turn is needed for
> > >> ARCH_MULTIPLATFORM.
> > >> 
> > >> Signed-off-by: Magnus Damm <damm@opensource.se>
> > >> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > >> Reviewed-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > 
> > > I've noticed today that KZM9G doesn't boot v3.10-rc2 with
> > > CONFIG_AUTO_ZRELADDR=y. While not caused by this patch, that's something
> > > that will need to be fixed to support multi-arch kernels. I'm not too
> > > familiar with early boot code, would you be able to have a look at this
> > > ?
> > 
> > I will have a look. I suspect that issue is not related to this patch, is
> > it?
> 
> No, it isn't, the issue is present in v3.10-rc2. I don't know if it has ever
> worked.

The following patch fixes the issue, caused by physical RAM being present at 
0x41000000 on KZM9G. I'm not sure if it would be acceptable as a generic 
solution though.

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index fe4d9c3..ea2f112 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -176,7 +176,7 @@ not_angel:
 #ifdef CONFIG_AUTO_ZRELADDR
 		@ determine final kernel image address
 		mov	r4, pc
-		and	r4, r4, #0xf8000000
+		and	r4, r4, #0xff000000
 		add	r4, r4, #TEXT_OFFSET
 #else
 		ldr	r4, =zreladdr

-- 
Regards,

Laurent Pinchart
