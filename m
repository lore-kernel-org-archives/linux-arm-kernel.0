From: davem@davemloft.net (David Miller)
Date: Tue, 30 Oct 2018 11:25:11 -0700 (PDT)
Subject: [PATCH 1/2] net: axienet: recheck condition after timeout in
 mdio_wait()
In-Reply-To: <20181030093139.10226-2-kurt@linutronix.de>
References: <20181030093139.10226-1-kurt@linutronix.de>
 <20181030093139.10226-2-kurt@linutronix.de>
Message-ID: <20181030.112511.957438343014682098.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kurt Kanzenbach <kurt@linutronix.de>
Date: Tue, 30 Oct 2018 10:31:38 +0100

> The function could report a false positive if it gets preempted between reading
> the XAE_MDIO_MCR_OFFSET register and checking for the timeout.  In such a case,
> the condition has to be rechecked to avoid false positives.
> 
> Therefore, check for expected condition even after the timeout occurred.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
 ...
>  		if (time_before_eq(end, jiffies)) {
> -			WARN_ON(1);
> -			return -ETIMEDOUT;
> +			val = axienet_ior(lp, XAE_MDIO_MCR_OFFSET);
> +			break;
>  		}
> +
>  		udelay(1);
>  	}
> -	return 0;
> +	if (val & XAE_MDIO_MCR_READY_MASK)
> +		return 0;
> +
> +	WARN_ON(1);
> +	return -ETIMEDOUT;

You are not fundamentally changing the situation at all.

The condtion could change right after your last read of
XAR_MDIO_MCR_OFFSET, which is the same thing that happens before your
modifications to this code.

It sounds more like the timeout is slightly too short, and that's the
real problem that causes whatever behavior you think you are fixing
here.

I'm not applying this.
