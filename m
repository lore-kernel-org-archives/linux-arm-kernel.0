From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Wed, 22 Jun 2011 20:46:48 +0200
Subject: [PATCH] Fix CPU spinlock lockups on secondary CPU bringup
In-Reply-To: <20110622105550.GQ23234@n2100.arm.linux.org.uk>
References: <20110622105550.GQ23234@n2100.arm.linux.org.uk>
Message-ID: <1308768408.2268.2.camel@edumazet-HP-Compaq-6005-Pro-SFF-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mercredi 22 juin 2011 ? 11:55 +0100, Russell King - ARM Linux a
?crit :
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Secondary CPU bringup typically calls calibrate_delay() during its
> initialization.  However, calibrate_delay() modifies a global variable
> (loops_per_jiffy) used for udelay() and __delay().
> 
> A side effect of 71c696b1 (calibrate: extract fall-back calculation
> into own helper) introduced in the 2.6.39 merge window means that we
> end up with a substantial period where loops_per_jiffy is zero.  This
> causes the spinlock debugging code to malfunction:
...

>  
> +	loops_per_jiffy = lpj;
>  	printed = true;
>  }

To be 100% safe, I would use

	ACCESS_ONCE(loops_per_jiffy) = lpj;

But I assume no current gcc would be that stupid ;)
