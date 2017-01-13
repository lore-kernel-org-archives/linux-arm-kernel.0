From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 13 Jan 2017 09:22:15 +0000
Subject: [RFC 07/13] KVM: arm64: ITS: Change entry_size and indirect bit
 in BASER
In-Reply-To: <89752a29-d533-1f4c-9e9b-93e8bd0556b3@redhat.com>
References: <1484236613-24633-1-git-send-email-eric.auger@redhat.com>
 <1484236613-24633-8-git-send-email-eric.auger@redhat.com>
 <dc26dc19-313b-375b-0d9b-f4ff411a914f@arm.com>
 <89752a29-d533-1f4c-9e9b-93e8bd0556b3@redhat.com>
Message-ID: <7538fddf-919f-5428-a665-485ea1be6e9a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/01/17 08:57, Auger Eric wrote:
> Hi Marc,
> 
> On 12/01/2017 18:05, Marc Zyngier wrote:
>> On 12/01/17 15:56, Eric Auger wrote:
>>> Change the device table entry_size to 16 bytes instead of 8.
>>> We also Store the device and collection device in the its
>>> struct.
>>>
>>> The patch also clears the indirect bit for the device BASER.
>>> The indirect bit is set as read-only.
>>
>> Err... Why? We *really* want to continue supporting indirect tables, as
>> this is a massive memory saver for the guest.
>>
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>
>>> ---
>>>
>>> TODO: investigate support of 2 level tables, ie. enabling
>>> Indirect = 1. Support of 2 level tables is implementation
>>> defined.
>>
>> Clearly, that's a regression. What exactly is the issue that decided you
>> to disable it?
> Well no valuable reason besides I saw it was optional, lack of
> time/knowledge and a bit of laziness. I will address this requirement in
> my next respin.

Ah, I was worried about something much more fundamental! ;-)

> For my curiosity why did we choose not allowing the feature for
> collections. Is that just because we think their number if going
> sufficiently small compared to devices?

Collections are usually a much smaller number (directly related to the
number of CPUs in the system), and can be kept very compact. Devices, on
the other hand, can be extremely sparse (to the point where a guest can
fail to allocate enough memory to cover the required range).

TBH, we could allow it for collections as well. It is just not that useful.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
