From: orsonzhai@gmail.com (Orson Zhai)
Date: Sat, 17 Jan 2015 16:47:25 +0800
Subject: [PATCH v5 3/5] arm64: dts: Add support for Spreadtrum SC9836 SoC
 in dts and Makefile
In-Reply-To: <20150116140926.GB22569@leverpostej>
References: <1421402411-3479-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1421402411-3479-4-git-send-email-chunyan.zhang@spreadtrum.com>
 <20150116103558.GD21809@leverpostej>
 <CA+H2tpGPKc8Gu=s+d4PnO=Wp_Uv=o338hxj_1opPRkZ3KZH+rw@mail.gmail.com>
 <20150116140926.GB22569@leverpostej>
Message-ID: <CA+H2tpFenKzBEvkaHOh7shX7GaYyGFc2CbBTDxgSL9=Wq1Q++g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 10:09 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Jan 16, 2015 at 12:49:20PM +0000, Orson Zhai wrote:
>> Hi, Mark,
>>
>> On Fri, Jan 16, 2015 at 6:35 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>[...]
>>
>>  It returns "status busy" after I type the command below.
>
> Is this while other CPUs are active, or after you've hotplugged out all
> other CPUs? The latter is expected, but the former is not.
>
> Are you able to hotplug CPU0 out and back in while other CPUs are
> active

Yes, I have just tested again and confirm that cpu0 could be
turned on/off when one of the other 3 CPUs was active.

>
> [...]
>
> For this bus you could instead use addresses relative to the bus inside,
> rather than absolute addresses,

Do you mean something like  apb at 0 {...} apb at 1 {...} ?

> or you could have:
>
> ranges = <0x0 0x70000000 0x0 0x70000000 0x0 0x10000000>;
>
> [...]
>>
>> This initial patch is picked up from a very big dt file.
>> There are several apb buses in this chip.
>
> At the same level us the bus hierarchy?
>
These buses are led by some bus matrix to different areas.
But I'd like treat them simply at same level.
Is it right to do that?

>> So I use apb at starting-address to separate them.
>> But I remember another rule that the @address needs to equal  first
>> address in property reg array.
>> Do I have to delete @7000000 as well if i delete reg line?
>
> Hmm. I'm not too keen on encoding a reg or unit-address here, because
> the control interface of the bus isn't at that address. If we want to
> add that later then the reg would be different in those cases. Given
> there's no control interface here, there shouldn't be a reg or
> unit-address.
>

Do you mean something like

   ap-ahb { ... };
   aon-ahb { ... };

without using @xxxx ?

   Thanks, Orson

> Just ensure that the name before the unit-address is unique.
>
> Thanks,
> Mark.
