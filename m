From: will.deacon@arm.com (Will Deacon)
Date: Fri, 25 Apr 2014 10:12:24 +0100
Subject: [PATCH] ARM: fix string functions on !MMU
In-Reply-To: <20140424154320.GA4129@debian>
References: <1398103808-24380-1-git-send-email-rabin@rab.in>
 <20140422094424.GA6979@arm.com> <20140424154320.GA4129@debian>
Message-ID: <20140425091224.GA24499@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rabin,

On Thu, Apr 24, 2014 at 04:43:20PM +0100, Rabin Vincent wrote:
> On Tue, Apr 22, 2014 at 10:44:24AM +0100, Will Deacon wrote:
> > On Mon, Apr 21, 2014 at 07:10:08PM +0100, Rabin Vincent wrote:
> > > 8c56cc8be5b38e ("ARM: 7449/1: use generic strnlen_user and
> > > strncpy_from_user functions") apparently broken those string operations
> > > for !MMU.  USER_DS == KERNEL_DS on !MMU, so user_addr_max() always
> > > restricts the addresses to TASK_SIZE.
> > > 
> > > TASK_SIZE has anyway no meaning on !MMU, so make user_addr_max() not
> > > restrict anything.
> > 
> > Might be worth mentioning that this is an issue because KERNEL_DS is 0x0
> > (since it's a 32-bit quantity), so checks like addr < user_addr_max() will
> > fail.
> 
> Thanks for the ack, but I don't quite understand what you mean here.
> You describe the state before this patch, right?  Why does it matter
> that KERNEL_DS is 0x0?

Apologies, I misread the code that you're patching so I guess I'll have to
revoke my ack, sorry! That's not to say I think the patch is bad, I'd just
like to discuss it with you a bit more.

Having re-read the code, the issue is because TASK_SIZE is defined as
CONFIG_DRAM_SIZE, right? Since CONFIG_DRAM_BASE may be non-zero, it means
TASK_SIZE is truly a size -- not a limit (as it would be in virtual space).
What we actually want for !MMU is END_MEM instead of TASK_SIZE.

Will
