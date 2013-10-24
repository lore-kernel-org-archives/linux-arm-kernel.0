From: joe@perches.com (Joe Perches)
Date: Thu, 24 Oct 2013 11:43:38 -0700
Subject: [PATCH 4/8] input: Remove OOM message after input_allocate_device
In-Reply-To: <20131024182611.GA3512@pengutronix.de>
References: <cover.1382555436.git.joe@perches.com>
 <cc5e6a317bc9ef33cfdfae3ed9d3a47b5319a47b.1382555436.git.joe@perches.com>
 <20131024182611.GA3512@pengutronix.de>
Message-ID: <1382640218.22433.71.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-10-24 at 20:26 +0200, Uwe Kleine-K?nig wrote:
> Hello Joe,
> 
> On Wed, Oct 23, 2013 at 12:14:50PM -0700, Joe Perches wrote:
> > Emitting an OOM message isn't necessary after input_allocate_device
> > as there's a generic OOM and a dump_stack already done.
> > 
> > [...]
> > Signed-off-by: Joe Perches <joe@perches.com>
> > diff --git a/drivers/input/joystick/as5011.c b/drivers/input/joystick/as5011.c
> > index 005d852..3b9c709 100644
> > --- a/drivers/input/joystick/as5011.c
> > +++ b/drivers/input/joystick/as5011.c
> > @@ -254,8 +254,6 @@ static int as5011_probe(struct i2c_client *client,
> >  	as5011 = kmalloc(sizeof(struct as5011_device), GFP_KERNEL);
> >  	input_dev = input_allocate_device();
> >  	if (!as5011 || !input_dev) {
> > -		dev_err(&client->dev,
> > -			"Can't allocate memory for device structure\n");
> Don't know if that can happen, but if as5011 is NULL but input_dev isn't
> the message would still be sensible, wouldn't it? There are several more
> that suffer the same "problem".

Any k.alloc without __GFP_NOWARN does a generic OOM message
and a dump_stack() so there could already be 2 messages anyway.

cheers, Joe
