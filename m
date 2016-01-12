From: laura@labbott.name (Laura Abbott)
Date: Mon, 11 Jan 2016 16:26:28 -0800
Subject: [RESEND][PATCHv2 1/3] ion: Devicetree bindings for Ion
In-Reply-To: <CAL_JsqLBk1TAa2bKnA6TpEfrXxVZ7JYojOgmszEKoWC0+Huuug@mail.gmail.com>
References: <1452548364-9522-1-git-send-email-laura@labbott.name>
 <1452548364-9522-2-git-send-email-laura@labbott.name>
 <CAL_JsqLBk1TAa2bKnA6TpEfrXxVZ7JYojOgmszEKoWC0+Huuug@mail.gmail.com>
Message-ID: <56944834.4040108@labbott.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/11/16 3:28 PM, Rob Herring wrote:
> On Mon, Jan 11, 2016 at 3:39 PM, Laura Abbott <laura@labbott.name> wrote:
>>
>> This adds a base set of devicetree bindings for the Ion memory
>> manager. This supports setting up the generic set of heaps and
>> their properties.
>>
>> Signed-off-by: Laura Abbott <laura@labbott.name>
>> ---
>>   drivers/staging/android/ion/devicetree.txt | 50 ++++++++++++++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>>   create mode 100644 drivers/staging/android/ion/devicetree.txt
>>
>> diff --git a/drivers/staging/android/ion/devicetree.txt b/drivers/staging/android/ion/devicetree.txt
>> new file mode 100644
>> index 0000000..e1ea537
>> --- /dev/null
>> +++ b/drivers/staging/android/ion/devicetree.txt
>> @@ -0,0 +1,50 @@
>> +Ion Memory Manager
>> +
>> +Ion is a memory manager that allows for sharing of buffers via dma-buf.
>> +Ion allows for different types of allocation via an abstraction called
>> +a 'heap'. A heap represents a specific type of memory. Each heap has
>> +a different type. There can be multiple instances of the same heap
>> +type.
>> +
>> +Required properties for Ion
>> +
>> +- compatible: "linux,ion" PLUS a compatible property for the device
>> +
>> +All child nodes of a linux,ion node are interpreted as heaps
>> +
>> +required properties for heaps
>> +
>> +- compatible: compatible string for a heap type PLUS a compatible property
>> +for the specific instance of the heap. Current heap types
>> +-- linux,ion-heap-system
>> +-- linux,ion-heap-system-contig
>> +-- linux,ion-heap-carveout
>> +-- linux,ion-heap-chunk
>> +-- linux,ion-heap-dma
>> +-- linux,ion-heap-custom
>> +
>> +Optional properties
>> +- memory-region: A phandle to a memory region. Required for DMA heap type
>> +(see reserved-memory.txt for details on the reservation)
>
> Why would all of them not require a memory region other than system heap?
>
>> +
>> +Example:
>> +
>> +       ion {
>> +               compatbile = "qcom,msm8916-ion", "linux,ion";
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +
>> +               ion-system-heap {
>> +                       compatbile = "qcom,system-heap", "linux,ion-heap-system"
>> +               };
>
> What is the purpose of this in DT? Don't we always want/need a system
> heap? How does it vary by platform?
>
>> +               ion-camera-region {
>> +                       compatible = "qcom,camera-heap", "linux,ion-heap-dma"
>> +                       memory-region = <&camera_region>;
>
> Why not just add a property (or properties) to the camera_region node
> that ION drivers can search for?
>
> Rob
>

Thinking about all of this put together with the general comments, would the
following be more acceptable:

- Keep the approach of this patch series with having the heaps specified
in an array in a file
- For each array of heaps, have a list of machine compatible strings that
work with the heaps.
- Call of_machine_is_compatible on all the heaps until one is found
- When setting up the heaps, check for a property like Rob suggested
to get the appropriate memory node
- Add appropriate documentation in the devicetree directory explaining
the entire approach

The only Ion data in the DT with this approach would be the property in the
appropriate memory node. There is no ABI except the memory property so as
Ion changes there would be no breakage. This approach does go a little
bit out outside of the traditional way devicetree works. A more
traditional approach would be to just have an ion node with a compatible
string and then just find the memory node via a property (although this
does taint the DT more with Ion even if the ABI may be relatively stable)

Thanks,
Laura
