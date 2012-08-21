From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Aug 2012 10:11:40 +0000
Subject: [PATCH] ARM: io: avoid writeback addressing modes for __raw_
 accessors
In-Reply-To: <20120821090213.GE28660@mudshark.cambridge.arm.com>
References: <1344956366-32574-1-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.02.1208201443070.1754@xanadu.home>
 <20120821090213.GE28660@mudshark.cambridge.arm.com>
Message-ID: <201208211011.41093.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 August 2012, Will Deacon wrote:
> On Mon, Aug 20, 2012 at 07:45:20PM +0100, Nicolas Pitre wrote:
> > On Mon, 20 Aug 2012, Will Deacon wrote:
> > > On Mon, Aug 20, 2012 at 07:04:01PM +0100, Nicolas Pitre wrote:
> > > > Nah... the const is wrong.  The way you wrote it means that addr may 
> > > > change but the pointed data is constant.  This is obviously wrong since 
> > > > we expect the pointed location to change even from a read.
> > > 
> > > That's the prototype for the read accessors though -- a bunch of other
> > > architectures define them that way (including asm-generic), so I wonder what
> > > the reasoning behind that was?
> > 
> > I'm still asserting that they're wrong.
> 
> I did a bit of digging around and `const volatile void *' is apparently used
> because a function with such a parameter type can be passed any old pointer
> without warnings. Torvalds says something about them here:
> 
>   http://readlist.com/lists/vger.kernel.org/linux-kernel/14/72300.html
> 
> Personally, I too think that the const is misleading and who on Earth would
> be passing in pointers to const for an I/O region? However, it's an argument
> I'd rather avoid so, for the sake of consistency, I'll cast away the const in
> the asm block.
> 

You could have a read-only register area, and I would regard it as sensible
to mark a pointer to it as "const", although there should not be any
optimizations based on that.

There is no need to cast away the constness of the pointer when passing
it into the inline assembly, as the "asm volatile" already implies that
gcc cannot remove the contents.

On a related topic, thank you very much for introducing the inline
assemblies here, as they finally solve a lingering problem that has
hit us in the past [1] and that could happen again in other drivers.

	Arnd

[1] http://old.nabble.com/ARM-unaligned-MMIO-access-with-attribute%28%28packed%29%29-td30827280.html
