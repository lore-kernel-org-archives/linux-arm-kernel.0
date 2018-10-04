From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Thu, 4 Oct 2018 13:06:20 +0200
Subject: [PATCH v2 00/29] at24: remove at24_platform_data
In-Reply-To: <a4c2e6cf-749a-83a1-0bda-43ddb7e744cd@gmail.com>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180831194643.GA62862@ban.mtv.corp.google.com>
 <CAMRc=MejZLV1EQ7uAddsxLY0MTUF8WyiBn=F0ZhkWQJpET0EDQ@mail.gmail.com>
 <a4c2e6cf-749a-83a1-0bda-43ddb7e744cd@gmail.com>
Message-ID: <CAMRc=MfwM7vODsnuV9eKS4Uf7M5ac59u7ao7KvyaxKzPv5FRvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?r., 3 pa? 2018 o 23:04 Florian Fainelli <f.fainelli@gmail.com> napisa?(a):
>
>
>
> On 10/3/2018 1:15 PM, Bartosz Golaszewski wrote:
> > pt., 31 sie 2018 o 21:46 Brian Norris <computersforpeace@gmail.com> napisa?(a):
> >>
> >> Hi,
> >>
> >> On Fri, Aug 10, 2018 at 10:04:57AM +0200, Bartosz Golaszewski wrote:
> >>> Most boards use the EEPROM to store the MAC address. This series adds
> >>> support for cell lookups to the nvmem framework, registers relevant
> >>> cells for all users, adds nvmem support to eth_platform_get_mac_address(),
> >>> converts davinci_emac driver to using it and replaces at24_platform_data
> >>> with device properties.
> >>
> >> We already have:
> >>
> >> of_get_nvmem_mac_address() (which does exactly what you're adding,
> >> except it's DT specific)
> >> of_get_mac_address()
> >> fwnode_get_mac_address()
> >> device_get_mac_address()
> >>
> >> and now you've taught me that this exists too:
> >>
> >> eth_platform_get_mac_address()
> >>
> >> These mostly don't share code, and with your series, they'll start to
> >> diverge even more as to what they support. Can you please help rectify
> >> that, instead of widening the gap?
> >>
> >> For instance, you can delete most of eth_platform_get_mac_address() and
> >> replace it with device_get_mac_address() [1]. And you could add your new
> >> stuff to fwnode_get_mac_address().
> >>
> >> And important part to note here is that you code isn't just useful for
> >> ethernet -- it could be useful for Wifi devices too. So IMO, sticking it
> >> only in an "eth" function is the wrong move.
> >>
> >> Brian
> >>
> >> [1] arch_get_platform_mac_address() is the only part I wouldn't want to
> >> replicate into a truly generic helper. The following should be a no-op
> >> refactor, AIUI:
> >>
> >
> > The only user of arch_get_platform_mac_address() is sparc. It returns
> > an address that seems to be read from some kind of EEPROM. I'm not
> > familiar with this arch though. I'm wondering if we could somehow
> > seamlessly remove this call and then convert all users of
> > eth_platform_get_mac_address() to using device_get_mac_address()?
> >
> > David: I couldn't find a place in sparc code where any ethernet device
> > would be registered, so is there a chance that nobody is using it?
>
> SPARC uses a true Open Firmware implementation, so it would register
> drivers through the CONFIG_OF infrastructure.
> --

I'm seeing that there are only six callers of
eth_platform_get_mac_address() (the only function which calls
arch_get_platform_mac_address()).

Of these six callers four are intel ethernet drivers and two are usb
ethernet adapter drivers.

Is it even possible that sparc wants to get the mac address for a usb
adapter from some memory chip? Maybe we *can* safely remove that
function completely? That would allow us to simplify a lot of code.

Bart
