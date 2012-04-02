From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Apr 2012 23:52:23 +0100
Subject: [PATCH v5 06/27] irq_domain/powerpc: eliminate irq_map; use
 irq_alloc_desc() instead
In-Reply-To: <1333406005.30734.61.camel@pasglop>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-7-git-send-email-grant.likely@secretlab.ca>
 <m2iphj3zxr.fsf@igel.home> <m2hax2qeqs.fsf@igel.home>
 <20120402202848.1EB833E02A7@localhost>
 <20120402215524.GM24211@n2100.arm.linux.org.uk>
 <1333406005.30734.61.camel@pasglop>
Message-ID: <20120402225223.GN24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 03, 2012 at 08:33:25AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2012-04-02 at 22:55 +0100, Russell King - ARM Linux wrote:
> > Well, presumably someone is calling irq_set_irq_type() asking explicitly
> > for IRQ_TYPE_NONE.  The code will now (as it always used to before David's
> > change) do exactly what you ask this to: it will ask the type to be set
> > to none.
> > 
> > If you don't want to set the type to none, don't call the interface asking
> > for that to happen. 
> 
> I think part of the idea with NONE is to use it as "reset that interrupt
> to the "default" setting, whatever that means ...

No, it never was (anyone who thought that is plain wrong because that
wasn't my original design.)

NONE really did mean "I don't want any trigger level" for set_irq_type()
as it was originally designed on ARM, and there's a number of PCMCIA
socket drivers which rely on that behaviour: the reason is that with
edge triggered interrupts, Linux normally remembers edges which happen
with the interrupt disabled, and delivers those events when the interrupt
is re-enabled.  There are situations (such as edge triggered status GPIOs)
where we _really_ do want to ignore transitions on an edge triggered
input.  And PCMCIA soc_common uses set_irq_type() with NONE to do this.

The reason you can't request an interrupt with a NONE type is because
I saw that to be pointless - and in any case, the type is a bitmask and
NONE ended up being zero.  Zero is also what you get with request_irq()
used with drivers which don't pass any IRQ trigger flags, so request_irq()
has to ignore this case.

Now, arguably, we could say that there should be an interface for clearing
pending edges in our interrupt model, but traditionally there hasn't been,
even when my ARM IRQ stuff was moved forward into genirq.  However,
subsequently changing genirq in a way which breaks previously working
stuff is a regression, and that's what my revert addresses.

If we want to fix it a better way, then sure, that'll be good.  But what
we shouldn't do is re-introduce one regression to fix a different
regression.

So, Thomas, what do you think about providing a way that a disabled
interrupt could have its pending status cleared such that when it's
enabled, any queued events are ignored?  Maybe an enable_and_clear_irq() ?
