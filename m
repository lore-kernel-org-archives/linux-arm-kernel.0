From: tnowicki@caviumnetworks.com (Tomasz Nowicki)
Date: Thu, 19 Jan 2017 12:08:41 +0100
Subject: [PATCH v3] IOMMU: SMMUv2: Support for Extended Stream ID (16 bit)
In-Reply-To: <67d2c502-43c4-8479-6abf-481a334f8047@linaro.org>
References: <20170117151431.17085-1-aleksey.makarov@linaro.org>
 <bc9eb7ab-5cc7-411b-60f3-b8c369753f9b@caviumnetworks.com>
 <67d2c502-43c4-8479-6abf-481a334f8047@linaro.org>
Message-ID: <a4fcdce8-5518-ada6-2746-9e41c83003ff@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.01.2017 11:57, Aleksey Makarov wrote:
> Hi Tomasz,
>
> On 01/19/2017 11:55 AM, Tomasz Nowicki wrote:
>> Hi Aleksey,
>>
>> On 17.01.2017 16:14, Aleksey Makarov wrote:
>>> Enable the Extended Stream ID feature when available.
>>>
>>> This patch on top of series "KVM PCIe/MSI passthrough on ARM/ARM64
>>> and IOVA reserved regions" by Eric Auger [1] allows to passthrough
>>> an external PCIe network card on a ThunderX server successfully.
>>>
>>> Without this patch that card caused a warning like
>>>
>>>     pci 0006:90:00.0: stream ID 0x9000 out of range for SMMU (0x7fff)
>>>
>>> during boot.
>>>
>>> [1] https://lkml.kernel.org/r/1484127714-3263-1-git-send-email-eric.auger at redhat.com
>>>
>>> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
>>
>> I do not thing this is related to PCIe network card. It is rather common to all devices which bus number > 127
>>
>> ----
>>
>> iommu/arm-smmu: Support for Extended Stream ID (16 bit)
>>
>> It is the time we have the real 16-bit Stream ID user, which is the ThunderX. Its IO topology uses 1:1 map for requester to stream ID translation:
>>
>> RC no. | Requester ID | Stream ID
>>        |              |
>> RC_0   | 0-FFFF --->  | 0-FFFF
>>
>> which allows to get full 16-bit stream ID. Currently all devices with bus number >= 128 (0x80) get non-zero 16th bit of BDF and stream ID (due to 1:1 map). Eventually SMMU drops such device because the stream ID is out of range. This is the case for all devices connected as external endpoints on ThunderX.
>
> Technically the last sentence it is not correct as far as I can see.  There exists a device connected to PEM (external entpoint?) with BDF (== Stream ID) <= 0x7fff:
>
> 	0004:21:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED Graphics Family (rev 30)

Right. You?ve got a point.

>
>>
>> ----
>
> Thank you for review.  May I change the commit message this way and keep your 'Reviewed-by'?:

Yes, the commit message is accurate now. Add my R-b please.

>
> ---
> iommu/arm-smmu: Support for Extended Stream ID (16 bit)
>
> It is the time we have the real 16-bit Stream ID user, which is the
> ThunderX. Its IO topology uses 1:1 map for requester ID to stream ID
> translation for each root complex which allows to get full 16-bit
> stream ID.  Firmware assigns bus IDs that are greater than 128 (0x80)
> to some buses under PEM (external PCIe interface).  Eventually SMMU
> drops devices on that buses because their stream ID is out of range:
>
>   pci 0006:90:00.0: stream ID 0x9000 out of range for SMMU (0x7fff)
>
> To fix above issue enable the Extended Stream ID optional feature when available.
> ---
>

Thanks,
Tomasz
