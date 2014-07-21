From: gnurou@gmail.com (Alexandre Courbot)
Date: Mon, 21 Jul 2014 12:36:43 +0900
Subject: [alsa-devel] [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
 registration
In-Reply-To: <20140717110540.GS17528@sirena.org.uk>
References: <CAAVeFuLfgG6W1qK2ATTbq_ydEOjUuM8Wvftm6N1RK3Kz_y1zHg@mail.gmail.com>
 <20140716071237.GA7978@ulmo>
 <CAAVeFuJEjMBX+7vsLk5zXV5Moy=WDmWidpVZjQ_=8VD45+QdHg@mail.gmail.com>
 <20140716075107.GG7978@ulmo> <53C63CBA.20809@codethink.co.uk>
 <CAAVeFuK55XzwaU+eOWhfUxJ7wEwGqxRCPDZKf+gVeMgeV8ys6g@mail.gmail.com>
 <20140717074444.GB18640@ulmo>
 <CAAVeFuJQUA+92jGpgDkyQ+=Qu+okBHzS5aFi7gmdwh+qcFp3fg@mail.gmail.com>
 <20140717101723.GR17528@sirena.org.uk> <20140717104121.GF17877@ulmo>
 <20140717110540.GS17528@sirena.org.uk>
Message-ID: <CAAVeFuKQuvTH=5U8chZeMNLjCkfo78+_r2Gx5WUfy+q3F4QZpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 8:05 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Jul 17, 2014 at 12:41:23PM +0200, Thierry Reding wrote:
>> On Thu, Jul 17, 2014 at 11:17:23AM +0100, Mark Brown wrote:
>
>> > Not so sure about that - what about requesting GPIOs for a bidirectional
>> > bus?  Thinking about SPI bitbanging here.
>
>> Wouldn't you want to use a different means that the gpiod_array_*() API
>> to handle those cases? gpiod_array_*() is probably most useful to handle
>> bulk operations on a set of GPIOs that do essentially the same thing. If
>> you get and then need to index into that array to handle them all
>> differently then you don't gain very much.
>
> For set and get, sure - but it's still useful to be able to do bulk
> requests for GPIOs especially since that's the only bit of the interface
> that requires error handling.

I foresee many problems if people start using gpiod_array_get() as a
way to spare a few lines of error-checking code. First all the GPIOs
would end into an array instead of members with meaningful names -
unless they are moved later on, but doing so would add extra code and
somewhat kill the purpose. It also becomes more difficult to maintain
as you are dealing with array indexes to update all over the code.
Finally, it will make it more difficult to use gpiod_array_*() the way
it is intended to be used, as you would have to discriminate between
GPIOs of the same function and the rest by yourself.

Also, if such a convenience function is legitimate for GPIO, shouldn't
it also apply to other sub-systems? E.g. regulator_array_get()?

Maybe I am missing your point, but I still think some error-handling
code really doesn't hurt here, and the few drivers that would actually
benefit from a more automated GPIO request error handling can easily
implement it themselves. Let's keep gpiod_array_*() single-purposed
and to the point.
