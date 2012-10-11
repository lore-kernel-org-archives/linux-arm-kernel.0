From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 11 Oct 2012 14:39:44 +0800
Subject: [PATCH 0/7] ARM: tegra30: cpuidle: add LP2 support
In-Reply-To: <5074A47B.3050906@wwwdotorg.org>
References: <1349691981-31038-1-git-send-email-josephl@nvidia.com>
 <5074A47B.3050906@wwwdotorg.org>
Message-ID: <1349937584.19413.78.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Thanks for review and sorry for late response due to national holiday
yesterday.

On Wed, 2012-10-10 at 06:26 +0800, Stephen Warren wrote:
> On 10/08/2012 04:26 AM, Joseph Lo wrote:
> > The CPU idle LP2 is a power gating idle mode for Tegra30. It supports the
> > secondary CPUs (i.e., CPU1-CPU3) to go into LP2 dynamically. When any of
> > the secondary CPUs go into LP2, it can be power gated alone. There is a
> > limitation on CPU0. The CPU0 can go into LP2 only when all secondary CPUs
> > are already in LP2. After CPU0 is in LP2, the CPU rail can be turned off.
> > 
> > Verified on Seaboard(Tegra20) and Cardhu(Tegra30).
> 
> What's the most comprehensive way to verify this? I booted Cardhu with
> these patches applied and saw that all CPU cores did enter both idle
> states. However, I'm unsure what the best way to stress the system is,
> i.e. how would I stress and test for correct handling of all the L2
> caching/SMP coherency issues, etc.

Yes, we need a pattern to verify this. The idea is try to make data
traffic busy and the CPU can still fall into LP2. So I used a software
video decoding process to verify this. You can image how the data
traffic it is. The raw video data from file system to memory. Memory to
memory access during video decoding process. The L1/L2 cache and TLB
maintenance procedure can be verified.

To verify this, you need to get a mplayer and "lower resolution" video
clips. Using DVD resolution would be good choice. Then creating two
decoding processes in the background. Please do check the system can
fall into LP2. If not, please try to lower the fps value. Finally, using
loop to keep the decoding process always in the background.

The criteria to pass the verification. The system need to keep alive
over a weekend at least.

Thanks,
Joseph
