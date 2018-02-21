From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Feb 2018 12:34:53 +0100
Subject: [PATCH 2/3] ARM: orion: mark orion_ge00_mvmdio_bus_name as const
In-Reply-To: <20180221034938.GE14844@lunn.ch>
References: <20180220162519.1498223-1-arnd@arndb.de>
 <20180220162519.1498223-2-arnd@arndb.de>
 <20180221034938.GE14844@lunn.ch>
Message-ID: <CAK8P3a3QKm0jUJ5vThV94Vjg+RFKhcLk36d5yZGmOFzMtGBmfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 21, 2018 at 4:49 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Tue, Feb 20, 2018 at 05:24:51PM +0100, Arnd Bergmann wrote:
>> A section type mismatch warning shows up when building with LTO,
>> since orion_ge00_mvmdio_bus_name was put in __initconst but not marked
>> const itself:
>>
>> include/linux/of.h: In function 'spear_setup_of_timer':
>> arch/arm/mach-spear/time.c:207:34: error: 'timer_of_match' causes a section type conflict with 'orion_ge00_mvmdio_bus_name'
>>  static const struct of_device_id timer_of_match[] __initconst = {
>>                                   ^
>> arch/arm/plat-orion/common.c:475:32: note: 'orion_ge00_mvmdio_bus_name' was declared here
>>  static __initconst const char *orion_ge00_mvmdio_bus_name = "orion-mii";
>>
>> This marks it const as well.
>
> Hi Arnd
>
> I'm not sure this is the correct fix. orion_ge00_mvmdio_bus_name is
> assigned to orion_ge00_switch_board_info->bus_id. This is then passed
> to mdiobus_register_board_info() which makes a copy of
> orion_ge00_switch_board_info and adds it to its linked list. The
> original orion_ge00_switch_board_info will get freed since it is
> __initdata, but the copy still has a pointer to
> orion_ge00_mvmdio_bus_name, which also gets freed.
>
> I think the correct fix is to remove the __initconst from
> orion_ge00_mvmdio_bus_name. Marking it const is however valid.

I looked at it some more and agree with your analysis, thanks for your
review!

I also checked the only other user of mdiobus_register_board_info(),
and made sure it does not have this problem.

I've prepared a new patch now, will send that after some more testing.

      Arnd
