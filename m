From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 1 Oct 2012 17:07:25 +0100
Subject: [PATCH 14/15] KVM: ARM: Handle I/O aborts
In-Reply-To: <1349104329.2160.71.camel@linaro1.home>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153559.21241.29970.stgit@ubuntu>
 <20120927151108.GM25916@mudshark.cambridge.arm.com>
 <CANM98qKFKU98EWNaOepjxab3h5vQypxdt_YoJbKV9kd31XUfaw@mail.gmail.com>
 <20121001125326.GA2100@linaro.org>
 <1349104329.2160.71.camel@linaro1.home>
Message-ID: <20121001160725.GC2100@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 01, 2012 at 04:12:09PM +0100, Jon Medhurst (Tixy) wrote:
> On Mon, 2012-10-01 at 13:53 +0100, Dave Martin wrote:
> > On Sun, Sep 30, 2012 at 05:49:21PM -0400, Christoffer Dall wrote:
> > > On Thu, Sep 27, 2012 at 11:11 AM, Will Deacon <will.deacon@arm.com> wrote:
> > > > On Sat, Sep 15, 2012 at 04:35:59PM +0100, Christoffer Dall wrote:
> > > > I'm afraid you're not going to thank me much for this, but it's high time we
> > > > unified the various instruction decoding functions we have under arch/arm/
> > > > and this seems like a good opportunity for that. For example, look at the
> > > > following snippets (there is much more in the files I list) in addition to
> > > > what you have:
> > > >
> > > 
> > > I think it would be great if we had a set of unified decoding functions!
> > > 
> > > However, I think it's a shame if we can't merge KVM because we want to
> > > clean up this code. There would be nothing in the way of breaking API
> > > or anything like that preventing us from cleaning this up after the
> > > code has been merged.
> > > 
> > > Please consider reviewing the code for correctness and consider if the
> > > code could be merged as is.
> > > 
> > > On the other hand, if you or Dave or anyone else wants to create a set
> > > of patches that cleans this up in a timely manner, I will be happy to
> > > merge them for my code as well ;)
> > 
> > The time I would have available to put into this is rather limited, but
> > I have some initial ideas, as outlined below.
> > 
> > Tixy (who did the kprobes implementation, which is probably the most
> > sophisticated opcode handling we have in the kernel right now) may have
> > ideas too.  I would hope that any common framework could reuse a fair
> > chunk of his implementation and test coverage.
> 
> To my thinking, the kprobes code is very tailored to the job it needs to
> do and that turning it into something generic is just going to make
> everything bigger and more complex - because a generic framework would
> be bigger (as it's trying to be generic) and then things like kprobes
> will probably end up having an additional framework layered over the top
> to bend it to it's purposes. Perhaps I'm being too pessimistic.

Perhaps kprobes is a bit of a double-edged example.  It's an example of
an implementation with some good features, but because it is larger
the amount of adaptation required to convert to a common framework
would necessarily be larger also.

Yet, kprobes isn't trying to solve radically different problems from
other subsystems in the kernel.  It doesn't just want to descode and
manipulate the properties of instructions, it is actually interested in
many of the same properties (for example, whether an instruction is
a load or store, whether it modifies the PC etc.) as some other
subsystems.

I worry that by default every implementation of this ends up rather
deeply tailored to its correcponding subsystem -- so we gradually
accumulate more incompatible partially-overlapping duplicates of this
functionality over time.  This doesn't feel like a good thing.

> It would also requiring an inordinate amount of time to thrash out
> requirements, design, prototype, and to implement. (I don't think I'm
> being overly pessimistic about that ;-)
> 
> So, unless some-one has serious quantities of spare time lying around...

Well, I don't suggest that we should expect to get there in one go:
such an effort won't ever the off the ground for sure.

If we can consolidate a few simpler subsystems' opcode handling then
that would still be a step in the right direction, even if integrating
kprobes could not happen until much later.

If we do nothing, the situation will just gradually get worse.

Cheers
---Dave
