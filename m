From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 17 Jul 2014 12:58:25 +0200
Subject: [alsa-devel] [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
 registration
In-Reply-To: <20140717104121.GF17877@ulmo>
References: <CAAVeFuJRCwSwcEOng2M6s+mWhJT8sUtsh7YGE-hBTGUFWAhtrQ@mail.gmail.com>
 <CAAVeFuLfgG6W1qK2ATTbq_ydEOjUuM8Wvftm6N1RK3Kz_y1zHg@mail.gmail.com>
 <20140716071237.GA7978@ulmo>
 <CAAVeFuJEjMBX+7vsLk5zXV5Moy=WDmWidpVZjQ_=8VD45+QdHg@mail.gmail.com>
 <20140716075107.GG7978@ulmo> <53C63CBA.20809@codethink.co.uk>
 <CAAVeFuK55XzwaU+eOWhfUxJ7wEwGqxRCPDZKf+gVeMgeV8ys6g@mail.gmail.com>
 <20140717074444.GB18640@ulmo>
 <CAAVeFuJQUA+92jGpgDkyQ+=Qu+okBHzS5aFi7gmdwh+qcFp3fg@mail.gmail.com>
 <20140717101723.GR17528@sirena.org.uk> <20140717104121.GF17877@ulmo>
Message-ID: <53C7AC51.6060200@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/17/2014 12:41 PM, Thierry Reding wrote:
> On Thu, Jul 17, 2014 at 11:17:23AM +0100, Mark Brown wrote:
>> On Thu, Jul 17, 2014 at 05:55:36PM +0900, Alexandre Courbot wrote:
>>
>>> Right. It may very well be that a single flag specifier (as opposed to
>>> an array) will be enough for this case. If you need to request some
>>> GPIOs as input and some other as output then they are clearly
>>> different functions and requesting them together would be an abuse of
>>> the API.
>>
>> Not so sure about that - what about requesting GPIOs for a bidirectional
>> bus?  Thinking about SPI bitbanging here.
>
> Wouldn't you want to use a different means that the gpiod_array_*() API
> to handle those cases? gpiod_array_*() is probably most useful to handle
> bulk operations on a set of GPIOs that do essentially the same thing. If
> you get and then need to index into that array to handle them all
> differently then you don't gain very much.

I think the goal of a gpiod_array_* API should be to make requesting 
multiple GPIOs that are used by a driver as convenient as possible and at 
the same time reduce the amount of boiler plate code necessary. E.g compare

gpios[0] = gpio_get(...);
if (IS_ERR(gpios[0])) {
	ret = PTR_ERR(gpios[0]);
	goto cleanup;
}

gpios[1] = gpio_get(...);
if (IS_ERR(gpios[1])) {
	ret = PTR_ERR(gpios[1]);
	goto cleanup;
}

gpios[2] = gpio_get(...);
if (IS_ERR(gpios[2])) {
	ret = PTR_ERR(gpioss[2]);
	goto cleanup;
}

with

ret = gpio_array_get(..., gpios);
if (ret)
	goto err_cleanup;

- Lars
