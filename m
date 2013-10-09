From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 09 Oct 2013 09:58:03 -0600
Subject: [PATCH] pinctrl: phandle entries will be applied sequentially
In-Reply-To: <20131009124425.GG25034@n2100.arm.linux.org.uk>
References: <1381297324-19006-1-git-send-email-shawn.guo@linaro.org>
 <CACRpkdazPK6SNg9PdWCrjB8nwho1rCueumJWAN=STXdN1zNnMA@mail.gmail.com>
 <20131009124425.GG25034@n2100.arm.linux.org.uk>
Message-ID: <52557D0B.5040901@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/2013 06:44 AM, Russell King - ARM Linux wrote:
> On Wed, Oct 09, 2013 at 02:40:49PM +0200, Linus Walleij wrote:
>> NAK this this a Linux kernel implementation detail. Sherman Yin
>> fixed this up so the drivers does not have to imply any sequence
>> semantic for this.
>>
>> Study commit 03b054e9696c3cbd3d5905ec96da15acd0a2fe8d
>> "pinctrl: Pass all configs to driver on pin_config_set()"
>>
>> It is perfectly legal for a driver to accumulate the settings into
>> e.g. a single register write if it can, e.g.:
>>
>> u32 val = 0;
>>
>> for (i = 0; i < num_configs; i++) {
>>   switch() {
>>   FOO:
>>      val |= 1;
>>      break;
>>    BAR:
>>      val |= 2:
>>      break;
>>    BAZ:
>>      val |=4;
>>      break;
>> };
>>
>> writel(val, base+pinreg);
>>
>> I.e. the driver may choose to apply configs sequentially, but that is
>> not at all necessary.
> 
> So, just to be clear, what you're saying is that specifying two settings
> in a pinctrl declaration which provide different values results in
> undefined behaviour?

That makes sense to me, yes. It should be simple to separate out the
common/shared parts of a configuration, vs. other unique parts, and put
them into separate "pin configuration nodes", and hence avoid the
situation completely.
