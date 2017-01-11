From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Jan 2017 18:30:59 +0000
Subject: [RFC PATCH 1/2] ARM: vfp - allow kernel mode NEON in softirq
 context
In-Reply-To: <CAKv+Gu9S66y0QuOcJdwrT-WoQOCJged-MzfXqdm20RYVGg9w8w@mail.gmail.com>
References: <1483991849-32448-1-git-send-email-ard.biesheuvel@linaro.org>
 <1483991849-32448-2-git-send-email-ard.biesheuvel@linaro.org>
 <20170111175649.GK14217@n2100.armlinux.org.uk>
 <CAKv+Gu9S66y0QuOcJdwrT-WoQOCJged-MzfXqdm20RYVGg9w8w@mail.gmail.com>
Message-ID: <20170111183059.GL14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 06:23:10PM +0000, Ard Biesheuvel wrote:
> Re latency, I thought about adding a kernel_neon_yield(), which does a
> kernel_neon_end()/do_softirq()/kernel_neon_begin() sequence if any
> softirqs are pending, to be invoked by kernel mode NEON users at times
> when there are no live NEON registers. But in-kernel users of the
> crypto API are naturally quantised into disk sectors, pages or network
> packets, so I would not expect any noticeable starvation to occur. But
> that does mean such algorithms should not be exposed to userland
> (which sounds like a bad idea in any case, given that userland can
> simply execute the same instructions)

I was actually thinking about the impact of adding softirq disabling
over much of the VFP code necessary to make this safe, rather than the
softirq disable coming from the kernel mode neon itself.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
