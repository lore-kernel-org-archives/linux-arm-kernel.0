From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 16 May 2010 18:31:09 +0100
Subject: [patch 5/6] orion/kirkwood: Add i2s support
In-Reply-To: <20100515153130.937921459@mandriva.com>
References: <20100515152958.899927802@mandriva.com>
	<20100515153130.937921459@mandriva.com>
Message-ID: <20100516173105.GC9830@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 15, 2010 at 05:30:03PM +0200, apatard at mandriva.com wrote:

> This patch enables support for the i2s controller available on orion/kirkwood platforms
> 
> Signed-off-by: Arnaud Patard <apatard@mandriva.com>

All looks sensible enough, CCing in Liam.  One thing...

> +	if (status & ~(ORION_INT_CAUSE_PLAY_BYTES | \
> +			ORION_INT_CAUSE_REC_BYTES)) {
> +		printk(KERN_WARNING "%s: unexpected interrupt %lx\n",
> +			__func__, status);
> +		return IRQ_HANDLED;
> +	}

Did the driver really handle the interrupt here?  It's not even written
an ack back so IRQ_NONE might be a better response (the problem with
using IRQ_NONE before was that the driver may have handled some transfer
interrupts before it got the empty status).
