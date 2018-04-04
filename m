From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Wed, 4 Apr 2018 22:19:59 +0300
Subject: [PATCH v2 1/6] spi: core: handle timeout error from transfer_one()
In-Reply-To: <20180404070817.6cens44jvlmdaxtm@flea>
References: <20180403152905.1524-1-ssuloev@orpaltech.com>
 <20180403152905.1524-2-ssuloev@orpaltech.com>
 <20180403155224.GA11578@sirena.org.uk>
 <c0476d75-821f-7a0d-3c3f-270304e7b032@orpaltech.com>
 <20180403161824.GB11578@sirena.org.uk>
 <dad0ea81-2dd6-ccc3-a0c9-cf20ff195b7f@orpaltech.com>
 <20180404070817.6cens44jvlmdaxtm@flea>
Message-ID: <a75ac9e8-e95e-d412-a1f9-15de1d99badd@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2018 10:08 AM, Maxime Ripard wrote:
> On Tue, Apr 03, 2018 at 07:24:11PM +0300, Sergey Suloev wrote:
>> On 04/03/2018 07:18 PM, Mark Brown wrote:
>>> On Tue, Apr 03, 2018 at 07:00:55PM +0300, Sergey Suloev wrote:
>>>> On 04/03/2018 06:52 PM, Mark Brown wrote:
>>>>> On Tue, Apr 03, 2018 at 06:29:00PM +0300, Sergey Suloev wrote:
>>>>>> As long as sun4i/sun6i SPI drivers have overriden the default
>>>>>> "wait for completion" procedure then we need to properly
>>>>>> handle -ETIMEDOUT error from transfer_one().
>>>>> Why is this connected to those drivers specifically?
>>>> These 2 drivers have their own "waiting" code and not using the code from
>>>> SPI core.
>>> Does this not apply to any other driver - why is this something we only
>>> have to do when these drivers do it?  That's what's setting off alarm
>>> bells.
>> sun4i/sun6i drivers have let's say "smart" waiting while SPI core uses a
>> fixed interval to wait.
>>
>> I can't say for every SPI driver in kernel, that's outside of my area of
>> expertise.
> I'm not sure what's specific about the sun4i / sun6i case here. Your
> patch doesn't have anything to do with the delay before the timeout,
> but the fact that we return -ETIMEDOUT in the first place.
>
> And I'm pretty sure that papering over an error returned by a driver
> is not the right thing to do.
>
> Maxime
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

do you mean the changes in spi.c are not required at all ?

My point was to eat ETIMEDOUT error from transfer_one() as it is just a 
mark and

shouldn't be handled as a normal error.
