From: balbi@ti.com (Felipe Balbi)
Date: Sat, 8 Jun 2013 07:25:53 +0300
Subject: [PATCH 1/4] mmc: omap_hsmmc: Fix context save and restore for DT
In-Reply-To: <20130607214950.18581.56829.stgit@localhost>
References: <20130607214557.18581.75288.stgit@localhost>
 <20130607214950.18581.56829.stgit@localhost>
Message-ID: <20130608042553.GB20238@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 07, 2013 at 02:49:50PM -0700, Tony Lindgren wrote:
> We want to get rid of the omap specific platform init code
> callbacks as they don't play nice with device tree.

right, any plans to have similar functionality generically ? Maybe
something like:

probe()
{
	...

	/*
	 * tell PM runtime layer that we can handle runtime
	 * power gating of this device in certain conditions.
	 *
	 * Actual power gating will be triggered depending on
	 * PM QoS wakeup requirements.
	 */
	pm_runtime_enable_power_gating(dev);

	...
}

runtime_suspend()
{
	if (pm_runtime_will_power_gate(dev))
		save_context();
}

runtime_resume()
{
	if (pm_runtime_has_lost_power(dev))
		restore_context();
}

???

> Let's convert the context loss check to be based on a
> register state detection instead.

that might not work always. Specially when you consider that default
register values can change on every silicon release. I guess the above
might be a bit nicer, although a lot more work :-p

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130608/8ae16bad/attachment.sig>
