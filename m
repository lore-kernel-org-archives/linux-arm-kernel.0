From: balbi@ti.com (Felipe Balbi)
Date: Mon, 6 Jun 2011 20:13:28 +0300
Subject: [PATCH 1/2] cleanup regulator supply definitions in mach-omap2
	to use REGULATOR_SUPPLY
In-Reply-To: <EA5D78AA-5A89-43AC-9D14-F378673F5D41@linuxhacker.ru>
References: <1307342762-25363-1-git-send-email-green@linuxhacker.ru>
	<1307342762-25363-2-git-send-email-green@linuxhacker.ru>
	<20110606092126.GG18731@legolas.emea.dhcp.ti.com>
	<EA5D78AA-5A89-43AC-9D14-F378673F5D41@linuxhacker.ru>
Message-ID: <20110606171326.GK12242@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 06, 2011 at 11:45:29AM -0400, Oleg Drokin wrote:
> >> -static struct regulator_consumer_supply sdp4430_vaux_supply[] = {
> >> -	{
> >> -		.supply = "vmmc",
> >> -		.dev_name = "omap_hsmmc.1",
> >> -	},
> >> -};
> >> +static struct regulator_consumer_supply sdp4430_vaux_supply =
> >> +	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.1");
> > this should be an array, as it was before.
> 
> Only one is defined right now.
> Whoever needs a second element can convert it to array, I think?
> What;s the importance of having it as an array right now?

because later patches will be easier to review. Look below:

When I have this:

static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
};

static struct regulator_init_data sdp4430_vmmc = {
	.constraints = {
		.min_uV			= 1200000,
		.max_uV			= 3000000,
		.apply_uV		= true,
		.valid_modes_mask	= REGULATOR_MODE_NORMAL
					| REGULATOR_MODE_STANDBY,
		.valid_ops_mask	 = REGULATOR_CHANGE_VOLTAGE
					| REGULATOR_CHANGE_MODE
					| REGULATOR_CHANGE_STATUS,
	},
	.num_consumer_supplies  = ARRAY_SIZE(sdp4430_vmmc_supply),
	.consumer_supplies      = sdp4430_vmmc_supply,
};

and I want to add a new REGULATOR_SUPPLY() the diff is simple:

@@ -1,5 +1,6 @@
 static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
 	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
+	REGULATOR_SUPPLY("vmmc2", "omap_hsmmc.0"),
 };
 
 static struct regulator_init_data sdp4430_vmmc = {

now when I have this:

static struct regulator_consumer_supply sdp4430_vmmc_supply =
	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0");

static struct regulator_init_data sdp4430_vmmc = {
	.constraints = {
		.min_uV			= 1200000,
		.max_uV			= 3000000,
		.apply_uV		= true,
		.valid_modes_mask	= REGULATOR_MODE_NORMAL
					| REGULATOR_MODE_STANDBY,
		.valid_ops_mask	 = REGULATOR_CHANGE_VOLTAGE
					| REGULATOR_CHANGE_MODE
					| REGULATOR_CHANGE_STATUS,
	},
	.num_consumer_supplies  = 1,
	.consumer_supplies      = &sdp4430_vmmc_supply,
};

and I want to add the same supply, the diff is less obvious:

@@ -1,5 +1,7 @@
-static struct regulator_consumer_supply sdp4430_vmmc_supply =
-	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0");
+static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
+	REGULATOR_SUPPLY("vmmc2", "omap_hsmmc.0"),
+};
 
 static struct regulator_init_data sdp4430_vmmc = {
 	.constraints = {
@@ -12,6 +14,6 @@ static struct regulator_init_data sdp443
 					| REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies  = 1,
-	.consumer_supplies      = &sdp4430_vmmc_supply,
+	.num_consumer_supplies  = ARRAY_SIZE(sdp4430_vmmc_supply),
+	.consumer_supplies      = sdp4430_vmmc_supply,
 };

can you see now ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110606/0ff1e589/attachment.sig>
