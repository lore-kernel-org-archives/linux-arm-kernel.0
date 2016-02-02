From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 2 Feb 2016 14:18:15 +0900
Subject: [PATCH 18/19] arm64: kdump: update a kernel doc
In-Reply-To: <20160122111331.GA23620@leverpostej>
References: <20160119122848.GA2904@dhcp-128-65.nay.redhat.com>
 <20160119125114.GH25024@leverpostej>
 <20160119134553.GA2986@dhcp-128-65.nay.redhat.com>
 <20160119140139.GC26545@leverpostej>
 <20160120024946.GA2999@dhcp-128-65.nay.redhat.com>
 <569F2439.9000604@linaro.org> <20160120114929.GB25829@leverpostej>
 <56A08076.8060302@linaro.org> <20160121120210.GD2581@leverpostej>
 <56A1CAD2.70403@linaro.org> <20160122111331.GA23620@leverpostej>
Message-ID: <56B03C17.5090606@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On 01/22/2016 08:13 PM, Mark Rutland wrote:
> On Fri, Jan 22, 2016 at 03:23:14PM +0900, AKASHI Takahiro wrote:
>> On 01/21/2016 09:02 PM, Mark Rutland wrote:
>>> On Thu, Jan 21, 2016 at 03:53:42PM +0900, AKASHI Takahiro wrote:
>>>> On 01/20/2016 08:49 PM, Mark Rutland wrote:
>>>>> On Wed, Jan 20, 2016 at 03:07:53PM +0900, AKASHI Takahiro wrote:
>>>>>> On 01/20/2016 11:49 AM, Dave Young wrote:
>>>>>>> Firmware do not know kernel endianniess, kernel should respect firmware
>>>>>>> maps and adapt to it, it sounds like a generic issue not specfic to kexec.
>>>>>>
>>>>>> On arm64, a kernel image header has a bit field to specify the image's endianness.
>>>>>> Anyway, our current implementation replies on a user-supplied dtb to start BE kernel.
>>>>>
>>>>> The firmware should _never_ care about the kernel's endianness. The
>>>>> bootlaoder or first kernel shouldn't care about the next kernel's
>>>>> endianness apart from in exceptional circumstances. The DTB for a LE
>>>>> kernel should look identical to that passed to a BE kernel.
>>>>
>>>> Please note that I didn't say anything different from your last two statements.
>>>> The current arm64 kexec implementation doesn't do anything specific to BE,
>>>> but as far as BE kernel doesn't support UEFI, users are responsible for
>>>> providing a proper dtb.
>>>
>>> I'm just confused as to what you mean by a "proper dtb" in that case.
>>>
>>> If you just mean one with memory nodes hacked in, then that would
>>> currently be a way to make that work, yes.
>>
>> One of useful cases that I have in my mind is kdump.
>> We may want to use a small sub-set of dtb, especially devices, to
>> make the reboot more reliable. Device drivers are likely to be vulnerable
>> at crash.
>
> I don't think that we can reliably have userspace carve out devices from
> the DTB or from ACPI tables in order to achieve that. That's going to
> end up complex and/or incomplete. We also can't do this in the
> kexec_load_file / Secure Boot case.
>
> That's not to say we cannot try, as it's possible when using kexec_load.
> However, it's only going to be possible on a subset of systems, and it
> would probably make sense to reserve this approach to those cases we
> cannot work around by other means (e.g. whitelisting "safe" devices in
> the kdump kernel, forcing explicit resets, etc).
>
>>> It seems like the better option is to fix the BE kernel to support a
>>> UEFI memory map, as that solves other issues.
>>
>> Why did Ard throw away his patch?
>
> In the absence of kexec it wasn't necessary, it only supported a subset
> of the runtime services (and no other features like DMI IIRC), and it
> looked like it would be painful to debug (if something went wrong while
> a CPU was in LE mode, we couldn't even panic()).
>
> Given BE kernels on UEFI were never supported until that point, there
> wasn't a compelling reason to support that case.
>
> Even if we support the UEFI memory map, I don't think it's worth the
> effort to support runtime services, ACPI, and related code that's only
> ever been tested on LE. So realistically this would only work on systems
> using UEFI && DT rather than UEFI && ACPI.
>
>> So, are you now suggesting that we put both "elfcorehdr=" and
>> "usable-memory=" under /chosen in dtb?
>
> Yes.
>
>> That's fair enough.  (as far as nobody cares about incompatibility
>> with other archs.)
>
> Glad to hear! :)

I'm preparing for a new version based on our discussions.
Do you think that UEFI memory map support on BE kernel is a prerequisite
for accepting my kdump?

-Takahiro AKASHI

> Thanks,
> Mark.
>
