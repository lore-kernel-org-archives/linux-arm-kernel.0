From: acourbot@nvidia.com (Alexandre Courbot)
Date: Thu, 30 Oct 2014 19:22:57 +0900
Subject: [PATCH v4 05/12] memory: Add NVIDIA Tegra memory controller
 support
In-Reply-To: <5452107D.8080207@nvidia.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
 <1413196434-5292-5-git-send-email-thierry.reding@gmail.com>
 <54520CFE.9060907@nvidia.com> <5452107D.8080207@nvidia.com>
Message-ID: <54521181.8080005@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 7:18 PM, Terje Bergstr?m <tbergstrom@nvidia.com> 
wrote:
 > On 30.10.2014 12:03, Alexandre Courbot wrote:
 >> I had to change the .reg of TEGRA_SWGROUP_GPU to 0xaac to get the IOMMU
 >> to work with GK20A. The reason is still not completely clear to me, but
 >> if you look at the TRM you see that 0xaa8 is basically constant, with
 >> the SMMU translation bit hardcoded to DISABLE (and the ASID field being
 >> meaningless in that case). However right after that register you have a
 >> functional one named GPUB instead of GPU, and this one is fully
 >> writeable (and has the expected effect).
 >
 > GPU has two SW group IDs, because it accesses memory both with and
 > without translation. The bit 34 in addresses in f.ex. PTE chooses
 > between the two.

Indeed, to enable SMMU translation I have to program 0xaac correctly 
*and* set the bit 34 of every address that needs to go through the SMMU.

 > GPU is hard-wired to disable translation. For GPUB translation can be
 > enabled.

So should I understand that the GPU group is for addresses without bit 
34 set (hence forcibly disabled) while GPUB is used when that bit is 
set? Or is it something else?
