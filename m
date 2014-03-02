From: peter.maydell@linaro.org (Peter Maydell)
Date: Sun, 2 Mar 2014 09:29:39 +0000
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <20140301195419.0DB5DC40B0D@trevor.secretlab.ca>
References: <20140226183454.GA14639@cbox>
 <alpine.DEB.2.02.1402271216040.31489@kaball.uk.xensource.com>
 <20140301195419.0DB5DC40B0D@trevor.secretlab.ca>
Message-ID: <CAFEAcA-q6OMuKO=Wxi9GELoQc4LVJED3Zgerb8ESyMoqw3pkCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 March 2014 19:54, Grant Likely <grant.likely@linaro.org> wrote:
> Allow me to elaborate. I'm not trying to punish Xen here, but I'm
> deliberately pushing back against "either/or" options in the spec. In
> this case the spec says the VM must implement one of pl011 *or* virtio
> *or* xenpv. That gives lots of implementation choice to VM projects.

>From the VM implementation side, of course, we want to push back
against "must be X and only X" settings in the spec. My feeling is
that if you're a VM that doesn't already handle X then implementing
it is potentially quite a bit of work (especially if it implies implementing
a bus framework or whatever that you don't have any support for,
as might be the case for requiring virtio in Xen). On the other hand
Linux already has support for all the options and is easy to configure
with all the options enabled. So when I was looking through / making
comments on this spec my preference generally came down on the
side of "give the VM side the flexibility to select 1 from some small
number of N".

(Sometimes, as with GIC choices, the "flexibility must be in the
guest, not the VM" approach is forced by host h/w possibilities.)

For initial console in particular it might be reasonable to require
"minimal pl011". On the other hand I don't think we want to imply
"as a guest it's OK for you not to support Xen pv console" because
that is saying "console performance will be terrible on Xen". How
about "must implement minimal pl011, and also at least one of
virtio-console, interrupt-driven pl011 or xen pv console" ?

thanks
-- PMM
