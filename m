From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Sep 2015 09:22:10 +0100
Subject: [PATCH] ARM: dts: Add ddc i2c reference to veyron
In-Reply-To: <CAL_JsqLLPCy6OpsP4NNjUA6+UxeTC-zGjGPPU+MLhUqFXSSGJQ@mail.gmail.com>
References: <1441229148-12095-1-git-send-email-dianders@chromium.org>
 <CAL_JsqLLPCy6OpsP4NNjUA6+UxeTC-zGjGPPU+MLhUqFXSSGJQ@mail.gmail.com>
Message-ID: <20150903082210.GU21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 02, 2015 at 07:13:24PM -0500, Rob Herring wrote:
> On Wed, Sep 2, 2015 at 4:25 PM, Douglas Anderson <dianders@chromium.org> wrote:
> > The ddc-i2c-bus property was missing from the veyron dtsi file since
> > downstream the ddc-i2c-bus was still being specified in rk3288.dtsi and
> > nobody noticed when the veyron dtsi was sent upstream.  Add it.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > Note: I noticed that this was wrong but I don't currently have
> > graphics up and running on upstream on veyron.  Posting this anyway
> > since it's pretty clear that it's needed.  If someone else wants to
> > try it out that'd be nice, otherwise I'll put it on my list to figure
> > out how to get myself setup for graphics upstream.  ;)
> 
> Based on your other patch, this is temporary, right?
> 
> I've been looking at DRM a lot lately. I think specifying the i2c bus
> in the hdmi chip or IP block node is wrong. If the I2C host is
> separate from the HDMI block, then it's only connection is to the HDMI
> connector. So the I2C host to the connector relationship is what the
> DT should describe. HPD gpio is similar. Now if the HDMI bridge
> controls DDC and HPD directly, then we don't need to describe those
> connections.

Except... we don't generally model connectors under DRM as a general
rule.  (The fbdev video connector stuff happened without very much
publicity afaics.)

It's not always appropriate to split it out from the bridge in any
case.  Consider something like a TDA998x where the TDA998x itself
takes care of reading the DDC bus, and doesn't provide an I2C-like
interface.  If you try and split that into "bridge" or "encoder" and
"connector" you end up having to invent a new kind of I2C thing which
isn't an I2C adapter, or somehow squeezing an I2C adapter which isn't
into the I2C layer.

The TDA998x provides an interface to read a block of EDID at a time.
It always does the page register access.  You don't get to read it
byte wise.  It doesn't fit into I2C as an adapter at all.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
