From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Mon, 3 Jul 2017 13:25:25 -0500
Subject: [PATCH] irqchip: gicv3-its: Use NUMA aware memory allocation for
 ITS tables
In-Reply-To: <CAFpQJXWQiePwNDV9rxjKALPf_XXMbhQcZM1RwJLkDXTyJxjjiA@mail.gmail.com>
References: <1498405569-463-1-git-send-email-shankerd@codeaurora.org>
 <CAFpQJXU84OTEp-1BteQeSqNy3Ya2hDskZA=Th_0f47qtS9-ucw@mail.gmail.com>
 <CAFpQJXVh0ojzwqZmT5OgBArx9rpK0_yDw_+gyP8LAkT1e4HWrQ@mail.gmail.com>
 <88a2a78f-6a5b-1b80-5dcf-0821b9fd81d9@codeaurora.org>
 <CAFpQJXWQiePwNDV9rxjKALPf_XXMbhQcZM1RwJLkDXTyJxjjiA@mail.gmail.com>
Message-ID: <90f6d20d-b996-308e-b612-4352d9eceabb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ganapatrao,

On 07/03/2017 11:51 AM, Ganapatrao Kulkarni wrote:
> On Mon, Jul 3, 2017 at 7:07 PM, Shanker Donthineni
> <shankerd@codeaurora.org> wrote:
>> Hi Ganapatraoo,
>>
>> On 06/29/2017 10:01 PM, Ganapatrao Kulkarni wrote:
>>> On Fri, Jun 30, 2017 at 8:04 AM, Ganapatrao Kulkarni
>>> <gpkulkarni@gmail.com> wrote:
>>>> Hi Shanker,
>>>>
>>>> On Sun, Jun 25, 2017 at 9:16 PM, Shanker Donthineni
>>>> <shankerd@codeaurora.org> wrote:
>>>>> The NUMA node information is visible to ITS driver but not being used
>>>>> other than handling errata. This patch allocates the memory for ITS
>>>>> tables from the corresponding NUMA node using the appropriate NUMA
>>>>> aware functions.
>>>
>>> IMHO, the description would have been more constructive?
>>>
>>> "All ITS tables are mapped by default to NODE 0 memory.
>>> Adding changes to allocate memory from respective NUMA NODES of ITS devices.
>>> This will optimize tables access and avoids unnecessary inter-node traffic."
>>>
>>
>> I don't understand why you are saying 'All ITS tables are mapped by default to NODE 0 memory'? Kernel runtime memory allocation comes from the corresponding NUMA node of the CPU that being called.
> 
> IIRC, ITT tables can be on any cpu, if drivers are not built-in and
> msi-x vectors are not initialised in init/probe, etc
> however Device table and Collection table are allocated from node 0
> memory during ITS driver init by boot-cpu/cpu0.
> 

Don't confuse boot-cpu aka logical cpu0 and NUMA node 0, these is no requirement that 
says boot cpu has to tied to NUMA node 0. The memory for first level device table, 
prop and collection tables are allocated from the boot cpu's NUMA node not NUMA node 0.

All other memory allocation inside the ITS driver can be done from any NUMA node depends 
on which CPU calls the memory allocation functions during runtime. 

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
