From: broonie@kernel.org (Mark Brown)
Date: Sat, 16 Nov 2013 10:02:05 +0000
Subject: [PATCH 17/31] ASoC: tegra: call pm_runtime APIs around register
 accesses
In-Reply-To: <1384548866-13141-18-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-18-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131116100205.GG15393@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 01:54:12PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Call pm_runtime_get_sync() before all register accesses; the HW requires
> clocks to be running when accessing registers.
> 
> This hasn't been needed to date, since all register IO was performed
> while playback was active, and hence the ASoC core had already called
> pm_runtime_get(). However, an imminent future commit will allocate and
> set up the FIFOs and routing during probe(), when that "protection"
> won't be in place.

Acked-by: Mark Brown <broonie@linaro.org>

However should we fix this at the regmap level in the same way that we
do for clocks?  That would need to be using _put_autosuspend() to avoid
being horrific.  Or alternatively should the driver be making the device
cache only when runtime PM is disabled?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131116/955c97d0/attachment.sig>
