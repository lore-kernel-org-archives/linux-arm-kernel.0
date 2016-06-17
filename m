From: tj@kernel.org (Tejun Heo)
Date: Fri, 17 Jun 2016 12:10:53 -0400
Subject: [PATCH] ata: fix "ering" sysfs time printing
In-Reply-To: <20160617153739.429055-1-arnd@arndb.de>
References: <20160617153739.429055-1-arnd@arndb.de>
Message-ID: <20160617161053.GK3262@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 05:37:12PM +0200, Arnd Bergmann wrote:
> The sysfs file for the libata error handling has multiple issues
> in the way it prints time stamps:
> 
>  * it prints a 9-digit nanosecond value using a %06lu format string,
>    which drops some leading zeroes
>  * it converts a 64-bit jiffes value to a timespec using
>    jiffies_to_timespec(), which takes a 'long' argument, so the
>    result is wrong after a jiffies overflow (49 days).
>  * we try to avoid using timespec because that generally overflows
>    in 2038, although this particular usage is ok.
> 
> This replaces the jiffies_to_timespec call with an open-coded
> implementation that gets it right.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Heh, I'm not even sure why we're exposing this but it's already there.
Applied to libata/for-4.8.

Thanks!

-- 
tejun
