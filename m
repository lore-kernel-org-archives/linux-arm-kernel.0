From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 29 Jan 2013 21:20:04 +0000 (UTC)
Subject: [PATCH 02/12] ARM: OMAP2+: PM: introduce power domains functional
 states
In-Reply-To: <CAORVsuVX5AHocHSAg7aMbnLy9FaaPDS5doTCY4_G_-3r+AWEgw@mail.gmail.com>
References: <20121209174545.6933.59371.stgit@dusk.lan>
 <20121209175253.6933.87846.stgit@dusk.lan>
 <CAORVsuVX5AHocHSAg7aMbnLy9FaaPDS5doTCY4_G_-3r+AWEgw@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1301292114231.11442@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi 

(redacted some context)

On Wed, 12 Dec 2012, Jean Pihet wrote:

> On Sun, Dec 9, 2012 at 6:53 PM, Paul Walmsley <paul@pwsan.com> wrote:
> 
> +/**
> > + * _match_pwrst: determine the closest supported power state
> > + * @pwrsts: list of allowed states, defined as a bitmask
> > + * @pwrst: initial state to be used as a starting point
> > + * @min: minimum (i.e. lowest consumption) allowed state
> > + * @max: maximum (i.e. highest consumption) allowed state
> > + *
> > + * Search down then up for a valid state from a list of allowed
> > + * states.  Used by states conversion functions (_pwrdm_fpwrst_to_*)
> > + * to look for allowed power and logic states for a powerdomain.
> > + * Returns the matching allowed state.  XXX Deprecated.  The software
> > + * should not try to program unsupported powerstates.
> >
> 
> Why is this new code already deprecated? Does this require a rewrite?

The reason why is documented in the above comment.  The kernel should not 
attempt to program power states that the hardware doesn't support.  Our 
existing code will program unrequested power states, and that isn't 
predictable behavior.  If the kernel attempts to program a powerdomain to 
the CSWR power state, and the powerdomain doesn't support that state, it 
shouldn't silently program a different power state and return success.  
It should return an error, since the calling code shouldn't have tried to 
program that power state in the first place.

One of the subsequent patches removes this behavior and this code.  It's 
only being kept to ensure an orderly, functional kernel from one patch 
series to the next.


- Paul
