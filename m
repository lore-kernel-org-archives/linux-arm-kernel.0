From: broonie@kernel.org (Mark Brown)
Date: Wed, 26 Nov 2014 13:40:55 +0000
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <547526BC.1090202@codeaurora.org>
References: <546FC674.1070005@codeaurora.org>
 <20141121232738.GP3815@sirena.org.uk>
 <546FCE3A.1000005@codeaurora.org>
 <20141124181614.GT7712@sirena.org.uk>
 <5473A0F3.6080405@codeaurora.org>
 <20141125204430.GN7712@sirena.org.uk>
 <547526BC.1090202@codeaurora.org>
Message-ID: <20141126134055.GF7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 05:02:52PM -0800, Stephen Boyd wrote:
> On 11/25/2014 12:44 PM, Mark Brown wrote:

> >I'm still quite confused here...

> Hm... hopefully it's not getting worse.

It is a bit, the story keeps changing a lot.

> >I can't help but think that this all sounds like the RPM isn't mapping
> >very well onto practical systems and needs revisiting in future
> >versions...  for example with what I'm parsing out of the above an
> >active+sleep set command or otherwise having the two modes tied together
> >for some regulators would make the whole problem go away.

> We create the 'active only' regulators for consumers that actually need
> them. From the set of regulators on a board only a couple need this

That's what I don't think is making any sense.  Creating two regulators
for the same thing seems like bad news, at best it's going to make reuse
harder.

> treatment. I don't see how tying the two states together via an active+sleep
> set command would make this problem go away for the cases I already
> described before, i.e. CPU wants some voltage and other IO devices want
> another voltage and the CPU doesn't care what the voltage is when the CPU is

Not paying attention to requests from a disabled consumer seems like
something we should be able to do in general.  

> in idle or suspend. Having a combination active + sleep set command would be
> nice. The RPM already sort of supports this by allowing you to only modify
> the active set. If you never modify the sleep set, then the RPM just applies
> whatever is in the active set to the sleep set. We can probably go through
> and figure out what resources could get away with only using the active set
> so we can cut down on sleep set requests that are always the same between
> active and sleep set.

This version is starting to sound a lot like the consumers need to be
able to do an idle to sleep transition and change their settings when
they enter their sleep mode.  It seems a lot like what many devices do
now when they enter and exit runtime PM but with deferred application
depending on other users (for regulators I'm assuming the active set
would actually be a subset of the sleep set of valid voltages).

> >I think any duplication that's going on sounds like a consequence of
> >the way this is currently implemented.  I think based on what I *think*
> >you're saying the RPM driver probably ought to be hiding this and adding
> >a property which makes the active and sleep sets track each other with
> >normal suspend mode control otherwise.  That could potentially be done
> >in the core, though the tracking would be substantial surgery.

> Sorry I don't follow this part. It's about more than suspend, we also care
> about idle. I agree that pushing the concept of active vs. sleep into the
> framework is substantial.

That's not what it seemed like people had been talking about up until
this most recent e-mail, you'd been talking about suspend mode.  The
starting point was mapping onto the suspend support the regulator has.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141126/99fea7c6/attachment-0001.sig>
