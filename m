From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 23 Aug 2016 12:17:23 +0800
Subject: [PATCH 3/9] regulator: core: Try full range when adjusting
 regulators to constraints
In-Reply-To: <20160822180932.GW22076@sirena.org.uk>
References: <20160821021125.1521-1-wens@csie.org>
 <20160821021125.1521-4-wens@csie.org>
 <20160822162907.GO22076@sirena.org.uk>
 <20160822175205.h76hurjaopnosymc@vip.cybercity.dk>
 <20160822180932.GW22076@sirena.org.uk>
Message-ID: <CAGb2v67ZST-E++z5oobLRwCfHMZZR6HTss=MSqJLJArnQz3qMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2016 at 2:09 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Aug 22, 2016 at 07:52:05PM +0200, Rask Ingemann Lambertsen wrote:
>> On Mon, Aug 22, 2016 at 05:29:07PM +0100, Mark Brown wrote:
>
>> > This seems like you have buggy constraints, constraints which allow
>> > voltages that can't physically be satisfied don't make obvious sense.
>
>> No, it's for cases like this (see the cubietruck4 or a80-optimus dts
>> patches):
>
>>                       reg_bldo4: bldo4 {
>>                               regulator-min-microvolt = <1080000>;
>>                               regulator-max-microvolt = <1320000>;
>>                               regulator-name = "vcc12-hsic";
>>                       };
>
>> The regulator can do 1100000 uV, 1200000 uV and 1300000 uV, all of which
>> are within the constraints, so obviously the constraints can be satisfied,
>> yet the regulator core fails do so with a message like this:
>
> Sure, but the constraints also say that you can do 1.32V which the
> system is not physically capable of delivering.  That's not a good sign
> for the constraints, it suggests that at least the capabilities of the
> regulator have not been taken into consideration when setting up the
> constraints.

So to be clear, the constraints should be the intersection of the
recommended operating parameters of the consumer and the regulator's
output, with the voltage/current steps taken in to consideration.

In that case I'll drop this patch and fix up the constraints.
And maybe send a patch to clarify the regulator bindings.

Thanks
ChenYu
