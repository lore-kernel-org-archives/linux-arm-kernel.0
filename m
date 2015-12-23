From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 23 Dec 2015 17:38:45 +0800
Subject: [PATCH V2 22/23] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1EC183BD@lhreml503-mbb>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
 <1450278993-12664-23-git-send-email-tn@semihalf.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1EC14C0F@lhreml503-mbb>
 <567923D2.2010202@semihalf.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1EC183BD@lhreml503-mbb>
Message-ID: <567A6BA5.1030408@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22/2015 10:48 PM, Gabriele Paoloni wrote:
> Hi Tomasz
>
>> -----Original Message-----
>> From: linux-kernel-owner at vger.kernel.org [mailto:linux-kernel-
>> owner at vger.kernel.org] On Behalf Of Tomasz Nowicki
>> Sent: 22 December 2015 10:20
>> To: Gabriele Paoloni; bhelgaas at google.com; arnd at arndb.de;
>> will.deacon at arm.com; catalin.marinas at arm.com; rjw at rjwysocki.net;
>> hanjun.guo at linaro.org; Lorenzo.Pieralisi at arm.com; okaya at codeaurora.org;
>> jiang.liu at linux.intel.com; Stefano.Stabellini at eu.citrix.com
>> Cc: robert.richter at caviumnetworks.com; mw at semihalf.com;
>> Liviu.Dudau at arm.com; ddaney at caviumnetworks.com; tglx at linutronix.de;
>> Wangyijing; Suravee.Suthikulpanit at amd.com; msalter at redhat.com; linux-
>> pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
>> acpi at vger.kernel.org; linux-kernel at vger.kernel.org; linaro-
>> acpi at lists.linaro.org; jchandra at broadcom.com; jcm at redhat.com
>> Subject: Re: [PATCH V2 22/23] pci, acpi: Match PCI config space
>> accessors against platfrom specific quirks.
>>
>> On 21.12.2015 12:47, Gabriele Paoloni wrote:
>>> 2) In the quirk mechanism you proposed, I see that the callback
>> function
>>>      allows to do some preparation work for the host bridge. For
>> example in
>>>      Hisilicon hip05 case we would need to read some values from the
>> ACPI
>>>      table (see acpi_pci_root_hisi_add() function in
>>>      https://lkml.org/lkml/2015/12/3/426).
>>>      I am quite new to ACPI and I wonder if it is OK to add such
>> "Packages"
>>>      to the  PCI host bridge ACPI device...or maybe we need to declare
>> a new
>>>      one...?
>>
>> I may miss sth so please correct me in that case.
>>
>> https://lkml.org/lkml/2015/12/3/426 shows that you need special
>> handling for root->secondary.start bus number only, right? So how about
>> creating special MCFG region <rc-base:rc-base+rc-size> only for
>> <segment,bus>.
>> Like that:
>>
>> [0008]                       Base Address : <rc-base>
>> [0002]               Segment Group Number : <segment>
>> [0001]                   Start Bus Number : <root->secondary.start>
>> [0001]                     End Bus Number : <root->secondary.start>
>> [0004]                           Reserved : 00000000
>>
>>
>> static const struct dmi_system_id hisi_quirk[] = {
>> 	{
>> 		.ident = "HiSi...",
>> 		.matches = {
>> 			DMI_MATCH(<whatever you need to match your platform>),
>> 		},
>> 	},
>> 	{ }
>> };
>>
>> static struct pci_ops hisi_ecam_pci_ops = {
>> 	.map_bus = pci_mcfg_dev_base,
>> 	.read = hisi_pcie_cfg_read,
>> 	.write = hisi_pcie_cfg_write,
>> };
>>
>> DECLARE_ACPI_MCFG_FIXUP(hisi_quirk, &hisi_ecam_pci_ops,
>> 			<segment>, <bus>);
>>
>> With above code you can use your custom PCI config accessor only for
>> that region.
>>
>> Let me know if that is not enough for you.
>
> In principle I think it can work...
>
> Liudongdong, Guo Hanjun what is your opinion about?

Let me and Dongdong prepare a patch for Hip05 and then will
back to this discussion to see if we met some problems.

Thanks
Hanjun
