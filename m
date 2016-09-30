From: jonathanh@nvidia.com (Jon Hunter)
Date: Fri, 30 Sep 2016 09:02:00 +0100
Subject: [PATCH v2 3/6] dt/bindings: Add bindings for Tegra GMI controller
In-Reply-To: <CALw8SCUK0_kvNR_juAc7N_DMQbV=voizqXE6PApc_B_CQHzzOA@mail.gmail.com>
References: <1472045838-22628-1-git-send-email-mirza.krak@gmail.com>
 <1472045838-22628-4-git-send-email-mirza.krak@gmail.com>
 <de2fb909-829e-6c04-4f6a-442cbb9171c9@nvidia.com>
 <CALw8SCVcPymDZ8NyUbeanRF0TCT1TZzL6iRDticYA42FWrEWqw@mail.gmail.com>
 <20160830170636.GA8741@rob-hp-laptop>
 <CALw8SCUYQGWXn7=Jpn=uvFvvPRVFQGrtSNot+-tVgP73yAEEOQ@mail.gmail.com>
 <a3a2371b-5d98-db2d-b7e4-be6d08cb7271@nvidia.com>
 <CALw8SCUK0_kvNR_juAc7N_DMQbV=voizqXE6PApc_B_CQHzzOA@mail.gmail.com>
Message-ID: <fca81faa-f7de-08df-00dd-dcc36d94aaf2@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On 19/09/16 08:21, Mirza Krak wrote:
> 2016-09-06 12:32 GMT+02:00 Jon Hunter <jonathanh@nvidia.com>:
>>
>> On 31/08/16 12:22, Mirza Krak wrote:
>>> 2016-08-30 19:06 GMT+02:00 Rob Herring <robh@kernel.org>:
>>
>> ...
>>
>>>>>                  nvidia,snor-cs = <4>;
>>>>
>>>> NAK, no custom CS properties.
>>
>> Ok, so ...
>>
>>> gmi at 70090000 {
>>>         compatible = "nvidia,tegra20-gmi";
>>>         reg = <0x70009000 0x1000>;
>>>         #address-cells = <2>;
>>>         #size-cells = <1>;
>>>         clocks = <&tegra_car TEGRA20_CLK_NOR>;
>>>         clock-names = "gmi";
>>>         resets = <&tegra_car 42>;
>>>         reset-names = "gmi";
>>>         ranges = <4 0 0xd0000000 0xfffffff>;
>>>
>>>         status = "okay";
>>>
>>>         bus at 4,0 {
>>>                 compatible = "simple-bus";
>>>                 #address-cells = <1>;
>>>                 #size-cells = <1>;
>>>                 ranges = <0 4 0 0x40000>;
>>>
>>>                 nvidia,snor-mux-mode;
>>>                 nvidia,snor-adv-inv;
>>>
>>>                 can at 0 {
>>>                         reg = <0 0x100>;
>>>                         ...
>>>                 };
>>>
>>>                 can at 40000 {
>>>                         reg = <0x40000 0x100>;
>>>                         ...
>>>                 };
>>>         };
>>> };
>>>
>>> Have I understood you correct?
>>>
>>> Also wanted to verify the example case where you only have on device
>>> connected to one CS#, from what I see in other implementations it
>>> seems OK to put the CS# in the reg property in that case. Is this
>>> correct?
>>>
>>> Example with one SJA1000 CAN controller connected to the GMI bus
>>> on CS4:
>>>
>>> gmi at 70090000 {
>>>         compatible = "nvidia,tegra20-gmi";
>>>         reg = <0x70009000 0x1000>;
>>>         #address-cells = <2>;
>>>         #size-cells = <1>;
>>>         clocks = <&tegra_car TEGRA20_CLK_NOR>;
>>>         clock-names = "gmi";
>>>         resets = <&tegra_car 42>;
>>>         reset-names = "gmi";
>>>         ranges = <4 0 0xd0000000 0xfffffff>;
>>>
>>>         status = "okay";
>>>
>>>         can at 4,0 {
>>>                 reg = <4 0 0x100>;
>>>                 nvidia,snor-mux-mode;
>>>                 nvidia,snor-adv-inv;
>>>                 ...
>>>         };
>>> };
>>>
>>> Jon, to be able to handle both cases in the driver we would first
>>> attempt to decode the CS# from the ranges property, and fallback to
>>> reg property if no ranges are defined. Does that sound reasonable?
>>
>> Given the above examples that may be supported, is there a
>> better/simpler way to extract the CS# than what Mirza is proposing? For
>> example, from the node-name unit-address?
>>
> 
> Hi.
> 
> I have been on vacation and now I am back and wanted to finalize these
> patch series.
> 
> So pinging this thread to see I we can agree on a solution.
> 
> Rob any comments to my proposal and Jon`s comment?

Can you comment on the above?

Cheers
Jon

-- 
nvpublic
