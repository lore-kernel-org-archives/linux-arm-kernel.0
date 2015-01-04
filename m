From: samuel.thibault@ens-lyon.org (Samuel Thibault)
Date: Mon, 5 Jan 2015 00:45:01 +0100
Subject: [PATCHv5 2/2] INPUT: Introduce generic trigger/LED pairs to
 input LEDs
In-Reply-To: <20150104232838.GA14912@dtor-glaptop>
References: <20141226232116.GA5069@type> <20141226232310.GD5069@type>
 <20150104232838.GA14912@dtor-glaptop>
Message-ID: <20150104234501.GJ25336@type.youpi.perso.aquilenet.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Torokhov, le Sun 04 Jan 2015 15:28:38 -0800, a ?crit :
> I'd rather we did not have a separate config option for this. Do we really need to
> support case where LEDs are disabled?

I don't really mind.

> I'd rather stub it out instead of providing 2 separate code paths.

Ok.

> > +/* LED state change for some keyboard, notify that keyboard.  */
> > +static void perdevice_input_led_set(struct led_classdev *cdev,
> > +			  enum led_brightness brightness)
> > +{
> > +	struct input_dev *dev;
> > +	struct led_classdev *leds;
> > +	int led;
> > +
> > +	dev = cdev->dev->platform_data;
> 
> Umm, platform data is not the best place for storing this. Why not drvdata?

Just because it didn't exist when I wrote the code :)
Ok.

> > +/* A new input device with potential LEDs to connect.  */
> > +int input_led_connect(struct input_dev *dev)
> > +{
> > +	int i, error = -ENOMEM;
> > +	struct led_classdev *leds;
> > +	struct led_trigger *triggers;
> > +
> > +	leds = kcalloc(LED_CNT, sizeof(*leds), GFP_KERNEL);
> > +	if (!leds)
> > +		goto err;
> 
> Why do we allocate all possible led's for every device?

Ah, right, that was making things simpler, but it could be
squeezed.  I'm just afraid of one thing: may dev->ledbit change after
input_register_device?  It seems that at least uinput somehow permits
this.  It then means having to store the number of actually created LEDs
and triggers alongside.

> > +	dev->leds = leds;
> > +
> > +	triggers = kcalloc(LED_CNT, sizeof(*triggers), GFP_KERNEL);
> > +	if (!triggers)
> > +		goto err;
> > +	dev->triggers = triggers;
> 
> Hmm, maybe having per-device triggers is a bit of overkill and we could have
> just "input-numl", "input-capsl", etc.

No, that won't work, notably for evdev access: we have to respect the
per-device semantic.

> > +	/* No issue so far, we can register for real.  */
> > +	for (i = 0; i < LED_CNT; i++)
> > +		if (leds[i].name) {
> > +			led_classdev_register(&dev->dev, &leds[i]);
> > +			leds[i].dev->platform_data = dev;
> > +			led_trigger_register(&triggers[i]);
> 
> We need error handling here.

Right.

Samuel
