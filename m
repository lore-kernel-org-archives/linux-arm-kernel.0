From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 12 Jan 2011 10:16:44 -0700
Subject: [RFC] arm: Defer lookup of machine_type and vet of atags to
	setup.c
In-Reply-To: <alpine.LFD.2.00.1101121145430.24532@xanadu.home>
References: <20110111015409.18291.87166.stgit@localhost6.localdomain6>
	<20110111104051.GA11039@n2100.arm.linux.org.uk>
	<20110111153630.GB2707@angua.secretlab.ca>
	<20110111154833.GF11039@n2100.arm.linux.org.uk>
	<AANLkTi=29LB66j123ufMHQk=46hGYdmR4nZZQFnN=Tku@mail.gmail.com>
	<20110112155215.GB11039@n2100.arm.linux.org.uk>
	<AANLkTinwGd9pa7YQ=5hXfarw=MB=YdpBuN7xJAd+Ps4f@mail.gmail.com>
	<alpine.LFD.2.00.1101121145430.24532@xanadu.home>
Message-ID: <AANLkTinPibTVUu2zoMbDYnSWXGvB6dVjCp54DoN9S1p3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 12, 2011 at 9:53 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Wed, 12 Jan 2011, Grant Likely wrote:
>
>> Actually it looks like the real problem is that the mmu has been
>> turned on, but the virtual mappings for devices have not yet been
>> established, and so the debug macros aren't using a valid address.
>
> A temporary virtual mapping should be there -- look for addruart in
> head.S.

Hi Russell and Nicolas,

Oops, yes all the early debug stuff works fine.  Stupid human trick on
my end, but I've sorted it out now.  Thanks for the help.  I'll have
patches to post later today.

g.

>
>> I'm using printk to get output into the ring buffer in my patch to
>> rework lookup_machine_type() in C, and that does indeed output to the
>> ring buffer, but the kernel cannot spit stuff out the serial port.
>>
>> It looks like I'd need to get past paging_init() in order to get
>> ll_debug working between turning on the mmu and paging_init(), but
>> paging_init() needs the mdesc pointer, and the whole point of the
>> error message is that the mdesc pointer is unknown! ?I don't see any
>> code that sets up a debug mapping of the uart before paging_init time.
>
> See above.
>
>> ?I could try to implement something like that, but it is looking to be
>> more complicated than it is worth when the current code works just
>> fine.
>
> My bet is that there is a bug with the current code that you are
> exposing.
>
>> Let me know if I've missed something, but I think I should drop the
>> removal of __lookup_machine_type from head.S from my patch.
>
> It's not the location of that code which is a problem. ?Even if you
> leave that code in place, you want to call it later and I bet that the
> display would be broken even if __lookup_machine_type doesn't move.
>
>
> Nicolas
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
