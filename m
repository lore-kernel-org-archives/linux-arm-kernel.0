From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Sun, 1 Feb 2015 11:08:16 +0100
Subject: bq2415x_charger.c: battery is discharged (fast,
 224mA) when it should be charged
In-Reply-To: <20150201094702.GA21628@amd>
References: <20150201094702.GA21628@amd>
Message-ID: <201502011108.16071@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sunday 01 February 2015 10:47:02 Pavel Machek wrote:
> Hi!
> 
> I connected N900 with full battery using USB. For some reason,
> charge limit was set to 100mA, battery was "full" and was
> discharging:
> 

Make sure you have loaded some usb gadget. Without it battery 
charging via dedicated wallcharger (and probably also usb host 
charger) does not working. g_nokia should be OK.

Try also compiling kernel with CONFIG_USB_GADGET_VBUS_DRAW=500

Also for charger autodetection you need to have loaded 
isp1704_charer.ko module (or compiled into kernel).

And make sure that isp1704_charger is loaded before module 
bq2415x_charger (there is some probe defer, no idea if it works 
as excepted).

> root at n900:/my/tui/ofone# ./tefone
> Ready.
> Battery  4.017 V  4.039 V  81 %  0 %  0 / 0 / 2056 mAh  Full
> -242.224 / 550 / 100  mA
> 
> I adjusted the current limit, but got no change, battery is
> still discharging, fast:
> 
> root at n900:/my/tui/ofone# echo 500 >
> /sys/class/power_supply/bq24150a-0/current_limit

You can try to write "host" to sysfs entry "mode". Another value 
is "dedicated" for wallchargers.

> root at n900:/my/tui/ofone# ./tefone
> Ready.
> Battery  3.994 V  4.034 V  78 %  0 %  0 / 0 / 2056 mAh  Full  
> -251.506 / 550 / 500  mA Battery  4.0 V  4.037 V  79 %  0 % 
> 0 / 0 / 2056 mAh  Full   -223.125 / 550 / 500  mA Battery 
> 4.005 V  4.037 V  79 %  0 %  0 / 0 / 2056 mAh  Full   -224.91
> / 550 / 500  mA Battery  3.994 V  4.037 V  78 %  0 %  0 / 0 /
> 2056 mAh  Full   -224.91 / 550 / 500  mA Battery  4.023 V 
> 4.037 V  81 %  0 %  0 / 0 / 2056 mAh  Full   -224.91 / 550 /
> 500  mA Battery  4.011 V  4.037 V  80 %  0 %  0 / 0 / 2056
> mAh  Full   -224.91 / 550 / 500  mA Battery  3.994 V  4.031 V
>  78 %  0 %  0 / 0 / 2056 mAh  Full   -256.504 / 550 / 500  mA
> Battery  3.994 V  4.029 V  78 %  0 %  0 / 0 / 2056 mAh  Full 
>  -224.017 / 550 / 500  mA Battery  3.988 V  4.029 V  77 %  0
> %  0 / 0 / 2056 mAh  Full   -224.731 / 550 / 500  mA Battery 
> 4.005 V  4.023 V  79 %  0 %  0 / 0 / 2056 mAh  Full   -223.66
> / 550 / 500  mA
> 
> I'm getting a lot of
> 
> [  208.037719] bq27x00-battery 2-0055: battery is not
> calibrated! ignoring capacity values [  238.038024]
> bq27x00-battery 2-0055: battery is not calibrated! ignoring
> capacity values
> 

Message is print every time when somebody try to read those 
properties. I think that printing it only one time should be 
enough. Change to WARN_ONCE?

Also design capacity from bq27x00_battery is incorrect (2056) on 
all N900 devices. It comes from some EEPROM memory stored in N900 
and without HW hacking it is not possible to rewrite.

I would suggest to add support for bq27x00_battery module to do 
not report design capacity. Maybe in N900 DT file can be property 
which tell driver to ignore it.

> messages, that's why all the 0s in battery information dump.
> 
> Any ideas?
> 
> Thanks,
> 									Pavel

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150201/d652accd/attachment.sig>
