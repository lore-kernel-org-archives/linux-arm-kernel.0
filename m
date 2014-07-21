From: broonie@kernel.org (Mark Brown)
Date: Mon, 21 Jul 2014 11:04:12 +0100
Subject: [alsa-devel] [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
 registration
In-Reply-To: <CAAVeFuKQuvTH=5U8chZeMNLjCkfo78+_r2Gx5WUfy+q3F4QZpQ@mail.gmail.com>
References: <CAAVeFuJEjMBX+7vsLk5zXV5Moy=WDmWidpVZjQ_=8VD45+QdHg@mail.gmail.com>
 <20140716075107.GG7978@ulmo> <53C63CBA.20809@codethink.co.uk>
 <CAAVeFuK55XzwaU+eOWhfUxJ7wEwGqxRCPDZKf+gVeMgeV8ys6g@mail.gmail.com>
 <20140717074444.GB18640@ulmo>
 <CAAVeFuJQUA+92jGpgDkyQ+=Qu+okBHzS5aFi7gmdwh+qcFp3fg@mail.gmail.com>
 <20140717101723.GR17528@sirena.org.uk>
 <20140717104121.GF17877@ulmo>
 <20140717110540.GS17528@sirena.org.uk>
 <CAAVeFuKQuvTH=5U8chZeMNLjCkfo78+_r2Gx5WUfy+q3F4QZpQ@mail.gmail.com>
Message-ID: <20140721100412.GT17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 12:36:43PM +0900, Alexandre Courbot wrote:
> On Thu, Jul 17, 2014 at 8:05 PM, Mark Brown <broonie@kernel.org> wrote:

> > For set and get, sure - but it's still useful to be able to do bulk
> > requests for GPIOs especially since that's the only bit of the interface
> > that requires error handling.

> I foresee many problems if people start using gpiod_array_get() as a
> way to spare a few lines of error-checking code. First all the GPIOs
> would end into an array instead of members with meaningful names -
> unless they are moved later on, but doing so would add extra code and
> somewhat kill the purpose. It also becomes more difficult to maintain
> as you are dealing with array indexes to update all over the code.

You just need a few defines for the names, it's not a big deal.

> Finally, it will make it more difficult to use gpiod_array_*() the way
> it is intended to be used, as you would have to discriminate between
> GPIOs of the same function and the rest by yourself.

Yes, you probably shouldn't mix and match here but that's fine.

> Also, if such a convenience function is legitimate for GPIO, shouldn't
> it also apply to other sub-systems? E.g. regulator_array_get()?

It's certainly a totally reasonable and expected way of using
regulator_bulk_get().

> Maybe I am missing your point, but I still think some error-handling
> code really doesn't hurt here, and the few drivers that would actually
> benefit from a more automated GPIO request error handling can easily
> implement it themselves. Let's keep gpiod_array_*() single-purposed
> and to the point.

I'm not sure I see the massive complication TBH - it's not so much about
complexity as it is about reducing the amount of boilerplate that people
need to get right.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140721/ce403552/attachment.sig>
