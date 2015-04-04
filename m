From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 04 Apr 2015 15:05:44 +0200
Subject: [PATCH] sunxi: a10-lime: add regulator nodes
In-Reply-To: <20150404125645.GK14618@lukather>
References: <551537ED.7060402@gmail.com> <551538AB.50207@redhat.com>
 <55169622.5070007@gmail.com> <20150330222311.GY23664@lukather>
 <CABxcv=nCROiQ2COrTmnwvhtSJzh83BWKaxgn0EkFuwW8HqSiQw@mail.gmail.com>
 <20150404123302.GY6023@sirena.org.uk> <20150404125645.GK14618@lukather>
Message-ID: <551FE1A8.9060709@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04-04-15 14:56, Maxime Ripard wrote:
> Hi Mark,
>
> On Sat, Apr 04, 2015 at 01:33:02PM +0100, Mark Brown wrote:
>> On Sat, Apr 04, 2015 at 02:18:12PM +0200, Javier Martinez Canillas wrote:
>>> On Tue, Mar 31, 2015 at 12:23 AM, Maxime Ripard
>>
>>>> No, it's defining which regulators are provided by the regulator, and
>>>> the voltage boundaries they have. It doesn't make any assumption with
>>>> regards to what is connected to what, and if a particular regulator is
>>>> connected to something. That's something that the board DTS should
>>>> describe as accurately as possible.
>>
>> This is broken - think about what this means.  If you are defining a
>> voltage (or any other constraint) you're saying that it's safe to use on
>> a given board. If you provide a voltage constraint saying that the
>> maximum allowable range for a voltage regulator is safe.  That's
>> unlikely to be true on any given board, usually only a limited set of
>> regulators can vary voltages at runtime safely at all and then rarely
>> over their full supported range.  Similarly for other constraints, for
>> example allowing a regulator to be disabled when there are driverless
>> things (or drivers without regulator support or mappings for that board)
>> relying on it is going to break.
>>
>> Providing a list of the regulators is safe but not really doing a huge
>> amount.
>>
>> Note that I've not seen the original patch so it's possible it's doing
>> something different.
>
> If this model is broken, then I don't see how the full regulator
> support is not broken.
>
> Our PMIC DTSI sets up the regulators with the ranges supported by the
> PMIC. We have two cases then:
>    - Either the regulator is not used on the board, and it will be
>      disabled by the framework.
>    - Or the regulator is actually used on the board, it will be defined
>      in the DTS, possibly with additional constraints.


Note that we've already stopped defining any constraints in the dtsi as
that indeed does not make much sense, if the dts does not provide
any constraints but does use / enable the regulator then:
1) That is a bug in the dts really
2) It will end up with the actual hardware constraints anyways as those
are coded into the driver.

>What I do see though, is that if we drop the DTSI, all our
> boards will have to define all the PMIC regulators, even if they're
> not used at all on the board, just to have the right behaviour. And
> that's clearly a no-go for me.

Right the advantage of the dtsi is that it lasts ALL regulators,
so that unused ones actually get turned off, where as a dts not using
the dtsi and only containing those it actually uses will result in
the unused regulators being untouched (since they are not listed)
rather then turned off.

Regards,

Hans
