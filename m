From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 27 Mar 2013 12:09:12 +0200
Subject: [RFC 02/14] ARM: OMAP2+: add omapdss_init_of()
In-Reply-To: <5152BBD3.9070202@ti.com>
References: <1364373921-7599-1-git-send-email-tomi.valkeinen@ti.com>
 <1364373921-7599-3-git-send-email-tomi.valkeinen@ti.com>
 <5152BBD3.9070202@ti.com>
Message-ID: <5152C548.9030500@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-03-27 11:28, Benoit Cousson wrote:
> Hi Tomi,

Hi Benoit. Thanks for your comments!

> On 03/27/2013 09:45 AM, Tomi Valkeinen wrote:
>> omapdss driver uses a omapdss platform device to pass platform specific
>> function pointers and DSS hardware version from the arch code to the
>> driver. This device is needed also when booting with DT.
>>
>> This patch adds omapdss_init_of() function, called from board-generic at
>> init time, which creates the omapdss device.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>  arch/arm/mach-omap2/board-generic.c |    1 +
>>  arch/arm/mach-omap2/common.h        |    2 ++
>>  arch/arm/mach-omap2/display.c       |   34 ++++++++++++++++++++++++++++++++++
>>  3 files changed, 37 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
>> index a61544b..29eb085 100644
>> --- a/arch/arm/mach-omap2/board-generic.c
>> +++ b/arch/arm/mach-omap2/board-generic.c
>> @@ -41,6 +41,7 @@ static void __init omap_generic_init(void)
>>  
>>  	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
>>  
>> +	omapdss_init_of();
> 
> Mmm, you should not have to call that explicitly. It looks like a hack
> to me. Everything in theory should be initialized during
> of_platform_populate / driver probe.

All the "real" devices are initialized properly. However, we still have
a "virtual" omapdss device, which does not represent a particular HW
block as such, and is not represented in the DT data. It's a legacy
thing, and slowly on its way out.

However, it still helps us to pass the platform callbacks via platform
data even in DT call, so we have this (hacky) omapdss_init_of() call.

And we also pass the OMAP revision information via the platform data, as
we need to know the DSS HW version. The only way to get that is to know
the OMAP version and revision. If we would set the DSS HW version
information into DT data, we could need separate dts files for each OMAP
revision.

>> +
>> +int __init omapdss_init_of(void)
>> +{
>> +	int r;
>> +	enum omapdss_version ver;
>> +
>> +	static struct omap_dss_board_info board_data = {
>> +		.dsi_enable_pads = omap_dsi_enable_pads,
>> +		.dsi_disable_pads = omap_dsi_disable_pads,
> 
> Pads config should be handle by pinmux framework is possible. Otherwise
> a dedicated driver will be required.

Hmm. These functions touch the OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_DSIPHY
(CONTROL_DSIPHY in the TRM) register. It's not a normal padconfig thing
(like, selecting between GPIO and some other function).

Can they be handled by the pinmux framework? I'm not familiar with it.
What do you mean with dedicated driver? Dedicated pinmux driver, or
something else?

>> +		.get_context_loss_count = omap_pm_get_dev_context_loss_count,
>> +		.set_min_bus_tput = omap_dss_set_min_bus_tput,
> 
> 
> All that code should disappear with DT. hacking a platform device with
> pdata is the old way of initializing a device.
> 
> I know that you do have some omap_pm callback, but you'd better get rid
> of them in case of DT boot.
> Fixing that is a generic issue, and as soon as a solution will be done
> to handle these specific hooks, every drivers will be able to use that.

So, what you're saying is that this is not the correct way, but there's
no other way to handle it currently? If so, yes, I know that, but, well,
there's no other way to handle it currently.

I could leave them out, but in that case when booting with DT there must
be no DSS context loss, and OPP must be at OPP100 all the time.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 899 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130327/7e442d80/attachment.sig>
