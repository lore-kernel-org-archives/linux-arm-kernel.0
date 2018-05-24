From: robh@kernel.org (Rob Herring)
Date: Thu, 24 May 2018 09:25:43 -0500
Subject: [PATCH v9 07/11] arm64: kexec_file: add crash dump support
In-Reply-To: <20180521101425.GC9887@linaro.org>
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-8-takahiro.akashi@linaro.org>
 <0aba6388-8a73-d371-7b92-3594639eb27e@arm.com>
 <20180518153552.GA23468@rob-hp-laptop> <20180521101425.GC9887@linaro.org>
Message-ID: <CAL_JsqLGgDTfhz6XqgMzDM_KL_W9HRtVOwjeP6rfk3+Tn-Stgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2018 at 5:14 AM, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
> Hi Rob,
>
> On Fri, May 18, 2018 at 10:35:52AM -0500, Rob Herring wrote:
>> On Tue, May 15, 2018 at 06:12:59PM +0100, James Morse wrote:
>> > Hi guys,
>> >
>> > (CC: +RobH, devicetree list)
>>
>> Thanks.
>>
>> > On 25/04/18 07:26, AKASHI Takahiro wrote:
>> > > Enabling crash dump (kdump) includes
>> > > * prepare contents of ELF header of a core dump file, /proc/vmcore,
>> > >   using crash_prepare_elf64_headers(), and
>> > > * add two device tree properties, "linux,usable-memory-range" and
>> > >   "linux,elfcorehdr", which represent repsectively a memory range
>> > >   to be used by crash dump kernel and the header's location
>>
>> BTW, I intend to move existing parsing these out of the arch code.
>> Please don't add more DT handling to arch/ unless it is *really* arch
>> specific. I'd assume that the next arch to add kexec support will use
>> these bindings instead of the powerpc way.
>
> So do you expect all the fdt-related stuff in my current implementation
> for arm64 to be put into libfdt, or at least drivers/of, from the beginning?

Yes.

> I'm not sure how arch-specific the properties here are. For instance,
> it is only arm64 that uses "linux,usable-memory-range" right now but
> if some other arch follows, it is no more arch-specific.
> # I remember that you didn't like this property :)

The question I guess is what will the next arch use. I don't think any
other DT based arch supports crashdump or kexec yet.

>> > > +{
>> > > + void *buf, *prop;
>> > > + size_t buf_size;
>> > > + int result;
>> > > +
>> > > + buf_size = (__dt_root_addr_cells + __dt_root_size_cells) * sizeof(u32);
>> > > + prop = buf = vmalloc(buf_size);
>>
>> This can go on the stack instead (and would be required to to work in
>> libfdt).
>
> Well, I can't agree with you here since we are now in effort, as far as
> I correctly understand, of purging all the variable-sized arrays on a local
> stack out of the kernel code.

You don't need a variable sized array. The array size just needs to
the the maximum size (16 bytes).

Rob
