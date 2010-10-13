From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 13 Oct 2010 16:00:55 -0400 (EDT)
Subject: [PATCH] sdio: fix suspend/resume regression
In-Reply-To: <AANLkTiki_Sky6pry+vWAoTtJ5ctVUpawAH6iRYV6L-+z@mail.gmail.com>
References: <1286788315.3101.11.camel@sven>
	<1286955116-22793-1-git-send-email-ohad@wizery.com>
	<AANLkTiki_Sky6pry+vWAoTtJ5ctVUpawAH6iRYV6L-+z@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1010131559580.2764@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Oct 2010, Vitaly Wool wrote:

> Hi Ohad,
> 
> On Wed, Oct 13, 2010 at 9:31 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> 
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index c94565d..515ff39 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -1682,6 +1682,19 @@ int mmc_suspend_host(struct mmc_host *host)
> > ? ? ? ?if (host->bus_ops && !host->bus_dead) {
> > ? ? ? ? ? ? ? ?if (host->bus_ops->suspend)
> > ? ? ? ? ? ? ? ? ? ? ? ?err = host->bus_ops->suspend(host);
> > + ? ? ? ? ? ? ? if (err == -ENOSYS || !host->bus_ops->resume) {
> > + ? ? ? ? ? ? ? ? ? ? ? /*
> > + ? ? ? ? ? ? ? ? ? ? ? ?* We simply "remove" the card in this case.
> > + ? ? ? ? ? ? ? ? ? ? ? ?* It will be redetected on resume.
> > + ? ? ? ? ? ? ? ? ? ? ? ?*/
> > + ? ? ? ? ? ? ? ? ? ? ? if (host->bus_ops->remove)
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? host->bus_ops->remove(host);
> > + ? ? ? ? ? ? ? ? ? ? ? mmc_claim_host(host);
> > + ? ? ? ? ? ? ? ? ? ? ? mmc_detach_bus(host);
> > + ? ? ? ? ? ? ? ? ? ? ? mmc_release_host(host);
> > + ? ? ? ? ? ? ? ? ? ? ? host->pm_flags = 0;
> > + ? ? ? ? ? ? ? ? ? ? ? err = 0;
> > + ? ? ? ? ? ? ? }
> > ? ? ? ?}
> > ? ? ? ?mmc_bus_put(host);
> >
> 
> what about moving this logic to sdio bus_ops as this seems to be
> completely specific to sdio right now?

It doesn't have to.


Nicolas
