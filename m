From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Oct 2014 22:50:43 +0100
Subject: [PATCH 2/3] ARM: vfp: fix VFPv3 hwcap detection on non-ARM vfp
 implementations
In-Reply-To: <541C74C1.9060504@codeaurora.org>
References: <1411076592-6157-1-git-send-email-sboyd@codeaurora.org>
 <1411076592-6157-3-git-send-email-sboyd@codeaurora.org>
 <20140918224625.GF5182@n2100.arm.linux.org.uk>
 <541C74C1.9060504@codeaurora.org>
Message-ID: <20141001215043.GS5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 19, 2014 at 11:24:01AM -0700, Stephen Boyd wrote:
> Thank you for the warm welcome! I looked at the TRMs for ARM11 and ARM9.
> I can't find anywhere where VFPv2 is supported and these bits are set.
> 
> Bits 22-16 of FPSID:
> 
> ARM1136r1p5:     0x01
> ARM1136r1p3:     0x01
> ARM1176:         0x01
> ARM11MPCorer2p0: 0x01
> ARM11MPCorer1p0: 0x01
> ARM1156:         0x01
> ARM9:            0x01
> 
> 
> Do you, or anyone else, know of other implementations? I *hope* that
> this same exercise was done by the VFP architects before they
> re-purposed bits but who knows. If nobody is actually setting these
> higher bits then is there any problem widening the mask (besides it
> being slightly confusing)?

There are certainly non-ARM implementations around, eg:

VFP support v0.3: implementor 56 architecture 2 part 20 variant 9 rev 5

which is from Marvell Dove.  I don't know how the other Marvell offerings
identify.  I wouldn't be surprised if there were other implementations
from other vendors too.

However, if we do have any implementation which indicates that it does
not support both single and double precision ops (bit 20), then today
the VFP support code refuses to initialise, and the system will behave
as if there is no VFP present.

So, the problem case is whether we do have non-ARM produced implementations
where the VFP code refuses to init, which would then be misidentified as
some insane architecture version.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
