From: broonie@kernel.org (Mark Brown)
Date: Sun, 8 Dec 2013 19:22:37 +0000
Subject: [PATCH] ARM: cpu: Document and tweak clock-frequency property
In-Reply-To: <CAFEAcA8qsb0f_5dVbytCD3fGQdT+W4=PJudCY1f-ee4Pwm=0=Q@mail.gmail.com>
References: <1386331027-26065-1-git-send-email-broonie@kernel.org>
 <52A36AB3.6060102@gmail.com> <20131208161922.GK29268@sirena.org.uk>
 <CAFEAcA8qsb0f_5dVbytCD3fGQdT+W4=PJudCY1f-ee4Pwm=0=Q@mail.gmail.com>
Message-ID: <20131208192237.GM29268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 08, 2013 at 04:38:58PM +0000, Peter Maydell wrote:

> Sorry, but there is already shipping software (kvmtool
> and QEMU) which isn't emitting clock-frequency properties
> for cpu nodes, based on what you documented in the kernel
> doc file, which says:

I didn't document anything here except this patch, I was just trying to
reconcile the implementation with the documentation.

> "The ARM architecture, in accordance with the ePAPR, requires
> the cpus and cpu nodes to be present and contain the properties
> described below."

> not "must contain the properties described below and also
> any others that the ePAPR spec says are mandatory".

I think that's a fairly tortured way of reading the language there to be
honest (and doesn't reflect the actual deployed code reading the binding
which does use this property without documentation outside ePAPR and does
warn if it's absent).  If that really is how we want to read things then
we probably ought to delete the reference to ePAPR both here and in the
other binding documentation we have and fork the specs.

> So I'm afraid you're stuck with this being an optional property.

Like I say I think a reasonable and robust implementation shouldn't
reject a device tree with it missing but that doesn't stop the device
tree being out of spec.  This is also the existing kernel behaviour for
this property so we're stuck with it anyway and my goal here was to
minimise our deviation from the spec so I introduced the minimum
practical change in the process of copying it in for discoverability.

This sort of situation is going to become more and more common as people
actually look at device trees in production; the kernel will have to be
robust against device trees that it previously accepted even if they are
out of spec (and should just generally be robust in parsing).  We've got
to understand that the kernel will fill the role Windows does for PCs -
things that run well enough with existing kernels are going to end up
being released regardless of spec conformance.  Kernels should be
liberal in what they accept, DTs should be conservative in what they
contain and both need to understand that the other is going to get it
wrong some of the time.

> (It's also not at all clear what a virtual machine's devicetree
> should set the clock-frequency properties to anyway...)

Yes, it's a poorly considered property all round.  Most currently
available silicon has variable clocks for the cores which is an issue
with a fixed DT like FDT provides and like you say for simulators and so
on it's meaningless.

Ideally someone with the time/enthuisiasm will get this dealt with more
sensibly in a future revision of ePAPR.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131208/ba398e33/attachment.sig>
