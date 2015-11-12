From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 12 Nov 2015 21:42:07 +0000
Subject: [PATCH v2] Documentation: dt: Add bindings for Secure-only devices
In-Reply-To: <20151112213343.GA28588@rob-hp-laptop>
References: <1447345490-29671-1-git-send-email-peter.maydell@linaro.org>
 <20151112213343.GA28588@rob-hp-laptop>
Message-ID: <CAFEAcA-JU=W2bHh4kUxuYFhehGi=WaE-tkoA82jRxen5t0a1EQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 November 2015 at 21:33, Rob Herring <robh@kernel.org> wrote:
> On Thu, Nov 12, 2015 at 04:24:50PM +0000, Peter Maydell wrote:
>> The existing device tree bindings assume that we are only trying to
>> describe a single address space with a device tree (for ARM, either
>> the Normal or the Secure world). Some uses for device tree need to
>> describe both Normal and Secure worlds in a single device tree. Add
>> documentation of how to do this, by adding extra properties which
>> describe when a device appears differently in the two worlds or when
>> it only appears in one of them.
>>
>> The binding describes the general principles for adding new
>> properties describing the secure world, but for now we only need a
>> single new property, "secure-status", which can be used to annotate
>> devices to indicate that they are only visible in one of the two
>> worlds.
>>
>> The primary expected use of this binding is for a virtual machine
>> like QEMU to describe the VM layout to a TrustZone aware firmware
>> (which would then use the secure-only devices itself, and pass the DT
>> on to a kernel running in the non-secure world, which ignores the
>> secure-only devices and uses the rest).
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> I'd specifically like Mark's ack on this one.
>
>> ---
>> This binding doesn't affect the kernel itself, but the kernel
>> Documentation/ tree is the de-facto current place where all DT
>> bindings are documented, so Grant suggested this was the right
>> place to send a doc patch.
>>
>> Changes v1->v2:
>>  * list all the status/secure-status combinations explicitly
>>  * use /* */ comment syntax, not //
>>
>>  Documentation/devicetree/bindings/arm/secure.txt | 51 ++++++++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/secure.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/secure.txt b/Documentation/devicetree/bindings/arm/secure.txt
>> new file mode 100644
>> index 0000000..7ed5ed6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/secure.txt
>> @@ -0,0 +1,51 @@
>> +* ARM Secure world bindings
>> +
>> +ARM CPUs with TrustZone support have two distinct address spaces,
>> +"Normal" and "Secure". Most devicetree consumers (including the Linux
>> +kernel) are not TrustZone aware and run entirely in either the Normal
>> +world or the Secure world. However some devicetree consumers are
>> +TrustZone aware and need to be able to determine whether devices are
>> +visible only in the Secure address space, only in the Normal address
>> +space, or visible in both. (One example of that situation would be a
>> +virtual machine which boots Secure firmware and wants to tell the
>> +firmware about the layout of the machine via devicetree.)
>> +
>> +The general principle of the naming scheme for Secure world bindings
>> +is that any property that needs a different value in the Secure world
>> +can be supported by prefixing the property name with "secure-". So for
>> +instance "secure-reg" would override "reg". If there is no "secure-"
>
> I'd prefer this be "secure-foo" and "foo", rather than reg given I
> specifically have a differing opinion on how to support reg.
>
> Also, would it be secure-vendor,foo or vendor,secure-foo for properties
> with vendor prefix? The latter looks more correct to me, but the former
> would be easier to search for both variants of the property. I'd lean
> towards the latter.

OK, so how about making that para read:

+ The general principle of the naming scheme for Secure world bindings
+ is that any property that needs a different value in the Secure world
+ can be supported by prefixing the property name with "secure-". So for
+ instance "secure-foo" would override "foo". For property names with
+ a vendor prefix, the Secure variant of "vendor,foo" would be
+ "vendor,secure-foo". If there is no "secure-" property then the Secure
+ world value is the same as specified for the Normal world by the
+ non-prefixed property. However, only the properties listed below may
+ validly have "secure-" versions; this list will be enlarged on a
+ case-by-case basis.

thanks
-- PMM
