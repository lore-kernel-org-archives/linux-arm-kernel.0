From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Jan 2015 19:44:20 +0000
Subject: [PATCH v6 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
In-Reply-To: <1421695428-19102-3-git-send-email-rjui@broadcom.com>
References: <rjui@broadcom.com>
 <1421695428-19102-1-git-send-email-rjui@broadcom.com>
 <1421695428-19102-3-git-send-email-rjui@broadcom.com>
Message-ID: <20150119194420.GG26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To see why atomic_t is pure obfuscation:

typedef struct {
        int counter;
} atomic_t;

So, counter is a plain int.

On Mon, Jan 19, 2015 at 11:23:47AM -0800, Ray Jui wrote:
> +static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
> +{
> +	struct bcm_iproc_i2c_dev *iproc_i2c = data;
> +	u32 status = readl(iproc_i2c->base + IS_OFFSET);
> +
> +	status &= ISR_MASK;
> +
> +	if (!status)
> +		return IRQ_NONE;
> +
> +	writel(status, iproc_i2c->base + IS_OFFSET);
> +	atomic_set(&iproc_i2c->xfer_is_done, 1);

#define atomic_set(v,i) (((v)->counter) = (i))

So, this is the same as doing:

	iproc_i2c->xfer_is_done.counter = 1;

which is merely setting the 'int' to 1.

> +	time_left = wait_for_completion_timeout(&iproc_i2c->done, time_left);
> +
> +	/* disable all interrupts */
> +	writel(0, iproc_i2c->base + IE_OFFSET);
> +
> +	if (!time_left && !atomic_read(&iproc_i2c->xfer_is_done)) {

#define atomic_read(v)  ACCESS_ONCE((v)->counter)

This is practically the same as:

	if (!time_left && !iproc_i2c->xfer_is_done.counter) {

except that this access will be guaranteed to happen just once at this
location (see ACCESS_ONCE() in include/linux/compiler.h).

However, complete()..wait_for_completion() ensures that there are
barriers in the way: complete takes a spinlock on the waiter, so the
write to iproc_i2c->xfer_is_done.counter will be visible by the time
wait_for_completion() returns, and wait_for_completion() also does.
The same spinlock is also manipulated by wait_for_completion(), which
means there's barriers there as well, so it can't cache the value of
"counter" across that call.

So, the "volatile" access guaranteed by ACCESS_ONCE() isn't even
needed here.

(It would be needed if you were spinning in a loop, calling no other
functions - but then you're supposed to use cpu_relax() in that
circumstance, which has a compiler barrier in it, which ensures that
it will re-read such a variable each time.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
