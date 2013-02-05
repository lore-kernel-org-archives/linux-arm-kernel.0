From: balbi@ti.com (Felipe Balbi)
Date: Tue, 5 Feb 2013 23:37:10 +0200
Subject: [PATCH 12/15] USB: gadget/freescale: disable non-multiplatform
 drivers
In-Reply-To: <20130205170027.GB1081@kroah.com>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de>
 <20130121184138.GB10106@arwen.pp.htv.fi>
 <20130121185716.GA26754@kroah.com>
 <201302051627.18337.arnd@arndb.de>
 <20130205170027.GB1081@kroah.com>
Message-ID: <20130205213710.GA3739@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 05, 2013 at 09:00:27AM -0800, Greg Kroah-Hartman wrote:
> On Tue, Feb 05, 2013 at 04:27:18PM +0000, Arnd Bergmann wrote:
> > On Monday 21 January 2013, Greg Kroah-Hartman wrote:
> > > On Mon, Jan 21, 2013 at 08:41:38PM +0200, Felipe Balbi wrote:
> > > > Hi,
> > > > 
> > > > On Mon, Jan 21, 2013 at 05:16:05PM +0000, Arnd Bergmann wrote:
> > > > > Both the fsl_mxc gadget and the imx_udc gadget drivers fail to build
> > > > > without the mach/hardware.h file that is not available when building
> > > > > for multiplatform. Let's disable these drivers for v3.8 in combination
> > > > > with CONFIG_ARCH_MULTIPLATFORM, and fix them properly in v3.9 unless
> > > > > someone has an better solution.
> > > > > 
> > > > > Without this patch, building allyesconfig results in:
> > > > > 
> > > > > drivers/usb/gadget/fsl_mxc_udc.c:21:27: fatal error: mach/hardware.h: No such file or directory
> > > > > 
> > > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > > Cc: Felipe Balbi <balbi@ti.com>
> > > > > Cc: Shawn Guo <shawn.guo@linaro.org>
> > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Cc: linux-usb at vger.kernel.org
> > > > 
> > > > NAK, I prefer to see a real fix for the problem (which in fact is
> > > > already in my fixes branch).
> > > 
> > > I'll pull that branch now, sorry for the delay.
> > 
> > Apparently it hasn't made it into the upstream kernel yet, and it also doesn't
> > seem to be in linux-next. Maybe this got lost while you were travelling?
> 
> Hm, no, I thought I got Felipe's fixes branch up into Linus's tree
> already.  Felipe, did I miss something from you?  If so, please resend
> or let me know, as I don't have anything pending on my side.

I don't have anything pending in my fixes branch:

$ git log fixes ^linus/master

$ git show-branch linus/master
[linus/master] Merge branch 'fix-max-write' of git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm

It's building find for me:

$ crossmake drivers/usb/gadget/fsl_udc_core.o \
	drivers/usb/gadget/fsl_mxc_udc.o > /dev/null

(crossmake is an alias to make ARCH=arm)

Arnd, are you maybe missing a merge of v3.8-rc6 ?

I can see that imx_udc.c is broken still, but there are no maintainers
for that driver. I'm adding Sascha to Cc list, maybe he knows someone
who can help, but if this driver isn't fixed in 2 merge windows, I will
schedule for removal from tree and someone else will have to
re-introduce it later without all the bogus includes.

---- build breaks ---

sound/soc/fsl/imx-pcm.c: In function 'snd_imx_pcm_mmap':
sound/soc/fsl/imx-pcm.c:28:2: error: 'KBUILD_MODNAME' undeclared (first use in this function)
sound/soc/fsl/imx-pcm.c:28:2: note: each undeclared identifier is
reported only once for each function it appears in
make[3]: *** [sound/soc/fsl/imx-pcm.o] Error 1

drivers/video/omap2/dss/dss.c: In function 'dss_calc_clock_div':
drivers/video/omap2/dss/dss.c:572:20: error:
'CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK' undeclared (first use in this function)
drivers/video/omap2/dss/dss.c:572:20: note: each undeclared identifier
is reported only once for each function it appears in
make[4]: *** [drivers/video/omap2/dss/dss.o] Error 1

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130205/aa5f5683/attachment.sig>
