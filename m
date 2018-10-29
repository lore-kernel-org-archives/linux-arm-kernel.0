From: anshuman.khandual@arm.com (Anshuman Khandual)
Date: Mon, 29 Oct 2018 18:15:42 +0530
Subject: [PATCH] arm64/numa: Add more vetting in numa_set_distance()
In-Reply-To: <839acfc7-6b3a-b7ac-2f4a-713960ece457@huawei.com>
References: <1540562267-101152-1-git-send-email-john.garry@huawei.com>
 <20181029112504.GF14127@arm.com>
 <925009c6-226d-213f-dbcb-68b772d80a18@huawei.com>
 <20181029121638.GB15446@arm.com>
 <839acfc7-6b3a-b7ac-2f4a-713960ece457@huawei.com>
Message-ID: <17e3006a-7ecd-968e-7e67-ea7d08858ec3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/29/2018 06:02 PM, John Garry wrote:
> On 29/10/2018 12:16, Will Deacon wrote:
>> On Mon, Oct 29, 2018 at 12:14:09PM +0000, John Garry wrote:
>>> On 29/10/2018 11:25, Will Deacon wrote:
>>>> On Fri, Oct 26, 2018 at 09:57:47PM +0800, John Garry wrote:
>>>>> Currently it is acceptable to set the distance between 2 separate nodes to
>>>>> LOCAL_DISTANCE.
>>>>>
>>>>> Reject this as it is invalid.
>>>>>
>>>>> This change avoids a crash reported in [1].
>>>>>
>>>>> [1] https://www.spinics.net/lists/arm-kernel/msg683304.html
>>>>>
>>>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>>>>
>>>>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
>>>>> index 146c04c..6092e3d 100644
>>>>> --- a/arch/arm64/mm/numa.c
>>>>> +++ b/arch/arm64/mm/numa.c
>>>>> @@ -335,7 +335,8 @@ void __init numa_set_distance(int from, int to, int distance)
>>>>> ????}
>>>>>
>>>>> ????if ((u8)distance != distance ||
>>>>> -??????? (from == to && distance != LOCAL_DISTANCE)) {
>>>>> +??????? (from == to && distance != LOCAL_DISTANCE) ||
>>>>> +??????? (from != to && distance == LOCAL_DISTANCE)) {
>>>>
>>>> The current code here is more-or-less lifted from the x86 implementation
>>>> of numa_set_distance().
>>>
>>> Right, I did notice this. I didn't think that x86 folks would be so
>>> concerned since they generally only use ACPI, and the ACPI code already
>>> validates these distances in drivers/acpi/numa.c: slit_valid() [unlike OF
>>> code].
>>>
>>> ?I think we should either factor out the sanity check
>>>> into a core helper or make the core code robust to these funny configurations.
>>>
>>> OK, so to me it would make sense to factor out a sanity check into a core
>>> helper.
>>
>> That, or have the OF code perform the same validation that slit_valid() is
>> doing for ACPI. I'm just trying to avoid other architectures running into
>> this problem down the line.
>>
> 
> Right, OF code should do this validation job if ACPI is doing it (especially since the DT bindings actually specify the distance rules), and not rely on the arch NUMA code to accept/reject numa_set_distance() combinations.

I would say this particular condition checking still falls under arch NUMA init
code sanity check like other basic tests what numa_set_distance() currently does
already but it should not be a necessity for the OF driver to check these. It can
choose to check but arch NUMA should check basic things like two different NUMA
nodes should not have LOCAL_DISTANCE as distance like in this case.

	(from == to && distance != LOCAL_DISTANCE) ||
		(from != to && distance == LOCAL_DISTANCE))


> 
> And, in addition to this, I'd say OF should disable NUMA if given an invalid table (like ACPI does).

Taking a decision to disable NUMA should be with kernel (arch NUMA) once kernel
starts booting. Platform should have sent right values, OF driver trying to
adjust stuff what platform has sent with FDT once the kernel starts booting is
not right. For example "Kernel NUMA wont like the distance factors lets clean
then up before passing on to MM". Disabling NUMA is one such major decision which
should be with arch NUMA code not with OF driver.
