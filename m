From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Wed, 8 Aug 2018 18:30:49 +0200
Subject: [PATCH 03/28] nvmem: add a notifier chain
In-Reply-To: <20180808161353.GF7275@lunn.ch>
References: <20180808153150.23444-1-brgl@bgdev.pl>
 <20180808153150.23444-4-brgl@bgdev.pl>
 <20180808161353.GF7275@lunn.ch>
Message-ID: <CAMpxmJXr60+7mRNf+AQrvSPAxW2hJXCP13rDbmtRfqouKzt3Bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-08-08 18:13 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
> On Wed, Aug 08, 2018 at 05:31:25PM +0200, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Add a blocking notifier chain with two events (add and remove) so that
>> users can get notified about the addition of nvmem devices they're
>> waiting for.
>>
>> We'll use this instead of the at24 setup callback in the mityomapl138
>> board file.
>
> Hi Bartosz
>
> What context is this notifier chain called in?
>
> I did something similar using the i2c notifier to try to work around
> the impending disappearing of the setup callback. But i got lockdep
> splats, because the notifier was called while some locks were being
> held, so it was not possible to register other i2c devices.
>
> The at24 setup callback is done as part of probe, so no important
> locks are held. Are any locks held when this notifier chain is called?
>
> Thanks
>         Andrew

In the case of at24 it would be called from at24_probe() ->
nvmem_register() in process context. Would you mind testing it? Would
be great to see if it works on multiple setups.

Bart
