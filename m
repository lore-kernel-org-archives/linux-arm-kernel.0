From: kraxel@redhat.com (Gerd Hoffmann)
Date: Fri, 27 Jan 2017 11:31:01 +0100
Subject: [PATCH 04/13] mmc: bcm2835: add bcm2835_check_data_error
In-Reply-To: <3876dea7-cd61-e7cf-e838-8bab6927c8fb@rock-chips.com>
References: <1485473846-24537-1-git-send-email-kraxel@redhat.com>
 <1485473846-24537-5-git-send-email-kraxel@redhat.com>
 <3876dea7-cd61-e7cf-e838-8bab6927c8fb@rock-chips.com>
Message-ID: <1485513061.19754.62.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Hi,

> > @@ -1007,15 +1017,7 @@ static void bcm2835_data_irq(struct bcm2835_host *host, u32 intmask)
> >  	if (!host->data)
> >  		return;
> >
> 
> remove this check, !host->data, as well.

There is a comment in the code saying it is needed, here is more
context:

static void bcm2835_data_irq(struct bcm2835_host *host, u32 intmask)
{
	/* There are no dedicated data/space available interrupt
	 * status bits, so it is necessary to use the single shared
	 * data/space available FIFO status bits. It is therefore not
	 * an error to get here when there is no data transfer in
	 * progress.
	 */
	if (!host->data)
		return;

	bcm2835_check_data_error(host, intmask);

cheers,
  Gerd
