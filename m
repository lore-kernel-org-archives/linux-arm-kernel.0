From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 4 Dec 2012 14:47:02 +0800
Subject: [PATCH 1/5] ARM: tegra20: cpuidle: add powered-down state for
 secondary CPU
In-Reply-To: <50BCED09.4040700@wwwdotorg.org>
References: <1354503607-13707-1-git-send-email-josephl@nvidia.com>
 <1354503607-13707-2-git-send-email-josephl@nvidia.com>
 <50BCED09.4040700@wwwdotorg.org>
Message-ID: <1354603622.30563.12.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-12-04 at 02:18 +0800, Stephen Warren wrote:
> On 12/02/2012 08:00 PM, Joseph Lo wrote:
> > The powered-down state of Tegra20 requires power gating both CPU cores.
> > When the secondary CPU requests to enter powered-down state, it saves
> > its own contexts and then enters WFI. The Tegra20 had a limition to
> > power down both CPU cores. The secondary CPU must waits for CPU0 in
> > powered-down state too. If the secondary CPU be woken up before CPU0
> > entering powered-down state, then it needs to restore its CPU states
> > and waits for next chance.
> > 
> > Be aware of that, you may see the legacy power state "LP2" in the code
> > which is exactly the same meaning of "CPU power down".
> 
> >  arch/arm/mach-tegra/sleep-tegra20.S   |  145 +++++++++++++++++++++++++++++++++
> 
> Is it actually necessary to implement those parts of the code in
> assembly? It looks like it's mostly just memory read/write and a few
> barriers, all of which can be coded in regular C or invoked from C.
> 
> The reason I ask is that we eventually want to remove all hard-coded
> virtual memory addresses, such as TEGRA_PMC_VIRT, and it'll be a lot
> easier to access memory relative to a variable base address from C than
> assembly.
> 
> Now, perhaps we can solve this later; when we actually try to get this
> code into drivers/cpuidle/ and remove the hard-coded virtual memory
> addresses. Still, it'd be great if we didn't have to re-write the code
> as much (from .S->.c) when making those changes...

OK. Let me think how to do this for both Tegra20 and Tegra30.

Thanks,
Joseph
