From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 18 Mar 2016 14:11:20 +0100
Subject: [PATCH v15 1/6] efi: ARM/arm64: ignore DT memory nodes instead of
 removing them
In-Reply-To: <20160318125600.GT2619@codeblueprint.co.uk>
References: <1457481587-8976-1-git-send-email-ddaney.cavm@gmail.com>
 <1457481587-8976-2-git-send-email-ddaney.cavm@gmail.com>
 <20160318122609.GS2619@codeblueprint.co.uk>
 <CAKv+Gu8STa=tF0o1qje6LorYxzBon704Q_O2U=cvigg9v53hZw@mail.gmail.com>
 <20160318125600.GT2619@codeblueprint.co.uk>
Message-ID: <CAKv+Gu_6S+ME8MH8DZ32q+hKcRiOqp=nRy6Reryy5v=J7yE2vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 March 2016 at 13:56, Matt Fleming <matt@codeblueprint.co.uk> wrote:
> On Fri, 18 Mar, at 01:31:59PM, Ard Biesheuvel wrote:
>>
>> Typically, the UEFI memory map is more restrictive, since it does not
>> only describe where the memory lives, but also which parts of it the
>> firmware has claimed for its own use. So if both memory nodes and the
>> UEFI memory map are available, we must use the latter anyway, and so
>> it makes sense to ignore the former. Alternatively, we could sanity
>> check the memory nodes against the memory map, but it is simpler just
>> to ignore them.
>>
>> However, that caused some problems in the past, since discovering the
>> memory nodes occurs before the EFI entry point is invoked, and so it
>> was decided that we strip the memory nodes rather than ignore them.
>
> Thanks Ard.
>
> Once you've stripped the memory nodes as represented in memblock,
> there's no way for the memory nodes to re-appear in one form or
> another after that point, right? The EFI memory map is the sole memory
> layout either via memblock or if it's queried directly?

Well, the significance of this patch in this series is that the memory
nodes contain additional properties that describe the NUMA topology,
which the UEFI memory map does not allow us to do. At some point, we
may decide to capture this information in a different way (i.e., a
separate configuration table), but for now, I think this is fine,
especially since stripping nodes is a bit of a blunt tool.
