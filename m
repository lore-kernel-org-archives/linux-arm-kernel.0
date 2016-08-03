From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Aug 2016 09:38:22 +0100
Subject: "Failed to create /dev/root: -14" after commit e6978e4bf1 ("ARM:
 save and reset the address limit when entering an exception")
In-Reply-To: <57A15C41.6000804@roeck-us.net>
References: <57A15C41.6000804@roeck-us.net>
Message-ID: <20160803083822.GI1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 02, 2016 at 07:51:45PM -0700, Guenter Roeck wrote:
> Hi,
> 
> I see the following crash when running a qemu arm 'kzm' runtime test with
> the current mainline.
>...
> Failed to create /dev/root: -14
> 
> [ followed by panic ]
> 
> A complete log file is at [1].

I think it's because of those undefined instructions you're hitting
with the hw-breakpoint code... can you try the patch below please?

 arch/arm/kernel/entry-armv.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index bc5f50799d75..9f157e7c51e7 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -295,6 +295,7 @@ __und_svc_fault:
 	bl	__und_fault
 
 __und_svc_finish:
+	get_thread_info tsk
 	ldr	r5, [sp, #S_PSR]		@ Get SVC cpsr
 	svc_exit r5				@ return from exception
  UNWIND(.fnend		)


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
