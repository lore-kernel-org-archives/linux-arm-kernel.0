From: thierry.reding@gmail.com (Thierry Reding)
Date: Sat, 28 Jun 2014 03:24:07 +0200
Subject: [RFC 1/4] ARM: tegra: Move SoC drivers to drivers/soc/tegra
In-Reply-To: <53ADDDC1.2080603@wwwdotorg.org>
References: <1403888329-24755-1-git-send-email-thierry.reding@gmail.com>
 <53ADDDC1.2080603@wwwdotorg.org>
Message-ID: <20140628012406.GC13290@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 03:10:25PM -0600, Stephen Warren wrote:
> On 06/27/2014 10:58 AM, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > These drivers are closely coupled and need to be moved as a whole. One
> > reason for moving them out of arch/arm/mach-tegra is to allow them to be
> > shared with 64-bit ARM.
> 
> Aside from any discussions re: splitting out cpuidle, power domains, ...
> into separate subsystem directories, this patch looks conceptually fine
> to me.
> 
> That said, given that I think arch/arm64 isn't going to have mach-*
> directories or machine descriptors, I wonder how all this code is going
> to be invoked at boot. arch/arm/mach-tegra/tegra.c calls a bunch of
> these functions at boot right now. So, it seems like moving the code so
> that it can compile in both places is only part of the solution?

Yes, that's correct. My primary motivation for moving this outside of
arch/arm/mach-tegra was because we need the powergate APIs for 64-bit
builds. I can look at moving out only that driver in a first step and
then look at moving cpuidle where it belongs. As for the other pieces
maybe a better solution would be to keep them in arch/arm/mach-tegra
for now until we've determined which of them are really needed for
64-bit and move them out on an as-needed basis. Untangling these on
by one will take some effort, though.

> Are we going to have an arm64-specific SoC driver that binds to the SoC
> compatible in order to initialize everything? If so, I wonder if the
> same can work for arch/arm so everything works the same way?

I think we'll have to do something along those lines. But I'm not sure
how well it will work out because some of these drivers need to be set
up very early, before any of the driver core is up.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140628/d9b8c160/attachment-0001.sig>
