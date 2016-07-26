From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Jul 2016 17:13:11 +0200
Subject: [PATCH 4/5] input: touchscreen: support Allwinner SoCs'
 touchscreen
In-Reply-To: <20160725170839.GA27415@dtor-ws>
References: <1469003351-15263-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469003351-15263-5-git-send-email-quentin.schulz@free-electrons.com>
 <20160721062950.GB5993@lukather> <20160721064140.GA17658@dtor-ws>
 <20160725094542.GI7419@lukather> <20160725170839.GA27415@dtor-ws>
Message-ID: <20160726151311.GG7190@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 25, 2016 at 10:08:39AM -0700, Dmitry Torokhov wrote:
> > > > ... but your driver isn't registered yet. How does input_report and
> > > > input_sync behave in such a case?
> > > 
> > > This is explicitly allowed:
> > > 
> > > "
> > > ...
> > >  * NOTE: input_event() may be safely used right after input device was
> > >  * allocated with input_allocate_device(), even before it is registered
> > >  * with input_register_device(), but the event will not reach any of the
> > >  * input handlers. Such early invocation of input_event() may be used
> > >  * to 'seed' initial state of a switch or initial position of absolute
> > >  * axis, etc.
> > >  */
> > > "
> > 
> > Good to know. Still, it feels like it should be handled explicitly,
> > instead of relying on the fact that we only call input_event in our
> > handler and that it works that way.
> 
> Why? It is the documented property of input API and it is done so
> precisely so that you can register interrupt before registering input
> device. That is done because once registered input device is supposed to
> be fully-functional.  It does not matter for this driver but there are
> drivers out there that require interrupt handling as part of their
> "open" method.

I'm not questionning the input framework itself, and it works right
now because we all looked at that issue and found that it would work
even in the event of an early interrupt.

What I'm afraid of is that in a few weeks /monthes / years / decades,
someone will add something new in the driver without taking care of
that, and we will miss it because we won't have enough context.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160726/e9555d8b/attachment.sig>
