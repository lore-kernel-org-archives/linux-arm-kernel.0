From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Wed, 27 Jan 2010 13:14:12 +0100
Subject: [PATCH v3] input: MXC: add mxc-keypad driver to support the
	Keypad Port present in the mxc application processors family.
In-Reply-To: <19296.5728.557535.920849@ipc1.ka-ro>
References: <1264586106.2463.23.camel@realization>
	<19296.5728.557535.920849@ipc1.ka-ro>
Message-ID: <1264594452.2463.62.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

On mer, 2010-01-27 at 11:33 +0100, Lothar Wa?mann wrote:
> Hi,
> 
> Alberto Panizzo writes:
> [...]
> > +#include <linux/input/matrix_keypad.h>
> > +
> > +#define MAX_MATRIX_KEY_ROWS	(8)
> > +#define MAX_MATRIX_KEY_COLS	(8)
> > +#define MATRIX_ROW_SHIFT	(3)
> > +
> pointless '()'

Ok.

> > [...]
> > +
> > +	/* Configure columns as output, rows as input (KDDR[15:0]) */
> > +	reg_val = readw(keypad->mmio_base + KDDR);
> > +	reg_val |= 0xff00;
> > +	reg_val &= 0xff00;
> >
> This is effectively the same as: 'reg_val = 0xff00;' which makes the
> readw() above pointless. Was this really intended?
> 
> > +	writew(reg_val, keypad->mmio_base + KDDR);

Yes, it should be instead:
	writew(0xff00, keypad->mmio_base + KDDR);


> > [...]
> > +	/* Sanity control, not all the rows must be to 0s now. */
> > +	if ((readw(keypad->mmio_base + KPDR) & keypad->rows_en_mask) == 0) {
> > +		dev_err(&dev->dev, "Too much keys pressed for now, "
> > +				"control pins initialisation\n");
> >
> It helps grepping for a message, if it is not split into multiple
> lines.

Ok.

> 
> > [...]
> > +
> > +	irq = platform_get_irq(pdev, 0);
> > +	if (irq < 0) {
> > +		dev_err(&pdev->dev, "failed to get keypad irq\n");
> > +		return -ENXIO;
> > +	}
> >
> This should be -ENODEV.
> 
Lot of reference keyboard driver use -ENXIO..
May should be better: return irq ?

> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (res == NULL) {
> > +		dev_err(&pdev->dev, "failed to get I/O memory\n");
> > +		return -ENXIO;
> >
> same as above.

same as above?


> > +
> > +	keypad->pdata = pdata;
> > +	keypad->input_dev = input_dev;
> > +	keypad->irq = irq;
> > +
> > +	keypad->mmio_base = ioremap(res->start, resource_size(res));
> > +	if (keypad->mmio_base == NULL) {
> > +		dev_err(&pdev->dev, "failed to remap I/O memory\n");
> > +		error = -ENXIO;
> >
> -ENOMEM;

Ok.
> 
> > +		goto failed_free_priv;
> > +	}
> > +
> > +	keypad->clk = clk_get(NULL, "kpp");
> >
> clk_get(&pdev->dev, "kpp");
> 
Ok.

Alberto!
