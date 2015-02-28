From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 28 Feb 2015 20:31:27 +0100
Subject: [PATCH v2 2/2] hwrng: iproc-rng200 - Add Broadcom IPROC RNG driver
In-Reply-To: <54F1E647.10106@broadcom.com>
References: <1424888184-22180-3-git-send-email-sbranden@broadcom.com>
 <2093191.gujNGSl66k@wuerfel> <54F1E647.10106@broadcom.com>
Message-ID: <2555599.AxGoQ20pkj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 28 February 2015 08:01:11 Scott Branden wrote:
> > The udelay(10) that the other drivers have seems about appropriate then,
> > and we can independently think of a way to refine the interface.
> > Please add a comment that explains the rate. Also, is there some kind
> > of FIFO present in the hwrng device? If it can store close to 1ms work
> > of data (1000 bits), you can just use an msleep(1) to wait for the
> > pool to recover.
> FIFO is 512 bits.  I will look as to whether we can live with 1/2 
> throughput.

In that case, I think usleep_range(min(len * 8, 500), 500)) would be
a good compromise: it waits at most until the fifo is full, but might
return earlier if enough bits are available to fulfill the request.

	Arnd
