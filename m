From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 12 Jan 2011 09:24:34 -0700
Subject: [RFC] arm: Defer lookup of machine_type and vet of atags to
	setup.c
In-Reply-To: <20110112155215.GB11039@n2100.arm.linux.org.uk>
References: <20110111015409.18291.87166.stgit@localhost6.localdomain6>
	<20110111104051.GA11039@n2100.arm.linux.org.uk>
	<20110111153630.GB2707@angua.secretlab.ca>
	<20110111154833.GF11039@n2100.arm.linux.org.uk>
	<AANLkTi=29LB66j123ufMHQk=46hGYdmR4nZZQFnN=Tku@mail.gmail.com>
	<20110112155215.GB11039@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinwGd9pa7YQ=5hXfarw=MB=YdpBuN7xJAd+Ps4f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 12, 2011 at 8:52 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jan 12, 2011 at 08:46:44AM -0700, Grant Likely wrote:
>> Looks like I've hit a hiccup though. ?When I remove the first call to
>> __lookup_machine_type, then it is only called after the MMU is turned
>> on and the kernel is no longer able to output the list of configured
>> machine ids when it doesn't recognize the value in r1 (tested with
>> qemu versatile emulation). ?I'm still investigating, so I'll defer
>> reposting the patch until I've got this issue solved.
>
> It only does this when DEBUG_LL is enabled - at which point you have
> printascii, printhex8, etc available (although there's no prototype
> for them.)
>
> You could use snprintf() to format a message and then use printascii()
> (conditional on CONFIG_DEBUG_LL as the existing code does) as well as
> printk("%s", buffer). ?That means if you have a debugger you can dump
> the kernel ring buffer and see the message, or see it via the serial
> port/debugging channel if DEBUG_LL is enabled.

Actually it looks like the real problem is that the mmu has been
turned on, but the virtual mappings for devices have not yet been
established, and so the debug macros aren't using a valid address.
I'm using printk to get output into the ring buffer in my patch to
rework lookup_machine_type() in C, and that does indeed output to the
ring buffer, but the kernel cannot spit stuff out the serial port.

It looks like I'd need to get past paging_init() in order to get
ll_debug working between turning on the mmu and paging_init(), but
paging_init() needs the mdesc pointer, and the whole point of the
error message is that the mdesc pointer is unknown!  I don't see any
code that sets up a debug mapping of the uart before paging_init time.
 I could try to implement something like that, but it is looking to be
more complicated than it is worth when the current code works just
fine.

Let me know if I've missed something, but I think I should drop the
removal of __lookup_machine_type from head.S from my patch.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
