From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Fri, 08 Apr 2016 12:50:54 +0200
Subject: [PATCH] ARM: dts: r8a7791: Don't disable referenced optional
 clocks
In-Reply-To: <20160407232155.GH18567@codeaurora.org>
References: <1459947173-6664-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <CAMuHMdUtPhBT0_+hSk_t5osHC8TssyGMFo+YOWetTGBkbpB4PQ@mail.gmail.com>
 <1459949826.23936.19.camel@collabora.co.uk>
 <20160407232155.GH18567@codeaurora.org>
Message-ID: <1460112654.31245.20.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-04-07 at 16:21 -0700, Stephen Boyd wrote:
> On 04/06, Sjoerd Simons wrote:
> > 
> > On Wed, 2016-04-06 at 15:11 +0200, Geert Uytterhoeven wrote:
> > > 
> > > CC Mike, Stephen, linux-clk (this time with the new Mike)
> > > 
> > > On Wed, Apr 6, 2016 at 2:52 PM, Sjoerd Simons
> > > <sjoerd.simons@collabora.co.uk> wrote:
> > > > 
> > > > 
> > > > clk_get on a disabled clock node will return EPROBE_DEFER,
> > > > which
> > > > can
> > > > cause drivers to be deferred forever if such clocks are
> > > > referenced
> > > > in
> > > > their clocks property.
> > > Is this a side effect of commit 3e5dd6f6e690048d ("clk: Ignore
> > > disabled DT
> > > clock providers")?
> > Yes it seems so. Reverting that patch means that i can drop this
> > one
> > and get the expected behaviour again.
> The DT is broken then? Is it possible to mark these status =
> "okay" so that things work again?

> > 
> > 
> > Though even so I'm not sure what the convention is for clocks like
> > these, the r8a7791.dtsi is inconsistent, as some are disabled while
> > others (e.g. the audio clocks) are 0hz. Would be good to get some
> > input
> > on that regardless.
> > 
> What's the question here?

So the question is how to model unconnected external clocks in device-
tree.

The dtsi we're loooking at has (in pseudo dt):

device {
? clock-names = "internal", "external";
? clocks = <&internal, &external>
};

external {
? compatible = "fixed-clock";
? clock-frequency = <12345>;
? status = "disabled";
};

Before?3e5dd6f6e690048d ("clk: Ignore?disabled DT?clock providers")
this apparently worked. Afterwards drivers getting all the clocks would
fail to probe with -EPROBE_DEFER.

Judging by your comment I assume this way of modelling it is broken
(and the behaviour caused by the patch is correct)??

And as a follow-up, is modelling unconnected clocks as enabled with a
frequency of 0hz as my proposed patch does seen as the right way of
doing things?


-- 
Sjoerd Simons
Collabora Ltd.
