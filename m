From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 6 Jan 2012 17:20:16 +0100
Subject: [PATCH] irqdomain: Initialize number of IRQs for simple domains
In-Reply-To: <CACxGe6sXmC2A0ihsK=rmQ8jQ61xcc7re=LgzPPJm8wHvvkFb4Q@mail.gmail.com>
References: <1325860112-22051-1-git-send-email-thierry.reding@avionic-design.de>
 <CACxGe6sXmC2A0ihsK=rmQ8jQ61xcc7re=LgzPPJm8wHvvkFb4Q@mail.gmail.com>
Message-ID: <20120106162016.GB5593@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grant Likely wrote:
> Hi Thierry,
> 
> On Fri, Jan 6, 2012 at 7:28 AM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > The irq_domain_add() function needs the number of interrupts in the
> > domain to properly initialize them. In addition the allocated domain
> > is now returned by the irq_domain_{add,generate}_simple() helpers.
> 
> The commit text should also include the justification for renaming
> irq_domain_create_simple() -> irq_domain_add_simple()

Actually the commit only fixes up the comment. The function has always been
called irq_domain_add_simple().

For reference, this was introduced in commit 7e71330.

> > ? ? ? ?domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> > - ? ? ? if (!domain) {
> > - ? ? ? ? ? ? ? WARN_ON(1);
> > - ? ? ? ? ? ? ? return;
> > - ? ? ? }
> > + ? ? ? if (!domain)
> > + ? ? ? ? ? ? ? return ERR_PTR(-ENOMEM);
> 
> Don't use the ERR_PTR() pattern (it's a horrible pattern IMHO).

Returning NULL here is probably okay. Can the ERR_PTR stay in
irq_domain_generate_simple(), though? It has two error conditions and
handling both by returning NULL may not be what we want.

> Return NULL on failure and keep the WARN_ON() in this function.
> Otherwise looks good.  Thanks for writing this patch.

I thought it would be better to pull the WARN_ON out of the function because
we now actually have a way to determine if the call succeeded in the caller.
In most cases I assume the caller will be much better suited to handle the
situation gracefully such that the WARN_ON is not required.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120106/2aac3dfa/attachment.sig>
