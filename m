From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 May 2016 15:18:17 +0100
Subject: Possible race between PTRACE_SETVFPREGS and PTRACE_CONT on ARM?
In-Reply-To: <20160531135251.GK24936@arm.com>
References: <574C7CDB.7050103@ericsson.com>
 <20160530213529.GS19428@n2100.arm.linux.org.uk>
 <20160530224028.GT19428@n2100.arm.linux.org.uk>
 <20160531135251.GK24936@arm.com>
Message-ID: <20160531141817.GW19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2016 at 02:52:52PM +0100, Will Deacon wrote:
> The only thing I'm uncertain of is whether or not PTRACE_SEIZE/PTRACE_LISTEN
> allow switching to the child (but even then, how is the parent doing
> to issue such a request?).

I can't see how that would be possible - the parent needs to finish
the vfp_set() call before it can issue any others - and there can
only be one tracer.  IOW, if we're in vfp_set(), the thread must
have attached to the child, at which point PTRACE_SEIZE will be
rejected.

PTRACE_LISTEN also requires the child to be in STOP state as well, and
again, can only be issued from the current tracer.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
