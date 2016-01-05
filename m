From: huangtao@rock-chips.com (Huang, Tao)
Date: Tue, 5 Jan 2016 16:48:59 +0800
Subject: [PATCH] i2c: rk3x: init module as subsys call
In-Reply-To: <7893052.zgDX0r4i77@phil>
References: <1451962938-17398-1-git-send-email-jay.xu@rock-chips.com>
 <2513923.8oltbpbAin@phil> <568B73E8.3010901@rock-chips.com>
 <7893052.zgDX0r4i77@phil>
Message-ID: <568B837B.50607@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Heiko:

On 2016?01?05? 16:00, Heiko Stuebner wrote:
> Hi Tao,
> 
> Am Dienstag, 5. Januar 2016, 15:42:32 schrieb Huang, Tao:

>> I don't think this is a good idea. This will trigger a lots of init call
>> failed. Before pmic init, all i2c device driver transmit will failed,
>> and because i2c is slow bus, and i2c transmit may failed by other
>> reasons, so the i2c driver and i2c device driver will try many times to
>> make sure the transmit completion. These unnecessary transmission will
>> make Linux boot very slow.
> 
> In general, the slowdown won't be _this_ much if touchscreen drivers need 
> one deferral-round before i2c is available. I'm also only pointing out 
> things I remember from the last time this came up. 
> 
> rk3x-i2c even was here already:
> http://www.spinics.net/lists/linux-i2c/msg16680.html

OK. I don't agree with the rule, but we will follow it.

> 
> 
>> I2C bus should be subsys, and we can easy resolve this problem, why we
>> depends on a complicated and slow implementation?
> 
> because it's the only safe way to do that. Because now you need i2c-init at 
> subsys-init time, some months later some other soc may need some other 
> ordering, especially needing i2c-init later/earlier.
> 
> Going through the deferral mechanism is the only way currently available to 
> actually make this work on all socs.
> 
> Tomeu from Collabora is working on some better scheme to optimize device 
> probing order but it looks like this may be a bit off still.
> 
> 
>>> Your touchscreen will have a "xyz-supply" property and I think the
>>> regulator-framework should already emit a -EPROBE_DEFER at
>>> regulator_get,
>>> when the regulator is specified but not available yet.
>>
>> Unfortunately, mostly driver do not support regulator api. They are
>> suppose power is on.
> 
> Having touchscreen drivers support its proper supply-regulators is not 
> rocket science ;-) [0] , so I would consider this a bug in the touchscreen 
> driver itself.

I don't just talk about touch screen driver, most i2c device driver such
as input sensor/camera/rtc/battery will suffer. So people will see their
drivers do not work or slow down on rk3368 platform :(

Thanks!
Huang, Tao
