From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Wed, 15 Feb 2017 09:53:40 +0100
Subject: [PATCH v3 01/18] dt-bindings: power: battery: add
 constant-charge-current property
In-Reply-To: <20170215004646.23607-1-liam@networkimprov.net>
References: <20170215004646.23607-1-liam@networkimprov.net>
Message-ID: <6a678b03-124a-76b3-066e-858731fc6c80@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 15/02/2017 01:46, Liam Breck wrote:
> 
> On Tue, 14 Feb 2017 10:40:55 +0100 Quentin Schulz wrote:
>> This adds the constant-charge-current property to the list of optional
>> properties of the battery.
>>
>> The constant charge current is critical for batteries as they can't
>> handle all charge currents.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> ---
>>
>> added in v3
>>
>>  Documentation/devicetree/bindings/power/supply/battery.txt | 2 ++
> 
> Is constant-charge-current dependent on the battery (e.g. capacity, nominal voltage, etc) or the 
> system (charger chip, input current/voltage, etc)?
> 
> It belongs in Doc.../power/supply/battery.txt if it's a characteristic of the battery.
> 
> Note, this page asserts that constant-current charging applies to NiMH batteries:
> http://power-topics.blogspot.com/2016/05/constant-voltage-constant-current.html
> 
> Related properties to be added to battery.txt near-future in a patchset for the BQ24190 
> charger are as follows. These are not currently in enum power_supply_property, so the actual names 
> are still to be decided.
> 
> precharge-current-microamp:
>    maximum charge current during precharge phase (typically 20% of battery capacity)
> 
> termination-current-microamp (or endcharge-current):
>    a charge cycle terminates when the battery voltage is above recharge threshold,
>    and the current is below this setting (typically 10% of battery capacity)
> 

We have a client with a board whose battery accepts a maximum of 300mA
for charging. So depending on the battery, we cannot have any charging
current we want. The AXP PmMICs set constant charge current in a range
of 300mA-1800mA, so it is enforced by the charger but needs to be
adapted depending on the battery present in the system.

The AXP PMICs charge battery with constant current (Ichrg) between the
trickle voltage (Vtrkl which is ~3.0V) and the targeted voltage (Vtrgt;
which seems to be the voltage telling the battery is fully charged).

So if I understand correctly, "my" constant-charge-current would be
located in the charging cycle between your precharge-current-microamp
and the termination-current-microamp as it is the current for the
charging process as a whole.

See here[1] for the explanation in the datasheet (page 20).

That would definitely match what is explained in your link for constant
current.

[1] http://dl.linux-sunxi.org/AXP/AXP209_Datasheet_v1.0en.pdf

Let me know if something seems odd,
Thanks,
Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
