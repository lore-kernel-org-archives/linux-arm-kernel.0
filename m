From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Oct 2014 22:34:37 +0100
Subject: [RFC] drop owner assignment from platform_drivers
In-Reply-To: <20141010182604.GC6075@katana>
References: <20141010072439.GA1741@katana>
 <20141010083627.GL5182@n2100.arm.linux.org.uk> <20141010182604.GC6075@katana>
Message-ID: <20141010213437.GP5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 10, 2014 at 08:26:05PM +0200, Wolfram Sang wrote:
> platform_create_bundle() calls platform_driver_probe().
> platform_driver_probe() calls platform_driver_register().
> platform_driver_register() modifies driver.owner.
> 
> So, it is correct from the point of view that it doesn't make sense to
> set the .owner field if it gets overwritten anyhow.
> 
> You got me wondering, though, that it could not be correct to call
> platform_driver_register() from the platform core instead of module
> init. I will check tomorrow. Still, this would be a bug independent of
> my series. Although I'd need to respin it if platform_driver_probe()
> needed a fix.

This shows what the bad side-effect of people doing "cleanups" is.
This bug was introduced by:

commit 9447057eaff871dd7c63c808de761b8732407169
Author: Libo Chen <clbchenlibo.chen@huawei.com>
Date:   Sat May 25 12:40:50 2013 +0800

    platform_device: use a macro instead of platform_driver_register

    I found a lot of mistakes using struct platform_driver without owner
    so I make a macro instead of the function platform_driver_register.
    It can set owner in it, then guys don`t care about module owner again.

    Signed-off-by: Libo Chen <libo.chen@huawei.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

So, this patch subsituted one set of mistakes for another mistake...

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
