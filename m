From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Jan 2012 16:05:16 +0000
Subject: [PATCH 4/4] ARM: add jump label support
In-Reply-To: <20120124154353.GA4304@debian>
References: <1321888429-3519-1-git-send-email-rabin@rab.in>
 <1321888429-3519-4-git-send-email-rabin@rab.in>
 <20111122194213.GC9581@n2100.arm.linux.org.uk> <20120124154353.GA4304@debian>
Message-ID: <20120124160516.GC12326@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2012 at 09:13:53PM +0530, Rabin Vincent wrote:
> On Tue, Nov 22, 2011 at 07:42:13PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Nov 21, 2011 at 08:43:49PM +0530, Rabin Vincent wrote:
> > > +static inline unsigned long
> > > +arm_gen_nop(void)
> > > +{
> > > +#ifdef CONFIG_THUMB2_KERNEL
> > > +	return 0xf3af8000; /* nop.w */
> > > +#elif defined(CONFIG_CPU_32v6K)
> > > +	return 0xe320f000; /* nop */
> > > +#else
> > > +	return 0xe1a00000; /* mov r0, r0 */
> > 
> > There really is no point making the distinction between the new nop
> > and the old nop instructions.  The difference between them is that the
> > new nop is a true 'no operation' whereas the old nop causes exactly
> > what the instruction says to happen - which in effect is a no-op.
> > 
> > Obviously, doing a true no-operation may require in less power, but
> > if you're using this code, you're debugging, so power usage isn't
> > really a concern.  So lets keep the code simple and just use the old
> > nop here.  It won't go away.
> 
> Is "if you're using this code, you're debugging" really correct here?
> Because the the purpose of jump labels is to reduce the overhead of
> tracepoints when they aren't activated, i.e. when you're not actively
> debugging.

Let me repeat: the difference is power.  Nothing more nothing less.
'nop' was invented to allow some vendors to 'optimize' nop from
a power management point of view.  Nothing more, nothing less.

'nop' will be executed as a true 'no operation' where as 'mov r0, r0'
will tell the CPU to load the value of r0 and store it back into the
register - which involves doing an operation.

There's no difference between "nop" vs "mov r0, r0" in terms of
performance.  It's purely a power thing.

If you have tracepoints enabled, then you're taking a performance
hit anyway by having all those sites inserted.  So, the only time
you'd sanely enable them is if you're doing development work.
You wouldn't enable them for production, unless you had some
desire to waste CPU cycles needlessly in your end users products
(maybe you're trying to go for the worlds slowest device?)
