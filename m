From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 02 Apr 2014 13:21:32 -0600
Subject: [PATCH 73/75] ARM: l2c: move L2 cache register saving to a more
 sensible location
In-Reply-To: <20140401230924.GE7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYaF-0007Hv-Nv@rmk-PC.arm.linux.org.uk> <533B0BC1.6080608@wwwdotorg.org>
 <533B0D6D.1080803@wwwdotorg.org>
 <20140401230924.GE7528@n2100.arm.linux.org.uk>
Message-ID: <533C633C.9070100@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/2014 05:09 PM, Russell King - ARM Linux wrote:
> On Tue, Apr 01, 2014 at 01:03:09PM -0600, Stephen Warren wrote:
>> On 04/01/2014 12:56 PM, Stephen Warren wrote:
>>> On 03/28/2014 09:20 AM, Russell King wrote:
>>>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>>>
>>> EXCEPT this one patch, the series,
>>> Tested-by: Stephen Warren <swarren@nvidia.com>
>>> (on Tegra20/Toshiba AC100 and Tegra30/Beaver)
>>>
>>> And any part which touches Tegra code,
>>> Acked-by: Stephen Warren <swarren@nvidia.com>
>>>
>>> However, this one patch causes boot failures on the Toshiba AC100,
>>> Springbank/Seaboard, and I would assume any Tegra20 system. I haven't
>>> investigated what the problem is; do you need me to and/or have any clues?
>>
>> Ah, disabling CONFIG_CPU_IDLE "fixes" this.
> 
> Still brings up the question of what's going on here.  Another thing
> could be that enabling BRESP is causing you problems.  You could
> try disabling that code too, though why that would happen only with
> CPU IDLE I'm not sure.

The problem also affects suspend/resume. Disabling CPU_IDLE simply
removes one case where the CPUs gets power-cycled, but doesn't solve the
suspend/resume issue.

Anyway, this patch removes the following code:

	/* Save the value for resuming. */
	l2x0_saved_regs.aux_ctrl = aux;

Was that intentional? Perhaps the call to data->save() should do this now?

Anyway, if I put that code back, in any of the following 3 places, then
boot, CPU hotplug, and suspend/resume all work OK with your series:

1) Right after:

	outer_cache = fns;

2) Right after:

	if (data->save)
		data->save(l2x0_base);

3) Right after:

	aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
