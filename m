From: broonie@kernel.org (Mark Brown)
Date: Wed, 10 Sep 2014 17:57:23 +0100
Subject: Unable to boot mainline on snow chromebook since 3.15
In-Reply-To: <CACxGe6uBcTPMh4p=oi7m_TVpjUrkgbQvxbStAn27HXEJxYe5fw@mail.gmail.com>
References: <540C8577.2070907@gmail.com> <20140908112112.GK26030@arm.com>
 <CACxGe6v40wMSW8LJRtyZ3C6PinRMcQM-Zog+XpTJ-QG3HHJknw@mail.gmail.com>
 <CAD=FV=VAqzvJQDQMjjeQ1p5okyDzE=ff_sguObZxh59qbzcaTQ@mail.gmail.com>
 <CACxGe6t_ex1bU=CvTpXR4VJgNf1hAq33hr6ykbHy_sMXEk4h-g@mail.gmail.com>
 <CAOesGMipX3MV6sMWLuY=D+bQ6qe8P17YFbTFwZOHPeSc3Pw9Cg@mail.gmail.com>
 <20140910143144.GF7960@sirena.org.uk>
 <CACxGe6u=QkGTKGfaE_jJ5VFMhdVKQNggp3qVBUgNP7rDbZss_A@mail.gmail.com>
 <20140910153919.GH7960@sirena.org.uk>
 <CACxGe6uBcTPMh4p=oi7m_TVpjUrkgbQvxbStAn27HXEJxYe5fw@mail.gmail.com>
Message-ID: <20140910165723.GK7960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 05:29:32PM +0100, Grant Likely wrote:

> What we can do is have an inhibit flag for
> simplefb/simpleuart/simplewhatever that holds off PM. When a real
> driver, or a stub that understands parsing the resource dependencies,
> takes ownership of the device (or userspace tells the kernel to stop
> caring) it can clear the inhibit.

It's not quite as simple as just disabling PM - for example in the
clocks case we've also got to worry about what happens with rate changes
(which is going to get more and more risky as we get smarter about being
able to push configuration changes back up the tree), regulators have a
similar thing with voltage changes.  With simple enables and disables we
have to worry about things like handling users who actively want to
power things on and and off but may potentially be sharing a resource
with an undeclared dependency.

If we are going to go with an approach like you suggest I think that
rather than require a userspace notification that everything is OK we
should have the stub drivers do something which causes the appropriate
behaviour to happen so long as they're loaded.  This means userspace
doesn't need an update and ensures it doesn't have to worry about cases
where we're using the stub driver at runtime due to a real driver not
being available - we can figure this stuff out within the kernel
oureslves.

That said a kick from userspace when the first round of module loading
has finished would be very helpful, I just don't think we should rely on
it for this behaviour.

> I don't want to build knowledge of resource dependencies into the
> simple case. We'll simply frequently get it wrong. For example: A
> future kernel will have better PM and will turn off more devices which
> isn't accounted for in an older DT.

That is tricky and there will be problems.  Being fairly aggressive
about doing these things and avoiding having runtime configuration hacks
since it makes it harder for people to introduce problems without
noticing them, and requiring an explicit request to do resource
management at all is the most conservative option.  Between them those
strategies should help for anything that's getting tested at least, it
makes it hard for the kernel to learn about a resource without it being
handled safely from the get go.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140910/3d8ea088/attachment.sig>
