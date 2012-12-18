From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 18 Dec 2012 12:18:19 +0200
Subject: [PATCH V3 5/5] ARM: tegra20: cpuidle: apply coupled cpuidle
 for powered-down mode
In-Reply-To: <1355797861-12759-6-git-send-email-josephl@nvidia.com>
References: <1355797861-12759-1-git-send-email-josephl@nvidia.com>
 <1355797861-12759-6-git-send-email-josephl@nvidia.com>
Message-ID: <20121218101819.GP19258@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 18, 2012 at 03:31:01AM +0100, Joseph Lo wrote:
> The "powered-down" cpuidle mode of Tegra20 needs the CPU0 be the last one
> core to go into this mode before other core. The coupled cpuidle framework
> can help to sync the MPCore to coupled state then go into "powered-down"
> idle mode together. The driver can just assume the MPCore come into
> "powered-down" mode at the same time. No need to take care if the CPU_0
> goes into this mode along and only can put it into safe idle mode (WFI).
> 
> The powered-down state of Tegra20 requires power gating both CPU cores.
> When the secondary CPU requests to enter powered-down state, it saves
> its own contexts and then enters WFI for waiting CPU0 in the same state.
> When the CPU0 requests powered-down state, it attempts to put the secondary
> CPU into reset to prevent it from waking up. Then power down both CPUs
> together and power off the cpu rail.
> 
> Be aware of that, you may see the legacy power state "LP2" in the code
> which is exactly the same meaning of "CPU power down".
> 
> Based on the work by:
> Colin Cross <ccross@android.com>
> Gary King <gking@nvidia.com>
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> V3:
> * sqash last two patch in previous version to support coupled cpuidle
>   directly

nitpick - it should be 'squash'.

Cheers,

Peter.
