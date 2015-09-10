From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 10 Sep 2015 21:01:41 +0200
Subject: [PATCH] ARM: fix alignement of __bug_table section entries
In-Reply-To: <87mvwvurae.fsf@belgarion.home> (Robert Jarzmik's message of
 "Thu, 10 Sep 2015 01:06:01 +0200")
References: <20150902103955.GF6281@e103592.cambridge.arm.com>
 <878u8lx9hl.fsf@belgarion.home>
 <20150905142519.GN21084@n2100.arm.linux.org.uk>
 <87y4gkx04m.fsf@belgarion.home>
 <20150905203818.GO21084@n2100.arm.linux.org.uk>
 <87lhcjwjde.fsf@belgarion.home>
 <20150906194805.GP21084@n2100.arm.linux.org.uk>
 <87egibw7yh.fsf@belgarion.home>
 <20150906235414.GQ21084@n2100.arm.linux.org.uk>
 <877fo0x2ur.fsf@belgarion.home>
 <20150908200809.GC21084@n2100.arm.linux.org.uk>
 <87mvwvurae.fsf@belgarion.home>
Message-ID: <87egi6umi2.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>
>> On Tue, Sep 08, 2015 at 07:01:00PM +0200, Robert Jarzmik wrote:
>>> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>> At the point we call into this code, the DACR should be 0x75, which
>> should allow us to read the instruction at 0xbf00202c.  But this is
>> failing with a permission error - which it would do if it thought
>> the kernel domain was in manager mode (iow, 0x55).
>
> Okay Russell, I have a good idea what's happening now. Basically, it boils down
> to compiler optimization of get_domain() which is called twice (set_fs() ->
> modify_domain() -> get_domain()). See the piece in [1] for a more complete
> explanation.
>
> I still haven't finished my work, as I need to disassemble the do_alignment()
And I have the proof of gcc optimization, which I'll add to the commit message
if you want :
00000728 <do_alignment>:
     ...
     770:	ee134f10 	mrc	15, 0, r4, cr3, cr0, {0}
     ... no r4 or mrc/mcr usage
     788:	e3842030 	orr	r2, r4, #48	; 0x30
     ... no r2/r4 or mrc/mcr usage
     794:	ee032f10 	mcr	15, 0, r2, cr3, cr0, {0}
     798:	ee07cf95 	mcr	15, 0, ip, cr7, cr5, {4}
     ... no r4 or mrc/mcr usage
     7ac:	e3c4300c 	bic	r3, r4, #12
     7b0:	e3833004 	orr	r3, r3, #4
     7b4:	ee033f10 	mcr	15, 0, r3, cr3, cr0, {0}
     ... no mrc/mcr usage
     7cc:	ebfffffe 	bl	0 <arm_copy_from_user>

Here, we have in probe_kernel_address() in do_alignment():
 - @770 : r4 = DACR
 - @794 : DACR = r4 | 0x30
 - @7b4 : DACR = (r4 & 0x0c) | 0x04 => the 0x30 is lost !!!

I'll send my patch to the mailing list tomorrow, as well as the other one to
align the __bug_table session.

Cheers.

--
Robert
