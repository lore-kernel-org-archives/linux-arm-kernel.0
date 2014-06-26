From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Jun 2014 16:17:57 +0100
Subject: mainline boot: 64 boots: 62 pass, 2 fail (v3.16-rc1-2-gebe0618)
In-Reply-To: <CAGa+x84UTbmFc2Twg9zEcr+ZP2xsq68gFvk=385+_cFM5hvGHg@mail.gmail.com>
References: <53A2AE11.2050208@gmail.com> <53A2BE94.2010308@gmail.com>
 <53A7A579.4010702@gmail.com>
 <CAGa+x85H510fNGTXJHGYfQybRa2FGgg2NyCgJ8rmjJ6TE7GNbA@mail.gmail.com>
 <53A9B99F.4040806@codeaurora.org> <53A9FBB5.60709@codeaurora.org>
 <53AABCF5.4050403@gmail.com> <53AB45D1.90909@codeaurora.org>
 <53ABC13C.8030908@gmail.com>
 <CAGa+x84UTbmFc2Twg9zEcr+ZP2xsq68gFvk=385+_cFM5hvGHg@mail.gmail.com>
Message-ID: <20140626151756.GU32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 07:59:19AM -0700, Kevin Hilman wrote:
> I agree that the u-boot bug needs to be fixed, and FWIW, I updated my
> u-boot and haven't seen the boot failure yet after several boots with
> next-20140625.
> 
> That being said, since it's not always feasible/practical to update
> u-boot, and when it comes down to it, this is still a kernel
> regression, we should also fix the kernel to sanity check the values
> coming from u-boot, like it was doing before.

It wasn't sanity checking the values (there is some sanity checking,
but the sanity checking doesn't catch this).

What caught it was that the kernel was configured to only look at the
first 8 of the 12 meminfo entries with ATAGs.  Since we no longer have
that limit, all meminfo entries are now looked at (since the kernel
doesn't need the limit.)

We could add back a soft-limit on the number of meminfo entries, but
this has to be platform specific.  Another entry to go into the
mach_info structures?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
