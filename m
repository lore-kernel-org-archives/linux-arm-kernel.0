From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 1 Jun 2015 09:56:05 +0100
Subject: [PATCH 05/98] exynos_drm.h: use __u64 from linux/types.h
In-Reply-To: <556C15BA.7000909@amd.com>
References: <1433000370-19509-1-git-send-email-mikko.rapeli@iki.fi>
 <1433000370-19509-6-git-send-email-mikko.rapeli@iki.fi>
 <20150530164655.GM2067@n2100.arm.linux.org.uk>
 <556C15BA.7000909@amd.com>
Message-ID: <20150601085605.GN2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 01, 2015 at 10:20:10AM +0200, Christian K?nig wrote:
> Using types that differs on 32-bit and 64-bit machines for a kernel
> interface is indeed a rather bad idea. This not only includes longs, but
> pointers as well.

[cut standard stdint.h types argument which we've heard before]

You need to read Linus' rant on this subject:

 From: Linus Torvalds <torvalds@osdl.org>
 Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
 Date: Mon, 29 Nov 2004 01:30:46 GMT

 Ok, this discussion has gone on for too long anyway, but let's make it
 easier for everybody. The kernel uses u8/u16/u32 because:

         - the kernel should not depend on, or pollute user-space naming.
           YOU MUST NOT USE "uint32_t" when that may not be defined, and
           user-space rules for when it is defined are arcane and totally
           arbitrary.

         - since the kernel cannot use those types for anything that is
           visible to user space anyway, there has to be alternate names.
           The tradition is to prepend two underscores, so the kernel would
           have to use "__uint32_t" etc for its header files.

         - at that point, there's no longer any valid argument that it's a
           "standard type" (it ain't), and I personally find it a lot more
           readable to just use the types that the kernel has always used:
           __u8/__u16/__u32. For stuff that is only used for the kernel,
           the shorter "u8/u16/u32" versions may be used.

 In short: having the kernel use the same names as user space is ACTIVELY
 BAD, exactly because those names have standards-defined visibility, which
 means that the kernel _cannot_ use them in all places anyway. So don't
 even _try_.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
