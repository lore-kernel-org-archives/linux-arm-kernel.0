From: broonie@kernel.org (Mark Brown)
Date: Sun, 1 Sep 2013 18:05:46 +0100
Subject: [alsa-devel] [PATCH 00/14] SPDIF support
In-Reply-To: <20130901121518.GQ6617@n2100.arm.linux.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de>
 <20130831172853.GL18608@sirena.org.uk>
 <20130831191956.GH6617@n2100.arm.linux.org.uk>
 <5222562B.8010001@metafoo.de>
 <20130901064216.GN6617@n2100.arm.linux.org.uk>
 <5222EFE5.3010306@metafoo.de>
 <20130901085121.GO6617@n2100.arm.linux.org.uk>
 <20130901115116.GB3084@sirena.org.uk>
 <20130901121518.GQ6617@n2100.arm.linux.org.uk>
Message-ID: <20130901170546.GI3084@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 01, 2013 at 01:15:18PM +0100, Russell King - ARM Linux wrote:
> On Sun, Sep 01, 2013 at 12:51:16PM +0100, Mark Brown wrote:
> > Like Lars-Peter says it really, really shouldn't be - what moving to
> > DPCM should be doing with this code is mostly moving the code around a
> > bit to pull the bits that are shared into a front end DAI.  The most
> > substantial change should be handling the enables but that shouldn't
> > take much code at all, your curent patch does it in 35 lines and I'd not
> > expect it to be much different in a DPCM world.

> The delta between the DPCM version and the dual-DAI version is over 300
> lines of change - the methods employed by these two methods are completely
> different.

> Maybe you could look at the patch and suggest where I'm going wrong?

The diff doesn't look that worrying to me - a large chunk of it is about
moving code around to register multiple DAIs which is something that the
final DPCM code is going to want to do anyway.  A lot of the changes in
the hw_params() function would probably stay the same too, though the
function would move to the front end DAI I expect.

> > Ask more detailed questions and engage in a discussion; the reason you
> > keep on getting the same responses is that you tend to repeat the same
> > requests a lot.  Something like "I understand the big picture but I am
> > trying to do X and need to know Y because Z" (with all of X, Y and Z
> > being important) is usually a good approach.

> When you don't even understand the "big picture", it's hard to know
> where to start.  That's why starting off with a simple question is
> the right thing to do - and you expect to get a simple but informative
> response, so that helps you to frame more specific questions later.

> If you start from a position of knowing very little, it's exceedingly
> difficult to ask specific questions.

So say that - explain that you find it hard to relate the answer to what
you're trying to accomplish, doing things like providing more detail on
the problem you're trying to solve and highlighting anything that you've
noticed is unusual to try to help people understand what might be
missing from their answers.

> Right, so, I have a widget with a stream name, and the stream name matches
> a CPU DAI stream.

Ah, this is stream names not regular routes - new code should just use a
normal DAPM route to connect to the AIF widgets.  Stream names are being
phased out now that we can just use DAPM routes (which mean that we
don't need to go through every single widget doing string checks every
time we start or stop a stream).

> If I register this widget against the platform DAPM context, then there is
> no connection between this widget and the CPU DAI streams.  (Bear in mind
> that at the time I tried this, I had disabled the creation of the stream
> widgets that were overwriting the platform stream widgets - because you
> were not providing any useful information to work around that problem.)

> If I register this widget against the CPU DAI DAPM context, the stream
> name is matched to the CPU DAI streams, and a connection is made between
> the stream widgets and my widget.

> This is what I mean by "some bindings only happen within a context".

This is happening because you're doing things based on the stream name -
stream names aren't really DAPM routes, they're magic things which only
work on the same DAPM context.  Previously we used to go through and do
the string compare to look up widgets outside of DAPM at runtime which
on a per device basis (though that made little difference since the only
devices supported were CODECs which are always a single device and
context), the current implementation replicates this functionality
exactly using DAPM routes and the long term plan is that no stream names
will be specified in widgets.

If you omit the stream name and add the routes via a routing table you
should at least get some error messages.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130901/6ff3aedc/attachment.sig>
