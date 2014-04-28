From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Apr 2014 19:19:04 +0100
Subject: [PATCH 00/16] Another 16 L2C patches
In-Reply-To: <535E990B.2020405@wwwdotorg.org>
References: <20140428165631.GM26756@n2100.arm.linux.org.uk>
 <535E8BEE.1000100@wwwdotorg.org> <535E8F6D.9000803@wwwdotorg.org>
 <20140428173943.GN26756@n2100.arm.linux.org.uk>
 <535E990B.2020405@wwwdotorg.org>
Message-ID: <20140428181904.GP26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 12:08:11PM -0600, Stephen Warren wrote:
> (Dropping most people from CC since this sub-thread is a Tegra-specific
> discussion)
> 
> On 04/28/2014 11:39 AM, Russell King - ARM Linux wrote:
> > On Mon, Apr 28, 2014 at 11:27:09AM -0600, Stephen Warren wrote:
> ...
> >> I do see one error in dmesg during boot, but it doesn't appear to
> >> negatively affect operation in brief testing, and is present in
> >> linux-next without this series anyway. Is this message a problem?
> >>
> >>> [    0.000000] L2C: platform modifies aux control register: 0x02080000 -> 0x3e480001
> >>> [    0.000000] L2C: DT/platform modifies aux control register: 0x02080000 -> 0x3e480001
> >>> [    0.000000] L2C-310 errata 727915 769419 enabled
> >>> [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
> >>> [    0.000000] L2C-310: enabling full line of zeros but not enabled in Cortex-A9
> >>                           ^^^^^^ this is logged at error level
> > 
> > Correct, it's an error because on Tegra you explicitly set bit 0 in the
> > auxiliary control register, which is pointless unless the feature is
> > also enabled in the Cortex-A9 control register as well.
> 
> Please forgive my almost complete lack of knowledge re: cache
> controllers. Is the correct fix for this:
> 
> a) To remove bit 0 from the aux_val passed to l2x0_of_init()
> 
> b) To set some BIT(3) in the Cortex-A9 auxcr, so this feature is enabled
> there too.
> 
> And if (b), I assume that's something that the bootloader should be
> doing, not the kernel?

See "Full line of zero write."

http://infocenter.arm.com/help/topic/com.arm.doc.ddi0246h/CJACBHHB.html#CJADBCJJ

which makes it (a).  The reverse steps are required when disabling the L2
cache controller.

If we decide that we encounter a platform which needs this feature
disabled, the correct way to deal with that is to add a L2C-310
specific property to DT, and not to try to crowbar it in via the L2C
aux control register masks (which should never have been exposed to
platforms using DT.)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
