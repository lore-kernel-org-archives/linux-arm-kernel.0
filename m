From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 1 Sep 2013 13:15:18 +0100
Subject: [alsa-devel] [PATCH 00/14] SPDIF support
In-Reply-To: <20130901115116.GB3084@sirena.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de> <20130831172853.GL18608@sirena.org.uk>
 <20130831191956.GH6617@n2100.arm.linux.org.uk> <5222562B.8010001@metafoo.de>
 <20130901064216.GN6617@n2100.arm.linux.org.uk> <5222EFE5.3010306@metafoo.de>
 <20130901085121.GO6617@n2100.arm.linux.org.uk>
 <20130901115116.GB3084@sirena.org.uk>
Message-ID: <20130901121518.GQ6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 01, 2013 at 12:51:16PM +0100, Mark Brown wrote:
> Like Lars-Peter says it really, really shouldn't be - what moving to
> DPCM should be doing with this code is mostly moving the code around a
> bit to pull the bits that are shared into a front end DAI.  The most
> substantial change should be handling the enables but that shouldn't
> take much code at all, your curent patch does it in 35 lines and I'd not
> expect it to be much different in a DPCM world.

The delta between the DPCM version and the dual-DAI version is over 300
lines of change - the methods employed by these two methods are completely
different.

Maybe you could look at the patch and suggest where I'm going wrong?

> On Sun, Sep 01, 2013 at 09:51:21AM +0100, Russell King - ARM Linux wrote:
> > Can you then please explain why when I ask for help understanding DAPM
> > in a "nice" way, the response I get is just "it's just a graph walk"
> > and no further technical details?
> 
> Ask more detailed questions and engage in a discussion; the reason you
> keep on getting the same responses is that you tend to repeat the same
> requests a lot.  Something like "I understand the big picture but I am
> trying to do X and need to know Y because Z" (with all of X, Y and Z
> being important) is usually a good approach.

When you don't even understand the "big picture", it's hard to know
where to start.  That's why starting off with a simple question is
the right thing to do - and you expect to get a simple but informative
response, so that helps you to frame more specific questions later.

If you start from a position of knowing very little, it's exceedingly
difficult to ask specific questions.

> The public interface for DAPM is that the widgets get created with
> sensible types and hooked up together then powered up as needed, if
> something needs to know specifics of that process like exactly when a
> given register will be written that's a worrying implementation detail.
> 
> > | DAPM is a set of "widgets" representing various components of an
> > | audio system.  The widgets are linked together by a graph.  Each
> > | widget lives in a context - cpu, platform or codec.  Some bindings
> > | only happen within a context, others cross contexts (so linking the
> > | CPU audio stream to the codec for example)
> 
> This last statement is not the case; you can see the route connecting
> code in snd_soc_dapm_add_route() - there is no case in which it will
> only try to match within a single context.
> 
> As I have said to you without more information it is hard to tell what
> problems you are seeing when you are trying this.  It could be a case of
> trying to create routes before the widgets are added, or it could be a
> case of trying to create inter device links with widgets with globally
> duplicated names (though that would give wrong routes rather than no
> routes so I suspect sequencing).

Right, so, I have a widget with a stream name, and the stream name matches
a CPU DAI stream.

If I register this widget against the platform DAPM context, then there is
no connection between this widget and the CPU DAI streams.  (Bear in mind
that at the time I tried this, I had disabled the creation of the stream
widgets that were overwriting the platform stream widgets - because you
were not providing any useful information to work around that problem.)

If I register this widget against the CPU DAI DAPM context, the stream
name is matched to the CPU DAI streams, and a connection is made between
the stream widgets and my widget.

This is what I mean by "some bindings only happen within a context".
