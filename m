From: lho@apm.com (Loc Ho)
Date: Fri, 22 May 2015 11:28:44 -0700
Subject: [PATCH v10 4/5] edac: Add APM X-Gene SoC EDAC driver
In-Reply-To: <2082687.grA49DxWyE@wuerfel>
References: <1431991481-25684-1-git-send-email-lho@apm.com>
 <4456746.y9FVaqRogk@wuerfel> <20150522084625.GE23022@pd.tnic>
 <2082687.grA49DxWyE@wuerfel>
Message-ID: <CAPw-ZTmaRQj740Z58Asrch3decmXA89EN9MdKg-WvWp8ftqB6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> > > +static int edac_mc_idx;
>> > > +static int edac_mc_active_mask;
>> > > +static int edac_mc_registered_mask;
>> > > +static DEFINE_MUTEX(xgene_edac_mc_lock);
>> >
>> > It would also be best to avoid global variables, but it seems that at
>> > least the edac_mc_idx is needed to work with the EDAC subsystem.
>> > Maybe Boris has an idea for how to avoid it.
>>
>> Right, so AFAICT this is used in
>>
>>         edac_mc_alloc(edac_mc_idx++
>>
>> and basically we're supplying the memory controller numbers in the order
>> we're calling xgene_edac_mc_add(). Perhaps we need to make the memory
>> controller numbering explicit with DT...
>
> I see now that the number is also used in xgene_edac_mc_is_active()
> as an index for the MCBADDRMR register, which seems very fragile,
> as it relies on the DT nodes getting seen in the same order by the
> driver that the hardware blocks are used in.
>
> Better add an explicit DT property for the index that is defined
> to be the same as MCBADDRMR bits, e.g.
>
>                        edacmc at 7e800000 {
>                              compatible = "apm,xgene-edac-mc";
>                              reg = <0x0 0x7e800000 0x0 0x1000>;
>                               memory-controller = <0>;
>                        };
>
> or use a reference to the normal memory controller DT node
> outside of the EDAC, and put a number in that one.
>
> Is there a strict 1:1 relation between the DIMM slot numbering
> on the board and the memory controller number within the EDAC
> registers?

Yes... The status active bit position is strictly tie to an
controller. Like the suggestion with memory-controller property.

-Loc
