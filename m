From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 15 Jun 2014 00:21:22 +0200
Subject: [PATCH V2 2/2] power: twl4030_charger: attempt to power off in
 case of critical events
In-Reply-To: <1401313610-14252-3-git-send-email-nm@ti.com>
References: <1401313610-14252-1-git-send-email-nm@ti.com>
 <1401313610-14252-3-git-send-email-nm@ti.com>
Message-ID: <20140614222122.GA1389@xo-6d-61-c0.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> +	if (irqs2 & TWL4030_ACCHGOV) {
>  		dev_crit(bci->dev, "Ac charger overvoltage\n");
> +		power_off = true;
> +	}
> +
> +	/* Try to shutdown the system */
> +	if (power_off)
> +		orderly_poweroff(true);
>  
>  	return IRQ_HANDLED;
>  }

Userland can make orderly_poweroff take long time, or even forever. (Think disconnected
network with nfsroot).

Should we do something more forceful here? Userland has to handle sudden poweroffs, anyway...

(You could invent new function "give userland 5 seconds to shut system down" if you
really wanted...)

										Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
