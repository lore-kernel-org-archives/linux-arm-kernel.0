From: girishks2000@gmail.com (Girish KS)
Date: Mon, 8 Apr 2013 15:21:03 +0530
Subject: [PATCH V3 4/5] spi: s3c64xx: Added provision for dedicated cs pin
In-Reply-To: <20130401125744.GG18636@opensource.wolfsonmicro.com>
References: <1363157014-9615-1-git-send-email-ks.giri@samsung.com>
 <1363157014-9615-5-git-send-email-ks.giri@samsung.com>
 <20130401125744.GG18636@opensource.wolfsonmicro.com>
Message-ID: <CAKrE-Kd+YAFmteDdh3odtV+YU1=OjoMuQV9usF4NmUse+TXhTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 1, 2013 at 6:27 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Mar 13, 2013 at 12:13:33PM +0530, Girish K S wrote:
>> From: Girish K S <girishks2000@gmail.com>
>>
>> The existing driver supports gpio based /cs signal.
>> For controller's that have one device per controller,
>> the slave device's /cs signal might be internally controlled
>> by the chip select bit of slave select register. They are not
>> externally asserted/deasserted using gpio pin.
>
> Applying this patch breaks my S3C64xx based system (Cragganmore, a
> non-DT platform).  It'll break all existing non-DT platforms since...

sure will rebase and take care of the non-dt case

>
>> + * @cs_gpio: CS line status, 'true' if CS line is asserted by gpio.
>> + *        'false' if asserted by internal dedicated pin.
>>   * @line: Custom 'identity' of the CS line.
>>   *
>>   * This is per SPI-Slave Chipselect information.
>> @@ -25,6 +27,7 @@ struct platform_device;
>>   */
>>  struct s3c64xx_spi_csinfo {
>>       u8 fb_delay;
>> +     bool cs_gpio;
>>       unsigned line;
>>  };
>
> ...you've added this new cs_gpio field to the platform data but not
> updated any of the existing users (including Cragganmore).  It would
> seem better to make the default behaviour stay as per the current
> default and make the new behaviour optional but at a minimum all
> existing in-tree users need to be updated.
>
> It's also a bit odd that we end up checking cs_gpio and then using line
> in the code, it'd be more idiomatic if cs_gpio were the GPIO number.

In the original driver it was assumed that the cs line is always a gpio pin.
But the current controller that i am working on has no gpio pin for cs
selection.
All the lines to the device are internally connected. There is no
option to select
the cs signal. So cs-gpio property parsing has to skipped for this
controller, that means
cs_gpio cannot be a GPIO number. If it has to be a number then it has
to be < 0 to say
it is not gpio. Any >= 0 number implies it is a valid gpio (in reality
for this controller it is not.)

So i introduced a new member cs_gpio. I will checkout the possibility
to avoid this member.
