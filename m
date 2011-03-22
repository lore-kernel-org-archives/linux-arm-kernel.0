From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 23 Mar 2011 01:51:02 +0900
Subject: [PATCH] Input: tca6416-keypad: Change to module_init()
In-Reply-To: <20110322163144.GC2202@sirena.org.uk>
References: <20110322142619.1109.89105.sendpatchset@t400s>
	<20110322142855.GB2202@sirena.org.uk>
	<20110322143307.GB24004@linux-sh.org>
	<AANLkTimRV9vzOE7+VPX48y3KebLJSvBOkqxoM--9gqGb@mail.gmail.com>
	<20110322153226.GC30303@linux-sh.org>
	<AANLkTimyxdcJ-eEke9x7X1zdiJNbFtncfv0=NzKjtAme@mail.gmail.com>
	<20110322155730.GD30303@linux-sh.org>
	<AANLkTi=Fjc2f837ifH152Rh8W0PfiZvViYaLe=8XZo4Z@mail.gmail.com>
	<20110322163144.GC2202@sirena.org.uk>
Message-ID: <AANLkTiniBVWhSiNZMRYbO857D_Vj03KxH4qYqkVo-11J@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2011 at 1:31 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Mar 23, 2011 at 01:20:23AM +0900, Magnus Damm wrote:
>> On Wed, Mar 23, 2011 at 12:57 AM, Paul Mundt <lethal@linux-sh.org> wrote:
>
>> > In this case I would suspect general indifference or simply copying other
>> > drivers. I2C is a bit of a tricky case with regards to ordering in
>> > general, but at least input devices are relatively straightforward.
>
>> I remember having to move the init order around at least once before
>> in the case of i2c, so I'm not so surprised when new initcall issues
>> come up now and then.
>
> It's mostly an issue for PMICs (and possibly some other similar things)
> so that the regulators are present before their consumers try to start.
> I'm not aware of any issues with I2C itself.

I recall changing my i2c bus driver i2c-sh_mobile.c from module_init()
to subsys_initcall() a few years ago (see
ccb3bc16b4891a82649d4bccbeefe60b1d9a62e2) - this because regular
drivers tend to use module_init() and following the link order is not
enough. I think the patch for tca6416 is more or less the same issue
but on subsys_initcall() level instead.

I'm not sure if this is i2c specific though - in general you probably
need to register the parent bus driver first.

I've seen some SH-Mobile designs with PMICs, and they all use a
dedicated i2c bus.

>> The "may" above comes from that I don't know the i2c bus driver
>> initcall time on non-SH-Mobile platforms. So this may trigger on other
>> platforms, or it may not depending on their cpu/board code and I2c bus
>> driver.
>
> In general embedded platforms register I2C early as things like PMICs
> typically hang off them. ?Grant was trying to push people to use
> deferred registration for this stuff but it didn't happen yet and I'd
> personally be more comfortable with more infastructure supporting that.

The dependency tracking is a bit primitive with only initcalls. I
wouldn't mind something like this:

-static int __init tca6416_keypad_init(void)
-{
-	return i2c_add_driver(&tca6416_keypad_driver);
-}
-
-subsys_initcall(tca6416_keypad_init);
-
-static void __exit tca6416_keypad_exit(void)
-{
-	i2c_del_driver(&tca6416_keypad_driver);
-}
-module_exit(tca6416_keypad_exit);
+i2c_driver_module(&tca6416_keypad_driver);

Cheers,

/ magnus
