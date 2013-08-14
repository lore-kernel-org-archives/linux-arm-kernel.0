From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Aug 2013 23:54:28 +0100
Subject: [PATCH v6 2/4] ARM: debug: support debug ll on hisilicon soc
In-Reply-To: <20130814162502.GA16491@quad.lixom.net>
References: <1374813135-16238-1-git-send-email-haojian.zhuang@linaro.org>
 <1374813135-16238-3-git-send-email-haojian.zhuang@linaro.org>
 <20130814063916.GH19951@quad.lixom.net>
 <20130814154443.GV23006@n2100.arm.linux.org.uk>
 <20130814162502.GA16491@quad.lixom.net>
Message-ID: <20130814225428.GB23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 09:25:02AM -0700, Olof Johansson wrote:
> On Wed, Aug 14, 2013 at 04:44:44PM +0100, Russell King - ARM Linux wrote:
> > On Tue, Aug 13, 2013 at 11:39:16PM -0700, Olof Johansson wrote:
> > > On Fri, Jul 26, 2013 at 12:32:13PM +0800, Haojian Zhuang wrote:
> > > > Support UART0 debug ll on hisilicon Hi3620 SoC.
> > > > 
> > > > Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> > > 
> > > 
> > > Applied, thanks.
> > 
> > Applied without reference to my debug cleanup series which has been
> > sitting in linux-next for ages?
> > 
> > Whatever happened to encouraging people to do things in a manner
> > compatible with the cleanups we're trying to do?
> 
> I quite frankly forgot that this was pending for 3.12 in your tree.
> 
> Thanks for catching this, I'll revert the patch in arm-soc and let it go
> in through yours on top of your cleanups.

Has this been pushed out yet?  I'm getting this new conflict:

++<<<<<<< HEAD
++=======
+       default "debug/keystone.S" if DEBUG_KEYSTONE_UART0 || \
+                                     DEBUG_KEYSTONE_UART1
+       default "debug/msm.S" if DEBUG_MSM_UART1 || \
+                                DEBUG_MSM_UART2 || \
+                                DEBUG_MSM_UART3 || \
+                                DEBUG_MSM8660_UART || \
+                                DEBUG_MSM8960_UART
+       default "debug/mvebu.S" if DEBUG_MVEBU_UART || \
+                                  DEBUG_MVEBU_UART_ALTERNATE
+       default "debug/mxs.S" if DEBUG_IMX23_UART || DEBUG_IMX28_UART
+       default "debug/nomadik.S" if DEBUG_NOMADIK_UART
+       default "debug/nspire.S" if     DEBUG_NSPIRE_CX_UART || \
+                                       DEBUG_NSPIRE_CLASSIC_UART
++>>>>>>> arm-soc/for-next

This seems to be due to the addition of MSM here.  If stuff like this
is going to go through arm-soc, I'm going to make no guarantees of
getting this stuff anywhere close to being correct for the next merge
window, because its too complicated to deal with properly in git
merges.

Also:

CONFLICT (delete/modify): arch/arm/include/debug/highbank.S deleted in HEAD and modified in arm-soc/for-next. Version arm-soc/for-next of arch/arm/include/debug/highbank.S left in tree.

which seems to be a change in the virtual address of the port.  This
one is particularly nasty because it needs to be moved to a completely
different file and therefore is not git rerere'able.  Does it have any
dependencies?
