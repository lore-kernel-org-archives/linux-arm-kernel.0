From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 25 Jul 2014 17:45:19 +0100
Subject: [PATCH v11 0/2] Add support for the Allwinner A31 DMA Controller
In-Reply-To: <20140725163746.GC20328@lukather>
References: <1405626376-471-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140725131217.GS8181@intel.com> <20140725163746.GC20328@lukather>
Message-ID: <20140725164518.GQ21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 06:37:46PM +0200, Maxime Ripard wrote:
> Hi Vinod,
> 
> On Fri, Jul 25, 2014 at 06:42:17PM +0530, Vinod Koul wrote:
> > - don't use devm_request_irq(). You have irq enabled and you have killed
> >   tasklet. This is too racy. You need to ensure no irqs can be generated before killing
> >   tasklets.
> 
> Ok, would calling disable_irq before killing the tasklet an option for
> you ? that would allow to keep the devm_request_irq.

That's not really an acceptable approach if you can use shared interrupts.
A better alternative would be devm_free_irq() to give a definite point
that the interrupt is unregistered in the driver remove sequence.  That
allows you to keep the advantage of devm_request_irq() to clean up during
the initialisation side.

An alternative approach would be to ensure that the hardware is quiesced,
and interrupts are disabled.  Then call synchronize_irq() on it, and at
that point, you should be certain that your interrupt handler should not
process any further interrupts for your device (though, in a shared
interrupt environment, it would still be called should a different device
on the shared line raise its interrupt.)

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
