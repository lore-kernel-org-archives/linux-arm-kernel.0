From: luto@amacapital.net (Andy Lutomirski)
Date: Fri, 27 Jun 2014 16:40:13 -0700
Subject: [musl] Re: Thread pointer changes
In-Reply-To: <20140627233505.GA32514@n2100.arm.linux.org.uk>
References: <20140611145533.GT179@brightrain.aerifal.cx>
 <53ADC5B1.6080905@amacapital.net>
 <20140627200949.GQ32514@n2100.arm.linux.org.uk>
 <20140627210931.GT23102@port70.net>
 <20140627213051.GS32514@n2100.arm.linux.org.uk>
 <20140627215541.GC16724@brightrain.aerifal.cx>
 <20140627221744.GU32514@n2100.arm.linux.org.uk>
 <20140627223328.GB17988@brightrain.aerifal.cx>
 <20140627230736.GX32514@n2100.arm.linux.org.uk>
 <CALCETrVFvYNPHMozB2E2L0LWSPv=o6JHfmoz4_pBC2gQwRLpug@mail.gmail.com>
 <20140627233505.GA32514@n2100.arm.linux.org.uk>
Message-ID: <CALCETrVOabOU=NMz-GO1L_iu5QgVYoUOrYMzDDBMxYRy4W69ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 4:35 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jun 27, 2014 at 04:17:52PM -0700, Andy Lutomirski wrote:
>> On Fri, Jun 27, 2014 at 4:07 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > The kuser helpers can NOT be removed unless the CPU is v6k+.  Let me
>> > put that a different way: the kuser helpers can not be removed unless
>> > the ELF HWCAPs indicate TLS support.
>>
>> Why?  (This is an honest question -- there may be an excellent
>> answer.)  I understand why they're needed in the first place, but I
>> don't understand why they need to live at a fixed address.
>
> Just very briefly - and this will be my last reply on this until Monday,
> especially so as I've spent a solid 1h30 replying to the emails in this
> thread, and it's past midnight here.
>
> I referred to the problems in an earlier reply (maybe in a different
> sub-thread of this thread.)
>
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

Right, got it.

>
> As part of the TLS implementation for older CPUs, the TLS value is stored
> right at the top of that page, and on every context switch, we have to
> update that value.  If the page was at a randomised address, the kernel
> would either have to poke directly into userspace and flush it from the
> caches (which is error prone - what if userspace unmaps the page) or it
> has to do cache flushing to ensure that the value is visible via the
> user alias of the page.
>

Hmm.  Maybe some day there'll be a reliable way to track a vdso.  This
currently doesn't exist, but x86_32 will need it if CRIU will ever
work there.

If you ever want an ARM vdso (e.g. for timing), I'd be happy to help
and try to share code with x86.

--Andy
