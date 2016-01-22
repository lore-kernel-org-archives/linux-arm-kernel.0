From: broonie@kernel.org (Mark Brown)
Date: Fri, 22 Jan 2016 17:18:15 +0000
Subject: [PATCH v3 3/9] ASoC: rockchip: i2s: add support for grabbing
 output clock to codec
In-Reply-To: <CAPz6YkWt-iXS6P4QBBoq3v3i7ZAGGu6=_9AHw4qgevEwDwbdTA@mail.gmail.com>
References: <1452865796-23527-1-git-send-email-wxt@rock-chips.com>
 <1452865796-23527-4-git-send-email-wxt@rock-chips.com>
 <20160115174623.GZ6588@sirena.org.uk>
 <CAPz6YkWt-iXS6P4QBBoq3v3i7ZAGGu6=_9AHw4qgevEwDwbdTA@mail.gmail.com>
Message-ID: <20160122171815.GD6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 15, 2016 at 01:48:04PM -0800, Sonny Rao wrote:
> On Fri, Jan 15, 2016 at 9:46 AM, Mark Brown <broonie@kernel.org> wrote:

> > If the I2S block is providing a clock to the CODEC then that's what the
> > software should do so that the CODEC can gate and ungate the clock as
> > required.  This patch has the I2S block using a clock, not providing
> > one.

> From my read of the clock diagram for RK3288  there is a single clock
> signal (labeled "clk_i2s0") that comes out of a fractional divider,
> and it is split such that one path gets sent to the I2S block and the
> second path is sent to a mux after which that signal is sent to an
> external pin that goes to the codec.

> There are separate clock gates for the two paths: one for the I2S
> block and one after that mux before the external pin.

> I'm not sure if it's being modeled that way in the Linux code or not,
> but at least physically I don't think this clock signal actually goes
> through the I2S block before being sent to the codec.

That's not really the issue here, the issue is that it's not the I2S
controller that is consuming the clock so it should not be the I2S
controller driver that ensures that the clock is enabled.  The driver
that manages the clock should be the one that uses it, like I say this
means you should add the code to enable the clock to the CODEC driver if
the CODEC driver needs the clock enabled.

> Does that help clarify?

The problem here isn't a lack of clarity in the situation.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160122/4510a8e8/attachment.sig>
