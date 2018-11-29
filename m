From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Nov 2018 10:28:26 +0000
Subject: I2c eeprom file missing - SFP module
In-Reply-To: <CAEHvULmcFk5Z3kLRY-MF6vRVNms9q91X8k3MCq7aLXC4SRgyXw@mail.gmail.com>
References: <CAEHvULmcFk5Z3kLRY-MF6vRVNms9q91X8k3MCq7aLXC4SRgyXw@mail.gmail.com>
Message-ID: <20181129102826.GS30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 29, 2018 at 12:20:48PM +0200, Roman Rozman wrote:
> Hi all,
> I have some linux kernel & SFP/I2C driver issue.

It seems you aren't using the SFP subsystem, which knows how to deal
with these dynamic devices.  The EEPROM contents is available via
ethtool when the network driver is converted (not many drivers have
been converted, and there are no plans to convert them except where
there's a need.)

> 1. working case:
> 
> When SFP module is inserted in my development unit board from the
> start (before the kernel loads up) then when startup completed i can
> see and read the eeprom file in the path:
> /sys/class/i2c-adapter/i2c-1/1-0050/eeprom
> 
> kernel prints on startup shows the i2c device scan result:
> 
> i2c /dev entires driver
> at24 - 1-0050: 256 byte 24c02 EEPROM, writable, 1 bytes/write
> at24 - 1-0052: 3278 byte 24c256 EEPROM, writable, 1 bytes/write

Right, because you've specified in DT that there is an EEPROM
present and the kernel finds it.

> 2. not working case:
> 
> If there is no SFP module inserted on startup,and kernel completes the
> boot procces, then when i'm inserting the SFP module in,i observe that
> the path:
> /sys/class/i2c-adapter/i2c-1/1-0050/ DOESN'T include the eeprom file.
> 
> the folder exists & includes:
> modalias,name,of_node,power,subsystem,ueventbut no eeprom file.
> 
> The device tree part of the sfp-eeprom code:
> 
> &i2c0 {
>  ...
>   sfp_eeprom at 50 {
>  compatible = "at,24c02";
>  reg = 0x50 ;
>  };

You're telling the kernel that there is an EEPROM there for the I2C
EEPROM driver.  The kernel probes it, finds it not present, and the
driver fails to initialise.

This driver knows nothing about hot-pluggable SFP modules - it isn't
a SFP driver.  It's merely a generic driver for I2C EEPROMs.

The newly added SFP subsystem does not expose the EEPROM via sysfs,
only via the standard ethtool -m interface.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
