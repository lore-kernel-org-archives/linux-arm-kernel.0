From: broonie@kernel.org (Mark Brown)
Date: Sun, 8 Dec 2013 16:19:22 +0000
Subject: [PATCH] ARM: cpu: Document and tweak clock-frequency property
In-Reply-To: <52A36AB3.6060102@gmail.com>
References: <1386331027-26065-1-git-send-email-broonie@kernel.org>
 <52A36AB3.6060102@gmail.com>
Message-ID: <20131208161922.GK29268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 07, 2013 at 12:36:35PM -0600, Rob Herring wrote:
> On 12/06/2013 05:57 AM, Mark Brown wrote:

> > +	- clock-frequency
> > +		Usage: required

> This breaks compatibility. It may be required for a feature in the

It doesn't, it's listed as mandatory in ePAPR section 3.7.1 which is
already part of our bindings - this is merely copying that information
into the binding document in the kernel so that it's more discoverable 
and so that we can tweak the definition to reflect reality a bit more
closely.

> kernel to work, but should not be required in general. Perhaps we need
> "optional/recommended" or "optional/required for new designs". Or we
> could say required only with heterogeneous cores.

For practical purposes a robust implementation should make it optional
(as the current ARMv7 one does) but that doesn't change the spec.

> > +		Value type: <u32> or <u64>

> How do I determine the size? I think generally this property which is
> used in multiple bindings is always u32. Of course, that won't work for
> our 5GHz parts next year.

Beats me.  Actually now I recheck the spec it should be a prop encoded
array consisting of a single element that's either u32 or u64, I guess
the array encodes the information.

> > +		Definition:
> > +			This is specified in ePAPR as the current clock
> > +			frequency of the CPU.  When used with these
> > +			extensions it should reflect the maximum clock
> > +			frequency for the CPU.

> What does extensions mean? cpu topology nodes?

No, it means the document being modified - the same language is used
throughout the document to refer to the extensions it's defining on top
of the base ePAPR CPU bindings.

> It is useful to have a standard way to determine the current cpu
> frequency. I've been asked for this several times on highbank. This
> could be cpufreq, but there is not always a driver loaded. lshw already
> has support for reading the frequency using this property. So I'm not
> real sure deviating from the ePAPR is a good idea.

That'd be nice but it's not terribly practical to do it in DT given that
we have a static DT.  As soon as something does change the frequency the
information goes bad, and I don't know how this is going to play with
things like kexec.  One could spec that the core always needs to be
started at top speed though that doesn't seem helpful.

> If a cpu only supports 1 frequency, then clock-frequency will always
> reflect the current and max freq. If a cpu supports multiple
> frequencies, then it should have an OPP table with those frequencies. We
> should then get max frequency from the OPP table rather than
> clock-frequency. It is clear that clock-frequency is insufficient to
> describe everything we need.

Right, though encoding the operating points into DT isn't always going
to be useful.  What I'm trying to do here is both reflect the existing
ARMv7 usage and make the property a bit more useful.

If defining it to be the maximum frequency isn't going to fly we should
probably just override ePAPR to say it's optional and implementations
should not rely on its accuracy.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131208/92f116da/attachment.sig>
