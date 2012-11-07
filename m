From: rajanikanth.hv@linaro.org (Rajanikanth H V)
Date: Thu, 8 Nov 2012 00:15:47 +0530 (IST)
Subject: [PATCH 1/4] mfd: ab8500: add devicetree support for fuelgauge
In-Reply-To: <509291FF.6090500@gmail.com>
References: <1351698033-8980-1-git-send-email-rajanikanth.hv@linaro.org>
 <1351698033-8980-2-git-send-email-rajanikanth.hv@linaro.org>
 <509291FF.6090500@gmail.com>
Message-ID: <alpine.DEB.2.02.1211072354150.5888@ubuntu12>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Nov 2012, Francesco Lavra wrote:
[...]
>> +	btech = of_get_property(np_bat_supply,
>> +		"stericsson,battery-type", NULL);
>> +	if (!btech) {
>> +		dev_warn(dev, "missing property battery-name/type\n");
>> +		strcpy(bat_tech, "UNKNOWN");
>> +	} else {
>> +		strcpy(bat_tech, btech);
>> +	}
>
> I don't get the point of declaring the char array and copying the string
> in it, when you could simply use just the pointer returned by
> of_get_property().

I am considering a corner case where in 'battery-type' property is not
present and battery is connected.In this case i promote battery to
UNKNOWN from null.
FYI: Further, btemp driver will identify the connected battery based on
resistance value and decide to use.
Ref: ab8500_btemp_id(...) ab8500_btemp.c

> Anyway, if the string property is longer than 8 characters, you are
> writing past the size of the destination array.

i believe it is safe as power_supply.h comprises defines having battery
technology type in 4 characters length which is normally the case and
7 chars length being "UNKNOWN" seldom referred
