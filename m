From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 29 Jul 2014 18:07:36 -0700
Subject: use IORESOURCE_REG resource type for non-translatable addresses
 in DT
In-Reply-To: <20140729234522.E9FF1C40738@trevor.secretlab.ca>
References: <53D788A7.4020303@mm-sol.com> <3794875.CZFbAag5Sv@wuerfel>
 <53D7AA72.6010309@mm-sol.com>
 <20140729234522.E9FF1C40738@trevor.secretlab.ca>
Message-ID: <53D84558.7060406@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/14 16:45, Grant Likely wrote:
> On Tue, 29 Jul 2014 17:06:42 +0300, Stanimir Varbanov <svarbanov@mm-sol.com> wrote:
>>
>> This was just an example. Of course it has many issues and probaly it is
>> wrong:) The main goal was to understand does IORESOURCE_REG resource
>> type and parsing the *reg* properties for non-translatable addresses are
>> feasible. And also does it acceptable by community and OF platform
>> maintainers.
> The use case is actually very different from of_address_to_resource or
> of_get_address() because those APIs explicitly return physical memory
> addresses from the CPU perspective. It makes more sense to create a new
> API that doesn't attempt to translate the reg address. Alternately, a
> new API that only translates upto a given parent node.

The most important thing is that platform_get_resource{_by_name}(&pdev,
IORESOURCE_REG, n) returns the reg property and optional size encoded
into a struct resource. I think Rob is suggesting we circumvent the
entire of_address_to_resource() path and do some if
(IS_ENABLED(CONFIG_OF) && type == IORESOURCE_REG) check in
platform_get_resource() to package up the reg property into a struct
resource. That should work.

It sounds like you think partially translating addresses is risky
though. Fair enough. Perhaps we should call WARN() if someone tries to
call platform_get_resource() with IORESOURCE_REG and the parent node has
a ranges property that isn't a one-to-one conversion. That way if we
want to do something like this we can.

pmic at 0 {
    #address-cells = <1>;
    #size-cells = <0>;
    reg = <0>;

    regulators {
        ranges;
        #address-cells = <1>;
        #size-cells = <0>;

        regulator at 40 {
            reg = <0x40>;
        };

        regulator at 50 {
            reg = <0x50>;
        }
    };
};

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
