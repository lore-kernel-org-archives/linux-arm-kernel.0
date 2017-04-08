From: gnurou@gmail.com (Alexandre Courbot)
Date: Sat, 8 Apr 2017 19:20:08 +0900
Subject: [PATCH v2] dt-bindings: Add documentation for GP10B GPU
In-Reply-To: <20170331125607.GA29779@ulmo.ba.sec>
References: <20170330091831.18322-2-acourbot@nvidia.com>
 <20170330092644.11890-1-acourbot@nvidia.com>
 <20170331125607.GA29779@ulmo.ba.sec>
Message-ID: <CAAVeFuJN3BQfuvA2dVP=6US1cMW9jfdfswAwNCKUg6w4Md3Xqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 31, 2017 at 9:56 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Thu, Mar 30, 2017 at 06:26:44PM +0900, Alexandre Courbot wrote:
>> GP10B's definition is mostly similar to GK20A's and GM20B's. The only
>> noticeable difference is the use of power domains instead of a regulator
>> for power supply.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>> Changes since v1:
>> - It's much better when it compiles.
>>
>>  .../devicetree/bindings/gpu/nvidia,gk20a.txt       | 25 +++++++++++++++++++++-
>>  1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt b/Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt
>> index ff3db65e50de..b7e4c7444510 100644
>> --- a/Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt
>> +++ b/Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt
>> @@ -5,6 +5,7 @@ Required properties:
>>    Currently recognized values:
>>    - nvidia,gk20a
>>    - nvidia,gm20b
>> +  - nvidia,gp10b
>>  - reg: Physical base address and length of the controller's registers.
>>    Must contain two entries:
>>    - first entry for bar0
>> @@ -14,7 +15,8 @@ Required properties:
>>  - interrupt-names: Must include the following entries:
>>    - stall
>>    - nonstall
>> -- vdd-supply: regulator for supply voltage.
>> +- vdd-supply: regulator for supply voltage. Only required for GPUs not using
>> +  power domains.
>>  - clocks: Must contain an entry for each entry in clock-names.
>>    See ../clocks/clock-bindings.txt for details.
>>  - clock-names: Must include the following entries:
>> @@ -27,6 +29,8 @@ is also required:
>>    See ../reset/reset.txt for details.
>>  - reset-names: Must include the following entries:
>>    - gpu
>> +- power-domains: GPUs that make use of power domains can define this property
>> +  instead of vdd-supply. Currently "nvidia,gp10b" makes use of this.
>>
>>  Optional properties:
>>  - iommus: A reference to the IOMMU. See ../iommu/iommu.txt for details.
>> @@ -68,3 +72,22 @@ Example for GM20B:
>>               iommus = <&mc TEGRA_SWGROUP_GPU>;
>>               status = "disabled";
>>       };
>> +
>> +Example for GP10B:
>> +
>> +     gpu at 17000000 {
>> +             compatible = "nvidia,gp10b";
>> +             reg = <0x0 0x17000000 0x0 0x1000000>,
>> +                   <0x0 0x18000000 0x0 0x1000000>;
>
> Would it make sense to add a reg-names property to give these meaning? I
> know that the binding describes what each entry is, but having the names
> specified in a property would make it more immediately obvious.

Would certainly work, especially since we have been doing this for
other properties. Is there an obvious pro to doing this though?
