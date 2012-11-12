From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 12 Nov 2012 15:57:34 +0200
Subject: [PATCH 0/5] OMAPFB: use dma_alloc instead of omap's vram
In-Reply-To: <CANOLnOO0yMabku-_3yhi=1bwohbrb=rtFDOuKf1LPCAFv_OqCQ@mail.gmail.com>
References: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
 <CANOLnOO0yMabku-_3yhi=1bwohbrb=rtFDOuKf1LPCAFv_OqCQ@mail.gmail.com>
Message-ID: <50A1004E.8000203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-11-12 15:39, Grazvydas Ignotas wrote:
> Hi,
> 
> On Mon, Nov 12, 2012 at 12:25 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> This series changes omapfb to use standard dma_alloc funcs instead of omap
>> specific vram allocator. This let's us remove the omap vram allocator, making
>> omapfb platform independent.
>>
>> However, note that using standard dma funcs causes the following downsides:
>>
>> ...
>>
>> 3) OMAPFB_GET_VRAM_INFO ioctl cannot return real values anymore. I
>> changed the ioctl to return 64M for all the values, which, I hope, the
>> applications will interpret as "there's enough vram".
> 
> Do at least OMAPFB_QUERY_MEM/OMAPFB_SETUP_MEM still work?
> 
>> 4) "vram" kernel parameter to define how much ram to reserve for video use no
>> longer works. The user needs to enable CMA and use "cma" parameter.
> 
> That's a significant change, you should update Documentation/ .

I've added the following documentation change:

diff --git a/Documentation/arm/OMAP/DSS b/Documentation/arm/OMAP/DSS
index a564cee..4484e02 100644
--- a/Documentation/arm/OMAP/DSS
+++ b/Documentation/arm/OMAP/DSS
@@ -285,7 +285,10 @@ FB0 +-- GFX  ---- LCD ---- LCD
 Misc notes
 ----------
 
-OMAP FB allocates the framebuffer memory using the OMAP VRAM allocator.
+OMAP FB allocates the framebuffer memory using the standard dma allocator. You
+can enable Contiguous Memory Allocator (CONFIG_CMA) to improve the dma
+allocator, and if CMA is enabled, you use "cma=" kernel parameter to increase
+the global memory area for CMA.
 
 Using DSI DPLL to generate pixel clock it is possible produce the pixel clock
 of 86.5MHz (max possible), and with that you get 1280x1024 at 57 output from DVI.
@@ -301,11 +304,6 @@ framebuffer parameters.
 Kernel boot arguments
 ---------------------
 
-vram=<size>[,<physaddr>]
-       - Amount of total VRAM to preallocate and optionally a physical start
-         memory address. For example, "10M". omapfb allocates memory for
-         framebuffers from VRAM.
-



-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 897 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121112/64153f68/attachment-0001.sig>
