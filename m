From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 20 Nov 2014 15:01:25 +0100
Subject: [PATCH 2/3] mmc: atmel-mci: stop using specific initcall
In-Reply-To: <2176441.d1sGy4JguN@wuerfel>
References: <1416478075-17059-1-git-send-email-ludovic.desroches@atmel.com>
 <1416478075-17059-2-git-send-email-ludovic.desroches@atmel.com>
 <2176441.d1sGy4JguN@wuerfel>
Message-ID: <20141120140125.GI3639@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 20, 2014 at 12:10:25PM +0100, Arnd Bergmann wrote:
> On Thursday 20 November 2014 11:07:54 Ludovic Desroches wrote:
> > No more use late initcall to manage probing order. Use probe deferring
> > if needed. Then use module_platform_driver and clean init/exit
> > attributes.
> > 
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > 
> 
> Do we need this backported into stable kernels? It seems that
> the __init/__exit annotations will break things if you ever
> tried to unbind the device or run into deferred probing on
> earlier kernels.

Well, it is a bit complicated, if we backport it, then the mci driver
could be probed before the dma controller. Requesting dma chan will fail
and it will switch to pio mode.

So it has to be backported with the probe deferring. The issue is
that probe deferring patch is based on other patches removing non-dt
support which become useless only ine 3.19.


Ludovic
