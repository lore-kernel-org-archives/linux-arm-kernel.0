From: rabin@rab.in (Rabin Vincent)
Date: Tue, 24 Jan 2012 21:13:53 +0530
Subject: [PATCH 4/4] ARM: add jump label support
In-Reply-To: <20111122194213.GC9581@n2100.arm.linux.org.uk>
References: <1321888429-3519-1-git-send-email-rabin@rab.in>
 <1321888429-3519-4-git-send-email-rabin@rab.in>
 <20111122194213.GC9581@n2100.arm.linux.org.uk>
Message-ID: <20120124154353.GA4304@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 07:42:13PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 21, 2011 at 08:43:49PM +0530, Rabin Vincent wrote:
> > +static inline unsigned long
> > +arm_gen_nop(void)
> > +{
> > +#ifdef CONFIG_THUMB2_KERNEL
> > +	return 0xf3af8000; /* nop.w */
> > +#elif defined(CONFIG_CPU_32v6K)
> > +	return 0xe320f000; /* nop */
> > +#else
> > +	return 0xe1a00000; /* mov r0, r0 */
> 
> There really is no point making the distinction between the new nop
> and the old nop instructions.  The difference between them is that the
> new nop is a true 'no operation' whereas the old nop causes exactly
> what the instruction says to happen - which in effect is a no-op.
> 
> Obviously, doing a true no-operation may require in less power, but
> if you're using this code, you're debugging, so power usage isn't
> really a concern.  So lets keep the code simple and just use the old
> nop here.  It won't go away.

Is "if you're using this code, you're debugging" really correct here?
Because the the purpose of jump labels is to reduce the overhead of
tracepoints when they aren't activated, i.e. when you're not actively
debugging.
