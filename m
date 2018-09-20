From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 20 Sep 2018 09:23:54 +0200
Subject: [PATCH 1/2] libata: add ledtrig support
In-Reply-To: <1537328730-9156-2-git-send-email-aditya@kobol.io>
References: <1537328730-9156-1-git-send-email-aditya@kobol.io>
 <1537328730-9156-2-git-send-email-aditya@kobol.io>
Message-ID: <20180920072354.GA20392@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> +#ifdef CONFIG_ATA_LEDS
> +	/* register LED triggers for all ports */
> +	for (i = 0; i < host->n_ports; i++) {
> +		if (unlikely(!host->ports[i]->ledtrig))
> +			continue;
> +
> +		snprintf(host->ports[i]->ledtrig_name,
> +			sizeof(host->ports[i]->ledtrig_name), "ata%u",
> +			host->ports[i]->print_id);

> +		host->ports[i]->ledtrig->name = host->ports[i]->ledtrig_name;
> +
> +		if (led_trigger_register(host->ports[i]->ledtrig)) {
> +			kfree(host->ports[i]->ledtrig);
> +			host->ports[i]->ledtrig = NULL;
> +		}
> +	}
> +#endif

No, we don't want you to register multiple triggers. We want one
trigger, than has parameter "which port to watch". (Number of triggers
is limited as by sysfs limitations).

Otherwise yes, ata trigger makes sense.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180920/35ad8ce6/attachment.sig>
