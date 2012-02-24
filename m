From: timur@freescale.com (Timur Tabi)
Date: Fri, 24 Feb 2012 17:05:16 -0600
Subject: [PATCH 4/4] ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
In-Reply-To: <20120224223512.GB15120@n2100.arm.linux.org.uk>
References: <1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
 <1330008519-3584-5-git-send-email-shawn.guo@linaro.org>
 <4F465A33.3020208@ru.mvista.com> <4F465EE5.4010908@freescale.com>
 <20120223165242.GB22562@n2100.arm.linux.org.uk>
 <4F4671BB.7060409@freescale.com>
 <20120223171407.GC22562@n2100.arm.linux.org.uk>
 <4F480120.6080409@freescale.com>
 <20120224215448.GA15120@n2100.arm.linux.org.uk>
 <4F480871.9020206@freescale.com>
 <20120224223512.GB15120@n2100.arm.linux.org.uk>
Message-ID: <4F4817AC.7050406@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:

> Ho hum.  So, what that's saying to me is that even implementing in_32be()
> on ARM results in rubbish because it wouldn't be big endian there.

Well, the "be" in in_be32() means to assume that 32-bit integer is stored
in big-endian format, and to convert it to native format during the read.
 An ARM implementation of in_be32() would include byte-swapping.

> So are we heading towards driver specific sets of IO accessors? :-(  It
> sounds like that's what it needs because of these different endian-ness
> issues.

I'm surprised that ioread32() on PowerPC always does a little-endian read,
but I'm guessing that was done for compatibility.  I don't know what to do
about that.

> And lets not forget that we're talking just about this - there's also
> the issue of on-SoC devices on ARM now appearing behind PCI buses on
> x86, which would make those appear as LE.  I bet if any of those
> appearing on PPC would appear in BE mode.  So, 'native endian' doesn't
> work either.

I think PCI is a special-case on most PowerPC parts, in that the registers
are still little-endian.  But I don't know how pervasive that is.  In
fact, I think on some Freescale PowerPC SOCs, the PCI registers are
little-endian, and other others they're big-endian.  You can see that in
fsl_pci.c.

> So, I'm getting the feeling that something as simple as IO accessors are
> just a huge mountain of crap waiting to bite.

Very few devices are shared between Freescale's PowerPC and ARM SOCs, so
the impact is only a few drivers.  That's why it might be okay (for now)
to have "dual" I/O accessors in specific drivers.

-- 
Timur Tabi
Linux kernel developer at Freescale
