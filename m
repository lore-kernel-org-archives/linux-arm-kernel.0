From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Dec 2013 06:30:10 +0100
Subject: [PATCH v2 00/16] ARM: support for ICP DAS LP-8x4x (with dts)
In-Reply-To: <1387401646.31516.14.camel@host5.omatika.ru>
References: <1386543229-1542-1-git-send-email-ynvich@gmail.com>
 <201312182210.30544.arnd@arndb.de>
 <1387401646.31516.14.camel@host5.omatika.ru>
Message-ID: <201312190630.11087.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 December 2013, Sergei Ianovich wrote:
> > You would still be able to boot a kernel with an old dts file on a new
> > kernel if it just contains a "simple-bus" node here, as long as it doesn't
> > need any boot-time setup at the bus controller. We can change the dts
> > file later if we need to add this functionality, which would break booting
> > old kernels with the new dts files, which isn't much of a problem in
> > general.
> 
> It should actually only break old kernels which require new
> functionally. Otherwise, dts can have
> 
> compatible = "marvell,pxa-extbus", "simple-bus";
> 
> and an older kernel will be happy with "simple-bus". Please correct me
> if I'm wrong.

This would work only if we can probe the devices behind the external
bus controller before the controller itsef has been set up, since
the initialization order can depend on a number of things but not
the bus hierarchy. It will also work if the code setting up the
bus controller can be guaranteed to run before we call
of_platform_populate for the regular devices, which is probably
the best solution here.

	Arnd
