From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Jan 2018 14:22:48 +0100
Subject: [PATCH linux dev-4.10 6/6] drivers/hwmon: Add a driver for a
 generic PECI hwmon
In-Reply-To: <bdc0375d-c379-6c2e-b350-76741afe151d@linux.intel.com>
References: <20180109223126.13093-1-jae.hyun.yoo@linux.intel.com>
 <20180109223126.13093-7-jae.hyun.yoo@linux.intel.com>
 <CAK8P3a31+9HGQ=fQby5Zi1RZ671hKraZP_2ggLTMX3qvOiTx0w@mail.gmail.com>
 <bdc0375d-c379-6c2e-b350-76741afe151d@linux.intel.com>
Message-ID: <CAK8P3a0xyQQeyDdj8UEMgdGK13jisvo5rOkGbi-wWYZA5QFSMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 11, 2018 at 12:45 AM, Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
> On 1/10/2018 4:29 AM, Arnd Bergmann wrote:
>>
>> On Tue, Jan 9, 2018 at 11:31 PM, Jae Hyun Yoo
>> <jae.hyun.yoo@linux.intel.com> wrote:
>>>
>>> This commit adds driver implementation for a generic PECI hwmon.
>>>
>>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>>
>>
>>> +static int xfer_peci_msg(int cmd, void *pmsg)
>>> +{
>>> +       int rc;
>>> +
>>> +       mutex_lock(&peci_hwmon_lock);
>>> +       rc = peci_ioctl(NULL, cmd, (unsigned long)pmsg);
>>> +       mutex_unlock(&peci_hwmon_lock);
>>> +
>>> +       return rc;
>>> +}
>>
>>
>> I said earlier that peci_ioctl() looked unused, that was obviously
>> wrong, but what you have here
>> is not a proper way to abstract a bus.
>>
>> Maybe this can be done more like an i2c bus: make the peci controller
>> a bus device
>> and register all known target/index pairs as devices with the peci bus
>> type, and have
>> them probed from DT. The driver can then bind to each of those
>> individually.
>> Not sure if that is getting to granular at that point, I'd have to
>> understand better
>> how it is expected to get used, and what the variances are between
>> implementations.
>>
>
> Thanks for sharing your opinion. In fact, this was also suggested by openbmc
> community so I should consider of redesigning it. I'm currently thinking
> about adding a new PECI device class as an abstract layer and any BMC
> chipset specific driver could be attached to the PECI class driver. Then,
> each CPU client could be registered as an individual device as you
> suggested. Will consider your suggestion.

Another idea might be to pretend that PECI was I2C. We already have a few
drivers for hardware that is not I2C but whose software interface looks
similar enough that it just works. No idea if that is the case for PECI, but
xfer_peci_msg might be close enough to i2c_xfer to make it work. If you
are able to do that, then the PECI controller would just register itself
as an i2c controller and it can be accessed using /dev/i2c from user space
or a high-level i2c_driver.

      Arnd
