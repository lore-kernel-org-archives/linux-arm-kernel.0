From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Sep 2015 20:16:52 +0100
Subject: [PATCH] ARM: fix alignement of __bug_table section entries
In-Reply-To: <87egi6umi2.fsf@belgarion.home>
References: <87y4gkx04m.fsf@belgarion.home>
 <20150905203818.GO21084@n2100.arm.linux.org.uk>
 <87lhcjwjde.fsf@belgarion.home>
 <20150906194805.GP21084@n2100.arm.linux.org.uk>
 <87egibw7yh.fsf@belgarion.home>
 <20150906235414.GQ21084@n2100.arm.linux.org.uk>
 <877fo0x2ur.fsf@belgarion.home>
 <20150908200809.GC21084@n2100.arm.linux.org.uk>
 <87mvwvurae.fsf@belgarion.home> <87egi6umi2.fsf@belgarion.home>
Message-ID: <20150910191652.GJ21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 10, 2015 at 09:01:41PM +0200, Robert Jarzmik wrote:
> And I have the proof of gcc optimization, which I'll add to the commit message
> if you want :
> 00000728 <do_alignment>:
>      ...
>      770:	ee134f10 	mrc	15, 0, r4, cr3, cr0, {0}
>      ... no r4 or mrc/mcr usage
>      788:	e3842030 	orr	r2, r4, #48	; 0x30
>      ... no r2/r4 or mrc/mcr usage
>      794:	ee032f10 	mcr	15, 0, r2, cr3, cr0, {0}
>      798:	ee07cf95 	mcr	15, 0, ip, cr7, cr5, {4}
>      ... no r4 or mrc/mcr usage
>      7ac:	e3c4300c 	bic	r3, r4, #12
>      7b0:	e3833004 	orr	r3, r3, #4
>      7b4:	ee033f10 	mcr	15, 0, r3, cr3, cr0, {0}
>      ... no mrc/mcr usage
>      7cc:	ebfffffe 	bl	0 <arm_copy_from_user>
> 
> Here, we have in probe_kernel_address() in do_alignment():
>  - @770 : r4 = DACR
>  - @794 : DACR = r4 | 0x30
>  - @7b4 : DACR = (r4 & 0x0c) | 0x04 => the 0x30 is lost !!!
> 
> I'll send my patch to the mailing list tomorrow, as well as the other one to
> align the __bug_table session.

I've been wondering whether we can teach GCC that set_domain modifies
the value that get_domain returns, rather than throwing a volatile
onto the asm in get_domain.  The issue with a volatile there is that
even if the result is unused, but the code is reachable, gcc still has
to output the code to read the register.

We might be able to get away with a memory clobber on the set_domain,
and fake a memory read in get_domain, eg, by passing
	"m" (current_thread_info()->cpu_domain))
to the get_domain asm.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
