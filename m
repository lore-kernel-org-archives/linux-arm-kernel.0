From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 May 2018 17:59:37 +0100
Subject: [PATCH v3 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
In-Reply-To: <CAD=FV=V1gGccKr1mHM0zx_-FFdLU1vrzUChwx6KTUyTGzj39Tw@mail.gmail.com>
References: <20180530150241.GO6920@sirena.org.uk>
 <CAD=FV=XJd-udEE6az0xP7i6x0oGsnd=BSCyZ0Og_+RjNCMXnCQ@mail.gmail.com>
 <20180530154849.GQ6920@sirena.org.uk>
 <CAD=FV=X2u=hMyWinSDtim-PmFwAy5mXcwg3HeYojAHcsUFhV3g@mail.gmail.com>
 <20180530160744.GS6920@sirena.org.uk>
 <CAD=FV=WVGu0f+=q-C9kiEmaLEUJqGY+Jbns83h72uF-9iasrUw@mail.gmail.com>
 <20180530161311.GT6920@sirena.org.uk>
 <CAD=FV=UpWEMSPUYOHmLQ0g_mF990kwn4_zm=ZCNttLKZiz7i=Q@mail.gmail.com>
 <20180530163644.GW6920@sirena.org.uk>
 <CAD=FV=V1gGccKr1mHM0zx_-FFdLU1vrzUChwx6KTUyTGzj39Tw@mail.gmail.com>
Message-ID: <20180530165937.GX6920@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 09:41:55AM -0700, Doug Anderson wrote:
> On Wed, May 30, 2018 at 9:36 AM, Mark Brown <broonie@kernel.org> wrote:

> > Yeah, and I don't think that's unreasonable for the core to do - just
> > drop the voltage to the constraint minimum after it has turned off the
> > regulator, then recheck and raise if needed before it enables again.

> Would it do this for all regulators, though?  Most regulators are
> hooked up over a slow i2c bus, so that means that every regulator
> disable would now do an extra i2c transfer even though for all
> regulators (other than RPMh) the voltage of a regulator doesn't matter
> when it's been "disabled' (from Linux's point of view).

It'd only affect regulators that can vary in voltage and actually get
disabled which is a pretty small subset.  Most regulators are either
fixed voltage or always on.

> Hrmmm, I suppose maybe it'd be OK though because for most regulators
> we'd use "regcache" and most regulators that we enabled/disable a lot
> are not expected to change voltage in Linux (so the regcache write
> would hopefully be a noop), so maybe it wouldn't be _that_
> inefficient...

Even if the regulator lacks a cache we'd at least skip out on the write
when we're not changing voltage as we'd do a read/modify/update cycle
and stop at the modify.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180530/af4e9b3f/attachment-0001.sig>
