From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 27 Oct 2013 12:47:53 +0100
Subject: [PATCHv2 1/3] Input: twl4030-keypad - add device tree support
In-Reply-To: <20131027114026.GB14091@earth.universe>
References: <1382446042-27099-1-git-send-email-sre@debian.org>
 <1382446042-27099-2-git-send-email-sre@debian.org>
 <20131027111715.GA2437@xo-6d-61-c0.localdomain>
 <20131027114026.GB14091@earth.universe>
Message-ID: <20131027114753.GB14901@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > + * keypad,num-rows and keypad,num-columns are required.
> > Is "keypad," prefix neccessary here?
> 
> See Documentation/devicetree/bindings/input/matrix-keymap.txt
> 
> > > +Optional Properties specific to linux:
> > > +- linux,keypad-no-autorepeat: do no enable autorepeat feature.
> > 
> > "do not autorepeat". Plus I do not see what is Linux specifc about not
> > autorepeating... Other systems will likely know about autorepeat, too.
> 
> This property has already been used like this for
> samsung-keypad, stmpe-keypad, omap-keypad and
> gpio-matrix-keypad.

Ok. But you still have a typo. "do no enable" => "do not enable".

> > > +#if IS_ENABLED(CONFIG_OF)
> > I'm probably missing something here, but why not #ifdef CONFIG_OF?
> 
> I have been told for other drivers, that IS_ENABLED() is
> the prefered way to check for configuration these days.

CONFIG_OF can not be module, using IS_ENABLED() on it is just wrong.

> > > @@ -381,7 +426,7 @@ static int twl4030_kp_probe(struct platform_device *pdev)
> > >  
> > >  	input_set_capability(input, EV_MSC, MSC_SCAN);
> > >  	/* Enable auto repeat feature of Linux input subsystem */
> > > -	if (pdata->rep)
> > > +	if (!kp->no_autorepeat)
> > >  		__set_bit(EV_REP, input->evbit);
> > >
> > 
> > Double negation is nasty to read. I believe code would be more
> > readable if you switched logic to kp->autorepeat.
> 
> I was thinking about the same when writing it, but decided
> against it, since it will just move the double negation to
> the variable initialization.

Well, the property should be linux,keypad-autorepeat in the first
place, but it is too late to change that.

Thanks,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
