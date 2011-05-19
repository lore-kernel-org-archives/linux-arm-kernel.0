From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 May 2011 20:31:21 +0100
Subject: [PATCH] MAX1111: Fix race condition causing NULL pointer exception
In-Reply-To: <201105191451.40416.morpheus.ibis@gmail.com>
References: <1305731918-20164-1-git-send-email-morpheus.ibis@gmail.com>
	<20110518152935.GJ5913@n2100.arm.linux.org.uk>
	<20110519123507.GA4950@elf.ucw.cz>
	<201105191451.40416.morpheus.ibis@gmail.com>
Message-ID: <20110519193121.GC7445@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 19, 2011 at 02:51:40PM +0200, Pavel Herrmann wrote:
> @@ -52,7 +53,14 @@ static int max1111_read(struct device *dev, int channel)
>  		MAX1111_CTRL_PD0 | MAX1111_CTRL_PD1 |
>  		MAX1111_CTRL_SGL | MAX1111_CTRL_UNI | MAX1111_CTRL_STR;
>  
> +	/* spi_sync requires data not to be freed before function returns
> +	 * for static data, any access is dangerous, use locks
> +	 */
> +	mutex_lock(&data->msg_lock_mutex);
> +
>  	err = spi_sync(data->spi, &data->msg);
> +
> +	mutex_unlock(&data->msg_lock_mutex);

I'm not sure that this is right.  Taking the lock around spi_sync() ensures
that two concurrent spi_sync()s can't happen in parallel, but with this you
could end up with another happening as soon as this lock is released -
before you've accessed the data which was transferred.

I think you want to hold the mutex at the point you setup the data to be
transferred, do the transfer, and then release the mutex once you've read
the results of the transfer.
