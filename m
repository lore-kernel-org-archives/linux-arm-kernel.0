From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 19 Nov 2014 09:24:41 +0100
Subject: [PATCH v5.5] of/fdt: export fdt blob as /sys/firmware/fdt
In-Reply-To: <CABGGiswNc1jHWiCraKmEVWRn-aMndt8AfYA3GtmaDBVpZBd+aA@mail.gmail.com>
References: <1415984735-32388-1-git-send-email-ard.biesheuvel@linaro.org>
 <20141118165145.4F6A8C40966@trevor.secretlab.ca>
 <20141118172545.GC14323@leverpostej>
 <20141118221103.4ECB3C40966@trevor.secretlab.ca>
 <CABGGiswNc1jHWiCraKmEVWRn-aMndt8AfYA3GtmaDBVpZBd+aA@mail.gmail.com>
Message-ID: <CAKv+Gu8fAG5jGAFovSJ_jKz52M2xbuyyAHvGi=tH+vmLL6Q00Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 November 2014 00:11, Rob Herring <rob.herring@linaro.org> wrote:
> On Tue, Nov 18, 2014 at 4:11 PM, Grant Likely <grant.likely@linaro.org> wrote:
>> On Tue, 18 Nov 2014 17:25:45 +0000
>> , Mark Rutland <mark.rutland@arm.com>
>>  wrote:
>>> On Tue, Nov 18, 2014 at 04:51:45PM +0000, Grant Likely wrote:
>>> > On Fri, 14 Nov 2014 18:05:35 +0100
>>> > , Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> >  wrote:
>>> > > Create a new /sys entry '/sys/firmware/fdt' to export the FDT blob
>>> > > that was passed to the kernel by the bootloader. This allows userland
>>> > > applications such as kexec to access the raw binary.
>
> [...]
>
>>> > * It also helps with exposing the reserved map to userspace, but kexec
>>> >   has done without that feature for years, and it is in the process of
>>> >   being deprecated in favour of /reserved-memory anyway.
>>>
>>> This is the first I'd heard of the reserve map being deprecated, and
>>> we're going to have DTs with reserved map entries for a long time going
>>> forwards.
>>
>> Deprecated, not removed or disabled. It will still work pretty much
>> forever, but users should be encouraged to move to the reserve-memory
>> tree.
>
> I thought you had said reserve map was still the right way for memory
> the kernel should never touch.
>
>>> Can't we expose the header fields under something like
>>> /sys/firmware/devicetree/dtb-header/, parallel to the usual
>>> /sys/firmware/devicetree/base for nodes?
>>
>> We could do that too.
>>
>> Honestly though, I'm just unsure of what the best thing to do is. If you
>> and a few others tell me that, "no, exporting the raw dtb is the right
>> thing to do", then I'll be okay, merge the patch and sleep properly.
>
> I always sleep better when others can take the blame.
>
> What happens when we rev the dtb format? Is the ABI the blob or the
> format of the blob?
>
> I lean towards we should add this. This is providing what is "in the
> firmware" while /proc/devicetree provides the live tree state
> including overlays.
>

Well, my pov is that FDT != devicetree ever since we started (ab)using
the FDT container format to pass just the UEFI entry points to the
kernel.
The boot protocol describes what should be passed in x0, and /that/ is
what we expose in /sys/firmware/fdt, regardless of how the kernel
decided to configure itself.
(perhaps we need to fix the wording in the document to refer to FDT not dtb)

So that also means I don't care about memreserve vs reserved-memory or
other DT specific details: as long as x0 points to something libfdt
understands at boot, we expose it and not interpret it any further.

-- 
Ard.
