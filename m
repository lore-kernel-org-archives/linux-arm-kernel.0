From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 10 Oct 2012 10:45:20 +0200
Subject: [PATCH 09/16] pinctrl: exynos: Use one IRQ domain per pin bank
In-Reply-To: <CACRpkdbNHqwt2X-SNRv3=7Ca-WrDERb=t01K7pFuvRzTNk1+4Q@mail.gmail.com>
References: <1349685556-23718-1-git-send-email-t.figa@samsung.com>
 <1349685556-23718-10-git-send-email-t.figa@samsung.com>
 <CACRpkdbNHqwt2X-SNRv3=7Ca-WrDERb=t01K7pFuvRzTNk1+4Q@mail.gmail.com>
Message-ID: <3063300.jojsnxbhX8@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 of October 2012 09:40:16 Linus Walleij wrote:
> On Mon, Oct 8, 2012 at 10:39 AM, Tomasz Figa <t.figa@samsung.com> wrote:
> > Instead of registering one IRQ domain for all pin banks of a pin
> > controller, this patch implements registration of per-bank domains.
> > 
> > At a cost of a little memory overhead (~2.5KiB for all GPIO interrupts
> > of Exynos4x12) it simplifies driver code and device tree sources,
> > because GPIO interrupts can be now specified per banks.
> > 
> > Example:
> >         device {
> >         
> >                 /* ... */
> >                 interrupt-parent = <&gpa1>;
> >                 interrupts = <3 0>;
> >                 /* ... */
> >         
> >         };
> > 
> > Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> 
> This looks like a very good patch!
> Can it be applied in isolation from the other patches?

This is heavily dependent on previous patches, because each pin bank must 
have its own node that can be bound to the IRQ domain and used as an 
interrupt-controller in interrupt-parent property.

I can imagine kind of hybrid solution, where bank nodes contain almost no 
data, other than gpio-controller, interrupt-controller and #*-cells 
properties, but this would introduce the need of matching bank nodes with 
banks statically defined in the driver.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
