From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 19 Jan 2014 20:52:21 +0100
Subject: [RFC v3 03/13] ahci-platform: Fix clk enable/disable unbalance
 on suspend/resume
In-Reply-To: <20140119191554.GB32165@mtj.dyndns.org>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-4-git-send-email-hdegoede@redhat.com>
 <20140119111412.GA11123@htj.dyndns.org> <52DC1DAA.3010403@redhat.com>
 <20140119191554.GB32165@mtj.dyndns.org>
Message-ID: <52DC2CF5.5080109@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/19/2014 08:15 PM, Tejun Heo wrote:
> Hey,
>
> On Sun, Jan 19, 2014 at 07:47:06PM +0100, Hans de Goede wrote:
>> As I see it either doing clks, regulator and sata-core things in a common
>> place makes sense, and then it goes for suspend and resume too, or we
>> opt for always following the complete override model, and which point
>> it becomes more sensible to just do a separate platform driver per
>> ahci implementation.
>
> It makes sense in light of those specific cases, but there are gonna
> be cases where the placement of the callback is slightly wrong and we
> end up with ->XXX_ops_pre() and then ->XXX_ops_post() and so on.
> Please make the whole op overridable and then export the default op
> and use it as library.

If we were to put a generic implementation in ahci_platform.c and export
it for use from overrides to avoid copy and pasting common bits everywhere,
then we still have the ordering problem you are talking about. How do you
envision all of this fitting together, I can imagine ie a
ahci_platform_resume_controller which has the bits of what is currently
ahci_resume stating at:

"if (dev->power.power_state.event == PM_EVENT_SUSPEND) {"

And having ahci_resume in ahci_platform.c still doing the clk and power enabling
before calling into ahci_platform_resume, and drivers overriding the resume method
need to do their own clk + regulator + whatever setup
before calling into ahci_platform_resume_controller ?

Also how do you see overriding the entire op, does that mean that pdata->suspend
will be deprecated (we will need to keep it around for now to avoid breaking
existing drivers using it), and all of:

ahci_probe
ahci_suspend
ahci_resume

Will get exported from ahci_platform.c and drivers needing to override any of them
will provide their own platform_driver struct, pointing either to their overrides,
or for driver methods they don't need to override to the exported function from
ahci_platform.c ?

This would also work nicely for the of_device_id data stuff, since if drivers
have their own platform_driver struct these bits could just go inside the
driver file instead of being in #ifdef CONFIG_FOO in ahci_platform.c

Regards,

Hans
