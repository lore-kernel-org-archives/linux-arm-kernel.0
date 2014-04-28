From: will.deacon@arm.com (Will Deacon)
Date: Mon, 28 Apr 2014 20:10:46 +0100
Subject: [PATCH] ARM: fix string functions on !MMU
In-Reply-To: <20140425184510.GA17229@debian>
References: <1398103808-24380-1-git-send-email-rabin@rab.in>
 <20140422094424.GA6979@arm.com> <20140424154320.GA4129@debian>
 <20140425091224.GA24499@arm.com> <20140425184510.GA17229@debian>
Message-ID: <20140428191046.GB22135@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 25, 2014 at 07:45:10PM +0100, Rabin Vincent wrote:
> On Fri, Apr 25, 2014 at 10:12:24AM +0100, Will Deacon wrote:
> > On Thu, Apr 24, 2014 at 04:43:20PM +0100, Rabin Vincent wrote:
> > > On Tue, Apr 22, 2014 at 10:44:24AM +0100, Will Deacon wrote:
> > > > On Mon, Apr 21, 2014 at 07:10:08PM +0100, Rabin Vincent wrote:
> > > > > 8c56cc8be5b38e ("ARM: 7449/1: use generic strnlen_user and
> > > > > strncpy_from_user functions") apparently broken those string operations
> > > > > for !MMU.  USER_DS == KERNEL_DS on !MMU, so user_addr_max() always
> > > > > restricts the addresses to TASK_SIZE.
> > > > > 
> > > > > TASK_SIZE has anyway no meaning on !MMU, so make user_addr_max() not
> > > > > restrict anything.
> > > > 
> > > > Might be worth mentioning that this is an issue because KERNEL_DS is 0x0
> > > > (since it's a 32-bit quantity), so checks like addr < user_addr_max() will
> > > > fail.
> > > 
> > > Thanks for the ack, but I don't quite understand what you mean here.
> > > You describe the state before this patch, right?  Why does it matter
> > > that KERNEL_DS is 0x0?
> > 
> > Apologies, I misread the code that you're patching so I guess I'll have to
> > revoke my ack, sorry! That's not to say I think the patch is bad, I'd just
> > like to discuss it with you a bit more.
> > 
> > Having re-read the code, the issue is because TASK_SIZE is defined as
> > CONFIG_DRAM_SIZE, right? Since CONFIG_DRAM_BASE may be non-zero, it means
> > TASK_SIZE is truly a size -- not a limit (as it would be in virtual space).
> > What we actually want for !MMU is END_MEM instead of TASK_SIZE.
> 
> I guess you mean I should #define user_addr_max() to END_MEM for !MMU?
> That won't work.  For example, on a !MMU boot, the first thing that
> fails because of this bug is devtmpsfs_mount() -> sys_mount() ->
> copy_mount_string() -> strndup_user(), which is run in a kernel thread.
> The type argument of sys_mount() points to a string in flash since we
> run an XIP kernel.  This flash address has no relation to END_MEM (which
> is nothing but CONFIG_DRAM_BASE + CONFIG_DRAM_SIZE) and could be higher
> than END_MEM.

Good point, I hadn't considered XIP with flash regions. In which case, I
don't think we have any choice but to use ~0UL as the limit. It looks like
Uwe has taken a quick look at some other users of TASK_SIZE, so I'll leave
you two to complete the audit ;)

Will
