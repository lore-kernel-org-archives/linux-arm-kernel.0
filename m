From: hare@suse.de (Hannes Reinecke)
Date: Wed, 29 Oct 2014 17:07:20 +0100
Subject: [PATCH v2 10/36] ncr5380: Fix SCSI_IRQ_NONE bugs
In-Reply-To: <20141027052609.555425104@telegraphics.com.au>
References: <20141027052607.105914311@telegraphics.com.au>
 <20141027052609.555425104@telegraphics.com.au>
Message-ID: <545110B8.9010809@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2014 06:26 AM, Finn Thain wrote:
> Oak scsi doesn't use any IRQ, but it sets irq = IRQ_NONE rather than
> SCSI_IRQ_NONE. Problem is, the core NCR5380 driver expects SCSI_IRQ_NONE
> if it is to issue IDENTIFY commands that prevent target disconnection.
> And, as Geert points out, IRQ_NONE is part of enum irqreturn.
>
> Other drivers, when they can't get an IRQ or can't use one, will set
> host->irq = SCSI_IRQ_NONE (that is, 255). But when they exit they will
> attempt to free IRQ 255 which was never requested.
>
> Fix these bugs by using NO_IRQ in place of SCSI_IRQ_NONE and IRQ_NONE.
> That means IRQ 0 is no longer probed by ISA drivers but I don't think
> this matters.
>
> Setting IRQ = 255 for these ISA drivers is understood to mean no IRQ.
> This remains supported so as to avoid breaking existing ISA setups (which
> can be difficult to get working) and because existing documentation
> (SANE, TLDP etc) describes this usage for the ISA NCR5380 driver options.
>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare at suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: J. Hawn, J. Guild, F. Imend?rffer, HRB 16746 (AG N?rnberg)
