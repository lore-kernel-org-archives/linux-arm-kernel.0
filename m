From: daniel@makrotopia.org (Daniel Golle)
Date: Thu, 20 Sep 2018 10:24:29 +0200
Subject: [PATCH 1/2] libata: add ledtrig support
In-Reply-To: <20180920072354.GA20392@amd>
References: <1537328730-9156-1-git-send-email-aditya@kobol.io>
 <1537328730-9156-2-git-send-email-aditya@kobol.io>
 <20180920072354.GA20392@amd>
Message-ID: <20180920082425.GB20006@makrotopia.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Thu, Sep 20, 2018 at 09:23:54AM +0200, Pavel Machek wrote:
> Hi!
> 
> > +#ifdef CONFIG_ATA_LEDS
> > +	/* register LED triggers for all ports */
> > +	for (i = 0; i < host->n_ports; i++) {
> > +		if (unlikely(!host->ports[i]->ledtrig))
> > +			continue;
> > +
> > +		snprintf(host->ports[i]->ledtrig_name,
> > +			sizeof(host->ports[i]->ledtrig_name), "ata%u",
> > +			host->ports[i]->print_id);
> 
> > +		host->ports[i]->ledtrig->name = host->ports[i]->ledtrig_name;
> > +
> > +		if (led_trigger_register(host->ports[i]->ledtrig)) {
> > +			kfree(host->ports[i]->ledtrig);
> > +			host->ports[i]->ledtrig = NULL;
> > +		}
> > +	}
> > +#endif
> 
> No, we don't want you to register multiple triggers. We want one
> trigger, than has parameter "which port to watch". (Number of triggers
> is limited as by sysfs limitations).

Back then I implemented it that way to be able to define the
default trigger for each LED in device tree and "trigger-sources"
didn't exist yet (it was introduced for USB ports and isn't yet used
for anything other than that)
However, the problem till today is also that ATA ports are often not
individual device-tree objects we can refer to, see for example
marvell,armada-370-sata which appears as one opaque controller. Ie.
all SATA drivers have to be converted to expose individual ports on
device-tree before the trigger-sources approach can be applied...


> 
> Otherwise yes, ata trigger makes sense.
> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
