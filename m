From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 2 Dec 2011 14:30:42 +0000
Subject: [PATCH] irqdomain: protect macro variable in domain iterators
In-Reply-To: <4ED8D7FE.1000205@gmail.com>
References: <1322833997-32083-1-git-send-email-nicolas.ferre@atmel.com>
 <20111202125932.GB2892@localhost.localdomain>
 <4ED8D7FE.1000205@gmail.com>
Message-ID: <20111202143042.GE2892@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2011 at 07:51:58AM -0600, Rob Herring wrote:
> On 12/02/2011 06:59 AM, Dave Martin wrote:
> > On Fri, Dec 02, 2011 at 02:53:17PM +0100, Nicolas Ferre wrote:
> >> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> >> ---
> >> Error found while using those iterators in an irq controller
> >> initialization function.
> >>
> >> May also need protection around irq and hwirq macro variables
> >> but those values are usually plain "int" anyway... Tell me if you
> >> feel that it should be done.
> >>
> >>  include/linux/irqdomain.h |    8 ++++----
> >>  1 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> >> index 99834e58..a553004 100644
> >> --- a/include/linux/irqdomain.h
> >> +++ b/include/linux/irqdomain.h
> >> @@ -82,12 +82,12 @@ static inline unsigned int irq_domain_to_irq(struct irq_domain *d,
> >>  }
> >>  
> >>  #define irq_domain_for_each_hwirq(d, hw) \
> >> -	for (hw = d->hwirq_base; hw < d->hwirq_base + d->nr_irq; hw++)
> >> +	for (hw = (d)->hwirq_base; hw < (d)->hwirq_base + (d)->nr_irq; hw++)
> >>  
> >>  #define irq_domain_for_each_irq(d, hw, irq) \
> >> -	for (hw = d->hwirq_base, irq = irq_domain_to_irq(d, hw); \
> >> -	     hw < d->hwirq_base + d->nr_irq; \
> >> -	     hw++, irq = irq_domain_to_irq(d, hw))
> >> +	for (hw = (d)->hwirq_base, irq = irq_domain_to_irq((d), hw); \
> >> +	     hw < (d)->hwirq_base + (d)->nr_irq; \
> >> +	     hw++, irq = irq_domain_to_irq((d), hw))
> > 
> > I suggest just putting all the brackets in -- if having spotted this
> > problem you only half-fix the macros, an opportunity is being missed;
> > someone have to come and fix it again later:
> > 
> > 
> > #define irq_domain_for_each_hwirq(d, hw) \
> > 	for ((hw) = (d)->hwirq_base; (hw) < (d)->hwirq_base + (d)->nr_irq; (hw)++)
> > 
> > #define irq_domain_for_each_irq(d, hw, irq) \
> > 	for ((hw) = (d)->hwirq_base, (irq) = irq_domain_to_irq(d, hw); \
> > 	     (hw) < (d)->hwirq_base + (d)->nr_irq; \
> > 	     (hw)++, (irq) = irq_domain_to_irq(d, hw))
> > 
> 
> Parameters on the left side of an '=' can't be a complex expression.
> Look at other iterator macros.

Do you mean "can't" or "shouldn't, by policy"?  I don't see a statement of
the policy, but feel free to point me at it if it exists.

An arbitrarily complex expression can appear on the left size of a C
assignment, providing that it is an lvalue of an appropriate type; though
if it involves things like casts or ?: we would rapidly get into ill-
advised obfuscated code territory.


The most plausible use I can think of it something like:

int do_something(type *result, args)
{
	widget w;
	/* ... */

	widget_for_each_whatever(*result, w) {
		/* do stuff */
	}

	/* ... */
}

I don't comment on whether this is a good idea, but from the language
point of view it is perfectly reasonable.

(Note that *result = something parses how we want, but *result++, if
generated in the macro expansion, will not)


You're right that this won't work with at least some of the existing
macros, but my view is if that if a macro can be made trivially correct,
without pitfalls, that you should do it.  As a general principle, this
helps to avoid latent bugs in the code.  I don't think we should have
a special-case rule because this is a certain special flavour of macro,
unless implementing the macro robustly becomes impossible.


Just my opinion, though -- if people want it the other way, then I don't
have a serious problem with that.

Cheers
---Dave
