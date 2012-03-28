From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Wed, 28 Mar 2012 11:59:41 -0400
Subject: [PATCH] ARM: pxa: fix build failure for regulator consumer in
 em-x270.c
In-Reply-To: <20120328152743.GW3232@opensource.wolfsonmicro.com>
References: <CAP=VYLp-weNj35OHtmZ6pf5-t7OUxWREeu8r5sSOLhFYu0CppQ@mail.gmail.com>
 <1331244366-6147-1-git-send-email-paul.gortmaker@windriver.com>
 <4F732C97.2030804@compulab.co.il>
 <20120328152743.GW3232@opensource.wolfsonmicro.com>
Message-ID: <4F73356D.5080401@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-03-28 11:27 AM, Mark Brown wrote:
> On Wed, Mar 28, 2012 at 05:21:59PM +0200, Igor Grinberg wrote:
>> On 03/09/12 00:06, Paul Gortmaker wrote:
> 
>>> +REGULATOR_CONSUMER(ldo3, "reg-userspace-consumer", "vcc gps");
> 
>> If you make this:
>> REGULATOR_CONSUMER(ldo3, NULL, "vcc gps");
> 
>>> +REGULATOR_CONSUMER(ldo19, "reg-userspace-consumer", "vcc gprs");
>>
>> and this:
>> REGULATOR_CONSUMER(ldo19, NULL, "vcc gprs");
> 
> These don't look like good fixes, you should be specifying the
> dev_name() for the consumer device?  Presumably it's two separate
> consumers and should be .0 and .1 or something?

Here is what I meant when I said in my v2 comment that there was
naming overlap, and that I wasn't sure what impact that had.

The two consumers are:

static struct platform_device em_x270_gps_userspace_consumer = {
        .name           = "reg-userspace-consumer",
        .id             = 0,
        .dev            = {
                .platform_data = &em_x270_gps_consumer_data,
        },
};

and 

static struct platform_device em_x270_gprs_userspace_consumer = {
        .name           = "reg-userspace-consumer",
        .id             = 1,
        .dev            = {
                .platform_data = &em_x270_gprs_consumer_data,
        }
};

Note that the existing names currently don't incorporate the .id
field as a suffix, and so never were unique.

Paul.
