From: dianders@chromium.org (Doug Anderson)
Date: Wed, 30 May 2018 09:06:16 -0700
Subject: [PATCH v3 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
In-Reply-To: <20180530154849.GQ6920@sirena.org.uk>
References: <20180523082908.GB4828@sirena.org.uk>
 <CAD=FV=XfPkpGD32MfTfcw02wQ+QetpUhY=P299uhpX6pY_iEvg@mail.gmail.com>
 <20180523154057.GL4828@sirena.org.uk>
 <CAD=FV=XWVOdJ8rWJnBTwoNqnYqYRYjknkZtUvT86+skbrTdwig@mail.gmail.com>
 <20180523155617.GN4828@sirena.org.uk>
 <CAD=FV=W4aDxWbcaJ9GZ1KkvyiTPAPR-oUoTFzJfS+LftU5ZP=Q@mail.gmail.com>
 <20180530093701.GD6920@sirena.org.uk>
 <CAD=FV=W-MLU9c-SvfLgKAKGP1eHN5xO-013f2M09XUa+QeHzrA@mail.gmail.com>
 <20180530150241.GO6920@sirena.org.uk>
 <CAD=FV=XJd-udEE6az0xP7i6x0oGsnd=BSCyZ0Og_+RjNCMXnCQ@mail.gmail.com>
 <20180530154849.GQ6920@sirena.org.uk>
Message-ID: <CAD=FV=X2u=hMyWinSDtim-PmFwAy5mXcwg3HeYojAHcsUFhV3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 30, 2018 at 8:48 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, May 30, 2018 at 08:34:50AM -0700, Doug Anderson wrote:
>> On Wed, May 30, 2018 at 8:02 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > What you're describing sounds like what we should be doing normally, if
>> > we're not doing that we should probably be fixing the core.
>
>> I'm not convinced that this behavior makes sense to move to the core.
>> On most regulators I'd expect that when the regulator driver says to
>> turn them off that they will output no voltage.  The reason RPMh is
>
> Oh, you mean while the regulator is off...  TBH I don't see a huge
> problem doing that anyway and just reverting to the bottom of the
> constraints when everything gets turned off since we have to see if we
> need to adjust the voltage every time we enabled anyway.
>
>> In any other system when Linux disabled the regulator it wouldn't
>> matter that you left it set at 1.4V.  Thus RPMh is special and IMO the
>> workaround belongs there.
>
> Without the core doing something the regulator isn't going to get told
> that anything updated voltages anyway...

I was just suggesting that when the core tells the regulator driver to
disable itself that the regulator driver tell RPMh to not only disable
itself but also (temporarily) vote for a lower voltage.  When the core
tells the regulator to re-enable itself then the regulator driver
restores the original voltage vote (or applies any vote that might
have been attempted while the regulator was disabled).  That wouldn't
require any regulator core changes.

-Doug
