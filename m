From: amstan@chromium.org (Alexandru Stan)
Date: Wed, 10 Dec 2014 17:08:37 -0800
Subject: [PATCH 1/4] regulator: core: Support trying to get close to a
 certain voltage
In-Reply-To: <20141210235347.GT11764@sirena.org.uk>
References: <1418245085-9754-1-git-send-email-dianders@chromium.org>
 <20141210235347.GT11764@sirena.org.uk>
Message-ID: <CAHNYxRy2t0OVj-+CqQFOfj0zWAGG0j8rmd8SxdNWgBMA2iAfXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The spec is from 1.7V to 1.95V, with 1.8V being ideal. It's not that
symmetric. But let's say that 0.1V is fine for tolerance(so 1.7-1.9V)

regulator_set_voltage_tol looks interesting, but i still think it's
not the appropriate thing to use in this case.

Imagine a board has a 1V-1.79 V regulator, we tell it to
regulator_set_voltage_tol(1800000,100000). It will try the 1.8V-1.9V
range, when it sees that it can't it'll fallback to 1.7V - 1.9V, and
it will just be lazy and pick the lowest of the range again:
1.7V(causing voltage drop issues because we're exactly at the minimum
of the spec). The correct voltage would be 1.79V

It's unfortunate that regulator_set_voltage was designed to always
pick the lowest voltage in that range. I understand that it's a power
efficiency thing, but it's not ideal in cases like this.

Alexandru Stan (amstan)


On Wed, Dec 10, 2014 at 3:53 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Dec 10, 2014 at 12:58:02PM -0800, Doug Anderson wrote:
>> There are some cases where you'd like to set a voltage for a regulator
>> and a range of voltages are OK, but you'd really like to get as close
>> as you can to a specific voltage if at all possible.
>
> This looks like regulator_set_voltage_tol(), why not use that?  The spec
> probably even has a number for the tolerance, or you can make one up.
