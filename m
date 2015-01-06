From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 6 Jan 2015 16:27:05 -0500 (EST)
Subject: [PATCH] Revert 9fc2105aeaaf56b0cf75296a84702d0f9e64437b to fix
 pyaudio (and probably more)
In-Reply-To: <alpine.LFD.2.11.1501061519090.18844@knanqh.ubzr>
References: <20150104190123.GA20153@amd> <20150105121126.GA10116@arm.com>
 <alpine.LFD.2.11.1501052259230.18844@knanqh.ubzr>
 <1923550.h5Fs9u5gUy@wuerfel>
 <alpine.LFD.2.11.1501061519090.18844@knanqh.ubzr>
Message-ID: <alpine.LFD.2.11.1501061618340.18844@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Jan 2015, Nicolas Pitre wrote:

> On Tue, 6 Jan 2015, Arnd Bergmann wrote:
> 
> > I think we still build RPC with gcc -march=armv3. Is that a problem
> > with this patch?
> 
> It is.
> 
> Tangential question: does anyone still own a working RPC?
> 
> For sure we no longer support the RPC unless it is fitted with a SA110.  
> And IIRC the reason why -march=armv3 is used in that case has to do with 
> the RPC memory bus not able to accommodate the SA110's LDRH/STRH 
> instructions. However it should be able to execute UMULL regardless.
> 
> Now I could add ".arch armv7-a" in the file to make it compile for RPC.  
> I can't just make it ".arch armv4" as this prevents Thumb2 compilation 
> for that file.
> 
> Other ideas?

I settled on the following:

diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 0573faab96..0eb8de1c6f 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -40,7 +40,10 @@ else
   lib-y	+= io-readsw-armv4.o io-writesw-armv4.o
 endif
 
-lib-$(CONFIG_ARCH_RPC)		+= ecard.o io-acorn.o floppydma.o
+ifeq ($(CONFIG_ARCH_RPC),y)
+  lib-y				+= ecard.o io-acorn.o floppydma.o
+  AFLAGS_delay-loop.o		+= -march=armv4
+endif
 
 $(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
 $(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S

That'll make things easier to sort out in the context of 
$tangential_question.


Nicolas
