From: dianders@chromium.org (Doug Anderson)
Date: Tue, 2 Dec 2014 15:02:37 -0800
Subject: [PATCH] i2c: rk3x: fix bug that cause measured high_ns doesn't
 meet I2C spec
In-Reply-To: <1415261514-4051-1-git-send-email-addy.ke@rock-chips.com>
References: <1415261514-4051-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <CAD=FV=WN3Tuzby0fVOyxJ14iroBcgEpWHaz7Rh7EyfrHijhV0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addy,

On Thu, Nov 6, 2014 at 12:11 AM, Addy Ke <addy.ke@rock-chips.com> wrote:
> high_ns calculated from the low division of CLKDIV register is the sum of
> actual measured high_ns and rise_ns. The rise time which related to
> external pull-up resistor can be up to the maximum rise time in I2C spec.
>
> In my test, if external pull-up resistor is 4.7K, rise_ns is about 700ns.
> So the actual measured high_ns is about 3900ns, which is less than 4000ns
> (the minimum high_ns in I2C spec).

It's a little unfortunate to have to make the assumption that the rise
time for a board is going to be the maximum the spec allows.  I think
this is something that's better to let a board specify in the device
tree.  Allowing us to specify it also gives us a little extra slop and
makes it easier to specify a "fall time" without affecting the
resulting frequency.  Right now your code assumes that the fall time
is 0.

I've prototyped what things could look like if the rise and fall times
were specified in the device tree.  You can see my patch (atop yours)
at:

https://chromium-review.googlesource.com/#/c/232774/

...perhaps you could squash that into your patch and post up v2?

-Doug
