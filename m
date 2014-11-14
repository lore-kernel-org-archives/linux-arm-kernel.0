From: B31939@freescale.com (Lian Minghuan-B31939)
Date: Fri, 14 Nov 2014 17:36:19 +0800
Subject: [PATCH v2] PCI: designware: Add support 4 ATUs assignment
In-Reply-To: <CA+mB=1KObT9O783SMcvHy8nJGQPnxyKgP332r5bHx-K_D+LhVg@mail.gmail.com>
References: <1415682444-24911-1-git-send-email-Minghuan.Lian@freescale.com>
 <CA+mB=1+4Dzxhbin6z0PUENvjUz-y8bq-K09FXTnSepFvVfe9HQ@mail.gmail.com>
 <546308DD.40109@freescale.com>
 <CA+mB=1K=Oyzdb2yfBvPRG9DHi-PFjRPtVS_dY9JMOz6dQog8QQ@mail.gmail.com>
 <546331E7.5060003@freescale.com>
 <CA+mB=1KObT9O783SMcvHy8nJGQPnxyKgP332r5bHx-K_D+LhVg@mail.gmail.com>
Message-ID: <5465CD13.9010608@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2014?11?13? 00:23, Srikanth Thokala wrote:
> Hi Minghuan,
>
> On Wed, Nov 12, 2014 at 3:39 PM, Lian Minghuan-B31939
> <B31939@freescale.com> wrote:
> [...]
>            return ret;
> @@ -770,6 +793,10 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>            u32 membase;
>            u32 memlimit;
>
> +       /* set ATUs setting for MEM and IO */
> +       dw_pcie_prog_viewport_mem_outbound(pp);
> +       dw_pcie_prog_viewport_io_outbound(pp);
> +
>>>>> I see from the code, these settings are required for the calls other
>>>>> than
>>>>> dw_pcie_(rd/wr)_other_conf, is it correct? If it is so, I feel this
>>>>> change
>>>>> is
>>>>> independent of this patch and should go as a separte patch?
>>>> [Minghuan] dw_pcie(rd/wr)_other_confg only calls the
>>>> dw_pcie_prog_viewport_mem/io_outbound when
>>>> we only use 2 ATUs.
>>>> The patch is to support 4ATUs. If no the calls, ATU2(MEM) and ATU3 will
>>>> not be initialized, and PCIe device driver will be broken.
>>> When you have only 2 ATUs (CFG0=MEM & CFG1=IO), you are calling
>>> mem/io_outbound() twice with the same writes which is not the case in the
>>> original driver. So, I mentioned it should go as a separate patch.
>> [Minghuan] Sorry, I do not understand what you mean.
>> How to separate patch?
>> A patch is to add the following code based on original code
>>
>> +       /* set ATUs setting for MEM and IO */
>> +       dw_pcie_prog_viewport_mem_outbound(pp);
>> +       dw_pcie_prog_viewport_io_outbound(pp);
>> +
>>
>> But why add this patch? 2 ATUs does not need them.
>>
>> Only 4 ATUs support needs them.
> Then you may have to add a condition here, num_atus >= 4?
>
>> And them are also ok for 2 ATUs.
> You are just re-writing them anyway, so I don't see a place for them here.
>
> So, this fragment should just work,
>
> +++
> if (num_atus >=4 ) {
>    dw_pcie_prog_viewport_mem_outbound(pp);
>    dw_pcie_prog_viewport_io_outbound(pp);
> }
> +++
>
> Is that correct? Am I still missing?
[Minghuan]  For 2 ATUs, ATU0 is for MEM as default, ATU1 for IO.
When to access CFG0/CFG1, ATU will temporarily to be changed to
CFG0/CFG1, then will be changed back to MEM/IO.
So the mem/io initialization I added will not bring any harm for 2 ATUs.
Why do we need the judgement 'num_atus >=4'.
>> For 2 ATUs, mem/io will be initialized every time read/write PCI device
>> configuration.
> Just out of curiosity, is it really required to initialize mem/io everytime
> there is a config read/write? Would it not work when initialized just once like
> for the case of 4 ATUs?
[Minghuan] For 2 ATUs, CFG0 and MEM share ATU0. So when access PCIe 
device configuration
ATU0 will be changed to CFG0 setting, and then be changed to MEM setting 
for MEM support.
> - Srikanth
>
>>
>>
