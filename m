From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Mar 2013 14:51:55 +0000
Subject: [PATCH 1/2] ARM: irq: Call irqchit_init if no init_irq
 function is specified
In-Reply-To: <51545832.1050504@gmail.com>
References: <1364463704-13692-1-git-send-email-maxime.ripard@free-electrons.com>
 <1364463704-13692-2-git-send-email-maxime.ripard@free-electrons.com>
 <51545832.1050504@gmail.com>
Message-ID: <20130328145155.GB3368@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 28, 2013 at 09:48:18AM -0500, Rob Herring wrote:
> On 03/28/2013 04:41 AM, Maxime Ripard wrote:
> > +	if (machine_desc->init_irq)
> > +		machine_desc->init_irq();
> > +	else
> > +		irqchip_init();
> 
> There needs to be an empty version defined for !OF.

Better:

#ifdef CONFIG_OF
	if (!machine_desc->init_irq)
		irqchip_init();
	else
#endif
		machine_desc->init_irq();

which means we don't even get the test if !OF, and if someone mistakenly
sets this to NULL for a !OF platform, they get to know about it.
