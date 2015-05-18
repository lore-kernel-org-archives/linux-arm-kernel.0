From: tony@atomide.com (Tony Lindgren)
Date: Mon, 18 May 2015 09:29:36 -0700
Subject: [PATCH] ARM: dts: am335x-bone* enable pmic-shutdown-controller
In-Reply-To: <CAOCHtYgwyQy+hQE2PeUd+7U9wNygVOUuAb-VSh_9K5y7zFHEWA@mail.gmail.com>
References: <1431525001-5747-1-git-send-email-robertcnelson@gmail.com>
 <20150513141658.GB6605@localhost> <20150513144846.GC6605@localhost>
 <CAALWOA-hkgrMi+OeNrmwaVpdEfNadFn0R-QbpXi9LU-4sbakJQ@mail.gmail.com>
 <20150518152108.GE10274@atomide.com>
 <CAOCHtYgwyQy+hQE2PeUd+7U9wNygVOUuAb-VSh_9K5y7zFHEWA@mail.gmail.com>
Message-ID: <20150518162936.GF10274@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Robert Nelson <robertcnelson@gmail.com> [150518 09:15]:
> On Mon, May 18, 2015 at 10:21 AM, Tony Lindgren <tony@atomide.com> wrote:
> 
> All the rev information is in the board's eeprom:
> 
> hexdump -e '8/1 "%c"' /sys/bus/i2c/devices/0-0050/eeprom -s 12 -n 4
> 
> Rev A5B
> 0A5B
> 
> Rev C
> 000C
> 
> Just another default qwerk to add to Pantelis' bone_capemgr. ;)

It seems we should not even instantiate some devices on BBB
until the EEPROM is parsed.. So maybe something like this:

1. The problem devices are initially set with status = "disabled"
   in the dts

2. We set up drivers/*/bbb-eeprom.c that parses the board
   revision at module_init time, and then flips the selected
   devices to have status = "enabled" and populates the revision
   info based on the eeprom and SoC revision passed in pdata.
   Then those devices get their struct device created and
   probed, but at a much later time.

So rather than trying to init all that early, let's just
init them much later when we have the proper I2C driver
running?

Regards,

Tony
