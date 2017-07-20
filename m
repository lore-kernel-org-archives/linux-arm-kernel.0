From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Jul 2017 16:44:25 +0200
Subject: [PATCH 01/18] regmap: mmio: Add function to attach a clock
In-Reply-To: <20170718132147.uzexelksygjeasmw@sirena.org.uk>
References: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
 <02f409ad80afed68e02660f161fc26d588a86fa7.1499955058.git-series.maxime.ripard@free-electrons.com>
 <20170713160142.2buaie6ebqbxunin@sirena.org.uk>
 <20170717090107.cpjxoxfqcc3qwabh@flea>
 <20170718132147.uzexelksygjeasmw@sirena.org.uk>
Message-ID: <20170720144425.7tvmme6llqmmj3ls@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 02:21:47PM +0100, Mark Brown wrote:
> On Mon, Jul 17, 2017 at 11:01:07AM +0200, Maxime Ripard wrote:
> > On Thu, Jul 13, 2017 at 05:01:42PM +0100, Mark Brown wrote:
> 
> > > > This might be problematic if the clock to enable is stored in another node.
> > > > Let's add a function that allows to attach a clock that has already been
> > > > retrieved to a regmap in order to fix this.
> 
> > > What is the use case for this?
> 
> > This is useful when the clock you want to be handled by the regmap is
> > not described in the device node that probed the driver, but one of
> > its subnode, or an another node entirely.
> 
> > We're in the latter case, where we have two controllers in the DT, but
> > are driven by the same driver. We'll create two regmaps, but one will
> > not have the proper of_node used to retrieve the clock.
> 
> I'm sorry but I'm still not seeing why you're doing this.  Can you be
> more concrete please?

We have two devices needed to bring DSI: the DSI controller itself and
its associated PHY.

The PHY configuration cannot be done through a framework because it
requires more information than the various phy frameworks allow to
pass through to the driver.

Therefore, we have a single driver, attached to the DSI controller,
which handles both the PHY and the DSI controller.

Both the PHY and the DSI controller are separate device, with
different memory regions. Therefore, we need to create two regmaps,
with clocks attached to them.

However, the default clock retrieval mechanism doesn't work for the
phy regmap, since only the DSI controller device of_node is
considered, while its clock is stored in a separate node.

I hope it's clearer,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170720/d1cff9d4/attachment.sig>
