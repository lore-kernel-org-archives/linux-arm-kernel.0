From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 19 May 2010 08:45:18 -0600
Subject: Boot interface for device trees on ARM
In-Reply-To: <20100519065015.GQ25892@yookeroo>
References: <201005181054.32325.jeremy.kerr@canonical.com>
	<alpine.LFD.2.00.1005172341200.12758@xanadu.home>
	<201005181324.45701.jeremy.kerr@canonical.com>
	<20100518084954.GC25892@yookeroo>
	<alpine.LFD.2.00.1005180802010.12758@xanadu.home>
	<20100519002826.GG25892@yookeroo>
	<alpine.LFD.2.00.1005182109180.12758@xanadu.home>
	<20100519065015.GQ25892@yookeroo>
Message-ID: <AANLkTikQOXrOSZjZ1OqFBhO0wkhirkHLR_Q-iuu7SBuP@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 19, 2010 at 12:50 AM, David Gibson
<david@gibson.dropbear.id.au> wrote:
> On Tue, May 18, 2010 at 09:28:38PM -0400, Nicolas Pitre wrote:
>> On Wed, 19 May 2010, David Gibson wrote:
>>
>> > On Tue, May 18, 2010 at 08:24:06AM -0400, Nicolas Pitre wrote:
>> > > On Tue, 18 May 2010, David Gibson wrote:
>> > > > On Tue, May 18, 2010 at 01:24:43PM +0800, Jeremy Kerr wrote:
>> > > > > Nicolas Pitre wrote:
>> > [snip]
>> > > > The only reason you'd need a subarchitecture number or equivalent is
>> > > > if you need to do things differently in the very, very early asm boot
>> > > > code. ?We may need a minimal form of this on PowerPC if we ever
>> > > > support multiple MMU families in the same kernel binary.
>> > >
>> > > Exact. ?For example, on ARM the machine ID is also used to figure out
>> > > the MMU mapping needed to be able to simply be able to debug the very
>> > > early assembly boot stage when there isn't even a stack available. While
>> > > this info is stored in the machine record, it is actually
>> > > subarchitecture specific and already half-digested for easy usage by
>> > > that initial MMU setup. ?I just don't want to imagine what the
>> > > equivalent functionality with DT would look like.
>> >
>> > Well, it wouldn't be *that* bad - you'd need a minimal asm-only tree
>> > walker to find and look up the compatible property. ?Quite possible
>> > but, yes, fairly awkward.
>> >
>> > Yeah, if you have to make really early MMU decisions based on
>> > subarchitecture it probbaly makes sense to have a simple ID for
>> > those. ?So one thing to consider here is that we've contemplated
>> > adding an "MMU family" ID to the device tree blob header for this
>> > purpose on PowerPC. ?If we did such a thing, it could also be used on
>> > ARM for a similar purpose. ?Then all the relevant machine information
>> > is in one block, and it's just a simple fixed dereference to extract
>> > the MMU type from the early asm.
>> >
>> > I'd have to talk to Ben et al, but I think we'd be happy enough to
>> > create a new dtb v18 which included that field, as well as a couple of
>> > other small improvements to the header and blob internals. ?ARM could
>> > standardize on that as the minimum acceptable dtb version.
>>
>> I still don't get it. ?Why on earth would you insist on replacing the
>> already existing ID value that is _already_ passed to the kernel by all
>> ARM bootloaders with something evidently far more complex?
>
> Um.. no. ?It's not more complex at all. ?We're talking about this ID
> in the dt blob's header, not in the device tree itself. ?As I said,
> it's one dereference to get to the ID, from the DT address which is
> being passed in. ?i.e. *one* more instruction than having it passed in
> register.
>
> There are two advantages, both small, but contrary to your assertion
> it's not significantly more complex, so they don't need to be big.
> ? ? ? ?1) It means the DT blob contains *all* the information you
> need about the machine. ?If you have multi-stage bootloaders, you can
> copy that blob and know you've got everything.
> ? ? ? ?2) It means we could have information with a similar purpose
> in the same place for both PowerPC and ARM (and maybe others in
> future).

Regardless, I think Nicolas is right.  While there is value in common
methods between architectures, I don't think this case warrants it
when the existing method works fine and changing it is
non-backwards-compatible.

g.
