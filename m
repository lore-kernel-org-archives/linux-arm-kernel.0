From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Aug 2014 10:38:09 -0600
Subject: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <1407914239-12054-5-git-send-email-libv@skynet.be>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-5-git-send-email-libv@skynet.be>
Message-ID: <53EB9471.3090204@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/13/2014 01:17 AM, Luc Verhaegen wrote:
> This claims and enables clocks listed in the simple framebuffer dt node.
> This is needed so that the display engine, in case the required clocks
> are known by the kernel code and are described in the dt, will remain
> properly enabled.

I think this make simplefb not simple any more, which rather goes 
against the whole point of it.

I specifically conceived simplefb to know about nothing more than the 
memory address and pixel layout of the memory buffer. I certainly don't 
like the idea of expanding simplefb to anything beyond that, and IIRC 
*not* extending is was a condition agreed when it was first merged. If 
more knowledge than that is required, then there needs to be a 
HW-specific driver to manage any clocks/resets/video registers, etc.

The correct way to handle this without a complete DRM/KMS/... driver is 
to avoid the clocks in question being turned off at boot. I thought 
there was a per-clock flag to prevent disabling an unused clock? If not, 
perhaps the clock driver should force the clock to be enabled (perhaps 
only if the DRM/KMS driver isn't enabled?). For example, the Tegra clock 
driver has a clock initialization table which IIRC was used for this 
purpose before we got a DRM/KMS driver. That way, all the details are 
kept inside the kernel code, and don't end up influencing the DT 
representation of simplefb.
