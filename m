From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Nov 2013 13:56:39 +0000
Subject: [PATCH v5 3/7] gpio: davinci: use irqdomain
In-Reply-To: <CACRpkdaJg4wqtD5xhPVrHJHxFoVwau6jidbOuQ9xFSK_6drxPQ@mail.gmail.com>
References: <1383905510-31760-1-git-send-email-prabhakar.csengg@gmail.com>
 <1383905510-31760-4-git-send-email-prabhakar.csengg@gmail.com>
 <CACRpkdaJg4wqtD5xhPVrHJHxFoVwau6jidbOuQ9xFSK_6drxPQ@mail.gmail.com>
Message-ID: <20131118135639.GD16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 02:11:32PM +0100, Linus Walleij wrote:
> On Fri, Nov 8, 2013 at 11:11 AM, Prabhakar Lad
> <prabhakar.csengg@gmail.com> wrote:
> 
> > From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
> >
> > This patch converts the davinci gpio driver to use irqdomain
> > support.
> >
> > Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> 
> (...)
> > @@ -282,8 +283,7 @@ gpio_irq_handler(unsigned irq, struct irq_desc *desc)
> >         desc->irq_data.chip->irq_ack(&desc->irq_data);
> >         while (1) {
> >                 u32             status;
> > -               int             n;
> > -               int             res;
> > +               int             bit;
> 
> Why is this an int? I think u8 would suffice.

For local variables, it's better to use "int" or even "unsigned" here
rather than u8.  u8 tells the compiler that you want the variable to be
8-bit, which seems fine, except the compiler is then at liberty to keep
on masking the register back down to 8-bit.
