From: nm@ti.com (Menon, Nishanth)
Date: Fri, 22 Jul 2011 08:53:12 -0500
Subject: [PATCH 2/2] OMAP2+: PM: SR: add suspend/resume handlers
In-Reply-To: <20110722091303.GK32058@legolas.emea.dhcp.ti.com>
References: <1311314153-23531-1-git-send-email-nm@ti.com>
	<1311314153-23531-3-git-send-email-nm@ti.com>
	<20110722091303.GK32058@legolas.emea.dhcp.ti.com>
Message-ID: <CAOMWX4djN8D1hWGuqRLkk53pVPghT_T=3FUkhJv8Hnu7CWQ8Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2011 at 04:13, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Fri, Jul 22, 2011 at 12:55:53AM -0500, Nishanth Menon wrote:
>> Suspend and Resume paths are safe enough to do it in
>> the standard LDM suspend/resume handlers where one can
>> sleep. Add suspend/resume handlers for SmartReflex.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>> ?arch/arm/mach-omap2/smartreflex.c | ? 87 +++++++++++++++++++++++++++++++++++++
>> ?1 files changed, 87 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
>> index 33a027f..fb90bd2 100644
>> --- a/arch/arm/mach-omap2/smartreflex.c
>> +++ b/arch/arm/mach-omap2/smartreflex.c
>> @@ -39,6 +39,7 @@ struct omap_sr {
>> ? ? ? int ? ? ? ? ? ? ? ? ? ? ? ? ? ? ip_type;
>> ? ? ? int ? ? ? ? ? ? ? ? ? ? ? ? ? ? nvalue_count;
>> ? ? ? bool ? ? ? ? ? ? ? ? ? ? ? ? ? ?autocomp_active;
>> + ? ? bool ? ? ? ? ? ? ? ? ? ? ? ? ? ?is_suspended;
>> ? ? ? u32 ? ? ? ? ? ? ? ? ? ? ? ? ? ? clk_length;
>> ? ? ? u32 ? ? ? ? ? ? ? ? ? ? ? ? ? ? err_weight;
>> ? ? ? u32 ? ? ? ? ? ? ? ? ? ? ? ? ? ? err_minlimit;
>> @@ -684,6 +685,12 @@ void omap_sr_enable(struct voltagedomain *voltdm)
>> ? ? ? if (!sr->autocomp_active)
>> ? ? ? ? ? ? ? return;
>>
>> + ? ? if (sr->is_suspended) {
>> + ? ? ? ? ? ? dev_dbg(&sr->pdev->dev, "%s: in suspended state\n", __func__);
>> + ? ? ? ? ? ? return;
>> + ? ? }
>
> I wonder why you get these called if you're in suspend state. If this is
> called by some other driver, then shouldn't you pm_runtime_get_sync();
> do_whatever_you_need_to_do(); and pm_runtime_put(); rather then just
> returning ?

because we have two state machines running in parallel - cpu idle and
dvfs(cpufreq, and other dependent domain voltage scaling) and SR
driver is just one - it does it's own get_sync and put_sync_suspend.
we cannot guarentee that the SR enable/disable calls can be properly
sequenced unless we use suspend lockouts. SmartReflex driver is an
independent entity of it's own - yeah we can do the same as we have
done historically in the omap[34]_idle paths(which is disable SR after
we have disabled interrupts), but in case of suspend(unlike in idle),
we do *know* that SR will have to be disabled - hence doing it earlier
as part of standard LDM suspend sequences is more opportunistic.

Regards,
Nishanth Menon
