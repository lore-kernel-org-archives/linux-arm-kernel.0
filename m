From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 16 Feb 2012 06:23:50 -0700
Subject: [PATCH v5 08/27] irq_domain: Move irq_domain code from powerpc to
 kernel/irq
In-Reply-To: <1329383368-12122-9-git-send-email-grant.likely@secretlab.ca>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-9-git-send-email-grant.likely@secretlab.ca>
Message-ID: <CACxGe6sKzDzxKUxs2ZVNpf07bzaJSsJ8m+3mdPkU+4mf3EajdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 2:09 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> This patch only moves the code. ?It doesn't make any changes, and the
> code is still only compiled for powerpc. ?Follow-on patches will generalize
> the code for other architectures.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Milton Miller <miltonm@bga.com>
> Tested-by: Olof Johansson <olof@lixom.net>
> ---
> +unsigned int irq_find_mapping(struct irq_domain *host,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? irq_hw_number_t hwirq)
> +{
> + ? ? ? unsigned int i;
> + ? ? ? unsigned int hint = hwirq % irq_virq_count;
> +
> + ? ? ? /* Look for default host if nececssary */
> + ? ? ? if (host == NULL)
> + ? ? ? ? ? ? ? host = irq_default_host;
> + ? ? ? if (host == NULL)
> + ? ? ? ? ? ? ? return NO_IRQ;
> +
> + ? ? ? /* legacy -> bail early */
> + ? ? ? if (host->revmap_type == IRQ_DOMAIN_MAP_LEGACY)
> + ? ? ? ? ? ? ? return hwirq;
> +
> + ? ? ? /* Slow path does a linear search of the map */
> + ? ? ? if (hint == 0)
> + ? ? ? ? ? ? ? hint = 1;
> + ? ? ? i = hint;
> + ? ? ? do {
> + ? ? ? ? ? ? ? struct irq_data *data = irq_get_irq_data(i);
> + ? ? ? ? ? ? ? if (data && (data->domain == host) && (data->hwirq == hwirq))
> + ? ? ? ? ? ? ? ? ? ? ? return i;
> + ? ? ? ? ? ? ? i++;
> + ? ? ? ? ? ? ? if (i >= irq_virq_count)
> + ? ? ? ? ? ? ? ? ? ? ? i = 1

Typo on this line; missing semicolon.  Fixed in my tree now.

g.
