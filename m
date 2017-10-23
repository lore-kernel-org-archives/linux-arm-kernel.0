From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Oct 2017 23:29:54 +0100
Subject: [PATCH] ARM: compressed: discard ksym/kcrctab input section
In-Reply-To: <c633c2ad-0344-385f-273a-a2eb9a39d7e3@gmail.com>
References: <20170908153143.27279-1-ard.biesheuvel@linaro.org>
 <33486b3e-8221-92b0-7e18-859be7d0a74b@suse.com>
 <CAKv+Gu-8PEPuWH=bT_wD0MYDw67RY3gQudW2mLO-QeBYqQesyw@mail.gmail.com>
 <c633c2ad-0344-385f-273a-a2eb9a39d7e3@gmail.com>
Message-ID: <20171023222954.GY20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 23, 2017 at 11:32:11PM +0200, Matthias Brugger wrote:
> For the record, gcc7 has a alignment problem which was fixed for PR82445 [1].
> 
> I tried to boot with the aforementioned patch from Arnd and the fixed
> gcc, but that didn't help.

That's because we have two entirely separate problems here, both leading
to the same "it doesn't boot" outcome.

1. We have additional bytes in the zImage file after _edata, which
   means that appending a dtb using the usual "cat" method doesn't
   work.  We look for the appended dtb at _edata.

2. Misaligned loads in the decompressor causing faults.

While removing "sort" and the ksymtab sections appears to fix the
problem, it does so by removing the troublesome sections.  However,
what it's actually highlighting is that we have more fundamental
issues here.

Additional sections that are not mentioned in the linker script
will be passed through by the linker to the output file, and can
result in exactly the same issue.  So, a patch that discards the
current sections doesn't really fix the issue, it papers it over.
I also feel that removing the "sort" code from the EFI stub also
papers over the problem.  Both of those remove the /current/ cause
of a more fundamental problem without addressing that fundamental
problem.

I'm not saying we shouldn't discard the sections, I'm saying we
need to do more to detect the fundamental problem, rather than
hiding it.

That fundamental problem is that we allow the build to succeed
when the results of the build are obviously incorrect.  I've
proposed a patch that causes the copy of vmlinux to zImage to
fail if the zImage size does not match the expected size of the
binary image.

We should also eliminate the reason for (2), which is what Arnds
patch addresses.

So, in total, I think we need three patches:

1. Arnds patch to fix the alignment issues.
2. My patch to detect wrong zImage size.
3. A patch to discard troublesome sections.

Optionally, removal of the sort code from the EFI stub is an
orthogonal issue - the sort code is merely the vehicle by which
the real problems have been found.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
