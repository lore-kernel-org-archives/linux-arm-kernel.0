From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 28 Mar 2015 22:06:23 +0000
Subject: [PATCH 4/8] pcmcia: pxa2xx: convert memory allocation to devm_*
 API
In-Reply-To: <87zj6wvm3z.fsf@free.fr>
References: <20150326112254.GZ8656@n2100.arm.linux.org.uk>
 <E1Yb5t5-0006I8-Oi@rmk-PC.arm.linux.org.uk>
 <87zj6wvm3z.fsf@free.fr>
Message-ID: <20150328220623.GA24899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 28, 2015 at 10:38:24PM +0100, Robert Jarzmik wrote:
> Russell King <rmk+kernel@arm.linux.org.uk> writes:
> 
> > Convert the pxa2xx socket driver memory allocation to use devm_kzalloc()
> > to simplify the cleanup path.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  drivers/pcmcia/pxa2xx_base.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
> > index 197c77a64ce0..dfcf07828605 100644
> > --- a/drivers/pcmcia/pxa2xx_base.c
> > +++ b/drivers/pcmcia/pxa2xx_base.c
> > @@ -302,7 +302,8 @@ static int pxa2xx_drv_pcmcia_probe(struct platform_device *dev)
> >  
> >  	pxa2xx_drv_pcmcia_ops(ops);
> >  
> > -	sinfo = kzalloc(SKT_DEV_INFO_SIZE(ops->nr), GFP_KERNEL);
> > +	sinfo = devm_kzalloc(&pdev->dev, SKT_DEV_INFO_SIZE(ops->nr),
> There is a typo here : &pdev->dev should be &dev->dev.
> 
> Now given that fix, you can add my :
> Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
> 
> This test of mine is rather cheap :
>  - it relies on 4.0-rc4
>  - I don't have any PCMCIA card to insert in the lubbock, hence the "cheap"
>  - I judge that pcmcia is working because :
>    - cat /proc/iomem gives:
>      10000000-10001fff : sa1111
>        10000400-100005ff : 0400
>        10000800-100009ff : 0800
>        10000a00-10000bff : 0a00
>          10000a00-10000bff : sa1111-ps2
>        10000c00-10000dff : 0c00
>          10000c00-10000dff : sa1111-ps2
>        10001600-100017ff : irq
>        10001800-100019ff : 1800
>          10001800-100019ff : sa1111-pcmcia
>     - I don't see any error message in kernel log
> 
> As a side note mainly to myself, the pcmcia is broken on pxa2xx architectures
> and panics the kernel at boot time because :
>  - in drivers/pcmcia/sa1111_lubbock.c I see :
>    pcmcia_lubbock_init()
>      pxa2xx_configure_sockets(&sadev->dev);
>        here it is expected that platform_data contains the pcmcia ops, but it's
>        NULL, and the dereferencing in pxa2xx_configure_sockets() of ops->first
>        panics.

I guess it's broken as a result of 5b703683b6cc3cb97bbe6b1b14898b273eb59279
which added that call without really understanding the call path.  I
don't see any solution other than partially reverting that commit.
As can be seen from the commit message, this was done blindly with no
testing - so it's no surprise that it broke.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
