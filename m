From: dalias@libc.org (Rich Felker)
Date: Fri, 27 Jun 2014 20:20:48 -0400
Subject: [musl] Re: Thread pointer changes
In-Reply-To: <20140627233505.GA32514@n2100.arm.linux.org.uk>
References: <53ADC5B1.6080905@amacapital.net>
 <20140627200949.GQ32514@n2100.arm.linux.org.uk>
 <20140627210931.GT23102@port70.net>
 <20140627213051.GS32514@n2100.arm.linux.org.uk>
 <20140627215541.GC16724@brightrain.aerifal.cx>
 <20140627221744.GU32514@n2100.arm.linux.org.uk>
 <20140627223328.GB17988@brightrain.aerifal.cx>
 <20140627230736.GX32514@n2100.arm.linux.org.uk>
 <CALCETrVFvYNPHMozB2E2L0LWSPv=o6JHfmoz4_pBC2gQwRLpug@mail.gmail.com>
 <20140627233505.GA32514@n2100.arm.linux.org.uk>
Message-ID: <20140628002048.GB19165@brightrain.aerifal.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 28, 2014 at 12:35:05AM +0100, Russell King - ARM Linux wrote:
> On Fri, Jun 27, 2014 at 04:17:52PM -0700, Andy Lutomirski wrote:
> > On Fri, Jun 27, 2014 at 4:07 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > > The kuser helpers can NOT be removed unless the CPU is v6k+.  Let me
> > > put that a different way: the kuser helpers can not be removed unless
> > > the ELF HWCAPs indicate TLS support.
> > 
> > Why?  (This is an honest question -- there may be an excellent
> > answer.)  I understand why they're needed in the first place, but I
> > don't understand why they need to live at a fixed address.
> 
> Just very briefly - and this will be my last reply on this until Monday,
> especially so as I've spent a solid 1h30 replying to the emails in this
> thread, and it's past midnight here.

Understood. Don't feel like you have to reply to the further emails in
this thread; we can wait until you have time.

> To answer your "why" (which I'll take as "why can't they be removed")
> the reason for that is the lack of TLS support.  If the kuser page
> is removed _and_ there is no hardware TLS support, then there is no way
> for userspace to have TLS.
> 
> As for your second bit (about why they need to live at a fixed address)
> we could have randomised it on v6 and later CPUs, but there are some
> v6 CPUs which suffer from data cache aliasing, just like all the previous
> CPUs.  With the data cache aliasing, it would make the TLS implementation
> a lot more complex.
> 
> As part of the TLS implementation for older CPUs, the TLS value is stored
> right at the top of that page, and on every context switch, we have to
> update that value.  If the page was at a randomised address, the kernel
> would either have to poke directly into userspace and flush it from the
> caches (which is error prone - what if userspace unmaps the page) or it
> has to do cache flushing to ensure that the value is visible via the
> user alias of the page.
> 
> If it wasn't for this need, we would have probably gone for a VDSO from
> the start.

Thank you for taking the time to give the technical explanation of why
it is the way it is. That makes a lot more sense, and indeed it makes
the option of having a randomized address seem a lot less attractive.

Rich
