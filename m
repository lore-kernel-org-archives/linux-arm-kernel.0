From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 27 Nov 2013 13:55:47 +0000
Subject: [PATCH 1/3] mfd: tps6586x: add version detection
In-Reply-To: <cd69295e946b48451f449eacc02efa4a@agner.ch>
References: <cover.1385508112.git.stefan@agner.ch>
 <ef881d39f78b75b4badeebb5be0264edc3906d86.1385508112.git.stefan@agner.ch>
 <20131127130954.GF3296@lee--X1>
 <cd69295e946b48451f449eacc02efa4a@agner.ch>
Message-ID: <20131127135547.GK3296@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>  	if (ret < 0) {
> >>  		dev_err(&client->dev, "Chip ID read failed: %d\n", ret);
> >>  		return -EIO;
> > 
> > Why are you returning an error here when you have a valid enum of:
> >   TPS6586X_ANY	= -1,
> > 
> Hm, when the device is not answering on that request, the probe method
> should fail I would say. This means that the device is missing most
> likely. However, I should set the device version to TPS6586X_ANY if I
> happen to end up in the default case.

I would say that returning an error is the sound thing to do, but I'm
missing the point of TPS6586X_ANY, as it doesn't appear to be used in
this context.

> >>  	}
> >>
> >> -	dev_info(&client->dev, "VERSIONCRC is %02x\n", ret);
> >> -
> >> -	tps6586x = devm_kzalloc(&client->dev, sizeof(*tps6586x), GFP_KERNEL);
> >> -	if (tps6586x == NULL) {
> >> -		dev_err(&client->dev, "memory for tps6586x alloc failed\n");
> >> -		return -ENOMEM;
> >> +	tps6586x->version = (enum tps6586x_version)ret;
> >> +	switch (ret) {
> >> +	case TPS658621A:
> >> +		name = "TPS658621A";
> >> +		break;
> >> +	case TPS658621CD:
> >> +		name = "TPS658621C/D";
> >> +		break;
> >> +	case TPS658623:
> >> +		name = "TPS658623";
> >> +		break;
> >> +	case TPS658643:
> >> +		name = "TPS658643";
> >> +		break;
> >> +	default:
> >> +		name = "TPS6586X";
> >> +		break;
> >>  	}
> >>
> >> +	dev_info(&client->dev, "Found %s, VERSIONCRC is %02x\n", name, ret);
> >> +
> > 
> > I'd suggest pulling this out of probe() and into a separate subroutine.
> > 
> > <snip>
> Since I will alter the version when I end up in the default case in my
> next patch, would you still do a separate subroutine? I think its
> somewhat heavily coupled to the probe function.
> 
> Sorry missing you on the CC, will do next time :-)

It's not that it's unrelated, it's just a whole bulk of code which is
essentially featureless. 17 lines of code just to have the name of the
device in the bootlog. For that reason I'd like to see this abstracted
from (the useful stuff in) probe() please.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
