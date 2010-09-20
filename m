From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Sep 2010 11:50:19 +0100
Subject: [RFC] mmaping with VIVT cache
In-Reply-To: <a4e3b92bbd5f9f04fa06dd5d3f2f160a@cox.rootnode.net>
References: <589851.42712.qm@web120206.mail.ne1.yahoo.com>
	<20100917210649.GA18343@n2100.arm.linux.org.uk>
	<a4e3b92bbd5f9f04fa06dd5d3f2f160a@cox.rootnode.net>
Message-ID: <20100920105019.GB30793@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 20, 2010 at 11:38:44AM +0100, Pawel Moll wrote:
> > However, in this case, architectures using VIPT aliasing caches will
> > also trip over it - has anyone used this webcam on something like
> > Sparc or powerpc?  I'm guessing that it'll fail there too...
> 
> It wasn't a webcam but USB audio card, not sparc nor powerpc but sh but
> the I believe problem stays the same - vmalloc-ed buffer mapped into the
> user-space...
> 
> http://thread.gmane.org/gmane.linux.alsa.devel/55882/focus=7160
> 
> I've ended up with pgprot_noncached(), as there was no "alias-safe API"
> available, and apparently it's still the case? ;-)

pgprot_noncached will be unsafe on ARMv6 and ARMv7 architectures when
used for mapping existing memory, as you'll be violating an architectural
restriction (having aliasing mappings of memory as 'Strongly ordered'
when there is a pre-existing 'Memory' type mapping.)
