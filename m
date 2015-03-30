From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 30 Mar 2015 08:08:29 +0100
Subject: [PATCH 1/2] input: keypad: tc3589x: localize platform data
In-Reply-To: <20150327164744.GA17364@dtor-ws>
References: <1426776765-18812-1-git-send-email-linus.walleij@linaro.org>
 <1426776765-18812-2-git-send-email-linus.walleij@linaro.org>
 <20150319163856.GF30732@dtor-ws> <20150327164744.GA17364@dtor-ws>
Message-ID: <20150330070829.GC457@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Mar 2015, Dmitry Torokhov wrote:

> On Thu, Mar 19, 2015 at 09:38:56AM -0700, Dmitry Torokhov wrote:
> > Hi Linus,
> > 
> > On Thu, Mar 19, 2015 at 03:52:44PM +0100, Linus Walleij wrote:
> > > This driver can only get its platform data from the device tree,
> > > and all platforms using it does that. Localize the platform data
> > > for the keypad. A later patch will enforce the device tree / OF
> > > dependence.
> > > 
> > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Cc: Lee Jones <lee.jones@linaro.org>
> > > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > > ---
> > > Dmitry it would be great if you could ACK this patch so Lee can
> > > take it with the other patch through MFD.
> > 
> > It looks like if you are making this OF-only you can get rid of pdata
> > altogether and parse the OF data directly into the keypad. But that can
> > be done later.
> > 
> > Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Hmm, just noticed an issue:
> 
> > >  
> > >  	keypad = kzalloc(sizeof(struct tc_keypad), GFP_KERNEL);
> > > +	keypad->board = tc3589x_keypad_of_probe(&pdev->dev);
> > > +	if (IS_ERR(keypad->board)) {
> > > +		dev_err(&pdev->dev, "invalid keypad platform data\n");
> > > +		return PTR_ERR(keypad->board);
> > > +	}
> > > +
> > >  	input = input_allocate_device();
> > >  	if (!keypad || !input) {
> > >  		dev_err(&pdev->dev, "failed to allocate keypad memory\n");
> 
> You slid of prasing right in between memory allocation and checking if
> it succeeded, so there is a potential oops and memory leak now.
> 
> I want to commit the version of the patch below, holler if you disagree.
> Note that I reverted much of plat -> board renames to keep the patch
> small.

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
