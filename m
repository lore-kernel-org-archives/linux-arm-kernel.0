From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Dec 2015 17:09:03 +0100
Subject: [PATCH v1 0/6] misc: add reboot mode driver
In-Reply-To: <3171716.cOpneyGyL8@diego>
References: <1450774949-23901-1-git-send-email-andy.yan@rock-chips.com>
 <3460735.DIRnhNBgbJ@wuerfel> <3171716.cOpneyGyL8@diego>
Message-ID: <6304362.XcrazqMAeC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 December 2015 16:56:12 Heiko St?bner wrote:
> Am Montag, 28. Dezember 2015, 16:28:55 schrieb Arnd Bergmann:
> > On Wednesday 23 December 2015 17:31:45 Andy Yan wrote:
> > > +        { .compatible = "rockchip,reboot-mode-nvram",
> > > +                .data = (void *)&reboot-mode-nvram },
> > > +        {},
> > > +};
> > 
> > nvram is a complex topic by itself, because there are so many ways to do it.
> > I think what you are referring to here is a battery-backed memory that uses
> > one or more bytes at a fixed offset to store a particular piece of
> > information, as the drivers/char/nvram.c driver does. Maybe we should put
> > the reboot mode into that driver then?
> > 
> > There are other nvram drivers at various places in the kernel, and each may
> > be slightly different, or completely different, like the EFIVARs driver on
> > UEFI firmware or the key/value store on Open Firmware, these probably need
> > their own methods and not share the generic driver.
> 
> actually we now have drivers/nvmem/* that does that byte-wise addressing for 
> eeproms, efuses, etc in a generic way.

Good point, so some of the reboot-reason users will be able to use that
framework, but some will not:

- drivers/nvmem only works for fixed-length data in a fixed location, but
  not for key/value pairs, TLVs etc.

- Coming back to an earlier problem I pointed out, a lot of the things
  stored in an nvram need a consistent user interface. This includes stuff
  like kernel command line, boot image name, boot device, console
  configuration, network mac address. We probably want the reboot reason
  to fit into the wider framework for these, and drivers/nvmem doesn't
  (currently) look like a good place for that.

	Arnd
