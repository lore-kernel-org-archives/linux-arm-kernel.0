From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Jan 2018 11:57:09 +0000
Subject: [PATCH 07/11] signal/arm64: Document conflicts with SI_USER and
 SIGFPE, SIGTRAP, SIGBUS
In-Reply-To: <871sipl9p9.fsf@xmission.com>
References: <87373b6ghs.fsf@xmission.com>
 <20180112005940.23279-7-ebiederm@xmission.com>
 <20180115163028.GU22781@e103592.cambridge.arm.com>
 <87h8rnox3c.fsf@xmission.com>
 <20180116172407.GA22781@e103592.cambridge.arm.com>
 <871sipl9p9.fsf@xmission.com>
Message-ID: <20180117115708.GM17719@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 16, 2018 at 04:28:50PM -0600, Eric W. Biederman wrote:
> I will keep FPE_FIXME as a place holder until this gets sorted out.
> 
> There is a second issue I am looking at in this location,
> and maybe I don't have to address it now.  But it looks like the code is
> calling send_sig_info instead of force_sig_info for a synchronous
> exception.  Am I reading that correctly?

VFP used to use force_sig_info(), but it seems to be really the wrong
call to use.  force_sig_info() checks whether the program decided to
ignore or block the signal, and if it did, replaces the signal handler
with the default handler and unblocks the signal.

Are you really suggesting that FP all FP signals should get this
treatment?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
