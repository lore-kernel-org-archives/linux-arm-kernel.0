From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 02 Nov 2011 15:31:06 +0100
Subject: [PATCH v2] gpio/samsung: Add device tree support for Exynos4
In-Reply-To: <CAJuYYwSfjg04gaJUgNkUzFNgs5d_7PL9nio-1RwrPizyShTxGQ@mail.gmail.com>
References: <1320108227-2693-1-git-send-email-thomas.abraham@linaro.org>
	<4EAFAC42.5080607@gmail.com>
	<CAJuYYwSfjg04gaJUgNkUzFNgs5d_7PL9nio-1RwrPizyShTxGQ@mail.gmail.com>
Message-ID: <4EB1542A.4030609@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/2011 02:05 PM, Thomas Abraham wrote:
> On 1 November 2011 13:52, Sylwester Nawrocki <snjw23@gmail.com> wrote:
>> On 11/01/2011 01:43 AM, Thomas Abraham wrote:
>>> As gpio chips get registered, a device tree node which represents the
>>> gpio chip is searched and attached to it. A translate function is also
>>> provided to convert the gpio specifier into actual platform settings
>>> for pin function selection, pull up/down and driver strength settings.
>>>
>>> Signed-off-by: Thomas Abraham<thomas.abraham@linaro.org>
>>> Acked-by: Grant Likely<grant.likely@secretlab.ca>
>>> ---
>>> Changes since v1:
>>> - As suggested by Rob and Grant, the gpio controller node lookup is based
>>>    on the base address of the gpio controller instead of the unique
>>>    per-controller compatible property value.
>>>
>>> This patch is based on the following tree and branch.
>>> git://git.linaro.org/git/people/arnd/arm-soc.git  branch: for-next
>>>
>>>   .../devicetree/bindings/gpio/gpio-samsung.txt      |   40 ++++++++++++
>>>   drivers/gpio/gpio-samsung.c                        |   66 ++++++++++++++++++++
>>>   2 files changed, 106 insertions(+), 0 deletions(-)
>>>   create mode 100644 Documentation/devicetree/bindings/gpio/gpio-samsung.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-samsung.txt b/Documentation/devicetree/bindings/gpio/gpio-samsung.txt
>>> new file mode 100644
>>> index 0000000..c143058
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/gpio/gpio-samsung.txt
>>> @@ -0,0 +1,40 @@
>>> +Samsung Exynos4 GPIO Controller
>>> +
>>> +Required properties:
>>> +- compatible: Compatible property value should be "samsung,exynos4-gpio>".
>>> +
>>> +- reg: Physical base address of the controller and length of memory mapped
>>> +  region.
>>> +
>>> +- #gpio-cells: Should be 4. The syntax of the gpio specifier used by client nodes
>>> +  should be the following with values derived from the SoC user manual.
>>> +<[phandle of the gpio controller node]
>>> +      [pin number within the gpio controller]
>>> +      [mux function]
>>> +      [pull up/down]
>>> +      [drive strength]>
>>> +
>>> +  Values for gpio specifier:
>>> +  - Pin number: is a value between 0 to 7.
>>> +  - Pull Up/Down: 0 - Pull Up/Down Disabled.
>>> +                  1 - Pull Down Enabled.
>>> +                  3 - Pull Up Enabled.
>>> +  - Drive Strength: 0 - 1x,
>>> +                    1 - 3x,
>>> +                    2 - 2x,
>>> +                    3 - 4x
>>
>> I wonder whether it's worth to have more regular mapping, i.e.
>> *)      0 - 1x,
>>        1 - 2x,
>>        2 - 3x,
>>        3 - 4x
>>
>> It doesn't give as much advantage, and introduces an overhead of doing
>> an additional remapping. However I find current mapping of the DT specifier
>> values to real driver strength slightly confusing.
>> Perhaps unlikely, the future SoCs could have different meaning of the
>> register values.
> 
> The dts file describes the hardware and the drive strength values
> listed above are as per the Exynos4 SoC user manual. I would prefer to
> do it the way you suggested, but that would mean dts is not exactly
> matching the hardware manual.

Sorry, I somehow missed these bindings are for Exynos4 only.

Anyway, there is rather little chance to have uniform drive strength
representation across all Samsung SoC. It's sometimes expressed in mA,
sometimes has no units. Perhaps it's best to stick with HW reg. values,
however it is some times confusing as hell...


For instance, for exynos4 we have:

driver strength | 1x   | 2x   | 3x   | 4x
---------------------------------------------
register value  | 0x00 | 0x2  | 0x01 | 0x03


for s3c6410:

driver strength | 2mA  | 4mA  | 7 mA | 9 mA
---------------------------------------------
register value  | 0x00 | 0x2  | 0x01 | 0x03


Nevertheless, I think, for exynos4 the effort to have actual drive strength
directly expressed in DT description, rather than using not entirely sane
HW values, is rather small.
And it could save a bit of frustration for all these poor engineers trying
to use the API..

...

> 
> Can I postpone these changes for now so that this patch gets merged in
> next-samsung-dt branch. I believe these are required changes but could
> be done a little later.

Sure, that's understood. It's fine for me to get those things fixed any time
for 3.2 stable release.

--
Regards,
Sylwester
