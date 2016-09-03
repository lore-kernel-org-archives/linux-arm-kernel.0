From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 3 Sep 2016 10:15:17 +0100
Subject: [PATCH 05/33] gpio: add generic single-register fixed-direction
 GPIO driver
In-Reply-To: <87zinqj8vr.fsf@belgarion.home>
References: <87fupmc59b.fsf@belgarion.home>
 <20160831084938.GQ1041@n2100.armlinux.org.uk>
 <20160831102721.GR1041@n2100.armlinux.org.uk>
 <87twe0krym.fsf@belgarion.home>
 <20160901092754.GU1041@n2100.armlinux.org.uk>
 <87oa47l1tn.fsf@belgarion.home>
 <20160901230248.GA1041@n2100.armlinux.org.uk>
 <87inuekx78.fsf@belgarion.home>
 <20160902185641.GF1041@n2100.armlinux.org.uk>
 <87zinqj8vr.fsf@belgarion.home>
Message-ID: <20160903091517.GJ1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 02, 2016 at 11:21:12PM +0200, Robert Jarzmik wrote:
> It looks that I have an ordering problem :
>  - I want gpio-pxa.probe() to be called at device initcall time
>  - pxa_cplds_irqs.probe() cannot complete before gpio-pxa.probe() because it
>    needs GPIO0 as its interrupt source
>    => it might need to honor -EPROBE_DEFER
>  - sa1111.sa1111_probe() cannot complete before pxa_cplds_irqs.probe() because
>    it needs IRQ305 as its source
>    => it might need to honor -EPROBE_DEFER

I wonder if we can work around that by adding this to sa1111_probe():

	if (!irq_get_chip(irq))
		return -EPROBE_DEFER;

It's not particularly nice, but it should at least ensure that things
happen in the right order.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
