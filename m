From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 29 Jun 2013 18:21:24 +0100
Subject: [PATCH] WIP: HACK: LPAE, BOOTMEM and NO_BOOTMEM
In-Reply-To: <20130629152959.GB31339@mtj.dyndns.org>
References: <1372467663-31425-1-git-send-email-santosh.shilimkar@ti.com>
 <20130629152959.GB31339@mtj.dyndns.org>
Message-ID: <20130629172123.GA3353@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 29, 2013 at 08:29:59AM -0700, Tejun Heo wrote:
> I suppose LPAE on arm is analogous to PAE on x86, IOW, high memory?
> This does affect memory initilization as you need to register memory
> areas which aren't addressable directly; however, why does it affect
> generic code which is just allocating memory?  Note that x86 already
> does highmem and the existing code works fine.  Once all bootmem users
> are gone, we can remove the bootmem wrappers but I don't what the
> point is with introducing yet another wrapper.

The reason is actually quite simple: on x86 you always have memory
starting at physical address zero.

Unfortunately, that has not been true on ARM - it's very common for
there to be an offset on physical memory, sometimes of the order of
3GB or more.  This is because on reset, ARMs start executing the code
at physical address zero, which therefore can't be RAM - and there's
a desire to avoid complex switching games in hardware to temporarily
map ROM there instead of RAM.

On these SoCs which Santosh is working on, the main physical memory
mapping is above 4GB, with just a small alias below 4GB to allow the
system to boot without the MMU being on, as they may have more than
4GB of RAM.  As I understand it, the small alias below 4GB is not
suitable for use as a "lowmem" mapping.
