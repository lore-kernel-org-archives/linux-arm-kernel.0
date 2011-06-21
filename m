From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Jun 2011 19:53:56 +0100
Subject: [PATCH 1/3] serial/imx: add device tree support
In-Reply-To: <BANLkTiny9xDwiUww9Ys+jQZ0SHdQATABUA@mail.gmail.com>
References: <1308410354-21387-1-git-send-email-shawn.guo@linaro.org>
	<1308410354-21387-2-git-send-email-shawn.guo@linaro.org>
	<20110618161934.GH8195@ponder.secretlab.ca>
	<20110619073000.GA23171@S2100-06.ap.freescale.net>
	<20110621135558.GB9228@S2101-09.ap.freescale.net>
	<4E00E3D2.6050602@firmworks.com>
	<BANLkTiny9xDwiUww9Ys+jQZ0SHdQATABUA@mail.gmail.com>
Message-ID: <20110621185356.GJ23234@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 12:42:14PM -0600, Grant Likely wrote:
> On Tue, Jun 21, 2011 at 12:32 PM, Mitch Bradley <wmb@firmworks.com> wrote:
> > I wonder if it makes sense to create a new device node "/linux-devices" to express a desired mapping from device nodes to /dev entries? ?The properties could be the names of device special files and the values the corresponding node phandles.
> 
> I've been trying /really/ hard to avoid doing something like that
> because a lot of the time the desired Linux dev name is a
> implementation detail, and a potentially unstable one at that.  If
> Linux requires certain devices to have certain names because that is
> how it hooks up clocks

As I keep on saying, we don't _have_ to have to match on device name.
If DT can come up with a better way to bind a clock to a particular
device/connection name then DT can provide its own clk_get()
implementation which does that.

clk_get() has the struct device, and therefore can get at the DT
information itself to read out whatever properties are required.  But,
we must not get away from the fact that clk_get()'s second argument
should _never_ be used as a unique clock name itself.

At the moment, until we do have some kind of DT based clk_get(), the
easiest way to move clk-API using drivers over is to use the device
name in the static clk_lookup tables.

It's all an implementation detail, one which is (thankfully) hidden
behind a proper API which will be _completely_ transparent to drivers
using the clk API in the _proper_ way.
