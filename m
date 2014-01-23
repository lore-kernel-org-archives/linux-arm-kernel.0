From: wangnan0@huawei.com (Wang Nan)
Date: Thu, 23 Jan 2014 10:16:37 +0800
Subject: [PATCH 2/3] ARM: kexec: copying code to ioremapped area
In-Reply-To: <20140122132734.GB15937@n2100.arm.linux.org.uk>
References: <1390389916-8711-1-git-send-email-wangnan0@huawei.com>
 <1390389916-8711-3-git-send-email-wangnan0@huawei.com>
 <20140122132734.GB15937@n2100.arm.linux.org.uk>
Message-ID: <52E07B85.6030709@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/1/22 21:27, Russell King - ARM Linux wrote:
> On Wed, Jan 22, 2014 at 07:25:15PM +0800, Wang Nan wrote:
>> ARM's kdump is actually corrupted (at least for omap4460), mainly because of
>> cache problem: flush_icache_range can't reliably ensure the copied data
>> correctly goes into RAM.
> 
> Quite right too.  You're mistake here is thinking that flush_icache_range()
> should push it to RAM.  That's incorrect.
> 
> flush_icache_range() is there to deal with such things as loadable modules
> and self modifying code, where the MMU is not being turned off.  Hence, it
> only flushes to the point of coherency between the I and D caches, and
> any further levels of cache between that point and memory are not touched.
> Why should it touch any more levels - it's not the function's purpose.
> 
>> After mmu turned off and jump to the trampoline, kexec always failed due
>> to random undef instructions.
> 
> We already have code in the kernel which deals with shutting the MMU off.
> An instance of how this can be done is illustrated in the soft_restart()
> code path, and kexec already uses this.
> 
> One of the first things soft_restart() does is turn off the outer cache -
> which OMAP4 does have, but this can only be done if there is a single CPU
> running.  If there's multiple CPUs running, then the outer cache can't be
> disabled, and that's the most likely cause of the problem you're seeing.
> 

You are right, commit b25f3e1c (OMAP4/highbank: Flush L2 cache before disabling)
solves my problem, it flushes outer cache before disabling. I have tested it in
UP and SMP situations and it works (actually, omap4 has not ready to support kexec
in SMP case, I insert an empty cpu_kill() to make it work), so the first 2
patches are unneeded.

What about the 3rd one (ARM: allow kernel to be loaded in middle of phymem)?
