From: andreiw@motorola.com (Andrei Warkentin)
Date: Tue, 22 Feb 2011 01:05:38 -0600
Subject: MMC quirks relating to performance/lifetime.
In-Reply-To: <201102201623.03596.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<201102191220.54815.arnd@arndb.de>
	<AANLkTincLPnW90xvE304dCjkTbKUQGf6H8yWDVdz5Kh4@mail.gmail.com>
	<201102201623.03596.arnd@arndb.de>
Message-ID: <AANLkTikZh10-2_BLqq0DOm67xZCAEsW9FaRw=+sh+GTY@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 20, 2011 at 9:23 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The description of the test case is probably suboptimal. What this does
> is 32 KB accesses, with 32 KB alignment in the pre and post case, but 16 KB
> alignment in the "on" case. The idea here is that it should never do
> any access with less than "--blocksize" aligment.
>

Now I feel slightly confused :(.

-b 16384 implies blocksize = 16384, maxalign is 8mb due to count 32,

               ret = time_rw_interval(dev, count, pre, blocksize,
                                       align - blocksize, maxalign,
                                       do_write);   //
<----------------- read 16k at align - 16k with 8mb intervals?
                returnif(ret);

                ret = time_rw_interval(dev, count, on, blocksize,
                                       align - blocksize / 2, maxalign,
                                       do_write);  //
<----------------- read 16k at align - 8k with 8mb intervals?
	        returnif(ret);

                ret = time_rw_interval(dev, count, post, blocksize,
 	                               align, maxalign, do_write); //
<-------- read 16k@align with 8mb intervals?
		returnif(ret);

I hope I'm not missing something obvious...


> This is what I think happens:
> Since the partition is over 64 MB size and it can have 7 4 MB allocation units open,
> writing to 8 locations on the drive separated 8 MB causes it to do garbage collection
> all the time for 32KB accesses and larger. However, the "on" measurement is only
> 16 KB aligned, so it goes into T's buffer A for small writes, and does not hit
> the garbage collection all the time, so it ends up being a lot faster.
>

Can't go to A. A is 8KB big. Strange...

A
