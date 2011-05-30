From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 30 May 2011 22:56:15 +0800
Subject: CSR ARM SoC Subarchitecture preview
In-Reply-To: <201105261740.05985.arnd@arndb.de>
References: <BANLkTikfje67KyyD+7Pn0D=afTyEde0euw@mail.gmail.com>
	<201105250851.03665.arnd@arndb.de>
	<BANLkTikOyo9g1GD_dOxb5As2Yr0rBc+hyA@mail.gmail.com>
	<201105261740.05985.arnd@arndb.de>
Message-ID: <BANLkTikN+y4XXr2nk8OCF477a3JmJbvizQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/26 Arnd Bergmann <arnd@arndb.de>:
> On Thursday 26 May 2011, Barry Song wrote:
>> 2011/5/25 Arnd Bergmann <arnd@arndb.de>:
>> > On Wednesday 25 May 2011 04:15:12 Barry Song wrote:
>> >
>> > Regarding platform data, the ideal case would be to not pass any,
>> > and have the driver itself enquire the settings by looking at device
>> > tree properties. There may be a few cases where that is not possible,
>> > or where a callback into platform code ends up simplifying things
>> > significantly, but that should stay the exception.
>> really. some hardware-related callbacks are now in arch and make
>> driver codes simpler and better to cross platform without considering
>> trivial hardware details.
>> if they are moved to drivers, the drivers will be very ugly with things like:
>> #ifdef BOARD_X
>> ....
>> #elif defined(BOARD_Y)
>> ...
>> #endif
>> that is not what people want.
>>
>> so a temp way is maybe providing funtions in arch as exported symbols
>> which will be called by drivers. different boards implement them in
>> different codes.
>
> We really need to look at this case-by-case. The #ifdef mess you cited
> is of course not acceptable, but that my feeling is that in most cases
> we can find a much nicer solution. It depends of course on what code
> gets run in the board specific fixup.
>
>> > From the little I know about GPS, the controllers have a fairly standardized
>> > serial port interface even across vendors. It would be good to be
>> > compatible with the existing ones there, e.g. bluetooth or serial GPS that
>> > all provide a tty interface. If your's is very different and has a
>> > high-level API, you might want to create a new drivers/gps/ subsystem
>> > with an architected user interface that works with both your own
>> > implementation and the serial ones.
>> > Turning a tty into a high-level interface is normally done using a new tty
>> > line discipline, similar to how PPP or CAN work over serial lines.
>>
>> yes. gps generally is an external module connected to SoC's uart.
>> actually, the char device we are talking is more like firmware inside
>> a common gps module. it is in lower level than an external interface.
>> anyway, csr is a company with gps technology. i'd like to figure out
>> whether we can provide a generic framework.
>
> Great! I think many people would appreciate that.
>
> This may actually be as easy as providing a new line discipline with
> very simple ioctls (e.g. GPSIO_GET_CURRENT_POSSITION).

yes. i believe that makes more senses than a simple char-based device
or misc device. the internal gps can still show as a /dev/ttyGPS or
something with a new ldisc.

>
> ? ? ? ?Arnd
>
