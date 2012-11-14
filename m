From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 14 Nov 2012 09:46:52 +0800
Subject: [PATCH V2] ARM: tegra: retain L2 content over CPU suspend/resume
In-Reply-To: <20121113115809.GA18622@elf.ucw.cz>
References: <1352772288-2290-1-git-send-email-josephl@nvidia.com>
 <20121113115809.GA18622@elf.ucw.cz>
Message-ID: <1352857612.3362.17.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-11-13 at 19:58 +0800, Pavel Machek wrote:
> On Tue 2012-11-13 10:04:48, Joseph Lo wrote:
> > The L2 RAM is in different power domain from the CPU cluster. So the
> > L2 content can be retained over CPU suspend/resume. To do that, we
> > need to disable L2 after the MMU is disabled, and enable L2 before
> > the MMU is enabled. But the L2 controller is in the same power domain
> > with the CPU cluster. We need to restore it's settings and re-enable
> > it after the power be resumed.
> 
> Is it good idea to retain L2 over suspend? I guess this is
> power-vs-speed balance...?
> 

Hi Pavel,

Thanks for your review. Because one of the Tegra's CPU idle state will
shut off the CPU power, it only contain CPU cluster, L1$, GIC and L2
controller. The L2 ram is still powered. The L2 flush is a slow
operation at low frequency. The CPU idle "power-down" state is likely to
happen often at low frequency for low power use case (e.g. low power
audio playback). So yes, it's power-vs-speed balance.

For the system-wide sleep mode (i.e. suspend), the power of L2 RAM would
be shut off at the deepest sleep mode. There would be different
procedure to handle L2.

Thanks,
Joseph
