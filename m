From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 30 May 2012 18:05:31 +0800
Subject: [PATCH v2 4/6] ARM: Samsung: Modify
 s3c64xx_spi{0|1|2}_set_platdata function
In-Reply-To: <20120530093421.GA9947@opensource.wolfsonmicro.com>
References: <1337333613-6216-1-git-send-email-thomas.abraham@linaro.org>
 <1337333613-6216-5-git-send-email-thomas.abraham@linaro.org>
 <20120520092113.GA20652@opensource.wolfsonmicro.com>
 <CAOesGMhFcdv7QW=_1U8HHfaETD83mJt=Dgk-8z40yOrC3PB_fA@mail.gmail.com>
 <20120530093421.GA9947@opensource.wolfsonmicro.com>
Message-ID: <CAJuYYwShLhKSrpGhaTyxX4dqaiKDAcjBtuWSMYAdsWcOMfP=qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 May 2012 17:34, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, May 30, 2012 at 12:28:55AM -0700, Olof Johansson wrote:
>> On Sun, May 20, 2012 at 2:21 AM, Mark Brown
>
>> > This dev_name also isn't equivalent to dev_name() which makes matters
>> > more confusing than they need to be.
>
>> Looks like they use the name as the magic string to pick initialization data.
>
> Right, and there's no problem at all with using the name. ?The thing is
> that there's no need to set the name at runtime since the struct device
> being configured is always going to end up with the same name and doing
> so is just causing confusion. ?The device being registered is specific
> to the SoC already so setting the SoC name at runtime isn't needed.

I think I did not understand your point. There is only one instance of
spi platform device statically defined for all Samsung platforms. The
name of this device is set as "s3c64xx-spi". Now, to choose a
particular driver data (for a platform) based on the device name, the
device name has to be changed during boot to indicate the platform.

If this not a good way, then the other way to choose driver data based
on device name is to statically define platform device for each of the
samsung platforms. This will add more lines of code into arch/arm and
can be avoided. If all the Samsung platforms had device tree support
enabled, this would not have been a problem.

>
>> I wonder if it makes more sense to keep the platform_data still
>> around, and just fill it in with the table (from patch "spi: s3c64xx:
>> move controller information into driver data") based on the OF
>> compatible field for the device-tree probe case, instead of trying to
>> overload and having to change the name in this way.
>
> We could do that, though it does seem nice to have everything be
> consistent.

So, for now, I will not change the existing platform data. But add
driver data (spi controller configuration) only for dt enabled
platforms. And use the spi controller configuration found in the
driver data instead of the platform data.

Thanks Mark for your comments.

Regards,
Thomas.
