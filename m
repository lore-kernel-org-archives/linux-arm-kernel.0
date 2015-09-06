From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Sep 2015 00:54:15 +0100
Subject: [PATCH] ARM: fix alignement of __bug_table section entries
In-Reply-To: <87egibw7yh.fsf@belgarion.home>
References: <1441175009-26730-1-git-send-email-robert.jarzmik@free.fr>
 <20150902103955.GF6281@e103592.cambridge.arm.com>
 <878u8lx9hl.fsf@belgarion.home>
 <20150905142519.GN21084@n2100.arm.linux.org.uk>
 <87y4gkx04m.fsf@belgarion.home>
 <20150905203818.GO21084@n2100.arm.linux.org.uk>
 <87lhcjwjde.fsf@belgarion.home>
 <20150906194805.GP21084@n2100.arm.linux.org.uk>
 <87egibw7yh.fsf@belgarion.home>
Message-ID: <20150906235414.GQ21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 06, 2015 at 11:31:34PM +0200, Robert Jarzmik wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> >> [1] Approach 1 : translation table sync
> >> =======================================
> ...
> > The important place is in arch/arm/include/asm/domain.h, which is where
> > we manipulate the DACR within probe_kernel_address().
> 
> Gah, silly me. But even with [1], I still get an error [2]. I have a
> confirmation that I have a "Page Permission" fault on the
> probe_kernel_address().

Hmm, that's not right.  If it's the DACR, then it should be a page domain
fault, not a page permission fault.

> [2] Oops
> ========
> # insmod /tmp/unalign.ko 
> RJK1: fsr=23 far=e1c23643 dacr=51
> RJK2: fsr=23 far=e1c23643 dacr=51
> RJK3: fsr=2f far=bf00202c dacr=51
> RJK: fault=4 instr=0x00000000 instrptr=bf00202c

Can you add a show_pte(current->mm, instrptr) to dump those page
table entries please?

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
