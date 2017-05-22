From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 22 May 2017 10:06:04 +0100
Subject: [PATCH 3/3][v4] staging: fsl-mc: move bus driver out of staging
In-Reply-To: <VI1PR0401MB1856FCA799A6C18CB85207EEECF80@VI1PR0401MB1856.eurprd04.prod.outlook.com>
References: <20170519131305.5068-1-laurentiu.tudor@nxp.com>
 <20170519131305.5068-4-laurentiu.tudor@nxp.com>
 <b3980350-9663-d98b-6533-fd3c15f98671@gmail.com> <86tw4g6nb0.fsf@arm.com>
 <VI1PR0401MB1856C0396AE7608FF2FC8CF1ECF80@VI1PR0401MB1856.eurprd04.prod.outlook.com>
 <878tlpmj9l.fsf@arm.com>
 <VI1PR0401MB1856FCA799A6C18CB85207EEECF80@VI1PR0401MB1856.eurprd04.prod.outlook.com>
Message-ID: <4420f96d-19e0-3bfc-cda2-e263f30ad94a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/05/17 09:42, Laurentiu Tudor wrote:
> Hi Marc,
> 
>> -----Original Message-----
>> From: Marc Zyngier [mailto:marc.zyngier at arm.com]
>> Sent: Monday, May 22, 2017 10:41 AM
>>
>> On Mon, May 22 2017 at  7:12:39 am GMT, Laurentiu Tudor
>> <laurentiu.tudor@nxp.com> wrote:
>>
>> Hi Laurentiu,
>>
>>> Hi Marc,
>>>
>>>> -----Original Message-----
>>>> From: Marc Zyngier [mailto:marc.zyngier at arm.com]
>>>> Sent: Saturday, May 20, 2017 9:43 AM
>>>> To: Matthias Brugger <matthias.bgg@gmail.com>
>>>>
>>>> On Fri, May 19 2017 at 02:41:43 PM, Matthias Brugger
>>>> <matthias.bgg@gmail.com> wrote:
>>>>> On 19/05/17 15:13, laurentiu.tudor at nxp.com wrote:
>>>>>> From: Stuart Yoder <stuart.yoder@nxp.com>
>>>>>>
>>>>>> Move the source files out of staging into their final locations:
>>>>>>    -include files in drivers/staging/fsl-mc/include go to include/linux/fsl
>>>>>>    -irq-gic-v3-its-fsl-mc-msi.c goes to drivers/irqchip
>>>>>
>>>>> This driver has as compatible "arm,gic-v3-its". I wonder if this is
>>>>> correct and if it should be moved like this out of staging.
>>>>
>>>> This is no different from the way we handle *any* bus that uses the
>>>> GICv3 ITS as an MSI controller. Each bus provides its glue code that
>>>> latches onto the ITS node, and calls into the generic code.
>>>>
>>>> Now, when it comes to moving this out of staging, here is my concern:
>>>> There is mention of a userspace tool (restool) used to control the
>>>> HW. Where is this tool? Where is the user ABI documented?
>>>
>>> The tool is published here:
>>>
>>> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit
>>> hub.com%2Fqoriq-open-
>> source%2Frestool&data=01%7C01%7Claurentiu.tudor%4
>>>
>> 0nxp.com%7Cd3c05908969d499cd4a008d4a0e5eaae%7C686ea1d3bc2b4c6fa92
>> cd99c
>>>
>> 5c301635%7C0&sdata=2sEXCZ%2BAFlTtle8N3yWJPsGRve8cXMRPzyumlwqOhbg
>> %3D&re
>>> served=0
>>>
>>> There are two ways of configuring the mc-bus:
>>>  - a static one, through a FDT based configuration file (we call it
>>> DPL), documented in the refman linked below, chapter 22.
>>>  - a dynamic one, using this restool utility.
>>> Please note the usage of restool is optional.
>>
>> Optional or not, it still is a userspace ABI, and while I can see restool issuing ioctl
>> system calls to configure the HW, I cannot see the corresponding code in the
>> kernel tree. So how does it work?
>> If the syscall interface is not present in the mainline kernel, drop the reference
>> to it in the documentation. If it is there (and I obviously missed it), document it,
>> and get it reviewed. 
> 
> Our original plan was to first get the bus out of staging and after that submit the restool support ASAP (patches are done - so I'm thinking at few days timeframe).
> if this is not acceptable, I can drop the restool reference from the README and resubmit the patch series. We'll re-add the reference together with the restool support patches.

I think it would make a lot more sense to drop anything that is not
implemented by the current code. Once you have patches that implement
this userspace interface, they can be reviewed together with the
corresponding documentation.

>> If there are associated DT bindings to the kernel code, they
>> must be documented (and reviewed) as part of the device-tree documentation,
>> and not in some obscure, hard to access document.
> 
> There's only one binding involved and it's already accepted [1].

Ah, I missed it. It would be good to mention it in the documentation as
well.

> [snip]
> 
>>>
>>> We're also working on publishing the docs on github so that they're
>>> more accessible.
>>
>> That'd be great, because the way the registration process is presented, I'd have
>> to agree to the Access Agreement *before* having a chance to read it. Not
>> going to happen...
> 
> Sorry about that. Not much I can do. :-( 

I understand this is not your job ;-). But maybe making people inside
NXP aware of the issue would help... Oh well.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
