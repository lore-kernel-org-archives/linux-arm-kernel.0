From: hjk@hansjkoch.de (Hans J. Koch)
Date: Mon, 28 Feb 2011 22:26:38 +0100
Subject: [PATCH v6 1/1] PRUSS UIO driver support
In-Reply-To: <1298926895-5294-2-git-send-email-pratheesh@ti.com>
References: <1298926895-5294-1-git-send-email-pratheesh@ti.com>
	<1298926895-5294-2-git-send-email-pratheesh@ti.com>
Message-ID: <20110228212638.GB16806@local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 01, 2011 at 02:31:35AM +0530, Pratheesh Gangadhar wrote:
> +
> +		/* Register PRUSS IRQ lines */
> +		p->irq = IRQ_DA8XX_EVTOUT0 + cnt;
> +		p->handler = pruss_handler;
> +
> +		ret = uio_register_device(&dev->dev, p);
> +
> +		if (ret < 0)
> +			goto out_free;
> +	}
> +
> +	spin_lock_init(&lock);

That's too late. uio_register_device() enables the irq, and your spin_lock
is not ready at that time.

> +	platform_set_drvdata(dev, info);
> +	return 0;
> +
> +out_free:
> +	pruss_cleanup(dev, info);
> +	return ret;
> +}

Thanks,
Hans
