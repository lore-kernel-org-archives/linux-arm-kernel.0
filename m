From: broonie@kernel.org (Mark Brown)
Date: Tue, 30 Jul 2013 23:58:45 +0100
Subject: [PATCH v6 2/8] ASoC: atmel: machine driver for at91sam9x5-wm8731
 boards
In-Reply-To: <51F8302D.406@wwwdotorg.org>
References: <1375180329-4860-1-git-send-email-richard.genoud@gmail.com>
 <1375180329-4860-3-git-send-email-richard.genoud@gmail.com>
 <51F7FBA8.6080400@wwwdotorg.org>
 <20130730204511.GX9858@sirena.org.uk> <51F8302D.406@wwwdotorg.org>
Message-ID: <20130730225845.GB9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 03:29:17PM -0600, Stephen Warren wrote:
> On 07/30/2013 02:45 PM, Mark Brown wrote:

> > You really shouldn't do this, it's not accomplishing much.

> What it accomplishes is not polluting the CODEC's binding with a set
> of strings that must always be supported since DT is an ABI. The
> strings are isolated into the specific audio complex binding, which
> might possibly become deprecated and replaced with something better
> and more generic.

You seem to be assuming that the strings are a bad thing.  I'm not sure
that this is the case modulo the tooling issues...

Besides the reality is that we're using strings right now and they're
being baked into bindings right now, I can't see anything being saved by
listing them in the board binding rather than in the CODEC binding since
both are ABIs especially once you get to the second board binding.  The
ship has sailed on that one.  

All the CODEC binding does is say "there are pins called this", it's up
to some other binding to define how they're used and the CODEC binding
can always add extra information to that list, including a mapping to
integers.

> > The above is going to be legibility challenged without defines at
> > which point the strings end up appearing in the binding document
> > anyway.

> Yes, you'd certainly have to use defines not raw integers. The strings
> wouldn't appear in the binding doc so much as the numbers.

The strings would be there in the text explaining what the numbers mean
- whatever happens the pin names are going to be physically present in
the document, it's just a formatting difference.  The CODEC document
has to list all the pins, we're not going to avoid that by defining a
mapping to integers since adding the integers will in some way end up
defining the names even if just as part of the name of a constant.

We could start adding the integers right now - something like:

	The X CODEC has the following numbered input and output pins:

		1. HPOUTL
		2. HPOUTR
		...

	(see datasheet for details), a header file is provided with
	constants X_PIN_foo for convenience.

would work with either approach to identifying the pins or if we're
being less verbose and just reference the header file for the
definitions that becomes something like:

	The X CODEC has input and output pins listed with numerical
	identifiers in the form the X_PIN_foo defined in the X.h header
	file where foo is the name of the pin.

(that's not good boilerplate wording but you get my drift) which still
ends up defining a set of known strings for pins.

In fact now that I think about this why don't we just go ahead and do
all this, starting by putting the numbers into the bindings for the
CODECs since that's the simplest thing and doesn't involve writing code?
I even have several boards on my desk that run DT ASoC...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130730/e03ac78f/attachment.sig>
