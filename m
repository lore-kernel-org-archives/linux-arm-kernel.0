From: robh@kernel.org (Rob Herring)
Date: Thu, 14 Apr 2016 12:02:55 -0500
Subject: [Question] refcount of DT node
In-Reply-To: <06E9E2D3-4627-4970-ABBB-34B5ED620709@konsulko.com>
References: <CAK7LNATFUW2KXUpFas6C_SJ0C7Qb1DWU0njLg-FCYciK2U6Oag@mail.gmail.com>
 <20160414084849.GT19428@n2100.arm.linux.org.uk>
 <20160414095957.GB10273@leverpostej>
 <06E9E2D3-4627-4970-ABBB-34B5ED620709@konsulko.com>
Message-ID: <20160414170255.GA26137@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 01:02:56PM +0300, Pantelis Antoniou wrote:
> Hi Mark,
> 
> > On Apr 14, 2016, at 12:59 , Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > On Thu, Apr 14, 2016 at 09:48:49AM +0100, Russell King - ARM Linux wrote:
> >> On Thu, Apr 14, 2016 at 04:47:57PM +0900, Masahiro Yamada wrote:
> >>> Hi experts.
> >>> 
> >>> My understanding of refcount of DT node is poor.
> >> 
> >> The message from DT people is... don't worry about DT node refcounting.
> >> Do whatever you want with it, they don't care whether you have correct
> >> refcounting or not.
> >> 
> >> The background behind that is that I've tried to fix the refcounting,
> >> and even had the coccinelle people generate some stuff to work on this
> >> issue, but DT people's attitude towards it is "don't bother".
> >> 
> >> So yes, people may get it wrong, but it seems it's something that DT
> >> people want ignored.
> > 
> > I'm not sure that's quite fair; the last discussion I recall about this
> > ended up concluding that we need a better API, rather than papering over
> > problems.
> > 
> > That said, there isn't much obvious progress on that front.
> > 
> > Frank, Pantelis, Rob, were there any conclusions on this from ELC, or is
> > this something that needs someone to propose something?
> > 
> 
> Frank mentioned that he wants a new API. I have some ideas about it too.
> 
> My take is that drivers should never do reference counting, we have to figure
> out a way for DT access using copy semantics or locks.

Generally yes, but I think there may be exceptions. I think the locking 
is too fine grained for what we need. For almost all users, I think we 
only need locking at the overlay or changeset level. The only other user 
I am aware of is PSeries (IIRC) and they only need reference counting 
for a few things like memory and cpu. I would handle those cases 
explicitly. But that is going to require someone familar with PSeries to 
work on. I suppose we could separate overlays from the OF_DYNAMIC 
dependency (or just the ref counting part of it) and then OF_DYNAMIC 
goes back to PPC only.

Rob
