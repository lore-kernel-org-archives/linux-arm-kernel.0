From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Apr 2014 09:46:16 +0100
Subject: [PATCH 01/38] mmc: sdio_irq: rework sdio irq handling
In-Reply-To: <CAPDyKFpqJQ4pA6JEWjBwxbuoZ9HkiUAz89O_5YVVBaVh13XeMQ@mail.gmail.com>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
 <E1Wd2Up-0003uJ-7k@rmk-PC.arm.linux.org.uk>
 <CAPDyKFpqJQ4pA6JEWjBwxbuoZ9HkiUAz89O_5YVVBaVh13XeMQ@mail.gmail.com>
Message-ID: <20140424084616.GE26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 09:58:55AM +0200, Ulf Hansson wrote:
> On 23 April 2014 21:06, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> > +               if (!(host->caps2 & MMC_CAP2_SDIO_NOTHREAD)) {
> > +                       atomic_set(&host->sdio_irq_thread_abort, 0);
> > +                       host->sdio_irq_thread =
> > +                               kthread_run(sdio_irq_thread, host,
> > +                                           "ksdioirqd/%s", mmc_hostname(host));
> > +                       if (IS_ERR(host->sdio_irq_thread)) {
> > +                               int err = PTR_ERR(host->sdio_irq_thread);
> > +                               host->sdio_irqs--;
> > +                               return err;
> > +                       }
> > +               } else {
> 
> I suppose you need to check for MMC_CAP_SDIO_IRQ here?

Why would you set MMC_CAP2_SDIO_NOTHREAD if you didn't have MMC_CAP_SDIO_IRQ ?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
