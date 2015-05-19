From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 19 May 2015 20:32:42 +0800
Subject: [PATCH] i2c: designware: separate ops for system_sleep_pm and
 runtime_pm
In-Reply-To: <20150518082823.GH1490@lahna.fi.intel.com>
References: <1431693099-2292-1-git-send-email-jszhang@marvell.com>
 <20150518082823.GH1490@lahna.fi.intel.com>
Message-ID: <20150519203242.74617ad6@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mika,

On Mon, 18 May 2015 11:28:23 +0300
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> On Fri, May 15, 2015 at 08:31:39PM +0800, Jisheng Zhang wrote:
> > Commit 1fc2fe204cb9 ("i2c: designware: Add runtime PM hooks") adds
> > runtime pm support using the same ops for system sleep and runtime pm.
> > When suspend to ram, the i2c host may have been runtime suspended, thus
> > i2c_dw_disable() hangs.
> 
> It hangs because it has already been powered off, right?

Either be powered off or clock gated or even both.

> 
> > This patch fixes this issue by separating ops for system sleep pm and
> > runtime pm, and in the system suspend/resume path, runtime pm apis are
> > used to ensure the device is at correct state.
> 
> I can see that this fixes the issue with the platform driver (as the
> platform bus core doesn't power on the device automatically as opposed
> to other buses, like PCI). However, I'm thinking that can we do better
> here.
> 
> Instead of powering the device on again, can't we leave it in low power
> state? Recently added 'dev->power.direct_complete' may be used to
> achieve that, I think.

how to handle runtime suspended via just being clock gated? Currently the
only solution is using the runtime pm apis to ensure the device is in a working
state during s2ram. What's your opinion?

Thanks,
Jisheng
