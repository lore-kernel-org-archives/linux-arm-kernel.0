From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 25 Jul 2014 22:12:18 +0530
Subject: [PATCH v11 0/2] Add support for the Allwinner A31 DMA Controller
In-Reply-To: <20140725163746.GC20328@lukather>
References: <1405626376-471-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140725131217.GS8181@intel.com> <20140725163746.GC20328@lukather>
Message-ID: <20140725164218.GW8181@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 06:37:46PM +0200, Maxime Ripard wrote:
> > Can you please send follow patches for these:
> > - don't recall if I pointed earlier, but can we use direct conversion for
> >   calculating convert_burst() and convert_buswidth(), latter one at least
> >   seem doable
> 
> Ok. Do you still want the error reporting for the invalid width and
> burst size?
I think for convert_buswidth() we can do away with a switch case and convert
the numbers directly

> > - don't use devm_request_irq(). You have irq enabled and you have killed
> >   tasklet. This is too racy. You need to ensure no irqs can be generated before killing
> >   tasklets.
> 
> Ok, would calling disable_irq before killing the tasklet an option for
> you ? that would allow to keep the devm_request_irq.
disable_irq also does syncronize, so it might work. But then again if the
probe fails after registering irq due to some other reason, and you get into
races with unitialized driver as well.

I think it might be easier to amnge by working with plain old request_irq()

> I'll also send patches for the various breakages and warnings spotted
> by the autobuilders.
Yes please, I havent seen the reports in detail yet, but they are reporting
mainly due COMPILE_TEST. DO you really want that?

Yes it did help me to compile for ARM, i didnt see any defconfig which has
this MACH in arm/configs

-- 
~Vinod
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140725/56c99054/attachment.sig>
