From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Jul 2012 22:06:37 +0100
Subject: [PATCH 1/1 v2] ARM: only call smp_send_stop() on SMP
In-Reply-To: <20120727204447.GA10024@mudshark.cambridge.arm.com>
References: <1340533690-4049-1-git-send-email-javier@dowhile0.org>
 <20120625005134.GA2342@S2101-09.ap.freescale.net>
 <20120625084905.GD19226@n2100.arm.linux.org.uk>
 <CAAwP0s2jTPM_ErDOFKXoe95_Xd=xjkuTAsDbLctQ08_QVNkakQ@mail.gmail.com>
 <5012CC98.60206@ti.com> <20120727204447.GA10024@mudshark.cambridge.arm.com>
Message-ID: <20120727210637.GA16377@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2012 at 09:44:47PM +0100, Will Deacon wrote:
> On Fri, Jul 27, 2012 at 06:15:04PM +0100, Jon Hunter wrote:
> > Hi Javier,
> > 
> > On 06/25/2012 05:31 AM, Javier Martinez Canillas wrote:
> > > On Mon, Jun 25, 2012 at 10:49 AM, Russell King - ARM Linux
> > > <linux@arm.linux.org.uk> wrote:
> > >> On Mon, Jun 25, 2012 at 08:51:37AM +0800, Shawn Guo wrote:
> > >>> It seems the same patch has been there for a while.
> > >>>
> > >>> http://thread.gmane.org/gmane.linux.kernel/1303115
> > >>
> > >> Bah, why doesn't stuff like this get resent if nothing has happened for
> > >> a while?
> > > 
> > > Indeed. At least other people that face the same issue (like me) sends
> > > similar patches to remind you :-)
> > 
> > I checked with Russell but this one is not in his patch tracking system
> > [1] and so still not queued. Can you submit this? Would be great to get
> > this one in.
> 
> I did comment on this one:
> 
>   http://thread.gmane.org/gmane.linux.kernel/1303115
> 
> and I really think we should fix the cause of the problem, rather than
> point patching this instance of it.

What do you think needs fixing there?

We support booting a kernel on systems with or without SMP support, even
with a SMP kernel.  When the kernel is booted on such a system, it is
undefined whether smp_cross_call() is a valid function pointer.

In any case, when we have only one CPU online in the system, it is
pointless even calling smp_cross_call().

That is why I explicitly suggested this solution.  This is the solution
_I_ want, because it is the most sane solution all round.
