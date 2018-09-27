From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Thu, 27 Sep 2018 10:41:16 -0700
Subject: [PATCH i2c-next v3 2/3] i2c: aspeed: Add 'aspeed,timeout' DT
 property reading code
In-Reply-To: <CACPK8XcKms88EcpT3soE6wLyAmvyiLfVkNeOQT0FgmY4eZoDrw@mail.gmail.com>
References: <20180926215842.23125-1-jae.hyun.yoo@linux.intel.com>
 <20180926215842.23125-3-jae.hyun.yoo@linux.intel.com>
 <CACPK8XcKms88EcpT3soE6wLyAmvyiLfVkNeOQT0FgmY4eZoDrw@mail.gmail.com>
Message-ID: <37ae7a11-44b6-88e5-0f4d-c97c70334ad4@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joel,

On 9/26/2018 8:11 PM, Joel Stanley wrote:
> On Thu, 27 Sep 2018 at 01:58, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>>
>> +/* Timeout */
>> +#define ASPEED_I2C_BUS_TIMEOUT_US_DEFAULT              (5 * 1000 * 1000)
> 
> The 5 seconds time out is way too long. On a system that doesn't have
> functional i2c, this holds up boot for a long time as most i2c client
> drivers try to initialise their device and fail. I realise you're not
> changing the value, but we should pick a better default. 1 second?
> Half a second?
> 

I agree with you. We could probably use 1 second as default which can
cover the most of general cases. If so, we don't need to make the
default setting in this driver because i2c-core-base will default
adap->timeout to 1 second if the value is 0 when a driver registers an
adapter. Will fix this code.

>>
>> +       ret = of_property_read_u32(pdev->dev.of_node, "aspeed,timeout",
>> +                                  &timeout_us);
> 
> Can we make this binding generic? It's not specific to aspeed's
> hardware. Getting the value could even part of the i2c core.
> 
> I read the previous thread with Wolfram. I think this would still fit
> with what Wolfram suggested, but please forgive my jetlagged brain if
> I've missed something.
> 

It followed the way of the existing i2c-mpc driver uses 'fsl,timeout'
for the same purpose. Though, I also want to make it as a generic as you
suggested like 'timeout' in milliseconds unit, not in microseconds unit.
If making it a generic property is acceptable, I'll fix it too.

Wolfram, can you please share your thought on it?

Thanks,
Jae
