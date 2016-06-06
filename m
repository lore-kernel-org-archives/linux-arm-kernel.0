From: ttnguyen@apm.com (Tai Tri Nguyen)
Date: Mon, 6 Jun 2016 10:55:35 -0700
Subject: [PATCH v2 2/4] Documentation: Add documentation for APM X-Gene
 SoC PMU DTS binding
In-Reply-To: <20160606172945.GE23505@leverpostej>
References: <1460510547-17611-1-git-send-email-ttnguyen@apm.com>
 <1460510547-17611-3-git-send-email-ttnguyen@apm.com>
 <20160418170009.GA15338@rob-hp-laptop>
 <CACgAJHyBbO_LXwtfNVK1f=dY3v1Jfxwxq1dw98EZ0aYdhjPpAg@mail.gmail.com>
 <20160420113121.GE2514@arm.com>
 <20160502205648.GA7374@rob-hp-laptop>
 <CACgAJHyT31DuVNoyRQZVKjv=zM5Fc-EY0gy=y=pHHrBTT+1Xow@mail.gmail.com>
 <20160531165630.GE4254@leverpostej>
 <CACgAJHwtb0hNs0JWOrpyF=_fRVvUi2QG4q7qohgCw4SjxqtX6A@mail.gmail.com>
 <CACgAJHxMCa2Hp_A8YnHmmVrHGd3yLhFs2k33MN6OHRUmZ7Y_Wg@mail.gmail.com>
 <20160606172945.GE23505@leverpostej>
Message-ID: <CACgAJHzqzqZnL7nwohJFNsymRawdQWn=CxhXR+vB1S+ORStzYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Mon, Jun 6, 2016 at 10:29 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, May 31, 2016 at 06:25:56PM -0700, Tai Tri Nguyen wrote:
>> Hi Mark,
>
> [...]
>
>> I'm facing a problem after removing the index for MCU and MC sub-nodes.
>> The MCUs and MCs aren't always enabled depending on how DRAM DIMMs are
>> installed on the system.
>> I still need a way to associate the MCU with its indicator bit in the
>> enable mask retrieved from CSR.
>
> Ah, I see.
>
> Can you elaborate on how the indicator bits are laid out? From the
> example binding, I see multiple nodes with the same index property, so
> I'm a little confused.
>
> I guess that there's a CSR per class of node (e.g. all MCBs in one CSR
> register)? Or do several nodes share the same bit?
>
> Is there a single CSR register? Are there several? Is that bit index
> used in other registers?

In our current XGene platforms, there are 2 MCBs and each MCB has 2 MCs.
   MCB0 --> MC0 and MC1
   MCB1 --> MC2 and MC3
There are 2 CSR are being used (each uses 1 bit) together as indicators:
  CSR1 indicates if both MCBs are active.
  CSR2 indicates if both MCs of the same MCB are active.

This is the true table:
dual MCB      dual MC
0                   0            --> MC0 active
0                   1            --> MC0/MC1 active
1                   0            --> MC0/MC2 active
1                   1            --> MC0/MC1/MC2/MC3 active

At the time the driver initializes, I check the 2 CSRs to come up with
the mcb_active_mask and mc_active_mask.
The index bits are used to compare against the mcb_active_mask/mc_active_mask.

>
>> For MC and MCB nodes only, can I introduce an "enable-mask" field?
>> For example:
>> "
>> pmucmcb at 7e710000 {
>>         compatible = "apm,xgene-pmu-mcb";
>>         reg = <0x0 0x7e710000 0x0 0x1000>;
>>         enable-mask = <0x00000001>;
>> };
>>
>> pmucmcb at 7e730000 {
>>         compatible = "apm,xgene-pmu-mcb";
>>         reg = <0x0 0x7e730000 0x0 0x1000>;
>>         enable-mask = <0x00000002>;
>> };
>> "
>> Or can you please give a suggestion how I can fix it?
>
> Assuming it's always a single bit, a *-bit-index property may be fine,
> and probably preferable.
>

Yes, it's always a single bit. I'll use *-bit-index for these sub-nodes.

Thanks,
--
Tai
