From: mturquette@baylibre.com (Michael Turquette)
Date: Wed, 06 Jul 2016 13:42:28 -0700
Subject: [PATCH v2] xen/arm: register clocks used by the hypervisor
In-Reply-To: <577D035C.7090504@arm.com>
References: <1467282752-14053-1-git-send-email-dirk.behme@de.bosch.com>
 <146776885213.35356.11565744417822933094@resonance>
 <577D035C.7090504@arm.com>
Message-ID: <146783774807.35356.6362595927321996311@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,

Quoting Julien Grall (2016-07-06 06:10:52)
> On 06/07/16 02:34, Michael Turquette wrote:
> > Hi!
> 
> Hello Michael,
> 
> > Quoting Dirk Behme (2016-06-30 03:32:32)
> >> Some clocks might be used by the Xen hypervisor and not by the Linux
> >> kernel. If these are not registered by the Linux kernel, they might be
> >> disabled by clk_disable_unused() as the kernel doesn't know that they
> >> are used. The clock of the serial console handled by Xen is one
> >> example for this. It might be disabled by clk_disable_unused() which
> >> stops the whole serial output, even from Xen, then.
> >
> > This whole thread had me confused until I realized that it all boiled
> > down to some nomenclature issues (for me).
> >
> > This code does not _register_ any clocks. It simply gets them and
> > enables them, which is what every other clk consumer in the Linux kernel
> > does. More details below.
> >
> >>
> >> Up to now, the workaround for this has been to use the Linux kernel
> >> command line parameter 'clk_ignore_unused'. See Xen bug
> >>
> >> http://bugs.xenproject.org/xen/bug/45
> >
> > clk_ignore_unused is a band-aid, not a proper medical solution. Setting
> > that flag will not turn clocks on for you, nor will it guarantee that
> > those clocks are never turned off in the future. It looks like you
> > figured this out correctly in the patch below but it is worth repeating.
> >
> > Also the new CLK_IS_CRITICAL flag might be of interest to you, but that
> > flag only exists as a way to enable clocks that must be enabled for the
> > system to function (hence, "critical") AND when those same clocks do not
> > have an accompanying Linux driver to consume them and enable them.
> 
> I don't think we want the kernel to enable the clock for the hypervisor. 
> We want to tell the kernel "don't touch at all to this clock, it does 
> not belong to you".

But the patch *does* touch the clock from the kernel. It enables the
clock via a call clk_prepare_enable. I'm utterly confused.

Regards,
Mike

> 
> Regards,
> 
> -- 
> Julien Grall
