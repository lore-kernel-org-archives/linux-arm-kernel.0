From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 6 Jan 2012 08:04:28 -0700
Subject: [PATCH] irqdomain: Initialize number of IRQs for simple domains
In-Reply-To: <1325860112-22051-1-git-send-email-thierry.reding@avionic-design.de>
References: <1325860112-22051-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <CACxGe6sXmC2A0ihsK=rmQ8jQ61xcc7re=LgzPPJm8wHvvkFb4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

On Fri, Jan 6, 2012 at 7:28 AM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> The irq_domain_add() function needs the number of interrupts in the
> domain to properly initialize them. In addition the allocated domain
> is now returned by the irq_domain_{add,generate}_simple() helpers.

The commit text should also include the justification for renaming
irq_domain_create_simple() -> irq_domain_add_simple()

>
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> ---
> ?/**
> - * irq_domain_create_simple() - Set up a 'simple' translation range
> + * irq_domain_add_simple() - Set up a 'simple' translation range
> ?*/
> -void irq_domain_add_simple(struct device_node *controller, int irq_base)
> +struct irq_domain *irq_domain_add_simple(struct device_node *controller,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?unsigned int irq_base,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?unsigned int nr_irq)
> ?{
> ? ? ? ?struct irq_domain *domain;
>
> ? ? ? ?domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> - ? ? ? if (!domain) {
> - ? ? ? ? ? ? ? WARN_ON(1);
> - ? ? ? ? ? ? ? return;
> - ? ? ? }
> + ? ? ? if (!domain)
> + ? ? ? ? ? ? ? return ERR_PTR(-ENOMEM);

Don't use the ERR_PTR() pattern (it's a horrible pattern IMHO).
Return NULL on failure and keep the WARN_ON() in this function.
Otherwise looks good.  Thanks for writing this patch.

g.
