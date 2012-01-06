From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 6 Jan 2012 14:34:22 -0700
Subject: [PATCH] irqdomain: Initialize number of IRQs for simple domains
In-Reply-To: <20120106162016.GB5593@avionic-0098.mockup.avionic-design.de>
References: <1325860112-22051-1-git-send-email-thierry.reding@avionic-design.de>
 <CACxGe6sXmC2A0ihsK=rmQ8jQ61xcc7re=LgzPPJm8wHvvkFb4Q@mail.gmail.com>
 <20120106162016.GB5593@avionic-0098.mockup.avionic-design.de>
Message-ID: <20120106213422.GF7457@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2012 at 05:20:16PM +0100, Thierry Reding wrote:
> * Grant Likely wrote:
> > Hi Thierry,
> > 
> > On Fri, Jan 6, 2012 at 7:28 AM, Thierry Reding
> > <thierry.reding@avionic-design.de> wrote:
> > > The irq_domain_add() function needs the number of interrupts in the
> > > domain to properly initialize them. In addition the allocated domain
> > > is now returned by the irq_domain_{add,generate}_simple() helpers.
> > 
> > The commit text should also include the justification for renaming
> > irq_domain_create_simple() -> irq_domain_add_simple()
> 
> Actually the commit only fixes up the comment. The function has always been
> called irq_domain_add_simple().
> 
> For reference, this was introduced in commit 7e71330.

Hahaha.  Oops, you're right.  :-)

> 
> > > ? ? ? ?domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> > > - ? ? ? if (!domain) {
> > > - ? ? ? ? ? ? ? WARN_ON(1);
> > > - ? ? ? ? ? ? ? return;
> > > - ? ? ? }
> > > + ? ? ? if (!domain)
> > > + ? ? ? ? ? ? ? return ERR_PTR(-ENOMEM);
> > 
> > Don't use the ERR_PTR() pattern (it's a horrible pattern IMHO).
> 
> Returning NULL here is probably okay. Can the ERR_PTR stay in
> irq_domain_generate_simple(), though? It has two error conditions and
> handling both by returning NULL may not be what we want.

No.  ERR_PTR is a horrible pattern because you cannot tell by looking
at a prototype that returns a pointer whether or not the correct
failure test is "if (!ptr)" or "if (IS_ERR(ptr))".  Unless it is
absolutely critical for an error code to be returned (which isn't the
case here) I will not accept new code that uses ERR_PTR().

In this case, if irq_domain_add_simple() fails, then something is very
wrong.  I'd much rather the routine complain loudly regardless of the
error condition.

Actually, looking again at irq_domain_generate_simple() it should
probably succeed even if it cannot find a matching node since an
irq_domain does more than just device tree translation.  Although,
irq_domain_generate_simple() is a stop-gap solution that will
eventually be removed.

g.
