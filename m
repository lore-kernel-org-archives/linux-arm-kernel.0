From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 2 Jan 2012 14:39:05 +0000
Subject: [PATCH 1/1] regulator/fixed: set constraints.apply_uV to 0
In-Reply-To: <CAH8gqwXopRx7_-wSq9djb_np+XeZE0w1HJ1XxZozGOBCF8Z+ZQ@mail.gmail.com>
References: <1325225213-29655-1-git-send-email-richard.zhao@linaro.org>
 <20111230103026.GA2766@opensource.wolfsonmicro.com>
 <20111230103830.GD2414@b20223-02.ap.freescale.net>
 <20111230104850.GE2766@opensource.wolfsonmicro.com>
 <20111230110842.GE2414@b20223-02.ap.freescale.net>
 <20111231010240.GC5835@opensource.wolfsonmicro.com>
 <20111231012629.GF2414@b20223-02.ap.freescale.net>
 <20111231215925.GA12740@opensource.wolfsonmicro.com>
 <CAH8gqwXopRx7_-wSq9djb_np+XeZE0w1HJ1XxZozGOBCF8Z+ZQ@mail.gmail.com>
Message-ID: <20120102143904.GQ4300@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 02, 2012 at 09:46:01PM +0800, Richard Zhao wrote:

> On 1 January 2012 05:59, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > It's not code which is specific to the fixed regulator, it's generic
> > code that's used by all regulators.

> The original patch is in fixed regulator driver.

Your original patch made no mention of device tree, it just had the
driver modify its constraints which is clearly not good - aside from the
design issue what happens if we make const data read only?  Any boards
that have their constraints marked const will start oopsing.  Your new
patch makes it impossible to apply a voltage to *any* regulator on a
device tree which is going to break any system that needs to apply a
voltage.

You really need to take a step back, think about the consequences of the
changes you're making and make changes that also make sense at a design
level.  You can't think only about the one board that you're currently
working on, it's important that you consider the wider effects of your
change.

To repeat my previous suggestions you could either make the system more
forgiving of silly constraints where that makes sense (and remember that
one of the reasons the core rejects silly constraints is that it wants
to make absolutely clear that the user wrote what they meant) or make
sure that silly constraints aren't written in the first place.  For
example, why not make this a device tree specific change?

> >> Could you please past some code to show your suggested solution,
> >> or you send out a patch to fix it?

> > Not in the immediate future.

> It's a __bug__ blocking others to use fixed regulator with dt binding.

There's some fairly clear and obvious directions to look at and simply
demanding that I drop everything and implement them for you too isn't
really inspiring me to do so.
