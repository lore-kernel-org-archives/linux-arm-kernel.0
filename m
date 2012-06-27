From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 27 Jun 2012 07:19:58 +0300
Subject: [PATCH 05/11] OMAPDSS: add clk_prepare and clk_unprepare
In-Reply-To: <20120627004709.GA22766@gmail.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
 <1340372890-10091-6-git-send-email-rnayak@ti.com>
 <1340604478.12683.25.camel@lappyti> <4FE80C43.6090802@ti.com>
 <1340611133.3395.3.camel@deskari> <4FE85005.4090303@ti.com>
 <1340630090.3395.85.camel@deskari> <20120627004709.GA22766@gmail.com>
Message-ID: <1340770798.1972.4.camel@lappyti>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-06-26 at 17:47 -0700, Mike Turquette wrote:
> On 20120625-16:14, Tomi Valkeinen wrote:
> > A question about clk_prepare/unprepare, not directly related: let's say
> > I have a driver for some HW block. The driver doesn't use clk functions,
> > but uses runtime PM. The driver also sets pm_runtime_irq_safe().
> > 
> > Now, the driver can call pm_runtime_get_sync() in an atomic context, and
> > this would lead to the underlying framework (hwmod, omap_device, I don't
> > know who =) enabling the func clock for that HW. But this would happen
> > in atomic context, so the underlying framework can't use clk_prepare.
> > 
> > How does the underlying framework handle that case? (sorry if that's a
> > stupid question =).
> > 
> 
> I think it's a good question!
> 
> If we're going to call clk_prepare_enable from within a runtime pm
> callback then I think we'll need to check if _irq_safe() is set and
> conditionally call only clk_enable in such a case.
> 
> I'm not a runtime pm expert, but if the driver owns the responsibility
> of calling pm_runtime_irq_safe then the driver has the proper context
> to know that it should call clk_prepare BEFORE calling
> pm_runtime_get_sync.

That's not quite what I meant. If it's the driver that does clk_enable,
be it in runtime PM callback or not, it's driver's responsibility.

But some clocks are not handled by the driver, but the hwmod/omap_device
framework. Mainly I think this is for the functional and interface
clocks. The driver has no visibility to those, they are implicitly
enabled via pm_runtime_get.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120627/3f730154/attachment.sig>
