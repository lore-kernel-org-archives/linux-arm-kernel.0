From: robh@kernel.org (Rob Herring)
Date: Sat, 17 Jan 2015 11:53:56 -0600
Subject: [Linaro-acpi] [PATCH v7 00/17] Introduce ACPI for ARM64 based on
 ACPI 5.1
In-Reply-To: <1887263.kzglbjcc0t@wuerfel>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1809831.d9GPSfLUEN@wuerfel> <20150116154913.GW7091@arm.com>
 <1887263.kzglbjcc0t@wuerfel>
Message-ID: <CAL_JsqJzx62Vt09PK=G0WZsr0hXPj5oB=fxtVtfQD2Ys6=n-iQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 9:53 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 16 January 2015 15:49:13 Will Deacon wrote:
>>
>> The on-board ethernet on Seattle requires the driver to program its AXI
>> attributes, so configuring it to be a coherent master actually means
>> "program the same cacheable AXI settings as you have on the CPU". That
>> sounds like Linux should be doing it to me, but even if the firmware takes
>> a guess at "normal cacheable WBRWA", it's not clear to me whether that
>> register persists across things like adapter reset.
>>
>> Tom?
>>
>> There's also the situation where the firmware hasn't initialised the
>> register and Linux realises this during probe. What should it do then?
>
> In case of a 10gbit ethernet adapter, there really should be no question
> regarding whether to set it coherent or not. Can't Linux just always
> set this AXI attribute in the driver?

Coherency is easy to get wrong, so the path could be broken. In fact
on highbank, it is the non-coherent path that is broken. You could
find out pretty far down the road that you need to change
configuration. But yes, I agree with your point as you pretty much
have to run coherently for decent performance on high speed
peripherals.

If we are mucking with AXI specifics in the kernel on ACPI systems,
we've already failed to abstract the platform. AXI is not even part of
the architecture.

Rob
