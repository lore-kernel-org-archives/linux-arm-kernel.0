From: broonie@kernel.org (Mark Brown)
Date: Tue, 30 Jul 2013 21:45:11 +0100
Subject: [PATCH v6 2/8] ASoC: atmel: machine driver for at91sam9x5-wm8731
 boards
In-Reply-To: <51F7FBA8.6080400@wwwdotorg.org>
References: <1375180329-4860-1-git-send-email-richard.genoud@gmail.com>
 <1375180329-4860-3-git-send-email-richard.genoud@gmail.com>
 <51F7FBA8.6080400@wwwdotorg.org>
Message-ID: <20130730204511.GX9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 11:45:12AM -0600, Stephen Warren wrote:
> On 07/30/2013 04:32 AM, Richard Genoud wrote:

> > +wm8731 pins:
> > +cf Documentation/devicetree/bindings/sound/wm8731.txt

> In the Tegra bindings, I deliberately put the list of CODEC pins into
> the audio complex binding rather than the CODEC binding. That's because

You really shouldn't do this, it's not accomplishing much.

> I'm not sure that in the long-term we want to use strings to identify
> the CODEC pins, rather than using integers. By putting the list orf
> CODEC pins in the audio complex binding rather than the CODEC binding, I
> didn't lumber the CODEC binding with a list of strings that it had to
> support forever.

How would you create the numbers - you can't use the pin numbers since
BGA type packages have alphanumeric ball identifiers?  Even with
numerical pin numbering ou'd need to specify some defines for this not
to be totally awful at which point you may as well have the strings
documented since you'd end up writing a table in the binding document
that's basically a mapping of pin names to numbers,

> One reason that strings are problematic is because they can't be mixed
> with integers/phandles in the same property, so if we ever end up with
> more generic audio bindings where the routing table is expressed more like:

> audio-routes = <&component_a $a_pin &component_b $b_pin>;

> ... in order to allow completely arbitrary and fully name-spaced routing
> specification[1], then $a_pin and $b_pin need to be integers not strings.

The above is going to be legibility challenged without defines at which
point the strings end up appearing in the binding document anyway.

Besides, you're stuck with the names you picked anyway so you may as
well put them in the CODEC driver binding document so that anyone else
using the same CODEC can reuse that bit of work.

> [1] and perhaps we can get rid of properties like
> audio-codec/ssc-controller, and automatically deduce which components
> are needed simply by finding all phandles in the audio-routes property.

> Perhaps the solution here is to allow mixing phandles/integers/strings
> in one property, but that's potentially quite a large change to the DTB
> format; we'd need to introduce type fields into the property data, and
> other data format changes.

I really do think this is a DT failure which ought to be addressed
there; people are working around this with things like parallel arrays
with names and phandles which aren't awesome once the arrays get to be
any size.

One option that seems sensible is to introduce syntactic sugar which
will do the parallel arrays trick automatically - the actual DT that
gets output could still be two arrays with indexes that match up (so no
impact on parsers) but the DT author would be able to write an array of
(phandle, string) tuples or something instead of having to line up two
arrays.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130730/9ad5b386/attachment-0001.sig>
