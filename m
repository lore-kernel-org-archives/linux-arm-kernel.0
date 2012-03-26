From: rajanikanth.hv@stericsson.com (Rajanikanth H V)
Date: Mon, 26 Mar 2012 11:07:39 +0200
Subject: [PATCH] serial: pl011: implement workaround for CTS clear	event
 issue
In-Reply-To: <20120326081756.GI5611@n2100.arm.linux.org.uk>
References: <1332748868-10172-1-git-send-email-linus.walleij@stericsson.com>
 <20120326081756.GI5611@n2100.arm.linux.org.uk>
Message-ID: <2B1D156D95AE9B4EAD379CB9E465FE73255E4BB903@EXDCVYMBSTM005.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

As per my understanding, pass counter helps to identify/break the 
Deadlock situation and triggers bottom half handler in which
Uart controller will be forced to reset (save and restore of UART register happens).

It has been found from hardware analysis that race condition(explained in my commit message)
was causing the situation to persist (i.e. CTS ack was not happening in spite of W1C),
hence, assuming UART controller in deadlock state is wrong.


Thanks,
Rajanikanth

-----Original Message-----
From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
Sent: Monday, March 26, 2012 1:48 PM
To: Linus WALLEIJ
Cc: Greg Kroah-Hartman; linux-serial at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Christophe ARNAL; Guillaume JAUNET; Matthias LOCHER; Chanho Min; Linus Walleij; Rajanikanth H V
Subject: Re: [PATCH] serial: pl011: implement workaround for CTS clear event issue

On Mon, Mar 26, 2012 at 10:01:08AM +0200, Linus Walleij wrote:
> -	unsigned int status, pass_counter = AMBA_ISR_PASS_LIMIT;
> +	unsigned int status;

Why are you removing the pass counter and associated code, which was
there before your work-around patch was applied?
