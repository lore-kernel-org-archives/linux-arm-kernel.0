From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 16 Nov 2011 19:14:35 +0000
Subject: [PATCH 3/5] ARM: vexpress: Add DT support in v2m
In-Reply-To: <1321465054.3137.386.camel@hornet.cambridge.arm.com>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
 <1321036026-23411-4-git-send-email-pawel.moll@arm.com>
 <20111116154402.GE2073@localhost.localdomain>
 <4EC3E446.4030608@gmail.com>
 <1321461458.3137.374.camel@hornet.cambridge.arm.com>
 <4EC3EBEC.3020601@gmail.com>
 <1321463271.3137.380.camel@hornet.cambridge.arm.com>
 <1321465054.3137.386.camel@hornet.cambridge.arm.com>
Message-ID: <20111116191435.GL2073@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2011 at 05:37:34PM +0000, Pawel Moll wrote:
> On Wed, 2011-11-16 at 17:07 +0000, Pawel Moll wrote:
> > > > I'd rather second Dave's idea of having
> > > > 
> > > >>> 	compatible = "arm,vexpress-<model>", "arm-vexpress-rs1", "arm-vexpress";
> > > > 
> > > > and
> > > > 
> > > >>> +	compatible = "arm,vexpress-<model>", "arm,vexpress-legacy", "arm-vexpress";
> > > 
> > > If arm,vexpress-ca9 is the only legacy platform, then just drop
> > > arm,vexpress-legacy altogether.
> > 
> > It's not. There is additional one, which is not publicly available, but
> > is using the motherboard in legacy mode.
> 
> Alternatively, I could add motherboard node property, something like:
> 
> / {
>         motherboard {
> 		arm,v2m-memory-map = "legacy";
> 
> and
> 
> / {
>         motherboard {
> 		arm,v2m-memory-map = "rs1";
> 
> That way the "legacies" and "rses" will disappear from the main
> compatible value:
> 
> 	compatible = "arm,vexpress-<model>", "arm-vexpress";
> 
> and everyone will be happy :-) There will be a bit more hassle with
> getting this property in v2m.c, but not too much. Does it make any
> sense?

Yes, I think this will work.

Because this value is not used for driver binding etc., there's no need
for it to be a compatible string: a property is just fine.  So, actually
it may be better.


Because this is a new binding, we can also describe _exactly_ the meaning
of this property being absent.  In other words, we can say that if the
am,v2m-memory-map property is absent, the memory map is the legacy
memory map.  If the property is present with value "rs1", we have the
rs1 memory map.  We can easily add extra values in the future as needed,
without any risk of incompatibility with the legacy case.

So how about:

// Legacy case
/ {
	motherboard {
		// arm,v2m-memory-map absent


// RS1 case
/ {
	motherboard {
		arm,v2m-memory-map = "rs1";

If you prefer an explicit = "legacy" for the legacy case though,
I'm fine with that too.


When we remove compatible strings from the compatible set on the other
hand, the device described by the node just becomes more and more
general which isn't what we want: legacy is not a generalisation of rs1,
nor vice versa; they are just plain different.  Because properties
don't have these implies generalisation/specialisation semantics, we
don't have this problem when using a property.

Cheers
---Dave
