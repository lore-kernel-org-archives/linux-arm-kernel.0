From: broonie@kernel.org (Mark Brown)
Date: Wed, 5 Feb 2014 18:18:17 +0000
Subject: [PATCH] regulator: core: Make regulator object reflect
 configured voltage
In-Reply-To: <CAJAp7OjB-cJbLpdWo0RFJZefCKcCiKc8KgrjkBobJnddv4MSWA@mail.gmail.com>
References: <1391493268-3242-1-git-send-email-bjorn.andersson@sonymobile.com>
 <20140204110531.GR22609@sirena.org.uk>
 <CAJAp7OjCnJ=P9Gi20=D9gybREiSaqd1CaQ0K=9fGbCzU1gTFLw@mail.gmail.com>
 <20140204181831.GP22609@sirena.org.uk>
 <CAJAp7Ohn3ch2nK_S8j9ieRBzNeyt6OJmumEhRXXykB9RgMJsQg@mail.gmail.com>
 <20140204200018.GZ22609@sirena.org.uk>
 <CAJAp7OjB-cJbLpdWo0RFJZefCKcCiKc8KgrjkBobJnddv4MSWA@mail.gmail.com>
Message-ID: <20140205181817.GG32298@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 10:00:15AM -0800, Bjorn Andersson wrote:
> On Tue, Feb 4, 2014 at 12:00 PM, Mark Brown <broonie@kernel.org> wrote:

> > So we should be changing the code to allow a set_voltage() that sets the
> > voltage to the existing voltage regardless of constraints allowing a
> > change then - that's what the underlying issue is.  Your change wouldn't
> > cover the case where the hardware defualt is being used for example.

> Makes sense, but the only thing we could check for would be if min_uV
> == max_uV == current-voltage. That would work out fine for this use
> case, but do you think it would be good enough?

It should be fine to check for min_uV <= current-voltage <= max_uV
instead if CHANGE_VOLTAGE isn't available, so long as the existing
setting is in the range it's fine.

> The best thing I've come up with then is to add the following check in
> regulator_set_voltage().

> if (min_uV == max_uV && _regulator_get_voltage(rdev) == min_uV)
>     goto out;

> Would this be acceptable? It's achieving the same thing as my patch,
> is more robust and covers the case of setting the voltage to the hw
> default value.

That sort of thing yes, just short circuit out the main logic in this
case.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140205/fda85355/attachment.sig>
