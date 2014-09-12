From: marvin24@gmx.de (Marc Dietrich)
Date: Fri, 12 Sep 2014 13:42:33 +0200
Subject: [RFC 4/4] ARM: shmobile: r8a7790: adapt DTS for I2C slave support
In-Reply-To: <20140912095821.GB1930@katana>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
 <7627175.tG5quZH0VN@fb07-iapwap2> <20140912095821.GB1930@katana>
Message-ID: <1921859.32moD2F04k@fb07-iapwap2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 12. September 2014, 11:58:21 schrieb Wolfram Sang:
> > ok, take our embedded controller driver (in staging/nvec) as an example.
> > It's basicly an MFD connecting keyboard, mouse, power, gpio, and some
> > other stuff to the soc. The MFD operates in master mode while the SOC is
> > the I2C slave. Theoretically, these roles could also switch (but that's
> > not defined in the nvec protocol).
> 
> I see these cases currently:
> 
> 1) my current case
> 
> The I2C slave is not needed for board bringup, mainly for development or
> playing around. It can have this or that functionality on this or that
> address. -> does not belong into DT, should be done in userspace
> 
> 2) Slave mode is needed for board bringup
> 
> Some other components need a specific I2C slave to be present before
> userspace is available, otherwise the system is unusable. This is IMO
> then a hardware description and justifies DT entries:
> 
> DT pseudocode:
> 
> 	i2c {
> 		compatible = "nvidia, tegra-i2c";
> 
> 		ec-slave at 42 {
> 			compatible = "nvidia, ax100-ec-slave";
> 			reg = <0x42>;
> 		};
> 	};
> 
> Of course, an MFD driver providing "nvidia, ax100-ec-slave" is needed
> which uses the I2C slave mode of the tegra controller.
> 
> 3) Master + slave mode is needed for board bringup:
> 
> Again, IMO a hardware description, so we could use:
> 
> 	i2c {
> 		compatible = "nvidia, tegra-i2c";
> 
> 		ec at 64 {
> 			compatible = "nvidia, ax100-ec";
> 			reg = <0x64>;
> 		};
> 	};
> 
> This is a standard I2C device driver (using the MFD framework) where
> i2c-tegra would act as a master on the client for 0x64. However, its
> probe function can fill an i2c_board_device (the driver should know the
> slave device address because of the protocol), get a new client using
> i2c_new_device, and register that as a I2C slave client. It then has an
> address where it listens and an address where it can send to. When to do
> what is protocol implementation.
> 
> Am I missing something? Board properties can be encoded within the
> compatible entries ("ax100-ec", "ax200-ec"...). I'd think this means
> mostly different protocols, though.

well, ac100 is the name of the board and nvec is the name of the protocol. 
Anyway, I'm fine with encoding the mode to use in the compatible property. 
Like you said before, a hypothetical driver supporting both modes could also 
register two compatibility strings (eg. nvidia,nvec and nvidia,nvec-slave) and 
use the mode (and hence the meaning of the reg value) according to this 
string.

Thanks,

Marc
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140912/9322a1de/attachment-0001.sig>
