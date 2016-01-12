From: afd@ti.com (Andrew F. Davis)
Date: Tue, 12 Jan 2016 09:22:20 -0600
Subject: /sys/class/power_supply/bq27200-0/capacity changed meaning
 between 4.1 and 4.4?
In-Reply-To: <56942344.9070609@ti.com>
References: <20160109230709.GA30551@amd> <5693BB75.70409@ti.com>
 <20160111214247.GA9735@amd> <56942344.9070609@ti.com>
Message-ID: <56951A2C.9010602@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2016 03:48 PM, Andrew F. Davis wrote:
> On 01/11/2016 03:42 PM, Pavel Machek wrote:
>> Hi!
>>
>>>> Did /sys/class/power_supply/bq27200-0/capacity change meaning between
>>>> 4.1 and 4.4?
>>
>>> There was a resent overhaul of this driver and a lot of code is
>>> vestigial as you have seen. I've been meaning to continue
>>> cleaning it up, my next step would probably to bring up regmap
>>
>> Ok, 1wire is probably reasonable approach. But we have an regression
>> between 4.1 and 4.4, and to debug it is probably by reading code.
>>
>> I can't prove you caused the regression, but you basically rewrote the
>> driver, so it should be easier for you to spot the bug.
>>
>
> Makes sense.
>
>> n900 has this variant:
>>
>>             bq27200: bq27200 at 55 {
>>                      compatible = "ti,bq27200";
>>                reg = <0x55>;
>>       };
>>
>
> Hmmm, not sure if I have this one on hand, I'll see if I can find an
> n900 around here (they seem to be pretty popular around here for testing
> (had a lot of TI parts)).
>
>> Will you try?
>>
>> If not, tell me, and I can do it, but it will involve a lot of swaring...
>>
>
> I'll give it a look over.

OK, I'm still looking for a test setup, but this was definitely a problem,
could you give this a try?:

diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_battery.c
index 880233c..4fec3cf 100644
--- a/drivers/power/bq27xxx_battery.c
+++ b/drivers/power/bq27xxx_battery.c
@@ -470,8 +470,9 @@ static inline int bq27xxx_read(struct bq27xxx_device_info *di, int reg_index,
  static int bq27xxx_battery_read_soc(struct bq27xxx_device_info *di)
  {
  	int soc;
+	bool single = di->chip == BQ27000 || di->chip == BQ27010;
  
-	soc = bq27xxx_read(di, BQ27XXX_REG_SOC, false);
+	soc = bq27xxx_read(di, BQ27XXX_REG_SOC, single);
  
  	if (soc < 0)
  		dev_dbg(di->dev, "error reading State-of-Charge\n");
